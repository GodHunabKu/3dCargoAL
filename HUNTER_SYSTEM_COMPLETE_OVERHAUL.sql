-- =====================================================================
-- HUNTER SYSTEM COMPLETE OVERHAUL - DATABASE SCHEMA
-- =====================================================================
-- Questo file contiene tutte le tabelle per rendere il Hunter System
-- 100% configurabile da database con reload real-time
-- =====================================================================

-- =====================================================================
-- 1. TABELLA: hunter_ui_config
-- Parametri UI completamente configurabili
-- =====================================================================
CREATE TABLE IF NOT EXISTS `hunter_ui_config` (
  `config_key` VARCHAR(50) PRIMARY KEY,
  `config_value` VARCHAR(255) NOT NULL,
  `config_type` ENUM('int', 'string', 'bool', 'color') NOT NULL DEFAULT 'string',
  `description` VARCHAR(255) DEFAULT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Popolamento hunter_ui_config
-- Colori UI per ogni rank
INSERT INTO `hunter_ui_config` (`config_key`, `config_value`, `config_type`, `description`) VALUES
-- Colori background per rank
('rank_E_bg_color', '0xFF2A2A2A', 'color', 'Colore background rank E (Grigio scuro)'),
('rank_D_bg_color', '0xFF1A4D1A', 'color', 'Colore background rank D (Verde scuro)'),
('rank_C_bg_color', '0xFF1A3D5C', 'color', 'Colore background rank C (Blu scuro)'),
('rank_B_bg_color', '0xFF5C1A5C', 'color', 'Colore background rank B (Viola scuro)'),
('rank_A_bg_color', '0xFF5C3A1A', 'color', 'Colore background rank A (Arancione scuro)'),
('rank_S_bg_color', '0xFF5C1A1A', 'color', 'Colore background rank S (Rosso scuro)'),
('rank_N_bg_color', '0xFF1A1A2E', 'color', 'Colore background rank N (Blu notte)'),

-- Colori border per rank
('rank_E_border_color', '0xFF808080', 'color', 'Colore bordo rank E (Grigio)'),
('rank_D_border_color', '0xFF00FF00', 'color', 'Colore bordo rank D (Verde)'),
('rank_C_border_color', '0xFF00BFFF', 'color', 'Colore bordo rank C (Celeste)'),
('rank_B_border_color', '0xFFFF00FF', 'color', 'Colore bordo rank B (Viola)'),
('rank_A_border_color', '0xFFFF8C00', 'color', 'Colore bordo rank A (Arancione)'),
('rank_S_border_color', '0xFFFF0000', 'color', 'Colore bordo rank S (Rosso)'),
('rank_N_border_color', '0xFFFFD700', 'color', 'Colore bordo rank N (Oro)'),

-- Colori testo per rank
('rank_E_text_color', '0xFFCCCCCC', 'color', 'Colore testo rank E'),
('rank_D_text_color', '0xFF00FF00', 'color', 'Colore testo rank D'),
('rank_C_text_color', '0xFF00BFFF', 'color', 'Colore testo rank C'),
('rank_B_text_color', '0xFFFF00FF', 'color', 'Colore testo rank B'),
('rank_A_text_color', '0xFFFF8C00', 'color', 'Colore testo rank A'),
('rank_S_text_color', '0xFFFF0000', 'color', 'Colore testo rank S'),
('rank_N_text_color', '0xFFFFD700', 'color', 'Colore testo rank N'),

-- Dimensioni finestre
('main_window_width', '800', 'int', 'Larghezza finestra principale'),
('main_window_height', '600', 'int', 'Altezza finestra principale'),
('achievement_popup_width', '500', 'int', 'Larghezza popup achievement'),
('achievement_popup_height', '200', 'int', 'Altezza popup achievement'),
('stats_panel_width', '380', 'int', 'Larghezza pannello stats'),
('leaderboard_panel_width', '380', 'int', 'Larghezza pannello leaderboard'),

-- Posizioni default
('main_window_default_x', '100', 'int', 'Posizione X default finestra'),
('main_window_default_y', '100', 'int', 'Posizione Y default finestra'),

-- Timeout animazioni
('achievement_popup_duration', '10', 'int', 'Durata popup achievement (secondi)'),
('fade_in_duration', '300', 'int', 'Durata fade-in (millisecondi)'),
('fade_out_duration', '300', 'int', 'Durata fade-out (millisecondi)'),
('glow_animation_speed', '2', 'int', 'Velocit\u00e0 animazione glow'),

-- Messaggi sistema
('window_title', 'HUNTER SYSTEM', 'string', 'Titolo finestra principale'),
('tab_stats_title', 'Statistiche', 'string', 'Titolo tab Statistiche'),
('tab_achievements_title', 'Achievement', 'string', 'Titolo tab Achievement'),
('tab_leaderboard_title', 'Classifica', 'string', 'Titolo tab Classifica'),
('tab_missions_title', 'Missioni', 'string', 'Titolo tab Missioni'),
('tab_whatif_title', 'What-If', 'string', 'Titolo tab What-If'),

-- Label UI
('label_rank', 'Rank:', 'string', 'Label rank'),
('label_gloria_points', 'Punti Gloria:', 'string', 'Label punti gloria'),
('label_kills', 'Uccisioni:', 'string', 'Label uccisioni'),
('label_streak', 'Streak Login:', 'string', 'Label streak'),
('label_missions_completed', 'Missioni Completate:', 'string', 'Label missioni completate'),
('label_next_rank', 'Prossimo Rank:', 'string', 'Label prossimo rank'),
('label_penalty_active', '\u26A0\uFE0F PENALIT\u00C0 ATTIVA', 'string', 'Label penalit\u00e0 attiva'),
('label_rival_tracker', 'Rival Tracker', 'string', 'Label rival tracker'),
('label_rank_bonus', 'Bonus Rank', 'string', 'Label bonus rank'),

-- Messaggi notifica
('achievement_unlock_title', '\uD83C\uDFC6 ACHIEVEMENT SBLOCCATO!', 'string', 'Titolo popup achievement unlock'),
('achievement_claim_button', 'Riscuoti', 'string', 'Testo bottone riscuoti'),
('reload_success_msg', '[HUNTER] Config ricaricata con successo!', 'string', 'Messaggio reload successo'),
('reload_error_msg', '[HUNTER] Errore durante il reload della config!', 'string', 'Messaggio reload errore'),

-- Colori vari UI
('penalty_box_bg_color', '0xFF8B0000', 'color', 'Colore background penalty box (rosso scuro)'),
('rival_box_bg_color', '0xFF1A1A3E', 'color', 'Colore background rival box (blu scuro)'),
('stats_bg_color', '0xFF1E1E1E', 'color', 'Colore background stats panel'),
('achievement_locked_color', '0xFF666666', 'color', 'Colore achievement bloccati'),
('achievement_unlocked_color', '0xFF00FF00', 'color', 'Colore achievement sbloccati'),
('achievement_claimed_color', '0xFFFFD700', 'color', 'Colore achievement riscossi'),

-- Settings vari
('enable_sound_notifications', 'true', 'bool', 'Abilita notifiche sonore'),
('enable_achievement_popups', 'true', 'bool', 'Abilita popup achievement'),
('auto_claim_achievements', 'false', 'bool', 'Riscossione automatica achievement'),
('show_rival_tracker', 'true', 'bool', 'Mostra rival tracker'),
('show_rank_bonus', 'true', 'bool', 'Mostra bonus rank'),
('random_tip_interval', '300', 'int', 'Intervallo random tips (secondi)'),
('leaderboard_refresh_interval', '60', 'int', 'Intervallo refresh leaderboard (secondi)');

-- =====================================================================
-- 2. TABELLA: hunter_rank_bonuses
-- Configurazione bonus per ogni rank
-- =====================================================================
CREATE TABLE IF NOT EXISTS `hunter_rank_bonuses` (
  `rank_code` VARCHAR(1) PRIMARY KEY,
  `rank_name` VARCHAR(50) NOT NULL,
  `min_points` INT NOT NULL,
  `max_points` INT NOT NULL,
  `bonus_gloria_percent` INT NOT NULL DEFAULT 0,
  `bonus_drop_percent` INT NOT NULL DEFAULT 0,
  `rank_color_hex` VARCHAR(8) NOT NULL,
  `rank_title` VARCHAR(100) NOT NULL,
  `rank_icon` VARCHAR(50) DEFAULT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Popolamento hunter_rank_bonuses
INSERT INTO `hunter_rank_bonuses` (`rank_code`, `rank_name`, `min_points`, `max_points`, `bonus_gloria_percent`, `bonus_drop_percent`, `rank_color_hex`, `rank_title`, `rank_icon`) VALUES
('E', 'Novizio', 0, 999, 0, 0, '0xFFCCCCCC', 'Cacciatore Novizio', 'icon_rank_e.tga'),
('D', 'Apprendista', 1000, 4999, 5, 2, '0xFF00FF00', 'Cacciatore Apprendista', 'icon_rank_d.tga'),
('C', 'Esperto', 5000, 19999, 10, 5, '0xFF00BFFF', 'Cacciatore Esperto', 'icon_rank_c.tga'),
('B', 'Veterano', 20000, 49999, 15, 8, '0xFFFF00FF', 'Cacciatore Veterano', 'icon_rank_b.tga'),
('A', 'Elite', 50000, 99999, 20, 12, '0xFFFF8C00', 'Cacciatore Elite', 'icon_rank_a.tga'),
('S', 'Maestro', 100000, 249999, 25, 15, '0xFFFF0000', 'Maestro Cacciatore', 'icon_rank_s.tga'),
('N', 'Leggenda', 250000, 999999999, 30, 20, '0xFFFFD700', 'Leggenda Vivente', 'icon_rank_n.tga');

-- =====================================================================
-- 3. TABELLA: hunter_penalty_config
-- Configurazione sistema penalit\u00e0
-- =====================================================================
CREATE TABLE IF NOT EXISTS `hunter_penalty_config` (
  `penalty_level` INT PRIMARY KEY,
  `strikes_required` INT NOT NULL,
  `duration_hours` INT NOT NULL,
  `gloria_malus_percent` INT NOT NULL,
  `penalty_message` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Popolamento hunter_penalty_config
INSERT INTO `hunter_penalty_config` (`penalty_level`, `strikes_required`, `duration_hours`, `gloria_malus_percent`, `penalty_message`) VALUES
(1, 1, 6, 10, 'Prima infrazione: Fallimento missione. Penalit\u00e0 lieve per 6 ore.'),
(2, 2, 24, 25, 'Seconda infrazione: Comportamento negligente. Penalit\u00e0 moderata per 24 ore.'),
(3, 3, 72, 50, 'Terza infrazione: Violazione grave. Penalit\u00e0 severa per 72 ore. Prossima infrazione = ban permanente dal sistema Hunter!');

-- =====================================================================
-- 4. TABELLA: hunter_streak_milestones
-- Milestone e ricompense per streak login
-- =====================================================================
CREATE TABLE IF NOT EXISTS `hunter_streak_milestones` (
  `streak_days` INT PRIMARY KEY,
  `bonus_percent` INT NOT NULL DEFAULT 0,
  `milestone_message` TEXT,
  `reward_vnum` INT DEFAULT NULL,
  `reward_count` INT DEFAULT 1,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Popolamento hunter_streak_milestones
INSERT INTO `hunter_streak_milestones` (`streak_days`, `bonus_percent`, `milestone_message`, `reward_vnum`, `reward_count`) VALUES
(3, 5, '\uD83D\uDD25 Streak 3 giorni! +5% bonus gloria per oggi!', 50011, 1),
(7, 10, '\uD83D\uDD25 Streak 1 settimana! +10% bonus gloria + ricompensa speciale!', 50011, 3),
(14, 15, '\uD83D\uDD25 Streak 2 settimane! +15% bonus gloria! Dedizione straordinaria!', 50011, 5),
(21, 20, '\uD83D\uDD25 Streak 3 settimane! +20% bonus gloria! Sei inarrestabile!', 50011, 7),
(30, 25, '\uD83D\uDD25 Streak 1 MESE! +25% bonus gloria! LEGGENDARIO!', 50012, 1),
(60, 30, '\uD83D\uDD25 Streak 2 MESI! +30% bonus gloria! STRAORDINARIO!', 50012, 2),
(90, 35, '\uD83D\uDD25 Streak 3 MESI! +35% bonus gloria! SEI UN MITO!', 50012, 3),
(180, 40, '\uD83D\uDD25 Streak 6 MESI! +40% bonus gloria! DEDIZIONE ASSOLUTA!', 50013, 1),
(365, 50, '\uD83D\uDD25 Streak 1 ANNO! +50% bonus gloria! HAI RAGGIUNTO L\'OLIMPO!', 50013, 3);

-- =====================================================================
-- 5. ESTENSIONE: hunter_quest_achievements_config
-- Aggiungi colonna achievement_type per categorizzare gli achievement
-- =====================================================================
-- Verifica se la colonna esiste gi\u00e0, se no la aggiungo
ALTER TABLE `hunter_quest_achievements_config`
ADD COLUMN IF NOT EXISTS `achievement_type` INT NOT NULL DEFAULT 1 COMMENT '1=Kill Count, 2=Glory Points, 3=Boss Kills, 4=Metin Destroyed, 5=Chests Opened, 6=Login Streak, 7=Missions Completed, 8=Events Participated';

ALTER TABLE `hunter_quest_achievements_config`
ADD COLUMN IF NOT EXISTS `achievement_category` VARCHAR(50) DEFAULT 'General' COMMENT 'Categoria achievement';

ALTER TABLE `hunter_quest_achievements_config`
ADD COLUMN IF NOT EXISTS `is_hidden` TINYINT(1) DEFAULT 0 COMMENT 'Achievement nascosto fino allo sblocco';

ALTER TABLE `hunter_quest_achievements_config`
ADD COLUMN IF NOT EXISTS `icon_path` VARCHAR(100) DEFAULT NULL COMMENT 'Path icona achievement';

-- =====================================================================
-- 6. NUOVI ACHIEVEMENTS - TYPE 3: BOSS KILLS
-- =====================================================================
INSERT INTO `hunter_quest_achievements_config` (`achievement_id`, `achievement_name`, `achievement_desc`, `requirement_value`, `reward_vnum`, `reward_count`, `achievement_type`, `achievement_category`, `icon_path`) VALUES
(101, 'Ammazza-Boss I', 'Uccidi 10 boss', 10, 50011, 1, 3, 'Boss Hunter', 'achievement_boss_1.tga'),
(102, 'Ammazza-Boss II', 'Uccidi 50 boss', 50, 50011, 2, 3, 'Boss Hunter', 'achievement_boss_2.tga'),
(103, 'Ammazza-Boss III', 'Uccidi 100 boss', 100, 50011, 3, 3, 'Boss Hunter', 'achievement_boss_3.tga'),
(104, 'Sterminatore di Boss', 'Uccidi 250 boss', 250, 50011, 5, 3, 'Boss Hunter', 'achievement_boss_4.tga'),
(105, 'Flagello dei Boss', 'Uccidi 500 boss', 500, 50012, 1, 3, 'Boss Hunter', 'achievement_boss_5.tga'),
(106, 'Incubo dei Boss', 'Uccidi 1000 boss', 1000, 50012, 2, 3, 'Boss Hunter', 'achievement_boss_6.tga'),
(107, 'Leggenda Boss Hunter', 'Uccidi 2500 boss', 2500, 50013, 1, 3, 'Boss Hunter', 'achievement_boss_legend.tga'),

-- =====================================================================
-- 7. NUOVI ACHIEVEMENTS - TYPE 4: METIN DESTROYED
-- =====================================================================
(201, 'Distruttore di Metin I', 'Distruggi 10 Metin', 10, 50011, 1, 4, 'Metin Destroyer', 'achievement_metin_1.tga'),
(202, 'Distruttore di Metin II', 'Distruggi 50 Metin', 50, 50011, 2, 4, 'Metin Destroyer', 'achievement_metin_2.tga'),
(203, 'Distruttore di Metin III', 'Distruggi 100 Metin', 100, 50011, 3, 4, 'Metin Destroyer', 'achievement_metin_3.tga'),
(204, 'Demolitore Esperto', 'Distruggi 250 Metin', 250, 50011, 5, 4, 'Metin Destroyer', 'achievement_metin_4.tga'),
(205, 'Martello dei Metin', 'Distruggi 500 Metin', 500, 50012, 1, 4, 'Metin Destroyer', 'achievement_metin_5.tga'),
(206, 'Annientatore Metin', 'Distruggi 1000 Metin', 1000, 50012, 2, 4, 'Metin Destroyer', 'achievement_metin_6.tga'),
(207, 'Leggenda Anti-Metin', 'Distruggi 2500 Metin', 2500, 50013, 1, 4, 'Metin Destroyer', 'achievement_metin_legend.tga'),

-- =====================================================================
-- 8. NUOVI ACHIEVEMENTS - TYPE 5: CHESTS OPENED
-- =====================================================================
(301, 'Cacciatore di Tesori I', 'Apri 10 bauli', 10, 50011, 1, 5, 'Treasure Hunter', 'achievement_chest_1.tga'),
(302, 'Cacciatore di Tesori II', 'Apri 50 bauli', 50, 50011, 2, 5, 'Treasure Hunter', 'achievement_chest_2.tga'),
(303, 'Cacciatore di Tesori III', 'Apri 100 bauli', 100, 50011, 3, 5, 'Treasure Hunter', 'achievement_chest_3.tga'),
(304, 'Esploratore Avido', 'Apri 250 bauli', 250, 50011, 5, 5, 'Treasure Hunter', 'achievement_chest_4.tga'),
(305, 'Maestro del Tesoro', 'Apri 500 bauli', 500, 50012, 1, 5, 'Treasure Hunter', 'achievement_chest_5.tga'),
(306, 'Re dei Bauli', 'Apri 1000 bauli', 1000, 50012, 2, 5, 'Treasure Hunter', 'achievement_chest_6.tga'),
(307, 'Leggenda Treasure Hunter', 'Apri 2500 bauli', 2500, 50013, 1, 5, 'Treasure Hunter', 'achievement_chest_legend.tga'),

-- =====================================================================
-- 9. NUOVI ACHIEVEMENTS - TYPE 6: LOGIN STREAK DAYS
-- =====================================================================
(401, 'Fedele I', 'Login streak: 3 giorni', 3, 50011, 1, 6, 'Dedication', 'achievement_streak_1.tga'),
(402, 'Fedele II', 'Login streak: 7 giorni', 7, 50011, 2, 6, 'Dedication', 'achievement_streak_2.tga'),
(403, 'Fedele III', 'Login streak: 14 giorni', 14, 50011, 3, 6, 'Dedication', 'achievement_streak_3.tga'),
(404, 'Cacciatore Devoto', 'Login streak: 30 giorni', 30, 50011, 5, 6, 'Dedication', 'achievement_streak_4.tga'),
(405, 'Presenza Costante', 'Login streak: 60 giorni', 60, 50012, 1, 6, 'Dedication', 'achievement_streak_5.tga'),
(406, 'Inarrestabile', 'Login streak: 90 giorni', 90, 50012, 2, 6, 'Dedication', 'achievement_streak_6.tga'),
(407, 'Dedizione Assoluta', 'Login streak: 180 giorni', 180, 50012, 3, 6, 'Dedication', 'achievement_streak_7.tga'),
(408, 'Leggenda della Dedizione', 'Login streak: 365 giorni', 365, 50013, 2, 6, 'Dedication', 'achievement_streak_legend.tga'),

-- =====================================================================
-- 10. NUOVI ACHIEVEMENTS - TYPE 7: MISSIONS COMPLETED
-- =====================================================================
(501, 'Seguace della Missione I', 'Completa 10 missioni', 10, 50011, 1, 7, 'Mission Master', 'achievement_mission_1.tga'),
(502, 'Seguace della Missione II', 'Completa 25 missioni', 25, 50011, 2, 7, 'Mission Master', 'achievement_mission_2.tga'),
(503, 'Seguace della Missione III', 'Completa 50 missioni', 50, 50011, 3, 7, 'Mission Master', 'achievement_mission_3.tga'),
(504, 'Esecutore Esperto', 'Completa 100 missioni', 100, 50011, 5, 7, 'Mission Master', 'achievement_mission_4.tga'),
(505, 'Veterano delle Missioni', 'Completa 250 missioni', 250, 50012, 1, 7, 'Mission Master', 'achievement_mission_5.tga'),
(506, 'Maestro delle Missioni', 'Completa 500 missioni', 500, 50012, 2, 7, 'Mission Master', 'achievement_mission_6.tga'),
(507, 'Leggenda Mission Master', 'Completa 1000 missioni', 1000, 50013, 1, 7, 'Mission Master', 'achievement_mission_legend.tga'),

-- =====================================================================
-- 11. NUOVI ACHIEVEMENTS - TYPE 8: EVENTS PARTICIPATED
-- =====================================================================
(601, 'Partecipante I', 'Partecipa a 5 eventi', 5, 50011, 1, 8, 'Event Champion', 'achievement_event_1.tga'),
(602, 'Partecipante II', 'Partecipa a 10 eventi', 10, 50011, 2, 8, 'Event Champion', 'achievement_event_2.tga'),
(603, 'Partecipante III', 'Partecipa a 25 eventi', 25, 50011, 3, 8, 'Event Champion', 'achievement_event_3.tga'),
(604, 'Entusiasta degli Eventi', 'Partecipa a 50 eventi', 50, 50011, 5, 8, 'Event Champion', 'achievement_event_4.tga'),
(605, 'Veterano degli Eventi', 'Partecipa a 100 eventi', 100, 50012, 1, 8, 'Event Champion', 'achievement_event_5.tga'),
(606, 'Campione degli Eventi', 'Partecipa a 250 eventi', 250, 50012, 2, 8, 'Event Champion', 'achievement_event_6.tga'),
(607, 'Leggenda Event Champion', 'Partecipa a 500 eventi', 500, 50013, 1, 8, 'Event Champion', 'achievement_event_legend.tga'),

-- =====================================================================
-- 12. ACHIEVEMENTS SPECIALI E NASCOSTI
-- =====================================================================
(701, 'Prima Caccia', 'Uccidi il tuo primo mostro come Hunter', 1, 50011, 1, 1, 'Special', 'achievement_first_kill.tga'),
(702, 'Primo Passo', 'Raggiungi Rank D', 1000, 50011, 2, 2, 'Special', 'achievement_rank_d.tga'),
(703, 'In Ascesa', 'Raggiungi Rank C', 5000, 50011, 3, 2, 'Special', 'achievement_rank_c.tga'),
(704, 'Elite Hunter', 'Raggiungi Rank A', 50000, 50012, 1, 2, 'Special', 'achievement_rank_a.tga'),
(705, 'Leggenda Nascente', 'Raggiungi Rank N', 250000, 50013, 3, 2, 'Special', 'achievement_rank_n.tga'),
(706, 'Perfezionista', 'Completa tutti gli achievement (hidden)', 1, 50013, 5, 2, 'Special', 'achievement_perfectionist.tga'),
(707, 'Resiliente', 'Recupera da 3 penalit\u00e0 senza ban (hidden)', 3, 50012, 2, 2, 'Special', 'achievement_resilient.tga'),
(708, 'Imbattibile', 'Mantieni streak di 100 giorni (hidden)', 100, 50013, 2, 6, 'Special', 'achievement_unbeatable.tga');

-- Imposta alcuni achievement come nascosti
UPDATE `hunter_quest_achievements_config` SET `is_hidden` = 1 WHERE `achievement_id` IN (706, 707, 708);

-- =====================================================================
-- 13. TABELLA: hunter_quest_tips
-- Tips random mostrati al giocatore
-- =====================================================================
CREATE TABLE IF NOT EXISTS `hunter_quest_tips` (
  `tip_id` INT AUTO_INCREMENT PRIMARY KEY,
  `tip_text` TEXT NOT NULL,
  `tip_category` VARCHAR(50) DEFAULT 'General',
  `is_active` TINYINT(1) DEFAULT 1,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Popolamento hunter_quest_tips
INSERT INTO `hunter_quest_tips` (`tip_text`, `tip_category`) VALUES
('Suggerimento: I boss danno pi\u00f9 punti Gloria delle creature normali!', 'Combat'),
('Suggerimento: Mantieni un login streak per bonus Gloria extra!', 'Streak'),
('Suggerimento: Completa le missioni quotidiane per massimizzare i punti!', 'Missions'),
('Suggerimento: Gli achievement nascosti si sbloccano con azioni speciali!', 'Achievements'),
('Suggerimento: Ogni rank ti d\u00e0 bonus permanenti a Gloria e Drop!', 'Ranks'),
('Suggerimento: Usa il tab What-If per pianificare la tua progressione!', 'Strategy'),
('Suggerimento: Evita di fallire le missioni per non ricevere penalit\u00e0!', 'Penalties'),
('Suggerimento: I Metin distrutti contano per achievement speciali!', 'Achievements'),
('Suggerimento: Apri bauli per sbloccare achievement Treasure Hunter!', 'Achievements'),
('Suggerimento: Partecipa agli eventi per punti Gloria bonus!', 'Events'),
('Suggerimento: Il Rival Tracker ti mostra chi ti ha superato in classifica!', 'Leaderboard'),
('Suggerimento: Puoi filtrare gli achievement per categoria nel tab dedicato!', 'UI'),
('Suggerimento: Rank N \u00e8 il massimo: +30% Gloria e +20% Drop!', 'Ranks'),
('Suggerimento: Login streak di 365 giorni ti rende una Leggenda!', 'Streak'),
('Suggerimento: Controlla le tue statistiche per vedere le fonti di Gloria!', 'Stats');

-- =====================================================================
-- 14. TABELLA: hunter_gloria_sources_tracking
-- Traccia le fonti di punti Gloria per le statistiche
-- =====================================================================
CREATE TABLE IF NOT EXISTS `hunter_gloria_sources_tracking` (
  `player_id` INT NOT NULL,
  `source_type` VARCHAR(50) NOT NULL COMMENT 'FRACTURE, MISSION, EVENT, EMERGENCY, BOSS, STREAK',
  `total_gloria` BIGINT NOT NULL DEFAULT 0,
  `count_events` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`player_id`, `source_type`),
  FOREIGN KEY (`player_id`) REFERENCES `player`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================================
-- 15. INDICI PER PERFORMANCE
-- =====================================================================
CREATE INDEX idx_achievement_type ON `hunter_quest_achievements_config` (`achievement_type`);
CREATE INDEX idx_achievement_category ON `hunter_quest_achievements_config` (`achievement_category`);
CREATE INDEX idx_is_hidden ON `hunter_quest_achievements_config` (`is_hidden`);
CREATE INDEX idx_config_type ON `hunter_ui_config` (`config_type`);
CREATE INDEX idx_rank_points ON `hunter_rank_bonuses` (`min_points`, `max_points`);
CREATE INDEX idx_tip_active ON `hunter_quest_tips` (`is_active`);

-- =====================================================================
-- 16. FIX 4: RANK THEME COLORS (56+ colors) - 100% CONFIGURABILE
-- =====================================================================
CREATE TABLE IF NOT EXISTS `hunter_ui_rank_colors` (
  `rank_code` VARCHAR(1) PRIMARY KEY,
  `bg_dark` VARCHAR(10) NOT NULL,
  `bg_medium` VARCHAR(10) NOT NULL,
  `bg_light` VARCHAR(10) NOT NULL,
  `border` VARCHAR(10) NOT NULL,
  `accent` VARCHAR(10) NOT NULL,
  `text_title` VARCHAR(10) NOT NULL,
  `text_value` VARCHAR(10) NOT NULL,
  `text_muted` VARCHAR(10) NOT NULL,
  `bar_fill` VARCHAR(10) NOT NULL,
  `glow` VARCHAR(10) NOT NULL,
  `btn_normal` VARCHAR(10) NOT NULL,
  `btn_hover` VARCHAR(10) NOT NULL,
  `btn_down` VARCHAR(10) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Popola con colori attuali da uihunterlevel.py RANK_THEMES
INSERT INTO `hunter_ui_rank_colors` VALUES
-- E-Rank (Grigio)
('E', '0xEE0D0D0D', '0xEE1A1A1A', '0xEE2A2A2A', '0xFF555555', '0xFF808080', '0xFF999999', '0xFFCCCCCC', '0xFF666666', '0xFF808080', '0x33808080', '0xFF333333', '0xFF444444', '0xFF555555', NOW(), NOW()),
-- D-Rank (Verde)
('D', '0xEE0A1A0A', '0xEE0F2A0F', '0xEE153A15', '0xFF00AA00', '0xFF00FF00', '0xFF44FF44', '0xFFAAFFAA', '0xFF337733', '0xFF00DD00', '0x3300FF00', '0xFF0A2A0A', '0xFF0F3F0F', '0xFF155515', NOW(), NOW()),
-- C-Rank (Celeste)
('C', '0xEE0A1A2A', '0xEE0F2A3A', '0xEE153A4A', '0xFF00CCFF', '0xFF00FFFF', '0xFF44DDFF', '0xFFAAEEFF', '0xFF337799', '0xFF00CCFF', '0x3300FFFF', '0xFF0A2A3A', '0xFF0F3A4A', '0xFF154A5A', NOW(), NOW()),
-- B-Rank (Blu)
('B', '0xEE0A0A2A', '0xEE0F0F3A', '0xEE15154A', '0xFF0066FF', '0xFF4488FF', '0xFF6699FF', '0xFFAABBFF', '0xFF334477', '0xFF0066FF', '0x330066FF', '0xFF0A0A3A', '0xFF0F0F4A', '0xFF15155A', NOW(), NOW()),
-- A-Rank (Viola)
('A', '0xEE1A0A2A', '0xEE2A0F3A', '0xEE3A154A', '0xFFAA00FF', '0xFFCC66FF', '0xFFDD88FF', '0xFFEEBBFF', '0xFF773399', '0xFFAA00FF', '0x33AA00FF', '0xFF2A0A3A', '0xFF3A0F4A', '0xFF4A155A', NOW(), NOW()),
-- S-Rank (Arancione)
('S', '0xEE2A1A0A', '0xEE3A2A0F', '0xEE4A3A15', '0xFFFF6600', '0xFFFFAA00', '0xFFFFBB44', '0xFFFFDDAA', '0xFF996633', '0xFFFF6600', '0x33FF6600', '0xFF3A2A0A', '0xFF4A3A0F', '0xFF5A4A15', NOW(), NOW()),
-- N-Rank (Rosso)
('N', '0xEE2A0A0A', '0xEE3A0F0F', '0xEE4A1515', '0xFFFF0000', '0xFFFF4444', '0xFFFF6666', '0xFFFFAAAA', '0xFF993333', '0xFFFF0000', '0x33FF0000', '0xFF3A0A0A', '0xFF4A0F0F', '0xFF5A1515', NOW(), NOW());

-- Colori speciali (medaglie, ecc.)
INSERT INTO `hunter_ui_config` (`config_key`, `config_value`, `config_type`, `description`) VALUES
('color_gold', '0xFFFFD700', 'color', 'Colore oro (medaglie)'),
('color_silver', '0xFFC0C0C0', 'color', 'Colore argento'),
('color_bronze', '0xFFCD7F32', 'color', 'Colore bronzo');

-- =====================================================================
-- 17. FIX 5: UI STRINGS (35+ strings) - 100% CONFIGURABILE
-- =====================================================================

-- Tab titles
INSERT INTO `hunter_texts` VALUES ('ui_tab_stats', 'STATISTICHE PERSONALI');
INSERT INTO `hunter_texts` VALUES ('ui_tab_achievements', 'TRAGUARDI');
INSERT INTO `hunter_texts` VALUES ('ui_tab_ranking', 'SALA DELLE LEGGENDE');
INSERT INTO `hunter_texts` VALUES ('ui_tab_events', 'EVENTI DEL GIORNO');
INSERT INTO `hunter_texts` VALUES ('ui_tab_missions', 'MISSIONI');
INSERT INTO `hunter_texts` VALUES ('ui_tab_guide', 'GUIDA');

-- Section titles
INSERT INTO `hunter_texts` VALUES ('ui_section_today', 'OGGI');
INSERT INTO `hunter_texts` VALUES ('ui_section_total', 'TOTALE');
INSERT INTO `hunter_texts` VALUES ('ui_section_economy', 'ECONOMIA');
INSERT INTO `hunter_texts` VALUES ('ui_section_records', 'RECORD');
INSERT INTO `hunter_texts` VALUES ('ui_section_personal_stats', 'STATISTICHE PERSONALI');

-- Guide sections
INSERT INTO `hunter_texts` VALUES ('ui_guide_ranks', 'SISTEMA DEI RANGHI');
INSERT INTO `hunter_texts` VALUES ('ui_guide_glory', 'COME GUADAGNARE GLORIA');
INSERT INTO `hunter_texts` VALUES ('ui_guide_credits', 'COME GUADAGNARE CREDITI');
INSERT INTO `hunter_texts` VALUES ('ui_guide_missions', 'MISSIONI GIORNALIERE');
INSERT INTO `hunter_texts` VALUES ('ui_guide_emergency', 'EMERGENCY QUEST');
INSERT INTO `hunter_texts` VALUES ('ui_guide_speedkill', 'SPEED KILL BONUS');
INSERT INTO `hunter_texts` VALUES ('ui_guide_events', 'EVENTI SCHEDULATI');
INSERT INTO `hunter_texts` VALUES ('ui_guide_chests', 'BAULI DIMENSIONALI');
INSERT INTO `hunter_texts` VALUES ('ui_guide_fractures', 'FRATTURE DIMENSIONALI');
INSERT INTO `hunter_texts` VALUES ('ui_guide_shop', 'MERCANTE HUNTER');

-- Rank descriptions
INSERT INTO `hunter_texts` VALUES ('rank_E_title', 'E-Rank');
INSERT INTO `hunter_texts` VALUES ('rank_E_desc', 'Novizio - Inizi il tuo viaggio');
INSERT INTO `hunter_texts` VALUES ('rank_D_title', 'D-Rank');
INSERT INTO `hunter_texts` VALUES ('rank_D_desc', 'Principiante - Hai imparato le basi');
INSERT INTO `hunter_texts` VALUES ('rank_C_title', 'C-Rank');
INSERT INTO `hunter_texts` VALUES ('rank_C_desc', 'Cacciatore - Competente e affidabile');
INSERT INTO `hunter_texts` VALUES ('rank_B_title', 'B-Rank');
INSERT INTO `hunter_texts` VALUES ('rank_B_desc', 'Veterano - Rispettato dalla comunità');
INSERT INTO `hunter_texts` VALUES ('rank_A_title', 'A-Rank');
INSERT INTO `hunter_texts` VALUES ('rank_A_desc', 'Elite - Tra i migliori del regno');
INSERT INTO `hunter_texts` VALUES ('rank_S_title', 'S-Rank');
INSERT INTO `hunter_texts` VALUES ('rank_S_desc', 'Leggenda - Potere straordinario');
INSERT INTO `hunter_texts` VALUES ('rank_N_title', 'N-Rank');
INSERT INTO `hunter_texts` VALUES ('rank_N_desc', 'Monarca Nazionale - Hai raggiunto l apice del potere!');

-- Messages
INSERT INTO `hunter_texts` VALUES ('ui_msg_all_complete', 'BONUS TUTTE COMPLETE');
INSERT INTO `hunter_texts` VALUES ('ui_msg_how_participate', 'COME PARTECIPARE');
INSERT INTO `hunter_texts` VALUES ('ui_msg_rewards', 'RICOMPENSE');

-- =====================================================================
-- 18. FIX 6: UI DIMENSIONS (20+ dimensions) - 100% CONFIGURABILE
-- =====================================================================

-- Main window
INSERT INTO `hunter_ui_config` (`config_key`, `config_value`, `config_type`, `description`) VALUES
('ui_window_width', '500', 'int', 'Larghezza finestra principale'),
('ui_window_height', '520', 'int', 'Altezza finestra principale'),

-- Sections
('ui_header_height', '95', 'int', 'Altezza header'),
('ui_content_height', '300', 'int', 'Altezza contenuto'),
('ui_tab_height', '28', 'int', 'Altezza tab'),
('ui_footer_height', '35', 'int', 'Altezza footer'),

-- Panels
('ui_stats_panel_width', '240', 'int', 'Larghezza pannello stats'),
('ui_stats_panel_height', '200', 'int', 'Altezza pannello stats'),
('ui_achievement_popup_width', '500', 'int', 'Larghezza popup achievement'),
('ui_achievement_popup_height', '200', 'int', 'Altezza popup achievement'),

-- Positions
('ui_window_center_x', '1', 'bool', 'Centra finestra X (0=no, 1=si)'),
('ui_window_center_y', '1', 'bool', 'Centra finestra Y'),
('ui_header_y', '0', 'int', 'Posizione Y header'),
('ui_content_y', '95', 'int', 'Posizione Y contenuto'),
('ui_footer_y', '485', 'int', 'Posizione Y footer'),

-- Text sizes
('ui_font_size_title', '16', 'int', 'Font size titoli'),
('ui_font_size_label', '12', 'int', 'Font size label'),
('ui_font_size_value', '14', 'int', 'Font size valori'),

-- Paddings
('ui_padding_small', '5', 'int', 'Padding piccolo'),
('ui_padding_medium', '10', 'int', 'Padding medio'),
('ui_padding_large', '15', 'int', 'Padding grande');

-- =====================================================================
-- 19. CONFIG TEST MODE
-- =====================================================================
INSERT INTO `hunter_ui_config` (`config_key`, `config_value`, `config_type`, `description`) VALUES
('test_mode_enabled', '0', 'bool', 'Abilita modalità test (0=no, 1=si)');

-- =====================================================================
-- FINE SCHEMA SQL
-- =====================================================================
-- Per applicare questo schema:
-- 1. Importa in Navicat o esegui da MySQL CLI
-- 2. Ricarica le quest con /reload q
-- 3. Usa /hunter_reload per ricaricare la config in-game
-- =====================================================================
