-- ============================================================================
-- HUNTER SYSTEM DATABASE - VERSIONE CORRETTA E OTTIMIZZATA
-- Tutti i fix applicati: Emergency quest bilanciate, eventi puliti, colori corretti
-- Database: srv1_hunabku
-- Data: 24 Dicembre 2025 - VERSIONE FINALE
-- ============================================================================

-- ISTRUZIONI:
-- 1. Esegui questo script su un database VUOTO o dopo aver droppato le tabelle esistenti
-- 2. Verifica che il database 'srv1_hunabku' esista: CREATE DATABASE IF NOT EXISTS srv1_hunabku;
-- 3. Esegui: mysql -u root -p srv1_hunabku < HUNTER_DATABASE_FIXED_FINAL.sql

USE srv1_hunabku;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ============================================================================
-- FIX #1: EMERGENCY QUESTS - VALORI BILANCIATI (non più impossibili)
-- ============================================================================

DROP TABLE IF EXISTS `hunter_quest_emergencies`;
CREATE TABLE `hunter_quest_emergencies`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `description` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `duration_seconds` int NULL DEFAULT 60,
  `target_vnum` int NULL DEFAULT 0,
  `target_count` int NULL DEFAULT 10,
  `reward_points` int NULL DEFAULT 100,
  `reward_item_vnum` int NULL DEFAULT 0,
  `reward_item_count` int NULL DEFAULT 0,
  `enabled` int NULL DEFAULT 1,
  `min_level` int NULL DEFAULT 1,
  `max_level` int NULL DEFAULT 120,
  `difficulty` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT 'NORMAL',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 9 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- FIX: Valori bilanciati e completabili
INSERT INTO `hunter_quest_emergencies` VALUES
(1, 'Prova del Novizio', 'Uccidi 30 mostri in 60 secondi. Missione introduttiva!', 60, 0, 30, 150, 0, 0, 1, 1, 50, 'EASY'),
(2, 'Caccia Rapida', 'Uccidi 2 Boss in 120 secondi.', 120, 0, 2, 400, 0, 0, 1, 20, 80, 'NORMAL'),
(3, 'Metin Sprint', 'Distruggi 3 Metin in 150 secondi.', 150, 0, 3, 350, 0, 0, 1, 15, 90, 'NORMAL'),
(4, 'Sopravvivi all\'Orda', 'Uccidi 60 mostri in 60 secondi. Fai del tuo meglio!', 60, 0, 60, 300, 0, 0, 1, 5, 120, 'HARD'),
(5, 'Distruttore di Metin', 'Distruggi 5 Metin in 180 secondi. Preparati a correre!', 180, 0, 5, 500, 0, 0, 1, 15, 120, 'HARD'),
(6, 'Difesa Disperata', 'Elimina 120 nemici in 90 secondi. (1.3 kill al secondo)', 90, 0, 120, 600, 0, 0, 1, 30, 120, 'EXTREME'),
(7, 'Cacciatore di Boss', 'Uccidi 3 Boss in 180 secondi. (Puoi cambiare CH)', 180, 0, 3, 1000, 0, 0, 1, 40, 120, 'EXTREME'),
(8, 'Il Massacro', 'Uccidi 250 creature in 180 secondi. Serve AOE potente!', 180, 0, 250, 1200, 0, 0, 1, 50, 120, 'GOD_MODE');

-- ============================================================================
-- FIX #2: EVENTI SCHEDULATI - PULIZIA E CORREZIONE COLOR_SCHEME
-- ============================================================================

DROP TABLE IF EXISTS `hunter_scheduled_events`;
CREATE TABLE `hunter_scheduled_events`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `event_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `event_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `event_desc` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `start_hour` int NOT NULL,
  `start_minute` int NOT NULL DEFAULT 0,
  `duration_minutes` int NOT NULL DEFAULT 30,
  `days_active` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1,2,3,4,5,6,7',
  `min_rank` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'E',
  `reward_glory_base` int NULL DEFAULT 10,
  `reward_glory_winner` int NULL DEFAULT 50,
  `color_scheme` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'BLUE',
  `priority` int NULL DEFAULT 5,
  `enabled` tinyint(1) NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 63 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- FIX: Eventi puliti con color_scheme corretti (UPPERCASE)
-- Eventi ALBA (5:00-8:00)
INSERT INTO `hunter_scheduled_events` VALUES (1, 'Alba del Cacciatore', 'glory_rush', 'Gloria x2 per ogni uccisione! Svegliati e guadagna!', 5, 0, 60, '1,2,3,4,5,6,7', 'E', 20, 100, 'GOLD', 5, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (2, 'Prima Frattura', 'first_rift', 'Chi trova PER PRIMO la Frattura dellAlba vince!', 6, 0, 30, '1,2,3,4,5,6,7', 'E', 50, 300, 'PURPLE', 6, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (3, 'Caccia ai Bauli Nascosti', 'treasure_race', 'Bauli speciali spawnano ovunque! Chi ne trova di piu?', 6, 30, 45, '1,2,3,4,5,6,7', 'E', 30, 200, 'GOLD', 5, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (4, 'Risveglio dei Boss', 'first_boss', 'Boss Mattutino spawna! Chi lo uccide PER PRIMO?', 7, 0, 30, '1,2,3,4,5,6,7', 'D', 60, 350, 'RED', 6, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (5, 'Metin dellAlba', 'metin_frenzy', 'Metin spawn x3! Distruggine il piu possibile!', 7, 30, 30, '1,2,3,4,5,6,7', 'E', 25, 150, 'ORANGE', 5, 1, '2025-12-24 16:44:17');

-- Eventi MATTINA (8:00-12:00)
INSERT INTO `hunter_scheduled_events` VALUES (6, 'Caccia alla Frattura Blu', 'first_rift', 'Frattura Blu appare! Trovala PRIMA degli altri!', 8, 0, 20, '1,2,3,4,5,6,7', 'E', 40, 250, 'BLUE', 6, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (7, 'SuperMetin Mattutini', 'super_metin', 'SuperMetin rari spawnano! Chi ne distrugge di piu?', 8, 30, 45, '1,2,3,4,5,6,7', 'D', 70, 400, 'ORANGE', 7, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (8, 'Massacro Boss Mattina', 'boss_massacre', 'Boss ovunque! Uccidine il MASSIMO in 30 minuti!', 9, 0, 30, '1,2,3,4,5,6,7', 'D', 60, 350, 'RED', 7, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (9, 'Tesori del Mattino', 'treasure_race', 'Scrigni dorati nelle mappe D! Raccoglili tutti!', 9, 30, 30, '1,2,3,4,5,6,7', 'D', 35, 200, 'GOLD', 5, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (10, 'Doppio Spawn Boss', 'double_spawn', 'DOPPIO SPAWN BOSS per 45 minuti! Approfittane!', 10, 0, 45, '1,2,3,4,5,6,7', 'C', 80, 450, 'RED', 8, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (11, 'Sfida Fratture Multiple', 'rift_hunt', 'Quante fratture riesci a trovare in 30 min?', 10, 45, 30, '1,2,3,4,5,6,7', 'C', 90, 500, 'PURPLE', 7, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (12, 'Gloria Rush Mezzogiorno', 'glory_rush', 'GLORIA x2 per TUTTO! Farming intensivo!', 11, 30, 30, '1,2,3,4,5,6,7', 'E', 25, 120, 'GOLD', 6, 1, '2025-12-24 16:44:17');

-- Eventi POMERIGGIO (12:00-18:00)
INSERT INTO `hunter_scheduled_events` VALUES (13, 'Frattura del Mezzogiorno', 'first_rift', 'Frattura Dorata! Il PRIMO che la trova vince GROSSO!', 12, 0, 25, '1,2,3,4,5,6,7', 'C', 100, 600, 'GOLD', 8, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (14, 'Caccia al Boss Leggendario', 'first_boss', 'Boss Leggendario spawna! Chi lo abbatte PER PRIMO?', 12, 30, 30, '1,2,3,4,5,6,7', 'C', 120, 700, 'RED', 9, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (15, 'Frenesia SuperMetin', 'super_metin', 'INVASIONE SuperMetin! Distruggine piu che puoi!', 13, 0, 45, '1,2,3,4,5,6,7', 'C', 80, 450, 'ORANGE', 8, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (16, 'Corsa ai Bauli Epici', 'treasure_race', 'Bauli EPICI con loot raro! Chi ne trova di piu?', 13, 45, 30, '1,2,3,4,5,6,7', 'C', 50, 300, 'GOLD', 6, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (17, 'Massacro Pomeridiano', 'boss_massacre', 'BOSS x2 spawn! Massacrali TUTTI!', 14, 15, 45, '1,2,3,4,5,6,7', 'B', 100, 550, 'RED', 8, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (18, 'Torneo PvP Pomeriggio', 'pvp_tournament', 'Arena aperta! Combatti per la GLORIA!', 15, 0, 60, '1,2,3,4,5,6,7', 'C', 40, 800, 'RED', 9, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (19, 'Caccia Fratture Rosse', 'rift_hunt', 'Fratture Rosse ovunque! Chi ne trova di piu in 40 min?', 15, 30, 40, '1,2,3,4,5,6,7', 'B', 110, 600, 'PURPLE', 8, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (20, 'Doppio Boss Intensivo', 'double_spawn', 'TRIPLO SPAWN BOSS! Ora o mai piu!', 16, 15, 45, '1,2,3,4,5,6,7', 'B', 120, 650, 'RED', 9, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (21, 'SuperMetin Estremo', 'super_metin', 'SuperMetin RARI con drop speciale!', 17, 0, 30, '1,2,3,4,5,6,7', 'B', 90, 500, 'ORANGE', 8, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (22, 'Survival Challenge', 'survival', 'Sopravvivi 20 minuti senza morire! Bonus Gloria!', 17, 30, 25, '1,2,3,4,5,6,7', 'C', 60, 400, 'BLUE', 7, 1, '2025-12-24 16:44:17');

-- Eventi SERA - ORA DI PUNTA (18:00-22:00)
INSERT INTO `hunter_scheduled_events` VALUES (23, 'ORA DI PUNTA - Frattura Nera', 'first_rift', 'FRATTURA NERA! Chi la trova PER PRIMO? PREMIO ENORME!', 18, 0, 30, '1,2,3,4,5,6,7', 'B', 150, 1000, 'PURPLE', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (24, 'Gloria Rush Serale', 'glory_rush', 'GLORIA x3 per 45 minuti! FARMING MASSIMO!', 18, 30, 45, '1,2,3,4,5,6,7', 'D', 50, 200, 'GOLD', 8, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (25, 'MEGA Boss Hunt', 'first_boss', 'MEGA BOSS spawna alle 19:00! Chi lo uccide PRIMO?', 19, 0, 30, '1,2,3,4,5,6,7', 'A', 200, 1200, 'RED', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (26, 'Invasione SuperMetin', 'super_metin', 'INVASIONE TOTALE SuperMetin! Record da battere!', 19, 30, 45, '1,2,3,4,5,6,7', 'B', 100, 600, 'ORANGE', 9, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (27, 'Caccia Fratture Elite', 'rift_hunt', 'Fratture ELITE! Chi ne trova PIU di 5?', 20, 0, 40, '1,2,3,4,5,6,7', 'A', 150, 900, 'PURPLE', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (28, 'BOSS MASSACRE SERALE', 'boss_massacre', 'STERMINIO BOSS! Chi ne uccide di PIU in 30 min?', 20, 45, 30, '1,2,3,4,5,6,7', 'A', 180, 1000, 'RED', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (29, 'Arena Suprema', 'pvp_tournament', 'TORNEO PVP SERALE! Il vincitore prende TUTTO!', 21, 15, 45, '1,2,3,4,5,6,7', 'B', 80, 1500, 'RED', 10, 1, '2025-12-24 16:44:17');

-- Eventi NOTTE (22:00-5:00)
INSERT INTO `hunter_scheduled_events` VALUES (30, 'Caccia Notturna - Frattura Ombra', 'first_rift', 'Frattura dellOmbra appare SOLO di notte! Trovala!', 22, 0, 30, '1,2,3,4,5,6,7', 'A', 180, 1100, 'PURPLE', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (31, 'Boss Notturno Leggendario', 'first_boss', 'BOSS NOTTURNO! Appare solo a mezzanotte!', 22, 30, 30, '1,2,3,4,5,6,7', 'S', 250, 1500, 'RED', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (32, 'Tesori della Mezzanotte', 'treasure_race', 'Bauli LEGGENDARI solo per i nottambuli!', 23, 0, 45, '1,2,3,4,5,6,7', 'B', 100, 700, 'GOLD', 9, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (33, 'Mezzanotte - SuperMetin Rari', 'super_metin', 'SuperMetin RARISSIMI con drop unico!', 23, 45, 30, '1,2,3,4,5,6,7', 'A', 150, 900, 'ORANGE', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (34, 'Massacro di Mezzanotte', 'boss_massacre', 'BOSS SPAWN x3! Chi ne uccide di piu?', 0, 15, 45, '1,2,3,4,5,6,7', 'S', 200, 1200, 'RED', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (35, 'Frattura del Giudizio', 'first_rift', 'Frattura FINALE della notte! Premio MASSIMO!', 1, 0, 30, '1,2,3,4,5,6,7', 'A', 200, 1300, 'PURPLE', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (36, 'Gloria Notturna x4', 'glory_rush', 'GLORIA x4! Solo per chi resta sveglio!', 1, 30, 60, '1,2,3,4,5,6,7', 'C', 40, 250, 'GOLD', 8, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (37, 'Silenzio della Notte', 'survival', 'Sopravvivi 30 min senza morire! Premio speciale!', 2, 30, 35, '1,2,3,4,5,6,7', 'B', 80, 500, 'BLUE', 7, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (38, 'Metin Fantasma', 'super_metin', 'Metin FANTASMA rarissimi! Solo ora!', 3, 0, 45, '1,2,3,4,5,6,7', 'C', 60, 400, 'ORANGE', 7, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (39, 'Bauli dellOscurita', 'treasure_race', 'Bauli nascosti nelloscurita! Trovane il massimo!', 3, 45, 30, '1,2,3,4,5,6,7', 'D', 40, 300, 'GOLD', 6, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (40, 'Boss Prima dellAlba', 'first_boss', 'Ultimo Boss prima dellalba! Chi lo uccide?', 4, 15, 30, '1,2,3,4,5,6,7', 'C', 70, 450, 'RED', 7, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (41, 'Doppio Spawn Finale', 'double_spawn', 'Ultimo doppio spawn della notte!', 4, 45, 30, '1,2,3,4,5,6,7', 'D', 50, 350, 'RED', 6, 1, '2025-12-24 16:44:17');

-- Eventi WEEKEND SPECIALI
INSERT INTO `hunter_scheduled_events` VALUES (42, 'Sabato Gloria x3', 'glory_rush', 'WEEKEND! Gloria TRIPLA tutto il giorno!', 10, 0, 120, '6', 'E', 30, 150, 'GOLD', 8, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (43, 'Sabato Frattura Dorata', 'first_rift', 'Frattura DORATA del weekend! Premio x2!', 11, 0, 30, '6', 'C', 150, 900, 'GOLD', 9, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (44, 'MEGA Caccia Boss Sabato', 'boss_massacre', 'BOSS x5 spawn! MASSACRO TOTALE!', 14, 0, 60, '6', 'B', 200, 1200, 'RED', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (45, 'Torneo PvP Sabato', 'pvp_tournament', 'TORNEO WEEKEND! Premi DOPPI!', 15, 0, 90, '6', 'B', 100, 2000, 'RED', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (46, 'SuperMetin Invasion Sab', 'super_metin', 'INVASIONE MASSIVA SuperMetin!', 16, 30, 45, '6', 'A', 180, 1000, 'ORANGE', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (47, 'Frattura LEGGENDARIA Sab', 'first_rift', 'FRATTURA LEGGENDARIA! Una volta a settimana!', 18, 0, 30, '6', 'S', 300, 2000, 'PURPLE', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (48, 'WORLD BOSS Sabato', 'first_boss', 'WORLD BOSS SETTIMANALE! Chi lo uccide?', 20, 0, 60, '6', 'S', 400, 3000, 'RED', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (49, 'Notte Sabato - Tutto x4', 'glory_rush', 'GLORIA x4 tutta la notte di sabato!', 22, 0, 120, '6', 'D', 50, 300, 'GOLD', 9, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (50, 'Domenica Relax Gloria x2', 'glory_rush', 'Domenica tranquilla con Gloria x2!', 9, 0, 180, '7', 'E', 25, 120, 'GOLD', 7, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (51, 'Dom Caccia Bauli Epici', 'treasure_race', 'Bauli EPICI della domenica!', 11, 0, 45, '7', 'D', 60, 400, 'GOLD', 8, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (52, 'Domenica Boss Marathon', 'boss_massacre', 'MARATONA BOSS! 2 ore di carneficina!', 14, 0, 120, '7', 'B', 150, 1000, 'RED', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (53, 'Frattura Domenicale', 'rift_hunt', 'Quante fratture trovi in 1 ora?', 15, 0, 60, '7', 'A', 200, 1200, 'PURPLE', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (54, 'TORNEO DEI CAMPIONI', 'pvp_tournament', 'GRAN FINALE SETTIMANALE! Premio ENORME!', 16, 0, 120, '7', 'A', 150, 5000, 'RED', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (55, 'Ultima Frattura Settimana', 'first_rift', 'ULTIMA FRATTURA! Non perdertela!', 18, 0, 30, '7', 'S', 350, 2500, 'PURPLE', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (56, 'BOSS FINALE SETTIMANALE', 'first_boss', 'IL BOSS PIU FORTE! Chi lo abbatte?', 20, 0, 60, '7', 'S', 500, 4000, 'RED', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (57, 'Countdown Settimana', 'glory_rush', 'Ultime ore! Gloria x5!', 22, 0, 120, '7', 'E', 60, 350, 'GOLD', 10, 1, '2025-12-24 16:44:17');

-- Eventi GIORNALIERI SPECIALI
INSERT INTO `hunter_scheduled_events` VALUES (58, 'Lunedi Fratture', 'rift_hunt', 'LUNEDI = Giorno delle Fratture! Spawn x2!', 19, 0, 60, '1', 'C', 100, 700, 'PURPLE', 9, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (59, 'Martedi Boss Day', 'boss_massacre', 'MARTEDI = Boss Day! Spawn aumentato!', 19, 0, 60, '2', 'C', 100, 700, 'RED', 9, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (60, 'Mercoledi Arena', 'pvp_tournament', 'MERCOLEDI = Arena Day! Premi x1.5!', 20, 0, 60, '3', 'D', 60, 1000, 'RED', 9, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (61, 'Giovedi Treasure Day', 'treasure_race', 'GIOVEDI = Treasure Day! Bauli ovunque!', 19, 0, 60, '4', 'D', 80, 600, 'GOLD', 9, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (62, 'Venerdi Gloria Rush', 'glory_rush', 'VENERDI = Gloria x3 dalle 18 alle 24!', 18, 0, 360, '5', 'E', 40, 200, 'GOLD', 9, 1, '2025-12-24 16:44:17');

-- ============================================================================
-- VERIFICA EVENTI
-- ============================================================================
-- Totale: 62 eventi puliti e funzionanti
-- Color_scheme: Tutti UPPERCASE e validi
-- Nessun evento test presente

SET FOREIGN_KEY_CHECKS = 1;

SELECT 'Database Hunter System installato con successo!' as 'STATUS';
SELECT 'Totale Emergency Quests:', COUNT(*) FROM hunter_quest_emergencies WHERE enabled=1;
SELECT 'Totale Eventi Schedulati:', COUNT(*) FROM hunter_scheduled_events WHERE enabled=1;
