-- ============================================================================
-- HUNTER TEST NPC - Testa TUTTO il sistema Hunter
-- NPC: 9009
-- Posizione: Spawn in qualsiasi città
-- ============================================================================

quest hunter_test_npc begin
    state start begin
        when 9009.chat."[TEST] Hunter System" begin
            local pid = pc.get_player_id()
            local pname = pc.get_name()

            say_title("HUNTER SYSTEM - TEST CENTER")
            say("NPC di test per verificare tutte le funzionalità")
            say("del Sistema Hunter (Solo Leveling)")
            say("")

            local selection = select(
                "1. Test Rank e Punti Gloria",
                "2. Test Missioni Giornaliere",
                "3. Test Emergency Quest",
                "4. Test Fratture Dimensionali",
                "5. Test Spawn (Boss/Metin/Bauli)",
                "6. Test Messaggi e Colori",
                "7. Test Eventi Programmati",
                "8. Visualizza Dati Player",
                "9. Reset Dati (ADMIN)",
                "Chiudi"
            )

            if selection == 1 then
                hunter_test_npc.test_rank_points()
            elseif selection == 2 then
                hunter_test_npc.test_missions()
            elseif selection == 3 then
                hunter_test_npc.test_emergency()
            elseif selection == 4 then
                hunter_test_npc.test_fractures()
            elseif selection == 5 then
                hunter_test_npc.test_spawns()
            elseif selection == 6 then
                hunter_test_npc.test_messages()
            elseif selection == 7 then
                hunter_test_npc.test_events()
            elseif selection == 8 then
                hunter_test_npc.show_player_data()
            elseif selection == 9 then
                if pc.is_gm() then
                    hunter_test_npc.reset_data()
                else
                    say("Solo per GM!")
                end
            end
        end

        -- ========================================================================
        -- TEST 1: RANK E PUNTI GLORIA
        -- ========================================================================
        function test_rank_points()
            say_title("TEST: Rank e Punti Gloria")
            say("")

            local opt = select(
                "Aggiungi 100 Gloria",
                "Aggiungi 1000 Gloria",
                "Aggiungi 10000 Gloria",
                "Aggiungi 50000 Gloria (Rank B)",
                "Aggiungi 500000 Gloria (Rank S)",
                "Rimuovi 500 Gloria",
                "Verifica Rank Up",
                "Indietro"
            )

            local pid = pc.get_player_id()

            if opt == 1 then
                mysql_direct_query("UPDATE srv1_hunabku.hunter_quest_ranking SET total_points = total_points + 100, spendable_points = spendable_points + 100 WHERE player_id=" .. pid)
                say("✅ +100 Gloria aggiunta!")
                hunter_level_bridge.send_player_data()
                wait()
                hunter_test_npc.test_rank_points()

            elseif opt == 2 then
                mysql_direct_query("UPDATE srv1_hunabku.hunter_quest_ranking SET total_points = total_points + 1000, spendable_points = spendable_points + 1000 WHERE player_id=" .. pid)
                say("✅ +1000 Gloria aggiunta!")
                hunter_level_bridge.send_player_data()
                wait()
                hunter_test_npc.test_rank_points()

            elseif opt == 3 then
                mysql_direct_query("UPDATE srv1_hunabku.hunter_quest_ranking SET total_points = total_points + 10000, spendable_points = spendable_points + 10000 WHERE player_id=" .. pid)
                say("✅ +10000 Gloria! Dovresti essere Rank C ora.")
                hunter_level_bridge.send_player_data()
                wait()
                hunter_test_npc.test_rank_points()

            elseif opt == 4 then
                mysql_direct_query("UPDATE srv1_hunabku.hunter_quest_ranking SET total_points = 55000, spendable_points = spendable_points + 55000 WHERE player_id=" .. pid)
                say("✅ Settato a 55000 Gloria = Rank B!")
                hunter_level_bridge.send_player_data()
                wait()
                hunter_test_npc.test_rank_points()

            elseif opt == 5 then
                mysql_direct_query("UPDATE srv1_hunabku.hunter_quest_ranking SET total_points = 550000, spendable_points = spendable_points + 550000 WHERE player_id=" .. pid)
                say("✅ Settato a 550000 Gloria = Rank S!")
                say("Riapri il Terminale Hunter per vedere il cambio!")
                hunter_level_bridge.send_player_data()
                wait()
                hunter_test_npc.test_rank_points()

            elseif opt == 6 then
                mysql_direct_query("UPDATE srv1_hunabku.hunter_quest_ranking SET spendable_points = spendable_points - 500 WHERE player_id=" .. pid)
                say("✅ -500 Gloria spendibile rimossa")
                hunter_level_bridge.send_player_data()
                wait()
                hunter_test_npc.test_rank_points()

            elseif opt == 7 then
                say("Controlla i tuoi punti attuali:")
                local c, d = mysql_direct_query("SELECT total_points, spendable_points FROM srv1_hunabku.hunter_quest_ranking WHERE player_id=" .. pid)
                if c > 0 then
                    local pts = tonumber(d[1].total_points) or 0
                    local rank_key = hunter_level_bridge.get_rank_key(pts)
                    say("Totale: " .. pts)
                    say("Spendibili: " .. d[1].spendable_points)
                    say("Rank: " .. rank_key .. " (" .. hunter_level_bridge.get_rank_name(rank_key) .. ")")
                end
                wait()
                hunter_test_npc.test_rank_points()
            end
        end

        -- ========================================================================
        -- TEST 2: MISSIONI GIORNALIERE
        -- ========================================================================
        function test_missions()
            say_title("TEST: Missioni Giornaliere")
            say("")

            local opt = select(
                "Assegna Nuove Missioni (3x)",
                "Mostra Missioni Correnti",
                "Simula Progresso Missione 1 (+1)",
                "Simula Progresso Missione 1 (+10)",
                "Completa Missione 1",
                "Completa TUTTE le Missioni",
                "Cancella Missioni di Oggi",
                "Indietro"
            )

            local pid = pc.get_player_id()
            local today = hunter_level_bridge.get_today_date()

            if opt == 1 then
                hunter_level_bridge.assign_daily_missions()
                say("✅ Nuove missioni assegnate!")
                say("Apri il Terminale Hunter per vederle")
                wait()
                hunter_test_npc.test_missions()

            elseif opt == 2 then
                local c, d = mysql_direct_query("SELECT pm.id, md.mission_name, pm.current_progress, pm.target_count, pm.status FROM srv1_hunabku.hunter_player_missions pm LEFT JOIN srv1_hunabku.hunter_mission_definitions md ON pm.mission_def_id = md.mission_id WHERE pm.player_id=" .. pid .. " AND pm.assigned_date='" .. today .. "'")
                if c > 0 then
                    say("Missioni di oggi:")
                    for i = 1, c do
                        say(i .. ". " .. d[i].mission_name)
                        say("   Progresso: " .. d[i].current_progress .. "/" .. d[i].target_count)
                        say("   Status: " .. d[i].status)
                    end
                else
                    say("❌ Nessuna missione assegnata oggi!")
                end
                wait()
                hunter_test_npc.test_missions()

            elseif opt == 3 then
                local c, d = mysql_direct_query("SELECT id, current_progress, target_count FROM srv1_hunabku.hunter_player_missions WHERE player_id=" .. pid .. " AND assigned_date='" .. today .. "' ORDER BY mission_slot LIMIT 1")
                if c > 0 then
                    local new_prog = math.min(tonumber(d[1].current_progress) + 1, tonumber(d[1].target_count))
                    mysql_direct_query("UPDATE srv1_hunabku.hunter_player_missions SET current_progress=" .. new_prog .. " WHERE id=" .. d[1].id)
                    cmdchat("HunterMissionProgress " .. d[1].id .. "|" .. new_prog .. "|" .. d[1].target_count)
                    say("✅ Missione 1: " .. new_prog .. "/" .. d[1].target_count)
                    say("La finestra dovrebbe aprirsi automaticamente!")
                else
                    say("❌ Nessuna missione trovata!")
                end
                wait()
                hunter_test_npc.test_missions()

            elseif opt == 4 then
                local c, d = mysql_direct_query("SELECT id, current_progress, target_count FROM srv1_hunabku.hunter_player_missions WHERE player_id=" .. pid .. " AND assigned_date='" .. today .. "' ORDER BY mission_slot LIMIT 1")
                if c > 0 then
                    local new_prog = math.min(tonumber(d[1].current_progress) + 10, tonumber(d[1].target_count))
                    mysql_direct_query("UPDATE srv1_hunabku.hunter_player_missions SET current_progress=" .. new_prog .. " WHERE id=" .. d[1].id)
                    cmdchat("HunterMissionProgress " .. d[1].id .. "|" .. new_prog .. "|" .. d[1].target_count)
                    say("✅ Missione 1: +" .. 10 .. " progresso!")
                else
                    say("❌ Nessuna missione trovata!")
                end
                wait()
                hunter_test_npc.test_missions()

            elseif opt == 5 then
                local c, d = mysql_direct_query("SELECT pm.id, pm.reward_glory, md.mission_name FROM srv1_hunabku.hunter_player_missions pm LEFT JOIN srv1_hunabku.hunter_mission_definitions md ON pm.mission_def_id = md.mission_id WHERE pm.player_id=" .. pid .. " AND pm.assigned_date='" .. today .. "' ORDER BY mission_slot LIMIT 1")
                if c > 0 then
                    hunter_level_bridge.complete_mission(tonumber(d[1].id))
                    say("✅ Missione completata!")
                    say("+" .. d[1].reward_glory .. " Gloria!")
                else
                    say("❌ Nessuna missione trovata!")
                end
                wait()
                hunter_test_npc.test_missions()

            elseif opt == 6 then
                local c, d = mysql_direct_query("SELECT id FROM srv1_hunabku.hunter_player_missions WHERE player_id=" .. pid .. " AND assigned_date='" .. today .. "' AND status='active'")
                if c > 0 then
                    for i = 1, c do
                        hunter_level_bridge.complete_mission(tonumber(d[i].id))
                    end
                    say("✅ Tutte le missioni completate!")
                    say("Dovresti ricevere bonus x1.5!")
                else
                    say("❌ Nessuna missione attiva!")
                end
                wait()
                hunter_test_npc.test_missions()

            elseif opt == 7 then
                mysql_direct_query("DELETE FROM srv1_hunabku.hunter_player_missions WHERE player_id=" .. pid .. " AND assigned_date='" .. today .. "'")
                say("✅ Missioni di oggi cancellate")
                wait()
                hunter_test_npc.test_missions()
            end
        end

        -- ========================================================================
        -- TEST 3: EMERGENCY QUEST
        -- ========================================================================
        function test_emergency()
            say_title("TEST: Emergency Quest")
            say("")

            local opt = select(
                "Attiva Emergency Quest Random",
                "Attiva 'Prova del Novizio' (30 kill/60s)",
                "Aggiungi +5 Progresso",
                "Completa Automaticamente",
                "Ferma Emergency Corrente",
                "Indietro"
            )

            if opt == 1 then
                hunter_level_bridge.trigger_random_emergency()
                say("✅ Emergency Quest attivata!")
                say("Controlla la finestra Emergency")

            elseif opt == 2 then
                hunter_level_bridge.start_emergency("Prova del Novizio", 60, 0, 30)
                pc.setqf("hq_emerg_reward_pts", 150)
                say("✅ Emergency 'Prova del Novizio' attivata!")
                say("30 kill in 60 secondi - Uccidi qualsiasi mob")

            elseif opt == 3 then
                if pc.getqf("hq_emerg_active") == 1 then
                    local current = pc.getqf("hq_emerg_cur") + 5
                    pc.setqf("hq_emerg_cur", current)
                    hunter_level_bridge.update_emergency(current)
                    say("✅ +5 progresso emergency!")
                else
                    say("❌ Nessuna emergency attiva!")
                end

            elseif opt == 4 then
                if pc.getqf("hq_emerg_active") == 1 then
                    hunter_level_bridge.end_emergency("SUCCESS")
                    say("✅ Emergency completata!")
                else
                    say("❌ Nessuna emergency attiva!")
                end

            elseif opt == 5 then
                pc.setqf("hq_emerg_active", 0)
                cmdchat("HunterEmergencyEnd")
                say("✅ Emergency fermata")
            end

            wait()
            hunter_test_npc.test_emergency()
        end

        -- ========================================================================
        -- TEST 4: FRATTURE DIMENSIONALI
        -- ========================================================================
        function test_fractures()
            say_title("TEST: Fratture Dimensionali")
            say("")

            local opt = select(
                "Spawn Frattura E-Rank (Verde)",
                "Spawn Frattura D-Rank (Blu)",
                "Spawn Frattura C-Rank (Arancio)",
                "Spawn Frattura S-Rank (Viola)",
                "Spawn Frattura National (B/W)",
                "Simula Sigillo Frattura",
                "Indietro"
            )

            if opt == 1 then
                hunter_level_bridge.spawn_gate_mob_and_alert("E-Rank", "GREEN")
                say("✅ Frattura E-Rank spawnata!")

            elseif opt == 2 then
                hunter_level_bridge.spawn_gate_mob_and_alert("D-Rank", "BLUE")
                say("✅ Frattura D-Rank spawnata!")

            elseif opt == 3 then
                hunter_level_bridge.spawn_gate_mob_and_alert("C-Rank", "ORANGE")
                say("✅ Frattura C-Rank spawnata!")

            elseif opt == 4 then
                hunter_level_bridge.spawn_gate_mob_and_alert("S-Rank", "PURPLE")
                say("✅ Frattura S-Rank spawnata!")

            elseif opt == 5 then
                hunter_level_bridge.spawn_gate_mob_and_alert("National", "BLACKWHITE")
                say("✅ Frattura National spawnata!")

            elseif opt == 6 then
                hunter_level_bridge.on_fracture_seal()
                mysql_direct_query("UPDATE srv1_hunabku.hunter_quest_ranking SET total_fractures = total_fractures + 1 WHERE player_id=" .. pc.get_player_id())
                say("✅ Sigillo frattura simulato!")
                say("Controlla se le missioni progressano")
            end

            wait()
            hunter_test_npc.test_fractures()
        end

        -- ========================================================================
        -- TEST 5: SPAWN (Boss, Metin, Bauli)
        -- ========================================================================
        function test_spawns()
            say_title("TEST: Spawn Sistema")
            say("")

            local opt = select(
                "Info Sistema Spawn",
                "Simula Kill Boss",
                "Simula Kill Super Metin",
                "Simula Kill Baule",
                "Test Speed Kill (60s Boss)",
                "Indietro"
            )

            if opt == 1 then
                say("Il sistema spawn funziona così:")
                say("")
                say("1. Uccidi mob normali → Counter aumenta")
                say("2. Soglia raggiunta (Config DB) → Roll")
                say("3. 40% Emergency, 60% Frattura")
                say("")
                say("Config attuali:")
                local threshold = hunter_level_bridge.get_config("spawn_threshold_normal") or 0
                local emerg_chance = hunter_level_bridge.get_config("emergency_chance_percent") or 0
                say("Soglia: " .. threshold .. " kill")
                say("Chance Emergency: " .. emerg_chance .. "%")
                wait()
                hunter_test_npc.test_spawns()

            elseif opt == 2 then
                -- Simula kill di un boss (vnum 6831 = Grimlor)
                hunter_level_bridge.on_boss_kill(6831)
                say("✅ Kill Boss simulato!")
                say("Controlla missioni e progresso")
                wait()
                hunter_test_npc.test_spawns()

            elseif opt == 3 then
                -- Simula kill Super Metin
                hunter_level_bridge.on_metin_kill(4705)
                say("✅ Kill Super Metin simulato!")
                say("Controlla missioni e stat metin")
                wait()
                hunter_test_npc.test_spawns()

            elseif opt == 4 then
                -- Simula apertura baule
                hunter_level_bridge.give_chest_reward()
                say("✅ Baule aperto!")
                say("Controlla inventario per reward")
                wait()
                hunter_test_npc.test_spawns()

            elseif opt == 5 then
                pc.setqf("hq_elite_spawn_time", get_time())
                say("✅ Timer spawn impostato!")
                say("Ora simula kill boss/metin entro 60s")
                say("per ottenere bonus x2 punti")
                wait()
                hunter_test_npc.test_spawns()
            end
        end

        -- ========================================================================
        -- TEST 6: MESSAGGI E COLORI
        -- ========================================================================
        function test_messages()
            say_title("TEST: Messaggi e Colori")
            say("")

            local opt = select(
                "Messaggio E-Rank (Grigio)",
                "Messaggio D-Rank (Verde)",
                "Messaggio C-Rank (Ciano)",
                "Messaggio B-Rank (Blu)",
                "Messaggio A-Rank (Viola)",
                "Messaggio S-Rank (Arancio)",
                "Messaggio N-Rank (Rosso)",
                "Test Tutti i Colori (sequenza)",
                "Indietro"
            )

            if opt == 1 then
                cmdchat("HunterSystemSpeak E|Test+Messaggio+E-Rank+(Grigio)")
                say("✅ Inviato messaggio E-Rank")

            elseif opt == 2 then
                cmdchat("HunterSystemSpeak D|Test+Messaggio+D-Rank+(Verde)")
                say("✅ Inviato messaggio D-Rank")

            elseif opt == 3 then
                cmdchat("HunterSystemSpeak C|Test+Messaggio+C-Rank+(Ciano)")
                say("✅ Inviato messaggio C-Rank")

            elseif opt == 4 then
                cmdchat("HunterSystemSpeak B|Test+Messaggio+B-Rank+(Blu)")
                say("✅ Inviato messaggio B-Rank")

            elseif opt == 5 then
                cmdchat("HunterSystemSpeak A|Test+Messaggio+A-Rank+(Viola)")
                say("✅ Inviato messaggio A-Rank")

            elseif opt == 6 then
                cmdchat("HunterSystemSpeak S|Test+Messaggio+S-Rank+(Arancio)")
                say("✅ Inviato messaggio S-Rank")

            elseif opt == 7 then
                cmdchat("HunterSystemSpeak N|Test+Messaggio+N-Rank+(Rosso)")
                say("✅ Inviato messaggio N-Rank")

            elseif opt == 8 then
                cmdchat("HunterSystemSpeak E|1.+Messaggio+E-Rank")
                timer("test_msg_d", 1)
                timer("test_msg_c", 2)
                timer("test_msg_b", 3)
                timer("test_msg_a", 4)
                timer("test_msg_s", 5)
                timer("test_msg_n", 6)
                say("✅ Sequenza messaggi in corso...")
                say("I colori devono rimanere DIVERSI!")
                say("E non devono diventare tutti grigi!")
            end

            wait()
            hunter_test_npc.test_messages()
        end

        when test_msg_d.timer begin
            cmdchat("HunterSystemSpeak D|2.+Messaggio+D-Rank")
        end
        when test_msg_c.timer begin
            cmdchat("HunterSystemSpeak C|3.+Messaggio+C-Rank")
        end
        when test_msg_b.timer begin
            cmdchat("HunterSystemSpeak B|4.+Messaggio+B-Rank")
        end
        when test_msg_a.timer begin
            cmdchat("HunterSystemSpeak A|5.+Messaggio+A-Rank")
        end
        when test_msg_s.timer begin
            cmdchat("HunterSystemSpeak S|6.+Messaggio+S-Rank")
        end
        when test_msg_n.timer begin
            cmdchat("HunterSystemSpeak N|7.+Messaggio+N-Rank")
        end

        -- ========================================================================
        -- TEST 7: EVENTI PROGRAMMATI
        -- ========================================================================
        function test_events()
            say_title("TEST: Eventi Programmati")
            say("")

            local opt = select(
                "Mostra Eventi di Oggi",
                "Simula Partecipazione Evento",
                "Carica Eventi nel Terminale",
                "Indietro"
            )

            if opt == 1 then
                local ts = get_time()
                local dow = hunter_level_bridge.get_day_db_from_ts(ts)
                local c, d = mysql_direct_query("SELECT event_name, start_hour, start_minute, event_type, reward_glory_base FROM srv1_hunabku.hunter_scheduled_events WHERE enabled=1 AND days_active LIKE '%" .. dow .. "%' ORDER BY start_hour, start_minute LIMIT 10")
                if c > 0 then
                    say("Eventi di oggi (primi 10):")
                    for i = 1, c do
                        local time_str = string.format("%02d:%02d", d[i].start_hour, d[i].start_minute)
                        say(time_str .. " - " .. d[i].event_name)
                        say("   Tipo: " .. d[i].event_type .. ", Gloria: " .. d[i].reward_glory_base)
                    end
                else
                    say("Nessun evento oggi!")
                end

            elseif opt == 2 then
                local c, d = mysql_direct_query("SELECT id, event_name, reward_glory_base FROM srv1_hunabku.hunter_scheduled_events WHERE enabled=1 LIMIT 1")
                if c > 0 then
                    hunter_level_bridge.join_event(tonumber(d[1].id))
                    say("✅ Partecipato a: " .. d[1].event_name)
                else
                    say("Nessun evento disponibile!")
                end

            elseif opt == 3 then
                hunter_level_bridge.send_today_events(false)
                say("✅ Eventi caricati nel Terminale")
                say("Apri tab Eventi per vederli")
            end

            wait()
            hunter_test_npc.test_events()
        end

        -- ========================================================================
        -- TEST 8: VISUALIZZA DATI PLAYER
        -- ========================================================================
        function show_player_data()
            local pid = pc.get_player_id()

            say_title("DATI HUNTER - " .. pc.get_name())
            say("")

            local c, d = mysql_direct_query("SELECT * FROM srv1_hunabku.hunter_quest_ranking WHERE player_id=" .. pid)
            if c > 0 then
                local data = d[1]
                say("Rank: " .. data.hunter_rank)
                say("Punti Totali: " .. data.total_points)
                say("Punti Spendibili: " .. data.spendable_points)
                say("Punti Daily: " .. data.daily_points)
                say("Punti Weekly: " .. data.weekly_points)
                say("")
                say("Kill Totali: " .. data.total_kills)
                say("Kill Daily: " .. data.daily_kills)
                say("Kill Weekly: " .. data.weekly_kills)
                say("")
                say("Fratture: " .. data.total_fractures)
                say("Bauli: " .. data.total_chests)
                say("Metin: " .. data.total_metins)
                say("")
                say("Streak Login: " .. data.login_streak .. " giorni")
                say("Penalty Strikes: " .. data.penalty_strikes)
            else
                say("❌ Dati non trovati!")
                say("Devi prima attivare il sistema Hunter")
            end
        end

        -- ========================================================================
        -- TEST 9: RESET DATI (ADMIN ONLY)
        -- ========================================================================
        function reset_data()
            say_title("RESET DATI HUNTER")
            say("ATTENZIONE: Questo cancellerà TUTTI i dati Hunter")
            say("")

            local opt = select(
                "Reset TUTTO (punti, missioni, stat)",
                "Reset Solo Missioni di Oggi",
                "Reset Solo Punti Daily/Weekly",
                "Annulla"
            )

            local pid = pc.get_player_id()
            local today = hunter_level_bridge.get_today_date()

            if opt == 1 then
                mysql_direct_query("UPDATE srv1_hunabku.hunter_quest_ranking SET total_points=0, spendable_points=0, daily_points=0, weekly_points=0, total_kills=0, daily_kills=0, weekly_kills=0, total_fractures=0, total_chests=0, total_metins=0, login_streak=0, penalty_strikes=0 WHERE player_id=" .. pid)
                mysql_direct_query("DELETE FROM srv1_hunabku.hunter_player_missions WHERE player_id=" .. pid)
                say("✅ RESET COMPLETO eseguito!")
                hunter_level_bridge.send_player_data()

            elseif opt == 2 then
                mysql_direct_query("DELETE FROM srv1_hunabku.hunter_player_missions WHERE player_id=" .. pid .. " AND assigned_date='" .. today .. "'")
                say("✅ Missioni di oggi cancellate")

            elseif opt == 3 then
                mysql_direct_query("UPDATE srv1_hunabku.hunter_quest_ranking SET daily_points=0, weekly_points=0, daily_kills=0, weekly_kills=0 WHERE player_id=" .. pid)
                say("✅ Punti Daily/Weekly resettati")
                hunter_level_bridge.send_player_data()
            end
        end
    end
end
