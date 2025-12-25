-- ============================================================
-- HUNTER SYSTEM TEST QUEST v2.0
-- Test completo sistema 100% configurabile da DB
-- ============================================================
-- Author: Senior Metin2 Developer
-- Version: 2.0
-- Date: 2025
-- ============================================================

quest hunter_test_quest begin
    state start begin
        -- ============================================================
        -- LOGIN HANDLER - Attiva test mode se abilitato
        -- ============================================================
        when login begin
            -- Carica config dal DB
            local test_enabled = tonumber(hunter_level_bridge.get_config("test_mode_enabled"))
            if test_enabled == 1 and pc.is_gm() then
                syschat("|cff00FF00[HUNTER TEST] Modalità test ATTIVA|r")
                syschat("|cffFFD700  Usa /hunter_test per aprire menu test|r")
                timer("hunter_test_autoshow", 3)
            end
        end

        when hunter_test_autoshow.timer begin
            syschat("|cff00FFFF[HUNTER TEST] Menu test disponibile: /hunter_test|r")
        end

        -- ============================================================
        -- MENU TEST PRINCIPALE
        -- ============================================================
        when chat."/hunter_test" with pc.is_gm() begin
            timer("hunter_test_menu", 1)
        end

        when hunter_test_menu.timer begin
            local menu_options = {
                "Test 1: Soglie Rank (DB Config)",
                "Test 2: Colori Rank (56+ colors)",
                "Test 3: Stringhe UI (35+ strings)",
                "Test 4: Dimensioni UI (20+ dims)",
                "Test 5: Achievements Real-Time",
                "Test 6: Penalty System",
                "Test 7: Rival Tracker",
                "Test 8: Streak Milestones",
                "Test 9: Gloria Sources",
                "Test 10: Config Reload",
                "---",
                "Chiudi Menu Test"
            }

            local sel = select(table.unpack(menu_options))

            if sel == 1 then
                -- ========================================================
                -- TEST 1: SOGLIE RANK
                -- ========================================================
                syschat("|cffFFD700========================================|r")
                syschat("|cffFFD700[TEST 1] SOGLIE RANK|r")
                syschat("|cffFFD700========================================|r")

                -- Leggi soglie attuali dal DB
                local N = tonumber(hunter_level_bridge.get_config("rank_threshold_N"))
                local S = tonumber(hunter_level_bridge.get_config("rank_threshold_S"))
                local A = tonumber(hunter_level_bridge.get_config("rank_threshold_A"))
                local B = tonumber(hunter_level_bridge.get_config("rank_threshold_B"))
                local C = tonumber(hunter_level_bridge.get_config("rank_threshold_C"))
                local D = tonumber(hunter_level_bridge.get_config("rank_threshold_D"))

                if N and S and A and B and C and D then
                    syschat("|cff00FF00✓ Soglie rank caricate correttamente dal DB|r")
                    syschat("|cffFFFFFF  Rank N: " .. N .. " pts|r")
                    syschat("|cffFFFFFF  Rank S: " .. S .. " pts|r")
                    syschat("|cffFFFFFF  Rank A: " .. A .. " pts|r")
                    syschat("|cffFFFFFF  Rank B: " .. B .. " pts|r")
                    syschat("|cffFFFFFF  Rank C: " .. C .. " pts|r")
                    syschat("|cffFFFFFF  Rank D: " .. D .. " pts|r")
                    syschat("|cffFFFFFF  Rank E: 0 pts|r")

                    -- Test calcolo rank
                    syschat("|cff00FFFF[VERIFICA] Calcolo automatico rank:|r")
                    local test_points = {0, 2000, 10000, 50000, 150000, 500000, 1500000}
                    local expected_ranks = {"E", "D", "C", "B", "A", "S", "N"}

                    for i, pts in ipairs(test_points) do
                        local rank_idx = hunter_level_bridge.get_rank_index(pts)
                        local rank_letter = hunter_level_bridge.get_rank_letter(rank_idx)
                        local expected = expected_ranks[i]

                        if rank_letter == expected then
                            syschat("|cff00FF00  ✓ " .. pts .. " pts → " .. rank_letter .. " (corretto)|r")
                        else
                            syschat("|cffFF0000  ✗ " .. pts .. " pts → " .. rank_letter .. " (atteso " .. expected .. ")|r")
                        end
                    end

                    syschat("|cff00FFFF========================================|r")
                    syschat("|cff00FFFF[AZIONE RICHIESTA]|r")
                    syschat("|cffFFFFFF1. Apri Navicat e modifica rank_threshold_C|r")
                    syschat("|cffFFFFFF   (es: da 10000 a 15000)|r")
                    syschat("|cffFFFFFF2. Esegui: /hunter_reload|r")
                    syschat("|cffFFFFFF3. Riesegui questo test|r")
                    syschat("|cffFFFFFF4. Verifica nuova soglia applicata|r")
                    syschat("|cff00FFFF========================================|r")
                else
                    syschat("|cffFF0000✗ ERRORE: Alcune soglie rank mancano nel DB!|r")
                    syschat("|cffFFFFFF  Importa HUNTER_SYSTEM_COMPLETE_OVERHAUL.sql|r")
                end

            elseif sel == 2 then
                -- ========================================================
                -- TEST 2: COLORI RANK (56+ COLORS)
                -- ========================================================
                syschat("|cffFFD700========================================|r")
                syschat("|cffFFD700[TEST 2] COLORI RANK (56+ colors)|r")
                syschat("|cffFFD700========================================|r")

                -- Query colori dal DB
                local c, d = mysql_direct_query("SELECT rank_code, border, accent, bg_dark FROM srv1_hunabku.hunter_ui_rank_colors ORDER BY rank_code")

                if c == 7 then
                    syschat("|cff00FF00✓ Trovati 7 rank nel DB (E,D,C,B,A,S,N)|r")
                    syschat("|cffFFFFFF  Totale colori configurabili: " .. (c * 13) .. " (56+)|r")
                    for i = 1, c do
                        syschat("|cffFFFFFF  " .. d[i].rank_code .. "-Rank: border=" .. d[i].border .. ", accent=" .. d[i].accent .. ", bg=" .. d[i].bg_dark .. "|r")
                    end

                    syschat("|cff00FFFF========================================|r")
                    syschat("|cff00FFFF[AZIONE RICHIESTA]|r")
                    syschat("|cffFFFFFF1. Apri Navicat → hunter_ui_rank_colors|r")
                    syschat("|cffFFFFFF2. Modifica border color per S-Rank|r")
                    syschat("|cffFFFFFF   UPDATE hunter_ui_rank_colors|r")
                    syschat("|cffFFFFFF   SET border='0xFFAA00AA'|r")
                    syschat("|cffFFFFFF   WHERE rank_code='S';|r")
                    syschat("|cffFFFFFF3. Esegui: /hunter_reload|r")
                    syschat("|cffFFFFFF4. Relog e apri Hunter Terminal|r")
                    syschat("|cffFFFFFF5. Verifica nuovo colore applicato|r")
                    syschat("|cff00FFFF========================================|r")
                else
                    syschat("|cffFF0000✗ ERRORE: Trovati solo " .. c .. " rank (attesi 7)|r")
                    syschat("|cffFFFFFF  Importa sezione FIX 4 da SQL|r")
                end

            elseif sel == 3 then
                -- ========================================================
                -- TEST 3: STRINGHE UI (35+ STRINGS)
                -- ========================================================
                syschat("|cffFFD700========================================|r")
                syschat("|cffFFD700[TEST 3] STRINGHE UI (35+ strings)|r")
                syschat("|cffFFD700========================================|r")

                -- Test alcune stringhe UI chiave
                local test_keys = {
                    "ui_tab_stats",
                    "ui_tab_achievements",
                    "ui_tab_ranking",
                    "ui_guide_ranks",
                    "rank_S_title",
                    "rank_N_desc"
                }
                local all_found = true
                local found_count = 0

                for _, key in ipairs(test_keys) do
                    local text = hunter_level_bridge.get_text(key)
                    if text and text ~= "" then
                        syschat("|cff00FF00  ✓ " .. key .. " = '" .. text .. "'|r")
                        found_count = found_count + 1
                    else
                        syschat("|cffFF0000  ✗ " .. key .. " NON TROVATO nel DB|r")
                        all_found = false
                    end
                end

                if all_found then
                    syschat("|cff00FF00✓ Tutte le " .. found_count .. " stringhe test trovate|r")

                    syschat("|cff00FFFF========================================|r")
                    syschat("|cff00FFFF[AZIONE RICHIESTA]|r")
                    syschat("|cffFFFFFF1. Apri Navicat → hunter_texts|r")
                    syschat("|cffFFFFFF2. Modifica testo|r")
                    syschat("|cffFFFFFF   UPDATE hunter_texts|r")
                    syschat("|cffFFFFFF   SET text_value='MY STATS'|r")
                    syschat("|cffFFFFFF   WHERE text_key='ui_tab_stats';|r")
                    syschat("|cffFFFFFF3. Relog|r")
                    syschat("|cffFFFFFF4. Apri Hunter Terminal|r")
                    syschat("|cffFFFFFF5. Verifica nuovo testo nel tab|r")
                    syschat("|cff00FFFF========================================|r")
                else
                    syschat("|cffFF0000✗ ERRORE: Alcune stringhe mancano|r")
                    syschat("|cffFFFFFF  Importa sezione FIX 5 da SQL|r")
                end

            elseif sel == 4 then
                -- ========================================================
                -- TEST 4: DIMENSIONI UI (20+ DIMENSIONS)
                -- ========================================================
                syschat("|cffFFD700========================================|r")
                syschat("|cffFFD700[TEST 4] DIMENSIONI UI (20+ dims)|r")
                syschat("|cffFFD700========================================|r")

                local width = tonumber(hunter_level_bridge.get_config("ui_window_width"))
                local height = tonumber(hunter_level_bridge.get_config("ui_window_height"))
                local header_h = tonumber(hunter_level_bridge.get_config("ui_header_height"))
                local pad_med = tonumber(hunter_level_bridge.get_config("ui_padding_medium"))

                if width and height and header_h and pad_med then
                    syschat("|cff00FF00✓ Dimensioni UI caricate dal DB|r")
                    syschat("|cffFFFFFF  Window: " .. width .. "x" .. height .. " px|r")
                    syschat("|cffFFFFFF  Header: " .. header_h .. " px|r")
                    syschat("|cffFFFFFF  Padding Med: " .. pad_med .. " px|r")

                    syschat("|cff00FFFF========================================|r")
                    syschat("|cff00FFFF[AZIONE RICHIESTA]|r")
                    syschat("|cffFFFFFF1. Apri Navicat → hunter_ui_config|r")
                    syschat("|cffFFFFFF2. Modifica dimensione finestra|r")
                    syschat("|cffFFFFFF   UPDATE hunter_ui_config|r")
                    syschat("|cffFFFFFF   SET config_value='600'|r")
                    syschat("|cffFFFFFF   WHERE config_key='ui_window_width';|r")
                    syschat("|cffFFFFFF3. Relog (dimensioni si applicano al login)|r")
                    syschat("|cffFFFFFF4. Apri Hunter Terminal|r")
                    syschat("|cffFFFFFF5. Verifica nuova larghezza finestra|r")
                    syschat("|cff00FFFF========================================|r")
                else
                    syschat("|cffFF0000✗ ERRORE: Dimensioni UI non trovate nel DB|r")
                    syschat("|cffFFFFFF  Importa sezione FIX 6 da SQL|r")
                end

            elseif sel == 5 then
                -- ========================================================
                -- TEST 5: ACHIEVEMENTS REAL-TIME
                -- ========================================================
                syschat("|cffFFD700========================================|r")
                syschat("|cffFFD700[TEST 5] ACHIEVEMENTS REAL-TIME|r")
                syschat("|cffFFD700========================================|r")

                -- Simula kill per testare achievement tracking
                local pid = pc.get_player_id()
                local current_kills = pc.getqf("hq_total_kills") or 0

                syschat("|cffFFFFFF  Kill attuali: " .. current_kills .. "|r")

                -- Incrementa kill di test
                pc.setqf("hq_total_kills", current_kills + 1)

                -- Trigger achievement check (Type 1 = Kill Count)
                hunter_level_bridge.update_achievement_progress(pid, 1, 1)

                syschat("|cff00FF00✓ Achievement progress aggiornato (+1 kill)|r")
                syschat("|cffFFFFFF  Nuove kill totali: " .. (current_kills + 1) .. "|r")

                syschat("|cff00FFFF========================================|r")
                syschat("|cff00FFFF[VERIFICA]|r")
                syschat("|cffFFFFFF1. Apri Hunter Terminal|r")
                syschat("|cffFFFFFF2. Controlla tab Achievements|r")
                syschat("|cffFFFFFF3. Verifica progresso aggiornato|r")
                syschat("|cffFFFFFF4. Se sbloccato nuovo achievement,|r")
                syschat("|cffFFFFFF   verifica popup mostrato|r")
                syschat("|cff00FFFF========================================|r")

            elseif sel == 6 then
                -- ========================================================
                -- TEST 6: PENALTY SYSTEM
                -- ========================================================
                syschat("|cffFFD700========================================|r")
                syschat("|cffFFD700[TEST 6] PENALTY SYSTEM|r")
                syschat("|cffFFD700========================================|r")

                -- Leggi penalty config dal DB
                local c, d = mysql_direct_query("SELECT penalty_level, strikes_required, duration_hours, gloria_malus_percent FROM srv1_hunabku.hunter_penalty_config ORDER BY penalty_level")

                if c >= 3 then
                    syschat("|cff00FF00✓ Penalty config caricata (3 livelli)|r")
                    for i = 1, c do
                        syschat("|cffFFFFFF  Livello " .. d[i].penalty_level .. ": " .. d[i].strikes_required .. " strike, " .. d[i].duration_hours .. "h, -" .. d[i].gloria_malus_percent .. "% gloria|r")
                    end

                    syschat("|cff00FFFF========================================|r")
                    syschat("|cff00FFFF[AZIONE RICHIESTA]|r")
                    syschat("|cffFFFFFF1. Fallisci una missione Hunter|r")
                    syschat("|cffFFFFFF2. Riceverai penalty Level 1|r")
                    syschat("|cffFFFFFF3. Apri Hunter Terminal|r")
                    syschat("|cffFFFFFF4. Verifica penalty box mostrato|r")
                    syschat("|cffFFFFFF5. Controlla malus gloria attivo|r")
                    syschat("|cff00FFFF========================================|r")
                else
                    syschat("|cffFF0000✗ ERRORE: Penalty config incompleta|r")
                    syschat("|cffFFFFFF  Verifica tabella hunter_penalty_config|r")
                end

            elseif sel == 7 then
                -- ========================================================
                -- TEST 7: RIVAL TRACKER
                -- ========================================================
                syschat("|cffFFD700========================================|r")
                syschat("|cffFFD700[TEST 7] RIVAL TRACKER|r")
                syschat("|cffFFD700========================================|r")

                -- Query rival info
                local pid = pc.get_player_id()
                local c, d = mysql_direct_query("SELECT overtaken_by, overtaken_diff, overtaken_label FROM srv1_hunabku.hunter_quest_ranking WHERE player_id=" .. pid)

                if c > 0 and d[1] then
                    local rival = d[1].overtaken_by
                    if rival and rival ~= "" then
                        syschat("|cff00FF00✓ Rival tracker attivo|r")
                        syschat("|cffFFFFFF  Superato da: " .. rival .. "|r")
                        syschat("|cffFFFFFF  Differenza: " .. (d[1].overtaken_diff or 0) .. " pts|r")
                        syschat("|cffFFFFFF  Categoria: " .. (d[1].overtaken_label or "N/A") .. "|r")

                        syschat("|cff00FFFF========================================|r")
                        syschat("|cff00FFFF[VERIFICA]|r")
                        syschat("|cffFFFFFF1. Apri Hunter Terminal|r")
                        syschat("|cffFFFFFF2. Verifica rival tracker box visibile|r")
                        syschat("|cffFFFFFF3. Dati corretti mostrati|r")
                        syschat("|cff00FFFF========================================|r")
                    else
                        syschat("|cff808080  Nessun rivale (non sei stato superato)|r")

                        syschat("|cff00FFFF========================================|r")
                        syschat("|cff00FFFF[AZIONE RICHIESTA]|r")
                        syschat("|cffFFFFFF1. Fatti superare da un altro player|r")
                        syschat("|cffFFFFFF2. Sistema rileverà automaticamente|r")
                        syschat("|cffFFFFFF3. Rival tracker apparirà in UI|r")
                        syschat("|cff00FFFF========================================|r")
                    end
                else
                    syschat("|cffFF0000✗ ERRORE: Dati ranking non trovati|r")
                end

            elseif sel == 8 then
                -- ========================================================
                -- TEST 8: STREAK MILESTONES
                -- ========================================================
                syschat("|cffFFD700========================================|r")
                syschat("|cffFFD700[TEST 8] STREAK MILESTONES|r")
                syschat("|cffFFD700========================================|r")

                -- Query milestones dal DB
                local c, d = mysql_direct_query("SELECT streak_days, bonus_percent, milestone_message FROM srv1_hunabku.hunter_streak_milestones ORDER BY streak_days")

                if c >= 9 then
                    syschat("|cff00FF00✓ Trovate " .. c .. " streak milestones nel DB|r")
                    syschat("|cffFFFFFF  Mostrando prime 5:|r")
                    for i = 1, math.min(c, 5) do
                        syschat("|cffFFFFFF  " .. d[i].streak_days .. " giorni: +" .. d[i].bonus_percent .. "% → " .. d[i].milestone_message .. "|r")
                    end

                    local current_streak = pc.getqf("hq_login_streak") or 0
                    syschat("|cffFFD700  Streak attuale: " .. current_streak .. " giorni|r")

                    -- Trova prossima milestone
                    local next_milestone = nil
                    for i = 1, c do
                        if tonumber(d[i].streak_days) > current_streak then
                            next_milestone = d[i]
                            break
                        end
                    end

                    if next_milestone then
                        local days_needed = tonumber(next_milestone.streak_days) - current_streak
                        syschat("|cff00FFFF========================================|r")
                        syschat("|cff00FFFF[PROSSIMA MILESTONE]|r")
                        syschat("|cffFFFFFF  Giorni richiesti: " .. next_milestone.streak_days .. "|r")
                        syschat("|cffFFFFFF  Mancano: " .. days_needed .. " giorni|r")
                        syschat("|cffFFFFFF  Bonus: +" .. next_milestone.bonus_percent .. "% gloria|r")
                        syschat("|cffFFFFFF  " .. next_milestone.milestone_message .. "|r")
                        syschat("|cff00FFFF========================================|r")
                    else
                        syschat("|cffFFD700✓ HAI RAGGIUNTO TUTTE LE MILESTONES!|r")
                    end
                else
                    syschat("|cffFF0000✗ ERRORE: Milestones non configurate|r")
                    syschat("|cffFFFFFF  Verifica tabella hunter_streak_milestones|r")
                end

            elseif sel == 9 then
                -- ========================================================
                -- TEST 9: GLORIA SOURCES
                -- ========================================================
                syschat("|cffFFD700========================================|r")
                syschat("|cffFFD700[TEST 9] GLORIA SOURCES TRACKING|r")
                syschat("|cffFFD700========================================|r")

                -- Query tracking sorgenti gloria
                local pid = pc.get_player_id()
                local c, d = mysql_direct_query("SELECT source_type, total_gloria FROM srv1_hunabku.hunter_gloria_sources_tracking WHERE player_id=" .. pid)

                if c > 0 then
                    local total = 0
                    local sources = {}

                    for i = 1, c do
                        local gloria = tonumber(d[i].total_gloria) or 0
                        total = total + gloria
                        sources[d[i].source_type] = gloria
                    end

                    if total > 0 then
                        syschat("|cff00FF00✓ Gloria sources tracked|r")
                        syschat("|cffFFFFFF  Gloria totale: " .. total .. " pts|r")

                        for source_type, gloria in pairs(sources) do
                            local pct = math.floor((gloria / total) * 100)
                            syschat("|cffFFFFFF  " .. source_type .. ": " .. pct .. "% (" .. gloria .. " pts)|r")
                        end

                        syschat("|cff00FFFF========================================|r")
                        syschat("|cff00FFFF[VERIFICA]|r")
                        syschat("|cffFFFFFF1. Apri Hunter Terminal|r")
                        syschat("|cffFFFFFF2. Tab Statistiche|r")
                        syschat("|cffFFFFFF3. Verifica pie chart sorgenti gloria|r")
                        syschat("|cffFFFFFF4. Percentuali corrette mostrate|r")
                        syschat("|cff00FFFF========================================|r")
                    else
                        syschat("|cff808080  Nessuna gloria guadagnata ancora|r")
                        syschat("|cffFFFFFF  Guadagna gloria per iniziare tracking|r")
                    end
                else
                    syschat("|cff808080  Tracking non iniziato|r")
                    syschat("|cffFFFFFF  Completa missioni/eventi per iniziare|r")
                end

            elseif sel == 10 then
                -- ========================================================
                -- TEST 10: CONFIG RELOAD
                -- ========================================================
                syschat("|cffFFD700========================================|r")
                syschat("|cffFFD700[TEST 10] CONFIG RELOAD COMPLETO|r")
                syschat("|cffFFD700========================================|r")

                syschat("|cffFFFFFF  Ricaricamento config dal DB...|r")

                local start_time = get_time()
                hunter_level_bridge.reload_all_config()
                local elapsed = get_time() - start_time

                syschat("|cff00FF00✓ Config ricaricata in " .. string.format("%.2f", elapsed) .. " secondi|r")

                syschat("|cff00FFFF========================================|r")
                syschat("|cff00FFFF[VERIFICA COMPLETA]|r")
                syschat("|cffFFFFFF1. Modifica un valore qualsiasi in Navicat|r")
                syschat("|cffFFFFFF   (es: rank_threshold_C, colore S-Rank, ecc)|r")
                syschat("|cffFFFFFF2. Esegui: /hunter_reload|r")
                syschat("|cffFFFFFF3. Verifica valore aggiornato in-game|r")
                syschat("|cffFFFFFF4. Zero riavvii server richiesti!|r")
                syschat("|cff00FFFF========================================|r")

            elseif sel == 12 then
                -- Chiudi menu
                syschat("|cff00FF00[HUNTER TEST] Menu test chiuso|r")
                return
            end

            -- Riapri menu dopo 2 secondi
            timer("hunter_test_menu", 2)
        end

        -- ============================================================
        -- COMANDI TEST RAPIDI (GM only)
        -- ============================================================

        when chat."/hunter_test_achievement" with pc.is_gm() begin
            local pid = pc.get_player_id()

            -- Simula unlock achievement ID 1 (Novizio)
            cmdchat("HunterAchievementUnlock 1|Novizio (Kill)|80030|1")
            syschat("|cff00FF00✓ Popup achievement mostrato (ID 1)|r")
        end

        when chat."/hunter_test_penalty" with pc.is_gm() begin
            -- Simula penalty attiva
            local expires = get_time() + 7200  -- 2 ore
            cmdchat("HunterPenaltyStatus 1|" .. expires .. "|2")
            syschat("|cff00FF00✓ Penalty box mostrato (2 strike, 2h rimaste)|r")
        end

        when chat."/hunter_test_rival" with pc.is_gm() begin
            -- Simula rival tracker
            cmdchat("HunterRivalInfo TestPlayer|245|Daily Gloria")
            syschat("|cff00FF00✓ Rival tracker mostrato|r")
        end

        when chat."/hunter_test_bonus" with pc.is_gm() begin
            -- Simula rank bonus
            cmdchat("HunterRankBonus 5|3|50000")
            syschat("|cff00FF00✓ Rank bonus indicator mostrato (+5% Gloria, +3% Drop)|r")
        end

        when chat."/hunter_test_colors" with pc.is_gm() begin
            -- Test reload colori rank
            syschat("|cffFFD700[TEST] Ricaricamento colori rank...|r")
            local count = hunter_level_bridge.send_rank_colors()
            if count > 0 then
                syschat("|cff00FF00✓ " .. count .. " rank colors inviati a client|r")
                syschat("|cffFFFFFF  Relog per vedere cambiamenti applicati|r")
            else
                syschat("|cffFF0000✗ ERRORE nel caricamento colori|r")
            end
        end

        when chat."/hunter_test_texts" with pc.is_gm() begin
            -- Test reload stringhe UI
            syschat("|cffFFD700[TEST] Ricaricamento stringhe UI...|r")
            local count = hunter_level_bridge.send_ui_texts()
            if count > 0 then
                syschat("|cff00FF00✓ " .. count .. " UI texts inviati a client|r")
                syschat("|cffFFFFFF  Relog per vedere cambiamenti applicati|r")
            else
                syschat("|cffFF0000✗ ERRORE nel caricamento testi|r")
            end
        end

        when chat."/hunter_test_dims" with pc.is_gm() begin
            -- Test reload dimensioni UI
            syschat("|cffFFD700[TEST] Ricaricamento dimensioni UI...|r")
            hunter_level_bridge.send_ui_dimensions()
            syschat("|cff00FF00✓ UI dimensions inviati a client|r")
            syschat("|cffFFFFFF  Relog per vedere cambiamenti applicati|r")
        end

        -- ============================================================
        -- HELP COMMAND
        -- ============================================================
        when chat."/hunter_test_help" with pc.is_gm() begin
            syschat("|cffFFD700========================================|r")
            syschat("|cffFFD700  HUNTER TEST QUEST - COMANDI|r")
            syschat("|cffFFD700========================================|r")
            syschat("|cff00FFFF/hunter_test|r - Menu test principale")
            syschat("|cff00FFFF/hunter_test_achievement|r - Test popup achievement")
            syschat("|cff00FFFF/hunter_test_penalty|r - Test penalty box")
            syschat("|cff00FFFF/hunter_test_rival|r - Test rival tracker")
            syschat("|cff00FFFF/hunter_test_bonus|r - Test rank bonus")
            syschat("|cff00FFFF/hunter_test_colors|r - Reload colori rank")
            syschat("|cff00FFFF/hunter_test_texts|r - Reload stringhe UI")
            syschat("|cff00FFFF/hunter_test_dims|r - Reload dimensioni UI")
            syschat("|cffFFD700========================================|r")
        end
    end
end
