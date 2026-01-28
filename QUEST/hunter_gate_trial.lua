--[[
============================================================
HUNTER SYSTEM - SUPREMI (WORLD BOSS) & RANK TRIAL
============================================================
Versione: 4.0 (Sistema Supremi)
NPC: 20019 = Guardiano Supremi | 20020 = Maestro Prove
============================================================
I giocatori selezionati possono evocare un SUPREMO (World Boss)
nella mappa principale! Il Supremo corrisponde al rank del giocatore.
Cooldown globale di 5 minuti tra spawn (tutti i canali).
============================================================
--]]

quest hunter_gate_trial begin
    state start begin

        -- ============================================================
        -- 1. CONFIG & UTILITY FUNCTIONS
        -- ============================================================

        function get_config(key)
            local config = {
                ["gate_guardian_npc"] = 20019,
                ["trial_master_npc"] = 20020,
                ["gate_rejection_penalty"] = 250,
                ["db_name"] = "srv1_hunabku",
                -- SUPREMI CONFIG
                ["supremo_map_index"] = 2,          -- Mappa dove spawna il Supremo
                ["supremo_x"] = 724,                -- Coordinata X
                ["supremo_y"] = 657,                -- Coordinata Y
                ["supremo_cooldown"] = 300,         -- 5 minuti cooldown globale
                ["supremo_duration"] = 600,         -- 10 minuti durata boss
            }
            return config[key]
        end
        
        -- Legge VNUM Supremo da database
        function get_supremo_vnum(rank)
            local db = hunter_gate_trial.get_config("db_name")
            local c, d = mysql_direct_query("SELECT supremo_vnum FROM " .. db .. ".hunter_supremo_config WHERE rank_code = '" .. rank .. "' AND enabled = 1 LIMIT 1")
            if c > 0 and d[1] then
                return hunter_gate_trial.safe_tonumber(d[1].supremo_vnum)
            end
            return 691  -- fallback default
        end
        
        -- Legge Nome Supremo da database
        function get_supremo_name(rank)
            local db = hunter_gate_trial.get_config("db_name")
            local c, d = mysql_direct_query("SELECT supremo_name FROM " .. db .. ".hunter_supremo_config WHERE rank_code = '" .. rank .. "' AND enabled = 1 LIMIT 1")
            if c > 0 and d[1] then
                return d[1].supremo_name or "Supremo"
            end
            return "Supremo Sconosciuto"
        end
        
        -- Legge impostazione globale da database
        function get_supremo_setting(key, default_value)
            local db = hunter_gate_trial.get_config("db_name")
            local c, d = mysql_direct_query("SELECT setting_value FROM " .. db .. ".hunter_supremo_settings WHERE setting_key = '" .. key .. "' LIMIT 1")
            if c > 0 and d[1] then
                return d[1].setting_value
            end
            return default_value
        end
        
        function safe_tonumber(val)
            local num = tonumber(val)
            return num or 0
        end
        
        function modulo(a, b) return a - math.floor(a / b) * b end

        function format_time(seconds)
            seconds = hunter_gate_trial.safe_tonumber(seconds)
            if seconds <= 0 then return "00:00:00" end
            local h = math.floor(seconds / 3600)
            local m = math.floor(hunter_gate_trial.modulo(seconds, 3600) / 60)
            local s = hunter_gate_trial.modulo(seconds, 60)
            return string.format("%02d:%02d:%02d", h, m, s)
        end
        
        function format_time_days(seconds)
            seconds = hunter_gate_trial.safe_tonumber(seconds)
            if seconds <= 0 then return "Scaduto" end
            local d = math.floor(seconds / 86400)
            local h = math.floor(hunter_gate_trial.modulo(seconds, 86400) / 3600)
            local m = math.floor(hunter_gate_trial.modulo(seconds, 3600) / 60)
            if d > 0 then return string.format("%dg %02dh %02dm", d, h, m)
            else return string.format("%02d:%02d", h, m) end
        end
        
        function clean_str(s)
            if not s then return "" end
            return string.gsub(tostring(s), " ", "+")
        end
        
        function rank_letter_to_num(letter)
            local ranks = { E=0, D=1, C=2, B=3, A=4, S=5, N=6 }; return ranks[letter] or 0
        end

        function rank_num_to_letter(num)
            local letters = { [0]="E", [1]="D", [2]="C", [3]="B", [4]="A", [5]="S", [6]="N" }; return letters[num] or "E"
        end

        -- ============================================================
        -- 2. CACHING & DATA MANAGEMENT
        -- ============================================================
        
        function load_player_cache()
            local pid = pc.get_player_id()
            local db = hunter_gate_trial.get_config("db_name")
            local c_rank, d_rank = mysql_direct_query("SELECT hunter_rank, total_points FROM " .. db .. ".hunter_quest_ranking WHERE player_id=" .. pid)
            if c_rank > 0 and d_rank[1] then
                pc.setqf("hgt_cache_rank_num", hunter_gate_trial.rank_letter_to_num(d_rank[1].hunter_rank or "E"))
                pc.setqf("hgt_cache_gloria", hunter_gate_trial.safe_tonumber(d_rank[1].total_points))
            else
                pc.setqf("hgt_cache_rank_num", 0); pc.setqf("hgt_cache_gloria", 0)
            end
            local c_trial, d_trial = mysql_direct_query("SELECT trial_id FROM " .. db .. ".hunter_player_trials WHERE player_id=" .. pid .. " AND status='in_progress' LIMIT 1")
            if c_trial > 0 and d_trial[1] then
                pc.setqf("hgt_trial_id", hunter_gate_trial.safe_tonumber(d_trial[1].trial_id)); pc.setqf("hgt_trial_active", 1)
            else
                pc.setqf("hgt_trial_id", 0); pc.setqf("hgt_trial_active", 0)
            end
        end

        function get_player_rank() return hunter_gate_trial.rank_num_to_letter(pc.getqf("hgt_cache_rank_num")) end
        function get_player_gloria() return pc.getqf("hgt_cache_gloria") or 0 end
        
        function add_gloria(amount)
            local pid = pc.get_player_id(); local db = hunter_gate_trial.get_config("db_name")
            
            -- FIX CRITICO: Leggi SEMPRE il valore attuale dal DATABASE, non dalla cache!
            -- La cache potrebbe essere 0 se non ancora caricata, causando perdita di gloria
            local current_gloria = 0
            local c_db, d_db = mysql_direct_query("SELECT total_points FROM " .. db .. ".hunter_quest_ranking WHERE player_id=" .. pid)
            if c_db > 0 and d_db[1] then
                current_gloria = hunter_gate_trial.safe_tonumber(d_db[1].total_points)
            end
            
            local new_gloria = math.max(0, current_gloria + hunter_gate_trial.safe_tonumber(amount))
            mysql_direct_query("UPDATE " .. db .. ".hunter_quest_ranking SET total_points = " .. new_gloria .. " WHERE player_id=" .. pid)
            if amount > 0 then
                mysql_direct_query("UPDATE " .. db .. ".hunter_quest_ranking SET daily_points = daily_points + " .. amount .. ", weekly_points = weekly_points + " .. amount .. " WHERE player_id=" .. pid)
            end
            pc.setqf("hgt_cache_gloria", new_gloria)
        end
        
        -- ============================================================
        -- 3. INTERFACE & COMMUNICATION
        -- ============================================================
        function speak_color(msg, color) cmdchat("HunterSystemSpeak " .. (color or hunter_gate_trial.get_player_rank()) .. "|" .. hunter_gate_trial.clean_str(msg)) end
        function show_gate_entry_effect(gate_name, color_code) cmdchat("HunterGateEntry " .. hunter_gate_trial.clean_str(gate_name) .. "|" .. color_code) end
        function show_gate_victory_effect(gate_name, gloria_earned) cmdchat("HunterGateVictory " .. hunter_gate_trial.clean_str(gate_name) .. "|" .. gloria_earned) end
        function show_gate_defeat_effect(gloria_penalty) cmdchat("HunterGateDefeat " .. gloria_penalty) end
        function show_trial_progress(progress_type, current, required) cmdchat("HunterTrialProgressPopup " .. progress_type .. "|" .. current .. "|" .. required) end
        function show_rank_up_effect(old_rank, new_rank) cmdchat("HunterRankUp " .. old_rank .. "|" .. new_rank) end
        
        -- Supremo UI Effect
        function show_supremo_spawn_effect(supremo_name, rank, summoner_name)
            cmdchat("HunterSupremoSpawn " .. hunter_gate_trial.clean_str(supremo_name) .. "|" .. rank .. "|" .. hunter_gate_trial.clean_str(summoner_name))
        end
        
        function send_gate_status()
            local access = hunter_gate_trial.check_gate_access()
            if access.has_access then 
                -- Invia info Supremo invece di Gate Dungeon
                local rank = hunter_gate_trial.get_player_rank()
                local supremo_name = hunter_gate_trial.get_supremo_name(rank)
                cmdchat("HunterSupremoStatus " .. access.gate_id .. "|" .. hunter_gate_trial.clean_str(supremo_name) .. "|" .. access.remaining_seconds .. "|" .. rank)
            else 
                cmdchat("HunterSupremoStatus 0|NONE|0|NONE") 
            end
        end
        
        function send_trial_status()
            local progress = hunter_gate_trial.get_trial_progress()
            if progress then
                local pkt = hunter_gate_trial.safe_tonumber(progress.trial_id) .. "|" .. hunter_gate_trial.clean_str(progress.trial_name) .. "|" .. progress.to_rank .. "|" .. progress.color_code .. "|" .. hunter_gate_trial.safe_tonumber(progress.remaining_seconds) .. "|" .. hunter_gate_trial.safe_tonumber(progress.boss_kills) .. "|" .. hunter_gate_trial.safe_tonumber(progress.required_boss_kills) .. "|" .. hunter_gate_trial.safe_tonumber(progress.metin_kills) .. "|" .. hunter_gate_trial.safe_tonumber(progress.required_metin_kills) .. "|" .. hunter_gate_trial.safe_tonumber(progress.fracture_seals) .. "|" .. hunter_gate_trial.safe_tonumber(progress.required_fracture_seals) .. "|" .. hunter_gate_trial.safe_tonumber(progress.chest_opens) .. "|" .. hunter_gate_trial.safe_tonumber(progress.required_chest_opens) .. "|" .. hunter_gate_trial.safe_tonumber(progress.daily_missions) .. "|" .. hunter_gate_trial.safe_tonumber(progress.required_daily_missions)
                cmdchat("HunterTrialStatus " .. pkt)
            else
                cmdchat("HunterTrialStatus 0|NONE|E|NONE|-1|0|0|0|0|0|0|0|0|0|0")
            end
        end

        function open_gate_trial_window()
            cmdchat("HunterGateTrialOpen")
        end
        
        -- ============================================================
        -- 4. SUPREMO SYSTEM (World Boss) - SISTEMA COMPLETO
        -- ============================================================
        
        -- Controlla se c'� cooldown globale attivo (tutti i canali)
        function is_supremo_on_cooldown()
            local cooldown_end = game.get_event_flag("hgt_supremo_cooldown_end") or 0
            return get_time() < cooldown_end
        end
        
        -- Imposta cooldown globale (legge durata da DB)
        function set_supremo_cooldown()
            local cooldown = hunter_gate_trial.safe_tonumber(hunter_gate_trial.get_supremo_setting("cooldown_seconds", "300"))
            game.set_event_flag("hgt_supremo_cooldown_end", get_time() + cooldown)
        end
        
        -- Ottieni secondi rimanenti del cooldown
        function get_supremo_cooldown_remaining()
            local cooldown_end = game.get_event_flag("hgt_supremo_cooldown_end") or 0
            local remaining = cooldown_end - get_time()
            return remaining > 0 and remaining or 0
        end
        
        -- Legge gloria reward da database per rank
        function get_supremo_gloria_reward(rank)
            local db = hunter_gate_trial.get_config("db_name")
            local c, d = mysql_direct_query("SELECT gloria_reward FROM " .. db .. ".hunter_supremo_config WHERE rank_code = '" .. rank .. "' AND enabled = 1 LIMIT 1")
            if c > 0 and d[1] then
                return hunter_gate_trial.safe_tonumber(d[1].gloria_reward)
            end
            -- Fallback per rank
            local rewards = { E = 500, D = 750, C = 1000, B = 1500, A = 2000, S = 3000, N = 5000 }
            return rewards[rank] or 500
        end
        
        -- Legge penalita fallimento da database
        function get_supremo_fail_penalty(rank)
            local db = hunter_gate_trial.get_config("db_name")
            local penalty_base = hunter_gate_trial.safe_tonumber(hunter_gate_trial.get_supremo_setting("fail_penalty", "500"))
            -- Penalita scala con rank
            local multipliers = { E = 1, D = 1.2, C = 1.5, B = 2, A = 2.5, S = 3, N = 4 }
            return math.floor(penalty_base * (multipliers[rank] or 1))
        end
        
        -- Distanza massima dal boss (in unita di gioco) - 40 metri = 4000 unita
        function get_supremo_max_distance()
            return hunter_gate_trial.safe_tonumber(hunter_gate_trial.get_supremo_setting("max_distance", "4000"))
        end
        
        -- Penalita per abbandono (membro si allontana)
        function get_supremo_abandon_penalty()
            return hunter_gate_trial.safe_tonumber(hunter_gate_trial.get_supremo_setting("abandon_penalty", "500"))
        end
        
        -- Funzione per assegnare accesso al Supremo con notice globale
        function grant_gate_access(player_id, player_name, gate_id, hours)
            local db = hunter_gate_trial.get_config("db_name")
            hours = hours or hunter_gate_trial.safe_tonumber(hunter_gate_trial.get_supremo_setting("access_duration_hours", "2"))
            
            -- Inserisci/Aggiorna accesso
            mysql_direct_query("INSERT INTO " .. db .. ".hunter_gate_access (player_id, player_name, gate_id, expires_at) VALUES (" .. player_id .. ", '" .. mysql_escape_string(player_name) .. "', " .. gate_id .. ", DATE_ADD(NOW(), INTERVAL " .. hours .. " HOUR)) ON DUPLICATE KEY UPDATE expires_at = DATE_ADD(NOW(), INTERVAL " .. hours .. " HOUR), status = 'pending'")
            
            -- Ottieni rank del giocatore per determinare quale Supremo
            local c_rank, d_rank = mysql_direct_query("SELECT hunter_rank FROM " .. db .. ".hunter_quest_ranking WHERE player_id=" .. player_id)
            local rank = (c_rank > 0 and d_rank[1]) and d_rank[1].hunter_rank or "E"
            local supremo_name = hunter_gate_trial.get_supremo_name(rank)
            
            -- NOTICE GLOBALE: Annuncia il sorteggiato a tutti!
            notice_all("[SUPREMO] " .. player_name .. " e stato scelto per sfidare " .. supremo_name .. " (" .. rank .. "-Rank)!")
            
            return true
        end

        -- Controlla se il giocatore ha accesso
        function check_gate_access()
            local pid = pc.get_player_id(); local db = hunter_gate_trial.get_config("db_name")
            local q = "SELECT ga.access_id, ga.gate_id, TIMESTAMPDIFF(SECOND, NOW(), ga.expires_at) as remaining_seconds FROM " .. db .. ".hunter_gate_access ga WHERE ga.player_id = " .. pid .. " AND ga.status = 'pending' AND ga.expires_at > NOW() LIMIT 1"
            local c, d = mysql_direct_query(q)
            if c > 0 and d[1] then
                local data = d[1]
                return { 
                    has_access = true, 
                    access_id = hunter_gate_trial.safe_tonumber(data.access_id), 
                    gate_id = hunter_gate_trial.safe_tonumber(data.gate_id), 
                    remaining_seconds = hunter_gate_trial.safe_tonumber(data.remaining_seconds) 
                }
            end
            return { has_access = false }
        end
        
        -- Controlla se il player (o il suo party) e l'evocatore del Supremo attivo
        function is_supremo_summoner()
            local pid = pc.get_player_id()
            local summoner_pid = game.get_event_flag("hgt_supremo_summoner_pid") or 0
            
            -- Controllo diretto
            if summoner_pid == pid then return true end
            
            -- Controllo party: se l'evocatore e nel mio party, conto come valido
            if party.is_party() and summoner_pid > 0 then
                local pids = {party.get_member_pids()}
                for i, member_pid in ipairs(pids) do
                    if member_pid == summoner_pid then
                        return true
                    end
                end
            end
            
            return false
        end
        
        -- Calcola distanza dal punto di spawn del Supremo
        function get_distance_from_supremo()
            local spawn_x = game.get_event_flag("hgt_supremo_spawn_x") or 0
            local spawn_y = game.get_event_flag("hgt_supremo_spawn_y") or 0
            local player_x = pc.get_x()
            local player_y = pc.get_y()
            
            local dx = player_x - spawn_x
            local dy = player_y - spawn_y
            return math.sqrt(dx * dx + dy * dy)
        end
        
        -- === ANNOUNCEMENT GLOBALE ===
        -- Invia notice testuale a tutti i giocatori sulla mappa
        function broadcast_supremo_awakening(summoner_name, supremo_name, rank)
            -- Notice testuale visibile a tutti
            notice_all("")
            notice_all("============================================")
            notice_all("     [!!!] RISVEGLIO DEL SUPREMO [!!!]     ")
            notice_all("============================================")
            notice_all("")
            notice_all(summoner_name .. " ha risvegliato un potente Supremo!")
            notice_all("")
            notice_all(supremo_name .. " (" .. rank .. "-Rank)")
            notice_all("")
            notice_all("Il Supremo e apparso! Preparatevi alla battaglia!")
            notice_all("============================================")
        end
        
        -- === UI DEDICATA SFIDA SUPREMO ===
        -- Invia dati per la nuova UI Supremo Challenge (non emergency standard)
        function send_supremo_challenge_ui(summoner_name, supremo_name, vnum, rank, duration, reward, penalty, spawn_x, spawn_y)
            -- Formato: HunterSupremoChallenge summonerName|supremoName|vnum|rank|duration|reward|penalty|spawnX|spawnY|maxDistance
            local max_dist = hunter_gate_trial.get_supremo_max_distance()
            local cmd = "HunterSupremoChallenge " .. 
                hunter_gate_trial.clean_str(summoner_name) .. "|" ..
                hunter_gate_trial.clean_str(supremo_name) .. "|" ..
                vnum .. "|" ..
                rank .. "|" ..
                duration .. "|" ..
                reward .. "|" ..
                penalty .. "|" ..
                spawn_x .. "|" ..
                spawn_y .. "|" ..
                max_dist
            
            cmdchat(cmd)
        end
        
        -- Aggiorna UI con tempo rimanente e distanza
        function update_supremo_challenge_ui(time_left, distance, status)
            -- Formato: HunterSupremoChallengeUpdate timeLeft|distance|status
            cmdchat("HunterSupremoChallengeUpdate " .. time_left .. "|" .. math.floor(distance) .. "|" .. status)
        end
        
        -- Chiudi UI sfida Supremo
        function close_supremo_challenge_ui(result, gloria_change, message)
            -- Formato: HunterSupremoChallengeClose result|gloriaChange|message
            cmdchat("HunterSupremoChallengeClose " .. result .. "|" .. gloria_change .. "|" .. hunter_gate_trial.clean_str(message))
        end
        
        -- Avvia Sfida Supremo con UI dedicata
        function start_supremo_challenge(summoner_name, supremo_name, vnum, rank, duration, spawn_x, spawn_y)
            local pid = pc.get_player_id()
            local gloria_reward = hunter_gate_trial.get_supremo_gloria_reward(rank)
            local gloria_penalty = hunter_gate_trial.get_supremo_fail_penalty(rank)
            
            -- Salva flag locali per tracking
            pc.setqf("hgt_supremo_active", 1)
            pc.setqf("hgt_supremo_vnum", vnum)
            pc.setqf("hgt_supremo_expire", get_time() + duration)
            pc.setqf("hgt_supremo_reward", gloria_reward)
            pc.setqf("hgt_supremo_penalty", gloria_penalty)
            pc.setqf("hgt_supremo_spawn_x", spawn_x)
            pc.setqf("hgt_supremo_spawn_y", spawn_y)
            pc.setqf("hgt_supremo_abandoned", 0)  -- Flag abbandono
            
            -- Invia UI dedicata
            hunter_gate_trial.send_supremo_challenge_ui(summoner_name, supremo_name, vnum, rank, duration, gloria_reward, gloria_penalty, spawn_x, spawn_y)
            
            -- Se in party, setta flag e invia UI a tutti i membri
            if party.is_party() then
                local pids = {party.get_member_pids()}
                for i, member_pid in ipairs(pids) do
                    if member_pid ~= pid then
                        q.begin_other_pc_block(member_pid)
                        pc.setqf("hgt_supremo_active", 1)
                        pc.setqf("hgt_supremo_vnum", vnum)
                        pc.setqf("hgt_supremo_expire", get_time() + duration)
                        pc.setqf("hgt_supremo_reward", gloria_reward)
                        pc.setqf("hgt_supremo_penalty", gloria_penalty)
                        pc.setqf("hgt_supremo_spawn_x", spawn_x)
                        pc.setqf("hgt_supremo_spawn_y", spawn_y)
                        pc.setqf("hgt_supremo_abandoned", 0)
                        hunter_gate_trial.send_supremo_challenge_ui(summoner_name, supremo_name, vnum, rank, duration, gloria_reward, gloria_penalty, spawn_x, spawn_y)
                        q.end_other_pc_block()
                    end
                end
            end
            
            -- Avvia timer controllo (ogni 2 secondi)
            loop_timer("hgt_supremo_check", 2)
        end
        
        -- Gestisce abbandono di un membro (si e allontanato troppo)
        function handle_member_abandon()
            local pid = pc.get_player_id()
            local db = hunter_gate_trial.get_config("db_name")
            local pname = pc.get_name()
            
            -- Gia abbandonato? Non processare di nuovo
            if pc.getqf("hgt_supremo_abandoned") == 1 then return end
            
            pc.setqf("hgt_supremo_abandoned", 1)
            pc.setqf("hgt_supremo_active", 0)
            
            -- Penalita abbandono
            local abandon_penalty = hunter_gate_trial.get_supremo_abandon_penalty()
            hunter_gate_trial.add_gloria(-abandon_penalty)
            
            -- Chiudi UI con messaggio abbandono
            hunter_gate_trial.close_supremo_challenge_ui("ABANDON", -abandon_penalty, "Ti+sei+allontanato+troppo+dal+Supremo!")
            
            hunter_gate_trial.speak_color("TI SEI ALLONTANATO DALLA BATTAGLIA! -" .. abandon_penalty .. " GLORIA!", "RED")
            
            -- Log
            mysql_direct_query("INSERT INTO " .. db .. ".hunter_gate_history (player_id, player_name, gate_id, gate_name, result, gloria_change) VALUES (" .. pid .. ", '" .. mysql_escape_string(pname) .. "', 0, 'Supremo', 'abandoned', -" .. abandon_penalty .. ")")
            
            -- Notice al gruppo
            notice_all("[SUPREMO] " .. pname .. " ha abbandonato la battaglia!")
        end
        
        -- Termina sfida Supremo (SUCCESS o FAIL o STOLEN o TIMEOUT)
        function end_supremo_challenge(status, killer_name)
            local pid = pc.get_player_id()
            local db = hunter_gate_trial.get_config("db_name")
            local reward = pc.getqf("hgt_supremo_reward") or 0
            local penalty = pc.getqf("hgt_supremo_penalty") or 0
            local supremo_vnum = pc.getqf("hgt_supremo_vnum") or 0
            local supremo_rank = hunter_gate_trial.rank_num_to_letter(game.get_event_flag("hgt_supremo_rank") or 0)
            local supremo_name = hunter_gate_trial.get_supremo_name(supremo_rank)
            
            -- Se gia abbandonato, non fare nulla
            if pc.getqf("hgt_supremo_abandoned") == 1 then
                pc.setqf("hgt_supremo_active", 0)
                cleartimer("hgt_supremo_check")
                return
            end
            
            -- Reset flag locali
            pc.setqf("hgt_supremo_active", 0)
            pc.setqf("hgt_supremo_vnum", 0)
            pc.setqf("hgt_supremo_expire", 0)
            
            -- Se in party, reset anche membri (quelli non abbandonati)
            if party.is_party() then
                local pids = {party.get_member_pids()}
                for i, member_pid in ipairs(pids) do
                    if member_pid ~= pid then
                        q.begin_other_pc_block(member_pid)
                        if pc.getqf("hgt_supremo_abandoned") ~= 1 then
                            pc.setqf("hgt_supremo_active", 0)
                            pc.setqf("hgt_supremo_vnum", 0)
                            pc.setqf("hgt_supremo_expire", 0)
                            
                            -- Invia risultato anche ai membri
                            if status == "SUCCESS" then
                                hunter_gate_trial.close_supremo_challenge_ui("SUCCESS", reward, "Supremo+sconfitto!+Gloria+al+vincitore!")
                            elseif status == "STOLEN" then
                                hunter_gate_trial.close_supremo_challenge_ui("STOLEN", -penalty, "Il+Supremo+e+stato+rubato+da+" .. hunter_gate_trial.clean_str(killer_name or "???") .. "!")
                            else
                                hunter_gate_trial.close_supremo_challenge_ui("TIMEOUT", -penalty, "Tempo+scaduto!+Il+Supremo+e+fuggito!")
                            end
                        end
                        q.end_other_pc_block()
                    end
                end
            end
            
            cleartimer("hgt_supremo_check")
            
            -- Reset flag globali Supremo
            game.set_event_flag("hgt_supremo_active", 0)
            game.set_event_flag("hgt_supremo_vnum", 0)
            game.set_event_flag("hgt_supremo_summoner_pid", 0)
            
            local pname = pc.get_name()
            
            if status == "SUCCESS" then
                -- === VITTORIA! ===
                hunter_gate_trial.add_gloria(reward)
                hunter_gate_trial.close_supremo_challenge_ui("SUCCESS", reward, "VITTORIA!+" .. hunter_gate_trial.clean_str(supremo_name) .. "+sconfitto!")
                hunter_gate_trial.speak_color("SUPREMO SCONFITTO! +" .. reward .. " GLORIA!", "S")
                
                -- Effetti vittoria
                cmdchat("HunterSupremoVictory " .. hunter_gate_trial.clean_str(supremo_name) .. "|" .. supremo_rank .. "|" .. reward)
                
                -- Log
                mysql_direct_query("UPDATE " .. db .. ".hunter_supremo_log SET status = 'completed', killed_by = '" .. mysql_escape_string(pname) .. "', gloria_awarded = " .. reward .. " WHERE supremo_vnum = " .. supremo_vnum .. " AND status = 'active' ORDER BY spawned_at DESC LIMIT 1")
                mysql_direct_query("INSERT INTO " .. db .. ".hunter_gate_history (player_id, player_name, gate_id, gate_name, result, gloria_change) VALUES (" .. pid .. ", '" .. mysql_escape_string(pname) .. "', " .. supremo_vnum .. ", '" .. mysql_escape_string(supremo_name) .. "', 'victory', " .. reward .. ")")
                
                -- Notice globale vittoria
                notice_all("")
                notice_all("|cFF00FF00-------------------------------------------|r")
                notice_all("|cFFFFD700     [VITTORIA] SUPREMO SCONFITTO!     |r")
                notice_all("|cFF00FF00-------------------------------------------|r")
                notice_all("|cFF00FFFF" .. pname .. "|r |cFFFFFFFFha sconfitto|r |cFFFF6600" .. supremo_name .. "|r|cFFFFFFFF!|r")
                notice_all("|cFFFFD700+" .. reward .. " Gloria guadagnata!|r")
                notice_all("|cFF00FF00-------------------------------------------|r")
                
            elseif status == "STOLEN" then
                -- === FURTO! ===
                hunter_gate_trial.add_gloria(-penalty)
                hunter_gate_trial.close_supremo_challenge_ui("STOLEN", -penalty, "RUBATO!+" .. hunter_gate_trial.clean_str(killer_name or "???") .. "+ha+rubato+il+tuo+Supremo!")
                hunter_gate_trial.speak_color("IL TUO SUPREMO E STATO RUBATO DA " .. (killer_name or "???") .. "! -" .. penalty .. " GLORIA!", "RED")
                
                -- Log
                mysql_direct_query("UPDATE " .. db .. ".hunter_supremo_log SET status = 'stolen', killed_by = '" .. mysql_escape_string(killer_name or "Unknown") .. "', gloria_awarded = -" .. penalty .. " WHERE supremo_vnum = " .. supremo_vnum .. " AND status = 'active' ORDER BY spawned_at DESC LIMIT 1")
                mysql_direct_query("INSERT INTO " .. db .. ".hunter_gate_history (player_id, player_name, gate_id, gate_name, result, gloria_change) VALUES (" .. pid .. ", '" .. mysql_escape_string(pname) .. "', " .. supremo_vnum .. ", '" .. mysql_escape_string(supremo_name) .. "', 'stolen', -" .. penalty .. ")")
                
                notice_all("[SUPREMO] " .. (killer_name or "Un cacciatore") .. " ha rubato il Supremo a " .. pname .. "!")
                
            else -- TIMEOUT
                -- === TIMEOUT! ===
                hunter_gate_trial.add_gloria(-penalty)
                hunter_gate_trial.close_supremo_challenge_ui("TIMEOUT", -penalty, "TEMPO+SCADUTO!+Il+Supremo+e+fuggito!")
                hunter_gate_trial.speak_color("TEMPO SCADUTO! IL SUPREMO E FUGGITO! -" .. penalty .. " GLORIA!", "RED")
                
                -- Log
                mysql_direct_query("UPDATE " .. db .. ".hunter_supremo_log SET status = 'failed', gloria_awarded = -" .. penalty .. " WHERE supremo_vnum = " .. supremo_vnum .. " AND status = 'active' ORDER BY spawned_at DESC LIMIT 1")
                mysql_direct_query("INSERT INTO " .. db .. ".hunter_gate_history (player_id, player_name, gate_id, gate_name, result, gloria_change) VALUES (" .. pid .. ", '" .. mysql_escape_string(pname) .. "', " .. supremo_vnum .. ", '" .. mysql_escape_string(supremo_name) .. "', 'timeout', -" .. penalty .. ")")
                
                notice_all("[SUPREMO] " .. pname .. " non e riuscito a sconfiggere " .. supremo_name .. " in tempo!")
            end
            
            hunter_gate_trial.send_gate_status()
        end
        
        -- Chiamata quando QUALCUNO uccide il Supremo (handler globale)
        function on_supremo_killed(killer_pid, killer_name)
            local supremo_active = game.get_event_flag("hgt_supremo_active") or 0
            if supremo_active ~= 1 then return end
            
            local summoner_pid = game.get_event_flag("hgt_supremo_summoner_pid") or 0
            if summoner_pid == 0 then return end
            
            -- Controlla se il killer e l'evocatore o nel suo party
            local is_valid_killer = (killer_pid == summoner_pid)
            
            -- Check party dell'evocatore
            if not is_valid_killer then
                for i = 1, 8 do
                    local party_member = game.get_event_flag("hgt_supremo_party_" .. i) or 0
                    if party_member > 0 and party_member == killer_pid then
                        is_valid_killer = true
                        break
                    end
                end
            end
            
            if is_valid_killer then
                -- Evocatore o membro party ha ucciso il boss = VITTORIA
                q.begin_other_pc_block(summoner_pid)
                hunter_gate_trial.end_supremo_challenge("SUCCESS", killer_name)
                q.end_other_pc_block()
            else
                -- LADRO ha ucciso il boss!
                -- 1. Evocatore perde gloria (STOLEN)
                q.begin_other_pc_block(summoner_pid)
                hunter_gate_trial.end_supremo_challenge("STOLEN", killer_name)
                q.end_other_pc_block()
                
                -- 2. Ladro riceve solo 10% della gloria (malus)
                local rank = hunter_gate_trial.rank_num_to_letter(game.get_event_flag("hgt_supremo_rank") or 0)
                local full_reward = hunter_gate_trial.get_supremo_gloria_reward(rank)
                local stolen_reward = math.floor(full_reward * 0.10)  -- Solo 10%!
                
                -- Dai gloria ridotta al ladro
                local db = hunter_gate_trial.get_config("db_name")
                mysql_direct_query("UPDATE " .. db .. ".hunter_quest_ranking SET total_points = total_points + " .. stolen_reward .. " WHERE player_id = " .. killer_pid)
                
                -- Notifica al ladro
                q.begin_other_pc_block(killer_pid)
                hunter_gate_trial.speak_color("Hai rubato il Supremo! Ricevi solo +" .. stolen_reward .. " Gloria (10% malus ladro).", "D")
                q.end_other_pc_block()
                
                notice_all("[SUPREMO] " .. killer_name .. " ha rubato il Supremo e riceve solo " .. stolen_reward .. " Gloria!")
            end
        end
        
        -- Spawna il Supremo VICINO AL GIOCATORE con tracking completo
        function spawn_supremo(summoner_name)
            local rank = hunter_gate_trial.get_player_rank()
            local vnum = hunter_gate_trial.get_supremo_vnum(rank)
            local supremo_name = hunter_gate_trial.get_supremo_name(rank)
            local pid = pc.get_player_id()
            local db = hunter_gate_trial.get_config("db_name")
            
            -- Durata sfida (default 10 minuti)
            local duration = hunter_gate_trial.safe_tonumber(hunter_gate_trial.get_supremo_setting("challenge_duration", "600"))
            
            -- Coordinate spawn (posizione giocatore)
            local spawn_x = pc.get_x()
            local spawn_y = pc.get_y()
            local local_x = pc.get_local_x()
            local local_y = pc.get_local_y()
            
            -- Spawna il mob vicino al giocatore
            mob.spawn(vnum, local_x + 5, local_y + 5, 1)
            
            -- === TRACKING GLOBALE DEL SUPREMO ===
            game.set_event_flag("hgt_supremo_active", 1)
            game.set_event_flag("hgt_supremo_vnum", vnum)
            game.set_event_flag("hgt_supremo_summoner_pid", pid)
            game.set_event_flag("hgt_supremo_rank", hunter_gate_trial.rank_letter_to_num(rank))
            game.set_event_flag("hgt_supremo_spawn_time", get_time())
            game.set_event_flag("hgt_supremo_expire_time", get_time() + duration)
            game.set_event_flag("hgt_supremo_spawn_x", spawn_x)
            game.set_event_flag("hgt_supremo_spawn_y", spawn_y)
            
            -- Salva membri del party per check furto
            for i = 1, 8 do
                game.set_event_flag("hgt_supremo_party_" .. i, 0)
            end
            if party.is_party() then
                local pids = {party.get_member_pids()}
                for i, member_pid in ipairs(pids) do
                    if i <= 8 then
                        game.set_event_flag("hgt_supremo_party_" .. i, member_pid)
                    end
                end
            else
                game.set_event_flag("hgt_supremo_party_1", pid) -- Solo player
            end
            
            -- Log nel database
            mysql_direct_query("INSERT INTO " .. db .. ".hunter_supremo_log (summoner_id, summoner_name, supremo_vnum, supremo_name, supremo_rank, map_index, coord_x, coord_y, status) VALUES (" .. pid .. ", '" .. mysql_escape_string(summoner_name) .. "', " .. vnum .. ", '" .. mysql_escape_string(supremo_name) .. "', '" .. rank .. "', " .. pc.get_map_index() .. ", " .. spawn_x .. ", " .. spawn_y .. ", 'active')")
            
            -- Imposta cooldown globale
            hunter_gate_trial.set_supremo_cooldown()
            
            -- === BROADCAST TESTUALE A TUTTI ===
            hunter_gate_trial.broadcast_supremo_awakening(summoner_name, supremo_name, rank)
            
            -- === UI AWAKENING PER EVOCATORE ===
            cmdchat("HunterSupremoAwakening " .. hunter_gate_trial.clean_str(summoner_name) .. "|" .. hunter_gate_trial.clean_str(supremo_name) .. "|" .. rank)
            
            -- === AVVIA SFIDA CON UI DEDICATA ===
            hunter_gate_trial.start_supremo_challenge(summoner_name, supremo_name, vnum, rank, duration, spawn_x, spawn_y)
            
            return true
        end
        
        -- Interazione con NPC Guardiano (ora Guardiano Supremi)
        function guardian_interaction()
            local pid = pc.get_player_id()
            local pname = pc.get_name()
            local db = hunter_gate_trial.get_config("db_name")
            
            -- GM Menu
            if pc.is_gm() then
                say_title("GM MENU | Guardiano Supremi")
                local gm_sel = select("Interazione Normale", "GM Resetta Accessi", "GM Concedi Accesso", "GM Spawn Supremo Forzato", "GM Reset Cooldown", "Chiudi")
                if gm_sel == 6 then return
                elseif gm_sel > 1 then
                    if gm_sel == 2 then 
                        mysql_direct_query("DELETE FROM " .. db .. ".hunter_gate_access WHERE player_id=" .. pid)
                        syschat("[GM] Tutti i tuoi accessi sono stati resettati.")
                        return
                    elseif gm_sel == 3 then 
                        hunter_gate_trial.grant_gate_access(pid, pname, 1, 2)
                        hunter_gate_trial.send_gate_status()
                        syschat("[GM] Accesso al Supremo concesso.")
                        return
                    elseif gm_sel == 4 then
                        game.set_event_flag("hgt_supremo_cooldown_end", 0) -- Reset cooldown
                        hunter_gate_trial.spawn_supremo(pname)
                        syschat("[GM] Supremo spawnato forzatamente.")
                        return
                    elseif gm_sel == 5 then
                        game.set_event_flag("hgt_supremo_cooldown_end", 0)
                        syschat("[GM] Cooldown Supremo resettato.")
                        return
                    end
                end
            end
            
            -- Carica dati giocatore
            hunter_gate_trial.load_player_cache()
            local rank = hunter_gate_trial.get_player_rank()
            local supremo_name = hunter_gate_trial.get_supremo_name(rank)
            local access = hunter_gate_trial.check_gate_access()
            
            -- Se NON ha accesso
            if not access.has_access then
                say_title("GUARDIANO DEI SUPREMI")
                say("")
                say("Il Sistema non ti ha scelto per sfidare i Supremi.")
                say("")
                say("Solo i cacciatori degni vengono selezionati")
                say("casualmente dal Sistema Hunter.")
                say("")
                say("La tua arroganza nel presentarti senza")
                say("essere stato scelto sara punita!")
                say("")
                
                local penalty = hunter_gate_trial.safe_tonumber(hunter_gate_trial.get_supremo_setting("rejection_penalty", "250"))
                hunter_gate_trial.add_gloria(-penalty)
                hunter_gate_trial.show_gate_defeat_effect(penalty)
                hunter_gate_trial.speak_color("HAI PERSO " .. penalty .. " GLORIA!", "RED")
                
                mysql_direct_query("INSERT INTO " .. db .. ".hunter_gate_history (player_id, player_name, gate_id, result, gloria_change) VALUES (" .. pid .. ", '" .. mysql_escape_string(pname) .. "', 0, 'rejection', -" .. penalty .. ")")
                return
            end
            
            -- Ha accesso - mostra opzioni Supremo
            say_title("GUARDIANO DEI SUPREMI")
            say("")
            say("|cFFFFD700Il Sistema ti ha scelto!|r")
            say("")
            say("Sei pronto a sfidare uno dei Supremi?")
            say("")
            say("|cFF" .. hunter_gate_trial.get_rank_color_hex(rank) .. "Supremo disponibile: " .. supremo_name .. "|r")
            say("|cFFAAAAAAGrado: " .. rank .. "-Rank|r")
            say("")
            say("Tempo rimasto per accettare:")
            say("|cFFFFD700" .. hunter_gate_trial.format_time(access.remaining_seconds) .. "|r")
            say("")
            
            -- Controlla cooldown
            if hunter_gate_trial.is_supremo_on_cooldown() then
                local cd_remaining = hunter_gate_trial.get_supremo_cooldown_remaining()
                say("|cFFFF0000ATTENZIONE: Un Supremo e gia stato evocato!|r")
                say("|cFFFF0000Attendi " .. hunter_gate_trial.format_time(cd_remaining) .. " prima di poter evocare.|r")
                say("")
            end
            
            local sel = select("Evoca il Supremo!", "Non sono pronto", "Apri Finestra Hunter")
            
            if sel == 1 then
                -- Controlla di nuovo il cooldown
                if hunter_gate_trial.is_supremo_on_cooldown() then
                    local cd_remaining = hunter_gate_trial.get_supremo_cooldown_remaining()
                    hunter_gate_trial.speak_color("Un Supremo e gia attivo! Attendi " .. math.ceil(cd_remaining/60) .. " minuti.", "RED")
                    return
                end
                
                say_title("CONFERMA EVOCAZIONE")
                say("")
                say("|cFFFF0000ATTENZIONE!|r")
                say("")
                say("Stai per evocare " .. supremo_name .. " nella mappa!")
                say("")
                say("|cFFFFD700Il Supremo apparira VICINO A TE!|r")
                say("")
                say("|cFF00FF00TUTTI potranno attaccarlo!|r")
                say("|cFFFF6600Le gilde nemiche potrebbero rubartelo!|r")
                say("")
                
                if select("EVOCA ORA!", "Ci devo pensare") == 1 then
                    -- Segna accesso come usato
                    mysql_direct_query("UPDATE " .. db .. ".hunter_gate_access SET status = 'used', entered_at = NOW() WHERE access_id = " .. access.access_id)
                    
                    -- Spawna il Supremo
                    hunter_gate_trial.spawn_supremo(pname)
                    
                    -- Effetto UI
                    hunter_gate_trial.show_supremo_spawn_effect(supremo_name, rank, pname)
                    hunter_gate_trial.show_gate_entry_effect(supremo_name, rank)
                    hunter_gate_trial.speak_color("HAI EVOCATO " .. supremo_name .. "! CORRI A UCCIDERLO!", rank)
                    
                    -- Log nel database
                    mysql_direct_query("INSERT INTO " .. db .. ".hunter_gate_history (player_id, player_name, gate_id, gate_name, result, gloria_change) VALUES (" .. pid .. ", '" .. mysql_escape_string(pname) .. "', " .. access.gate_id .. ", '" .. mysql_escape_string(supremo_name) .. "', 'summoned', 0)")
                    
                    -- Aggiorna stato
                    hunter_gate_trial.send_gate_status()
                end
            elseif sel == 3 then 
                hunter_gate_trial.open_gate_trial_window() 
            end
        end
        
        -- Helper per ottenere colore hex del rank
        function get_rank_color_hex(rank)
            local colors = {
                ["E"] = "808080",
                ["D"] = "00FF00",
                ["C"] = "00FFFF",
                ["B"] = "0066FF",
                ["A"] = "AA00FF",
                ["S"] = "FF6600",
                ["N"] = "FF0000",
            }
            return colors[rank] or "FFFFFF"
        end
        
        -- ============================================================
        -- 5. RANK TRIAL LOGIC
        -- ============================================================

        function check_trial_available()
            local current_rank = hunter_gate_trial.get_player_rank()
            if current_rank == "N" then return { available = false, message = "Hai raggiunto il rank massimo!", at_max = true } end
            -- Prima controlla se c'e' una trial in corso (indipendentemente dal trial_id)
            if pc.getqf("hgt_trial_active") == 1 and pc.getqf("hgt_trial_id") > 0 then 
                return { available = false, message = "Hai gia una prova in corso.", in_progress = true, trial_id = pc.getqf("hgt_trial_id") } 
            end
            local db = hunter_gate_trial.get_config("db_name"); local ct, dt = mysql_direct_query("SELECT * FROM " .. db .. ".hunter_rank_trials WHERE from_rank = '" .. current_rank .. "' AND enabled = 1 LIMIT 1")
            if ct == 0 then return { available = false, message = "Nessuna prova disponibile per il tuo rank." } end
            local trial = dt[1]
            local required_gloria = hunter_gate_trial.safe_tonumber(trial.required_gloria)
            if hunter_gate_trial.get_player_gloria() < required_gloria then return { available = false, message = "Gloria insufficiente.", missing_gloria = required_gloria - hunter_gate_trial.get_player_gloria() } end
            local required_level = hunter_gate_trial.safe_tonumber(trial.required_level)
            if pc.get_level() < required_level then return { available = false, message = "Livello insufficiente.", missing_level = required_level - pc.get_level() } end
            return { available = true, trial = trial }
        end
        
        function start_trial()
            local pid, pname, db = pc.get_player_id(), mysql_escape_string(pc.get_name()), hunter_gate_trial.get_config("db_name")
            local check = hunter_gate_trial.check_trial_available()
            if not check.available then hunter_gate_trial.speak_color(check.message, "RED"); return end
            local trial = check.trial; local time_limit = hunter_gate_trial.safe_tonumber(trial.time_limit_hours); local expires_sql = (time_limit > 0) and "DATE_ADD(NOW(), INTERVAL " .. time_limit .. " HOUR)" or "NULL"
            mysql_direct_query("INSERT INTO " .. db .. ".hunter_player_trials (player_id, trial_id, status, started_at, expires_at) VALUES (" .. pid .. ", " .. trial.trial_id .. ", 'in_progress', NOW(), " .. expires_sql .. ") ON DUPLICATE KEY UPDATE status = 'in_progress', started_at = NOW(), expires_at = " .. expires_sql .. ", boss_kills=0, metin_kills=0, fracture_seals=0, chest_opens=0, daily_missions=0")
            pc.setqf("hgt_trial_id", hunter_gate_trial.safe_tonumber(trial.trial_id)); pc.setqf("hgt_trial_active", 1)
            notice_all("[HUNTER SYSTEM] " .. pname .. " ha iniziato la " .. trial.trial_name .. "!"); hunter_gate_trial.speak_color("PROVA INIZIATA: " .. trial.trial_name, trial.color_code); hunter_gate_trial.send_trial_status()
            
            -- Se la prova ha limite di tempo, avvia il timer di controllo scadenza
            if time_limit > 0 then
                timer("hgt_trial_expire_check", 300)  -- Check ogni 5 minuti
                local time_str = hunter_gate_trial.format_time_days(time_limit * 3600)
                hunter_gate_trial.speak_color("ATTENZIONE: Hai " .. time_str .. " per completare questa prova!", "ORANGE")
            end
        end
        
        function get_trial_progress()
            if pc.getqf("hgt_trial_active") ~= 1 then return nil end
            local pid, db, trial_id = pc.get_player_id(), hunter_gate_trial.get_config("db_name"), pc.getqf("hgt_trial_id")
            local c, d = mysql_direct_query("SELECT pt.*, rt.*, TIMESTAMPDIFF(SECOND, NOW(), pt.expires_at) as remaining_seconds FROM " .. db .. ".hunter_player_trials pt JOIN " .. db .. ".hunter_rank_trials rt ON pt.trial_id = rt.trial_id WHERE pt.player_id = " .. pid .. " AND pt.trial_id = " .. trial_id .. " AND pt.status = 'in_progress'")
            if c > 0 and d[1] then return d[1] end
            pc.setqf("hgt_trial_active", 0); return nil
        end
        
        function update_trial_progress(progress_type, vnum)
            if pc.getqf("hgt_trial_active") ~= 1 then return end
            local progress = hunter_gate_trial.get_trial_progress()
            if not progress then return end
            local pid, db = pc.get_player_id(), hunter_gate_trial.get_config("db_name")
            local should_update, field_name = false, ""
            if progress_type == "boss_kill" and hunter_gate_trial.safe_tonumber(progress.required_boss_kills) > hunter_gate_trial.safe_tonumber(progress.boss_kills) then field_name = "boss_kills"; local v_list = progress.boss_vnum_list or ""; if v_list == "" or string.find(","..v_list..",", ","..vnum..",") then should_update = true end
            elseif progress_type == "metin_kill" and hunter_gate_trial.safe_tonumber(progress.required_metin_kills) > hunter_gate_trial.safe_tonumber(progress.metin_kills) then field_name = "metin_kills"; local v_list = progress.metin_vnum_list or ""; if v_list == "" or string.find(","..v_list..",", ","..vnum..",") then should_update = true end
            elseif progress_type == "fracture_seal" and hunter_gate_trial.safe_tonumber(progress.required_fracture_seals) > hunter_gate_trial.safe_tonumber(progress.fracture_seals) then field_name = "fracture_seals"; should_update = true
            elseif progress_type == "chest_open" and hunter_gate_trial.safe_tonumber(progress.required_chest_opens) > hunter_gate_trial.safe_tonumber(progress.chest_opens) then field_name = "chest_opens"; should_update = true
            elseif progress_type == "daily_mission" and hunter_gate_trial.safe_tonumber(progress.required_daily_missions) > hunter_gate_trial.safe_tonumber(progress.daily_missions) then field_name = "daily_missions"; should_update = true
            end
            if should_update then mysql_direct_query("UPDATE " .. db .. ".hunter_player_trials SET " .. field_name .. " = " .. field_name .. " + 1 WHERE player_id=" .. pid .. " AND trial_id=" .. progress.trial_id); hunter_gate_trial.send_trial_status(); hunter_gate_trial.check_trial_complete() end
        end
        
        function check_trial_complete()
            local progress = hunter_gate_trial.get_trial_progress()
            if not progress then return end
            if hunter_gate_trial.safe_tonumber(progress.boss_kills) >= hunter_gate_trial.safe_tonumber(progress.required_boss_kills) and hunter_gate_trial.safe_tonumber(progress.metin_kills) >= hunter_gate_trial.safe_tonumber(progress.required_metin_kills) and hunter_gate_trial.safe_tonumber(progress.fracture_seals) >= hunter_gate_trial.safe_tonumber(progress.required_fracture_seals) and hunter_gate_trial.safe_tonumber(progress.chest_opens) >= hunter_gate_trial.safe_tonumber(progress.required_chest_opens) and hunter_gate_trial.safe_tonumber(progress.daily_missions) >= hunter_gate_trial.safe_tonumber(progress.required_daily_missions) then
                local pid, pname, db = pc.get_player_id(), mysql_escape_string(pc.get_name()), hunter_gate_trial.get_config("db_name")
                local old_rank, new_rank, gloria = hunter_gate_trial.get_player_rank(), progress.to_rank, hunter_gate_trial.safe_tonumber(progress.gloria_reward)
                mysql_direct_query("UPDATE " .. db .. ".hunter_player_trials SET status='completed', completed_at=NOW() WHERE player_id=" .. pid .. " AND trial_id=" .. progress.trial_id); mysql_direct_query("UPDATE " .. db .. ".hunter_quest_ranking SET hunter_rank='" .. new_rank .. "', current_rank='" .. new_rank .. "' WHERE player_id=" .. pid)
                hunter_gate_trial.add_gloria(gloria); pc.setqf("hgt_trial_id", 0); pc.setqf("hgt_trial_active", 0); pc.setqf("hgt_cache_rank_num", hunter_gate_trial.rank_letter_to_num(new_rank))
                -- FIX: Incrementa contatore trial completate per achievement
                pc.setqf("hq_total_trials", (pc.getqf("hq_total_trials") or 0) + 1)
                hunter_gate_trial.show_rank_up_effect(old_rank, new_rank); notice_all("[HUNTER SYSTEM] " .. pname .. " ha completato la prova e raggiunto il " .. new_rank .. "-RANK!")
                hunter_gate_trial.speak_color("PROVA COMPLETATA! SEI ORA UN " .. new_rank .. "-RANK HUNTER!", progress.color_code); hunter_gate_trial.send_trial_status()
            end
        end
        
        function trial_master_interaction()
            if pc.is_gm() then
                say_title("GM MENU | Maestro Prove"); local gm_sel = select("Interazione Normale", "GM Resetta Prova", "GM +1 Boss", "GM +1 Metin", "GM +1 Altro", "GM Reset Rank", "Chiudi"); if gm_sel == 7 then return 
                elseif gm_sel > 1 then
                    if gm_sel == 2 then mysql_direct_query("DELETE FROM " .. hunter_gate_trial.get_config("db_name") .. ".hunter_player_trials WHERE player_id=" .. pc.get_player_id()); pc.setqf("hgt_trial_id", 0); pc.setqf("hgt_trial_active", 0); syschat("[GM] Prova resettata."); return
                    elseif gm_sel == 3 then hunter_gate_trial.update_trial_progress("boss_kill", 0); syschat("[GM] +1 Boss Kill aggiunto."); return
                    elseif gm_sel == 4 then hunter_gate_trial.update_trial_progress("metin_kill", 0); syschat("[GM] +1 Metin Kill aggiunto."); return
                    elseif gm_sel == 5 then hunter_gate_trial.update_trial_progress("fracture_seal", 0); hunter_gate_trial.update_trial_progress("chest_open", 0); hunter_gate_trial.update_trial_progress("daily_mission", 0); syschat("[GM] +1 a Fratture, Bauli e Missioni."); return
                    elseif gm_sel == 6 then mysql_direct_query("UPDATE " .. hunter_gate_trial.get_config("db_name") .. ".hunter_quest_ranking SET hunter_rank='E', current_rank='E' WHERE player_id=" .. pc.get_player_id()); pc.setqf("hgt_cache_rank_num", 0); syschat("[GM] Rank resettato a E."); return end
                end
            end
            local check = hunter_gate_trial.check_trial_available()
            say_title("MAESTRO DELLE PROVE"); say("Bentornato, " .. hunter_gate_trial.get_player_rank() .. "-Rank Hunter.")
            if check.at_max then say("Hai raggiunto il rank massimo! Non ci sono piu prove per te."); return end
            if check.in_progress then
                local progress = hunter_gate_trial.get_trial_progress()
                if progress then
                    say("Stai affrontando: " .. progress.trial_name); say("Obiettivo: " .. progress.to_rank .. "-RANK"); say(""); say("Progresso attuale:")
                    if hunter_gate_trial.safe_tonumber(progress.required_boss_kills) > 0 then say("  - Boss: " .. hunter_gate_trial.safe_tonumber(progress.boss_kills) .. "/" .. hunter_gate_trial.safe_tonumber(progress.required_boss_kills)) end
                    if hunter_gate_trial.safe_tonumber(progress.required_metin_kills) > 0 then say("  - Metin: " .. hunter_gate_trial.safe_tonumber(progress.metin_kills) .. "/" .. hunter_gate_trial.safe_tonumber(progress.required_metin_kills)) end
                    if hunter_gate_trial.safe_tonumber(progress.required_fracture_seals) > 0 then say("  - Fratture: " .. hunter_gate_trial.safe_tonumber(progress.fracture_seals) .. "/" .. hunter_gate_trial.safe_tonumber(progress.required_fracture_seals)) end
                    if hunter_gate_trial.safe_tonumber(progress.required_chest_opens) > 0 then say("  - Bauli: " .. hunter_gate_trial.safe_tonumber(progress.chest_opens) .. "/" .. hunter_gate_trial.safe_tonumber(progress.required_chest_opens)) end
                    if hunter_gate_trial.safe_tonumber(progress.required_daily_missions) > 0 then say("  - Missioni: " .. hunter_gate_trial.safe_tonumber(progress.daily_missions) .. "/" .. hunter_gate_trial.safe_tonumber(progress.required_daily_missions)) end
                    if hunter_gate_trial.safe_tonumber(progress.remaining_seconds) > 0 then say(""); say("Tempo rimasto: " .. hunter_gate_trial.format_time_days(hunter_gate_trial.safe_tonumber(progress.remaining_seconds))) end
                end
                local sel = select("Mostra Progresso UI", "Annulla Prova", "Chiudi")
                if sel == 1 then hunter_gate_trial.open_gate_trial_window()
                elseif sel == 2 then
                    if select("Vuoi davvero annullare?", "Si, annulla", "No") == 1 then
                        local current_trial_id = pc.getqf("hgt_trial_id")
                        if current_trial_id and current_trial_id > 0 then
                            mysql_direct_query("UPDATE " .. hunter_gate_trial.get_config("db_name") .. ".hunter_player_trials SET status='failed' WHERE player_id=" .. pc.get_player_id() .. " AND trial_id=" .. current_trial_id)
                        end
                        pc.setqf("hgt_trial_id", 0); pc.setqf("hgt_trial_active", 0); hunter_gate_trial.speak_color("Prova annullata.", "RED"); hunter_gate_trial.send_trial_status()
                    end
                end
                return
            end
            if not check.available then
                say(check.message)
                if check.missing_gloria then say("Ti mancano " .. check.missing_gloria .. " Gloria.") end
                if check.missing_level then say("Ti mancano " .. check.missing_level .. " livelli.") end
                return
            end
            local trial = check.trial
            say("Una nuova prova ti attende: " .. trial.trial_name); say("Obiettivo: Diventare " .. trial.to_rank .. "-RANK")
            if select("Inizia la Prova!", "Non sono pronto") == 1 then hunter_gate_trial.start_trial() end
        end
        
        function check_and_send_letter(force_send)
            -- Cooldown 5 minuti tra check (ignorato se force_send)
            if not force_send then
                if get_time() < (pc.getqf("hgt_last_letter_check") or 0) + 300 then return end
            end
            pc.setqf("hgt_last_letter_check", get_time())
            
            -- Se ha prova in corso, invia lettera per vedere progresso
            if pc.getqf("hgt_trial_active") == 1 then
                send_letter("Prova di Rank in Corso")
                return
            end
            
            -- Se pu� iniziare nuova prova
            if hunter_gate_trial.check_trial_available().available then 
                send_letter("Promozione Hunter Disponibile") 
            end
        end
        
        -- ============================================================
        -- 5B. TRIAL EXPIRATION SYSTEM
        -- ============================================================
        
        function check_trial_expired()
            -- Controlla se la prova attiva � scaduta
            if pc.getqf("hgt_trial_active") ~= 1 then return false end
            
            local progress = hunter_gate_trial.get_trial_progress()
            if not progress then return false end
            
            -- Se time_limit_hours � NULL (nessun limite), non scade mai
            local time_limit = hunter_gate_trial.safe_tonumber(progress.time_limit_hours)
            if time_limit == 0 or time_limit == nil then return false end
            
            -- Controlla se remaining_seconds � negativo (scaduta)
            local remaining = hunter_gate_trial.safe_tonumber(progress.remaining_seconds)
            if remaining ~= nil and remaining <= 0 then
                -- PROVA SCADUTA!
                hunter_gate_trial.fail_trial_expired(progress)
                return true
            end
            
            return false
        end
        
        function fail_trial_expired(progress)
            local pid, pname, db = pc.get_player_id(), mysql_escape_string(pc.get_name()), hunter_gate_trial.get_config("db_name")
            local trial_id = progress.trial_id or pc.getqf("hgt_trial_id")
            
            -- Aggiorna status a 'expired' nel database
            mysql_direct_query("UPDATE " .. db .. ".hunter_player_trials SET status='expired', completed_at=NOW() WHERE player_id=" .. pid .. " AND trial_id=" .. trial_id)
            
            -- Reset flag locali
            pc.setqf("hgt_trial_id", 0)
            pc.setqf("hgt_trial_active", 0)
            
            -- Notifica il giocatore
            local trial_name = progress.trial_name or "Prova di Rank"
            hunter_gate_trial.speak_color("TEMPO SCADUTO! La " .. trial_name .. " � fallita.", "RED")
            syschat("[HUNTER] La tua prova di rank � scaduta. Puoi riprovare parlando col Maestro delle Prove.")
            
            -- Aggiorna UI client
            hunter_gate_trial.send_trial_status()
            
            -- Log per debug
            if pc.is_gm() then
                syschat("[DEBUG] Trial " .. trial_id .. " marked as expired for player " .. pid)
            end
        end
        
        function get_trial_time_warning()
            -- Restituisce avviso se la prova sta per scadere
            if pc.getqf("hgt_trial_active") ~= 1 then return nil end
            
            local progress = hunter_gate_trial.get_trial_progress()
            if not progress then return nil end
            
            local time_limit = hunter_gate_trial.safe_tonumber(progress.time_limit_hours)
            if time_limit == 0 or time_limit == nil then return nil end
            
            local remaining = hunter_gate_trial.safe_tonumber(progress.remaining_seconds)
            if remaining == nil then return nil end
            
            -- Avvisi a soglie specifiche
            local hours_left = remaining / 3600
            
            if hours_left <= 1 then
                return "CRITICO", "Meno di 1 ORA rimasta!"
            elseif hours_left <= 6 then
                return "URGENTE", "Meno di 6 ore rimaste!"
            elseif hours_left <= 24 then
                return "ATTENZIONE", "Meno di 24 ore rimaste!"
            end
            
            return nil
        end
        
        -- ============================================================
        -- 6. EVENT HANDLERS
        -- ============================================================
        
        when 20019.click begin hunter_gate_trial.guardian_interaction() end
        when 20020.click begin hunter_gate_trial.trial_master_interaction() end
        when button or info begin hunter_gate_trial.open_gate_trial_window() end
        
        -- FIX: Handler per richiesta dati dal client (popola la UI)
        when chat."/hunter_request_trial_data" begin
            hunter_gate_trial.send_gate_status()
            hunter_gate_trial.send_trial_status()
        end
        
        when login with pc.get_level() >= 5 begin timer("hgt_login_check", 2) end
        
        when hgt_login_check.timer begin
            hunter_gate_trial.load_player_cache(); hunter_gate_trial.send_gate_status()
            hunter_gate_trial.send_trial_status(); hunter_gate_trial.check_and_send_letter(true)  -- force_send al login
            
            -- Controlla se la prova � scaduta
            if hunter_gate_trial.check_trial_expired() then
                -- Prova gi� fallita, non fare altro
            else
                -- Se ha prova attiva con limite tempo, avvia timer periodico
                if pc.getqf("hgt_trial_active") == 1 then
                    local progress = hunter_gate_trial.get_trial_progress()
                    if progress and hunter_gate_trial.safe_tonumber(progress.time_limit_hours) > 0 then
                        -- Timer ogni 5 minuti per controllare scadenza
                        timer("hgt_trial_expire_check", 300)
                        
                        -- Mostra avviso se sta per scadere
                        local severity, message = hunter_gate_trial.get_trial_time_warning()
                        if severity then
                            hunter_gate_trial.speak_color("[" .. severity .. "] " .. message, "RED")
                        end
                    end
                end
            end
        end
        
        -- Timer periodico per controllare scadenza prove (ogni 5 minuti)
        when hgt_trial_expire_check.timer begin
            if pc.getqf("hgt_trial_active") ~= 1 then
                cleartimer("hgt_trial_expire_check")
                return
            end
            
            -- Controlla se scaduta
            if hunter_gate_trial.check_trial_expired() then
                cleartimer("hgt_trial_expire_check")
                return
            end
            
            -- Mostra avviso se sta per scadere
            local severity, message = hunter_gate_trial.get_trial_time_warning()
            if severity == "CRITICO" then
                hunter_gate_trial.speak_color("[" .. severity .. "] " .. message, "RED")
                notice_in_map("[HUNTER] " .. pc.get_name() .. ": La tua prova sta per scadere!")
            elseif severity == "URGENTE" then
                hunter_gate_trial.speak_color("[" .. severity .. "] " .. message, "ORANGE")
            end
            
            -- Continua il timer
            timer("hgt_trial_expire_check", 300)
        end

        when logout begin
            local pid = pc.get_player_id()
            if _G.hgt_player_data and _G.hgt_player_data[pid] then _G.hgt_player_data[pid] = nil end
        end

        when levelup with pc.get_level() >= 30 begin hunter_gate_trial.check_and_send_letter() end
        
        -- === HANDLER KILL SUPREMO ===
        -- Questo handler cattura l'uccisione del Supremo da QUALSIASI giocatore
        when kill with game.get_event_flag("hgt_supremo_active") == 1 begin
            local killed_vnum = npc.get_race()
            local supremo_vnum = game.get_event_flag("hgt_supremo_vnum") or 0
            
            -- E' il Supremo?
            if killed_vnum == supremo_vnum and supremo_vnum > 0 then
                local killer_pid = pc.get_player_id()
                local killer_name = pc.get_name()
                
                -- Chiama handler globale
                hunter_gate_trial.on_supremo_killed(killer_pid, killer_name)
            end
        end
        
        -- === TIMER CHECK TIMEOUT E DISTANZA SUPREMO ===
        when hgt_supremo_check.timer begin
            -- Solo chi ha sfida attiva
            if pc.getqf("hgt_supremo_active") ~= 1 then
                cleartimer("hgt_supremo_check")
                return
            end
            
            -- Gia abbandonato? Stop
            if pc.getqf("hgt_supremo_abandoned") == 1 then
                cleartimer("hgt_supremo_check")
                return
            end
            
            local expire = pc.getqf("hgt_supremo_expire") or 0
            local time_left = expire - get_time()
            
            -- === CHECK DISTANZA ===
            local spawn_x = game.get_event_flag("hgt_supremo_spawn_x") or pc.getqf("hgt_supremo_spawn_x") or 0
            local spawn_y = game.get_event_flag("hgt_supremo_spawn_y") or pc.getqf("hgt_supremo_spawn_y") or 0
            local player_x = pc.get_x()
            local player_y = pc.get_y()
            
            local dx = player_x - spawn_x
            local dy = player_y - spawn_y
            local distance = math.sqrt(dx * dx + dy * dy)
            local max_distance = hunter_gate_trial.get_supremo_max_distance()
            
            -- Aggiorna UI con tempo e distanza
            local status = "FIGHTING"
            if distance > max_distance * 0.8 then
                status = "WARNING"  -- Sta per uscire dal range
            end
            hunter_gate_trial.update_supremo_challenge_ui(math.max(0, time_left), distance, status)
            
            -- Se troppo lontano = ABBANDONO!
            if distance > max_distance then
                hunter_gate_trial.handle_member_abandon()
                return
            end
            
            -- Se tempo scaduto = TIMEOUT!
            if time_left <= 0 then
                hunter_gate_trial.end_supremo_challenge("TIMEOUT", nil)
                return
            end
        end
        
        when kill with pc.getqf("hgt_in_gate") == 1 or pc.getqf("hgt_trial_active") == 1 or party.is_party() begin
            local vnum = npc.get_race()
            local killer_pid = pc.get_player_id()
            
            -- Gate completion (solo per chi � dentro)
            if pc.getqf("hgt_in_gate") == 1 and vnum == pc.getqf("hgt_gate_boss_vnum") then 
                hunter_gate_trial.complete_gate(true)
                return 
            end
            
            -- Trial progress per il killer
            if pc.getqf("hgt_trial_active") == 1 then 
                hunter_gate_trial.update_trial_progress("boss_kill", vnum)
                hunter_gate_trial.update_trial_progress("metin_kill", vnum) 
            end
            
            -- === PARTY SUPPORT: I membri del gruppo aiutano con le prove! ===
            if party.is_party() then
                local pids = {party.get_member_pids()}
                for i, member_pid in ipairs(pids) do
                    if member_pid ~= killer_pid then
                        -- Aggiorna progresso per ogni membro del party con prova attiva
                        q.begin_other_pc_block(member_pid)
                        if pc.getqf("hgt_trial_active") == 1 then
                            hunter_gate_trial.update_trial_progress("boss_kill", vnum)
                            hunter_gate_trial.update_trial_progress("metin_kill", vnum)
                            -- Notifica al membro che ha ricevuto aiuto
                            syschat("[HUNTER] Il tuo compagno ti ha aiutato! Progresso aggiornato.")
                        end
                        q.end_other_pc_block()
                    end
                end
            end
        end

        -- ============================================================
        -- 7. GLOBAL HOOKS (da chiamare da altre quest)
        -- ============================================================
        
        function register_hooks()
            -- Hook globale per aggiornare progresso trial
            _G.HGT_UpdateTrialProgress = function(player_pid, progress_type, vnum)
                if pc.get_player_id() == player_pid then
                    hunter_gate_trial.update_trial_progress(progress_type, vnum or 0)
                end
            end
            
            -- Hook per aggiornare progresso a TUTTO il party (fratture, bauli, missioni)
            _G.HGT_UpdatePartyTrialProgress = function(progress_type, vnum)
                local caller_pid = pc.get_player_id()
                
                -- Aggiorna per il chiamante
                if pc.getqf("hgt_trial_active") == 1 then
                    hunter_gate_trial.update_trial_progress(progress_type, vnum or 0)
                end
                
                -- Aggiorna per i membri del party
                if party.is_party() then
                    local pids = {party.get_member_pids()}
                    for i, member_pid in ipairs(pids) do
                        if member_pid ~= caller_pid then
                            q.begin_other_pc_block(member_pid)
                            if pc.getqf("hgt_trial_active") == 1 then
                                hunter_gate_trial.update_trial_progress(progress_type, vnum or 0)
                                syschat("[HUNTER] Il tuo compagno ti ha aiutato con: " .. progress_type)
                            end
                            q.end_other_pc_block()
                        end
                    end
                end
            end
        end

        when letter begin
            hunter_gate_trial.register_hooks()
        end
        
        -- Handler per lettera "Promozione Hunter Disponibile" - apre UI
        when letter."Promozione Hunter Disponibile" begin
            hunter_gate_trial.load_player_cache()
            hunter_gate_trial.send_gate_status()
            hunter_gate_trial.send_trial_status()
            -- FIX: Timer per aspettare che i dati arrivino al client prima di aprire la finestra
            timer("hgt_open_window_delayed", 1)
            -- Reinvia lettera dopo apertura (cos� rimane disponibile al prossimo login)
            hunter_gate_trial.check_and_send_letter(true)
        end
        
        -- Handler per lettera "Prova di Rank in Corso" - apre UI
        when letter."Prova di Rank in Corso" begin
            hunter_gate_trial.load_player_cache()
            hunter_gate_trial.send_gate_status()
            hunter_gate_trial.send_trial_status()
            -- FIX: Timer per aspettare che i dati arrivino al client prima di aprire la finestra
            timer("hgt_open_window_delayed", 1)
            -- Reinvia lettera dopo apertura (cos� rimane disponibile al prossimo login)
            hunter_gate_trial.check_and_send_letter(true)
        end
        
        -- Timer per aprire finestra con delay (assicura che i dati siano arrivati al client)
        when hgt_open_window_delayed.timer begin
            hunter_gate_trial.open_gate_trial_window()
        end
        
    end
end