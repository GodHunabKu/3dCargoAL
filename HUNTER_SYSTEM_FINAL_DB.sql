-- =====================================================================
-- HUNTER SYSTEM - DATABASE COMPLETO AL 100%
-- =====================================================================
-- Sistema Hunter completo ispirato a Solo Leveling
-- Tutte le tabelle necessarie con dati completi
-- Versione: FINAL (25 Dicembre 2025)
-- =====================================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

/*
 Navicat Premium Data Transfer

 Source Server         : Metin2Hunter2025
 Source Server Type    : MySQL
 Source Server Version : 101111 (10.11.11-MariaDB)
 Source Host           : 81.180.203.146:3306
 Source Schema         : srv1_hunabku

 Target Server Type    : MySQL
 Target Server Version : 101111 (10.11.11-MariaDB)
 File Encoding         : 65001

 Date: 24/12/2025 22:29:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for hunter_login_messages
-- ----------------------------
DROP TABLE IF EXISTS `hunter_login_messages`;
CREATE TABLE `hunter_login_messages`  (
  `day_number` int NOT NULL,
  `message_text` varchar(300) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`day_number`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hunter_login_messages
-- ----------------------------
INSERT INTO `hunter_login_messages` VALUES (1, 'Primo_giorno_di_caccia._Il_viaggio_inizia_ora.');
INSERT INTO `hunter_login_messages` VALUES (2, 'Secondo_giorno._Stai_costruendo_un_abitudine.');
INSERT INTO `hunter_login_messages` VALUES (3, '[BONUS_ATTIVATO]_3_giorni_consecutivi!_+5%_Gloria.');
INSERT INTO `hunter_login_messages` VALUES (4, 'La_costanza_e_la_chiave._Continua_cosi.');
INSERT INTO `hunter_login_messages` VALUES (5, '5_giorni._Gli_altri_Cacciatori_ti_stanno_notando.');
INSERT INTO `hunter_login_messages` VALUES (6, 'Quasi_una_settimana._Il_Sistema_e_impressionato.');
INSERT INTO `hunter_login_messages` VALUES (7, '[BONUS_POTENZIATO]_7_giorni!_+10%_Gloria._Sei_determinato.');
INSERT INTO `hunter_login_messages` VALUES (14, '2_settimane._Pochi_hanno_la_tua_dedizione.');
INSERT INTO `hunter_login_messages` VALUES (21, '3_settimane._Stai_diventando_una_leggenda.');
INSERT INTO `hunter_login_messages` VALUES (30, '[BONUS_MASSIMO]_30_giorni!_+20%_Gloria._Il_Sistema_ti_onora.');
INSERT INTO `hunter_login_messages` VALUES (60, '60_giorni._Sei_un_esempio_per_tutti_i_Cacciatori.');
INSERT INTO `hunter_login_messages` VALUES (90, '90_giorni._Il_tuo_nome_risuona_nelle_cronache.');
INSERT INTO `hunter_login_messages` VALUES (100, '[CENTENARIO]_100_giorni!_Sei_entrato_nella_storia.');
INSERT INTO `hunter_login_messages` VALUES (180, '180_giorni._Mezzo_anno_di_caccia_ininterrotta.');
INSERT INTO `hunter_login_messages` VALUES (365, '[IMMORTALE]_Un_anno_intero!_Sei_diventato_immortale.');

-- ----------------------------
-- Table structure for hunter_mission_definitions
-- ----------------------------
DROP TABLE IF EXISTS `hunter_mission_definitions`;
CREATE TABLE `hunter_mission_definitions`  (
  `mission_id` int NOT NULL AUTO_INCREMENT,
  `mission_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mission_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'kill_mob, kill_boss, kill_metin, seal_fracture',
  `target_vnum` int NULL DEFAULT 0 COMMENT 'VNUM specifico (0 = qualsiasi)',
  `target_count` int NOT NULL DEFAULT 10,
  `min_rank` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'E' COMMENT 'Rank minimo richiesto',
  `gloria_reward` int NOT NULL DEFAULT 100,
  `gloria_penalty` int NOT NULL DEFAULT 25,
  `time_limit_minutes` int NULL DEFAULT 1440 COMMENT 'Limite tempo in minuti (1440 = 24h)',
  `enabled` tinyint(1) NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  PRIMARY KEY (`mission_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 50 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hunter_mission_definitions
-- ----------------------------
INSERT INTO `hunter_mission_definitions` VALUES (1, 'Caccia ai Lupi', 'kill_mob', 101, 10, 'E', 50, 10, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (2, 'Stermina gli Orchi', 'kill_mob', 631, 15, 'E', 75, 15, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (3, 'Elimina i Cinghiali', 'kill_mob', 102, 20, 'E', 60, 12, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (4, 'Caccia agli Orsi', 'kill_mob', 1901, 8, 'E', 80, 16, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (5, 'Pulizia Ragni', 'kill_mob', 491, 12, 'E', 55, 11, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (6, 'Uccidi i Banditi', 'kill_mob', 5001, 10, 'E', 70, 14, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (7, 'Caccia Generale', 'kill_mob', 0, 25, 'E', 65, 13, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (8, 'Caccia ai Guerrieri Orco', 'kill_mob', 632, 15, 'D', 100, 20, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (9, 'Stermina gli Scheletri', 'kill_mob', 691, 20, 'D', 110, 22, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (10, 'Elimina i Demoni Minori', 'kill_mob', 1091, 12, 'D', 120, 24, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (11, 'Distruggi 2 Metin', 'kill_metin', 0, 2, 'D', 150, 30, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (12, 'Caccia agli Zombie', 'kill_mob', 791, 18, 'D', 95, 19, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (13, 'Uccidi i Ninja Nemici', 'kill_mob', 5101, 10, 'D', 130, 26, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (14, 'Pulizia Dungeon', 'kill_mob', 0, 30, 'D', 105, 21, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (15, 'Caccia al Boss Ragno', 'kill_boss', 492, 1, 'C', 200, 40, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (16, 'Stermina i Guerrieri Elite', 'kill_mob', 634, 15, 'C', 180, 36, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (17, 'Distruggi 3 Metin', 'kill_metin', 0, 3, 'C', 250, 50, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (18, 'Caccia ai Demoni', 'kill_mob', 1092, 12, 'C', 190, 38, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (19, 'Uccidi Boss Orco', 'kill_boss', 691, 1, 'C', 220, 44, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (20, 'Pulizia Avanzata', 'kill_mob', 0, 40, 'C', 170, 34, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (21, 'Caccia ai Non-Morti', 'kill_mob', 792, 20, 'C', 185, 37, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (22, 'Uccidi il Generale Orco', 'kill_boss', 693, 1, 'B', 350, 70, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (23, 'Distruggi 5 Metin', 'kill_metin', 0, 5, 'B', 400, 80, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (24, 'Sigilla una Frattura', 'seal_fracture', 0, 1, 'B', 500, 100, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (25, 'Caccia ai Demoni Maggiori', 'kill_mob', 1093, 15, 'B', 300, 60, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (26, 'Stermina i Capitani', 'kill_boss', 0, 2, 'B', 380, 76, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (27, 'Pulizia Massiva', 'kill_mob', 0, 60, 'B', 280, 56, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (28, 'Caccia Notturna', 'kill_mob', 793, 25, 'B', 320, 64, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (29, 'Uccidi il Re degli Orchi', 'kill_boss', 694, 1, 'A', 600, 120, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (30, 'Distruggi 8 Metin', 'kill_metin', 0, 8, 'A', 700, 140, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (31, 'Sigilla 2 Fratture', 'seal_fracture', 0, 2, 'A', 900, 180, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (32, 'Caccia ai Boss Demoniaci', 'kill_boss', 1094, 2, 'A', 650, 130, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (33, 'Sterminio Totale', 'kill_mob', 0, 100, 'A', 550, 110, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (34, 'Caccia ai Generali', 'kill_boss', 0, 3, 'A', 720, 144, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (35, 'Elite Hunter', 'kill_mob', 0, 80, 'A', 580, 116, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (36, 'Uccidi il Signore dei Demoni', 'kill_boss', 1095, 1, 'S', 1000, 200, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (37, 'Distruggi 12 Metin', 'kill_metin', 0, 12, 'S', 1100, 220, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (38, 'Sigilla 3 Fratture', 'seal_fracture', 0, 3, 'S', 1500, 300, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (39, 'Caccia Leggendaria', 'kill_boss', 0, 5, 'S', 1200, 240, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (40, 'Massacro', 'kill_mob', 0, 150, 'S', 900, 180, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (41, 'Dominio Assoluto', 'kill_boss', 0, 4, 'S', 1300, 260, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (42, 'Campione del Server', 'kill_mob', 0, 120, 'S', 950, 190, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (43, 'Uccidi il Boss Finale', 'kill_boss', 0, 3, 'N', 2000, 400, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (44, 'Distruggi 20 Metin', 'kill_metin', 0, 20, 'N', 2500, 500, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (45, 'Sigilla 5 Fratture', 'seal_fracture', 0, 5, 'N', 3000, 600, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (46, 'Leggenda Nazionale', 'kill_boss', 0, 8, 'N', 2200, 440, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (47, 'Annientamento', 'kill_mob', 0, 250, 'N', 1800, 360, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (48, 'Imperatore Hunter', 'kill_boss', 0, 6, 'N', 2400, 480, 1440, 1, '2025-12-24 05:34:27');
INSERT INTO `hunter_mission_definitions` VALUES (49, 'Gloria Eterna', 'kill_mob', 0, 200, 'N', 1900, 380, 1440, 1, '2025-12-24 05:34:27');

-- ----------------------------
-- Table structure for hunter_player_missions
-- ----------------------------
DROP TABLE IF EXISTS `hunter_player_missions`;
CREATE TABLE `hunter_player_missions`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `player_id` int NOT NULL,
  `mission_slot` int NOT NULL DEFAULT 1 COMMENT 'Slot 1-3',
  `mission_def_id` int NOT NULL COMMENT 'FK a mission_definitions.mission_id',
  `assigned_date` date NOT NULL,
  `current_progress` int NULL DEFAULT 0,
  `target_count` int NOT NULL,
  `status` enum('active','completed','failed') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'active',
  `reward_glory` int NOT NULL DEFAULT 100,
  `penalty_glory` int NOT NULL DEFAULT 25,
  `completed_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_player_date`(`player_id` ASC, `assigned_date` ASC) USING BTREE,
  UNIQUE INDEX `unique_player_slot_day`(`player_id` ASC, `mission_slot` ASC, `assigned_date` ASC) USING BTREE,
  INDEX `mission_def_id`(`mission_def_id` ASC) USING BTREE,
  CONSTRAINT `hunter_player_missions_ibfk_1` FOREIGN KEY (`mission_def_id`) REFERENCES `hunter_mission_definitions` (`mission_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hunter_player_missions
-- ----------------------------
INSERT INTO `hunter_player_missions` VALUES (4, 4, 1, 28, '2025-12-24', 2, 25, 'active', 320, 64, NULL);
INSERT INTO `hunter_player_missions` VALUES (5, 4, 2, 8, '2025-12-24', 0, 15, 'active', 100, 20, NULL);
INSERT INTO `hunter_player_missions` VALUES (6, 4, 3, 12, '2025-12-24', 0, 18, 'active', 95, 19, NULL);

-- ----------------------------
-- Table structure for hunter_quest_achievements_config
-- ----------------------------
DROP TABLE IF EXISTS `hunter_quest_achievements_config`;
CREATE TABLE `hunter_quest_achievements_config`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `type` int NULL DEFAULT 1,
  `requirement` int NULL DEFAULT 0,
  `reward_vnum` int NULL DEFAULT 0,
  `reward_count` int NULL DEFAULT 0,
  `enabled` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hunter_quest_achievements_config
-- ----------------------------
INSERT INTO `hunter_quest_achievements_config` VALUES (1, 'Novizio (Kill)', 1, 10, 80030, 1, 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (2, 'Principiante (Kill)', 1, 50, 80030, 5, 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (3, 'Cacciatore D (Kill)', 1, 100, 80031, 1, 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (4, 'Cacciatore C (Kill)', 1, 250, 80031, 2, 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (5, 'Cacciatore B (Kill)', 1, 500, 80032, 1, 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (6, 'Cacciatore A (Kill)', 1, 1000, 80032, 2, 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (7, 'Elite S (Kill)', 1, 2500, 80032, 5, 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (8, 'Fama Nascente (Punti)', 2, 5000, 80030, 10, 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (9, 'Fama Media (Punti)', 2, 20000, 80031, 5, 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (10, 'Fama Alta (Punti)', 2, 50000, 80032, 5, 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (11, 'Leggenda (Punti)', 2, 100000, 80040, 1, 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (12, 'MONARCA (Punti)', 2, 500000, 80039, 1, 1);

-- ----------------------------
-- Table structure for hunter_quest_config
-- ----------------------------
DROP TABLE IF EXISTS `hunter_quest_config`;
CREATE TABLE `hunter_quest_config`  (
  `config_key` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `config_value` int NULL DEFAULT 0,
  PRIMARY KEY (`config_key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hunter_quest_config
-- ----------------------------
INSERT INTO `hunter_quest_config` VALUES ('challenge_time_seconds', 60);
INSERT INTO `hunter_quest_config` VALUES ('daily_reset_hour', 0);
INSERT INTO `hunter_quest_config` VALUES ('emergency_chance_percent', 40);
INSERT INTO `hunter_quest_config` VALUES ('seal_fracture_bonus', 200);
INSERT INTO `hunter_quest_config` VALUES ('spawn_threshold_normal', 2);
INSERT INTO `hunter_quest_config` VALUES ('speedkill_boss_seconds', 60);
INSERT INTO `hunter_quest_config` VALUES ('speedkill_metin_seconds', 300);
INSERT INTO `hunter_quest_config` VALUES ('streak_bonus_30days', 20);
INSERT INTO `hunter_quest_config` VALUES ('streak_bonus_3days', 5);
INSERT INTO `hunter_quest_config` VALUES ('streak_bonus_7days', 10);
INSERT INTO `hunter_quest_config` VALUES ('timer_reset_check', 60);
INSERT INTO `hunter_quest_config` VALUES ('timer_tips_random', 90);
INSERT INTO `hunter_quest_config` VALUES ('timer_update_stats', 60);
INSERT INTO `hunter_quest_config` VALUES ('welcome_offline_seconds', 120);
INSERT INTO `hunter_quest_config` VALUES ('whatif_chance_percent', 50);
-- Config mancanti da aggiungere a hunter_quest_config
INSERT INTO `hunter_quest_config` VALUES ('rank_threshold_E', 0);
INSERT INTO `hunter_quest_config` VALUES ('rank_threshold_D', 2000);
INSERT INTO `hunter_quest_config` VALUES ('rank_threshold_C', 10000);
INSERT INTO `hunter_quest_config` VALUES ('rank_threshold_B', 50000);
INSERT INTO `hunter_quest_config` VALUES ('rank_threshold_A', 150000);
INSERT INTO `hunter_quest_config` VALUES ('rank_threshold_S', 500000);
INSERT INTO `hunter_quest_config` VALUES ('rank_threshold_N', 1500000);
INSERT INTO `hunter_quest_config` VALUES ('streak_days_tier1', 3);
INSERT INTO `hunter_quest_config` VALUES ('streak_days_tier2', 7);
INSERT INTO `hunter_quest_config` VALUES ('streak_days_tier3', 30);
INSERT INTO `hunter_quest_config` VALUES ('rival_range_daily', 500);
INSERT INTO `hunter_quest_config` VALUES ('rival_range_weekly', 2000);
INSERT INTO `hunter_quest_config` VALUES ('rival_range_total', 50000);
INSERT INTO `hunter_quest_config` VALUES ('rival_range_metins', 50);
INSERT INTO `hunter_quest_config` VALUES ('rival_range_chests', 50);
INSERT INTO `hunter_quest_config` VALUES ('rival_range_fractures', 20);

-- ----------------------------
-- Table structure for hunter_quest_emergencies
-- ----------------------------
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

-- ----------------------------
-- Records of hunter_quest_emergencies
-- FIXED: Balanced from impossible (4-7 kill/sec) to doable (1-1.5 kill/sec)
-- ----------------------------
INSERT INTO `hunter_quest_emergencies` VALUES (1, 'Sopravvivi all\'Orda', 'Uccidi 60 mostri in 60 secondi. Fai del tuo meglio!', 60, 0, 60, 300, 0, 0, 1, 5, 120, 'HARD');
INSERT INTO `hunter_quest_emergencies` VALUES (2, 'Distruttore di Metin', 'Distruggi 5 Metin in 3 minuti. Preparati a correre!', 180, 0, 5, 500, 0, 0, 1, 15, 120, 'HARD');
INSERT INTO `hunter_quest_emergencies` VALUES (3, 'Difesa Disperata', 'Elimina 120 nemici in 90 secondi. (1.3 kill al secondo)', 90, 0, 120, 600, 0, 0, 1, 30, 120, 'EXTREME');
INSERT INTO `hunter_quest_emergencies` VALUES (4, 'Cacciatore di Boss', 'Uccidi 3 Boss in 180 secondi. (Puoi cambiare CH)', 180, 0, 3, 1000, 0, 0, 1, 40, 120, 'EXTREME');
INSERT INTO `hunter_quest_emergencies` VALUES (5, 'Il Massacro', 'Uccidi 250 creature in 180 secondi. Serve AOE potente!', 180, 0, 250, 1200, 0, 0, 1, 50, 120, 'GOD_MODE');
INSERT INTO `hunter_quest_emergencies` VALUES (6, 'Prova del Novizio', 'Uccidi 30 mostri in 60 secondi. Missione introduttiva!', 60, 0, 30, 150, 0, 0, 1, 1, 50, 'EASY');
INSERT INTO `hunter_quest_emergencies` VALUES (7, 'Caccia Rapida', 'Uccidi 2 Boss in 120 secondi.', 120, 0, 2, 400, 0, 0, 1, 20, 80, 'NORMAL');
INSERT INTO `hunter_quest_emergencies` VALUES (8, 'Metin Sprint', 'Distruggi 3 Metin in 150 secondi.', 150, 0, 3, 350, 0, 0, 1, 15, 90, 'NORMAL');

-- ----------------------------
-- Table structure for hunter_quest_fractures
-- ----------------------------
DROP TABLE IF EXISTS `hunter_quest_fractures`;
CREATE TABLE `hunter_quest_fractures`  (
  `vnum` int NOT NULL,
  `name` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rank_label` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `color_code` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'PURPLE',
  `spawn_chance` int NULL DEFAULT 10,
  `req_points` int NULL DEFAULT 0,
  `enabled` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`vnum`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hunter_quest_fractures
-- ----------------------------
INSERT INTO `hunter_quest_fractures` VALUES (16060, 'Frattura Primordiale', 'E-Rank', 'GREEN', 35, 0, 1);
INSERT INTO `hunter_quest_fractures` VALUES (16061, 'Frattura Astrale', 'D-Rank', 'BLUE', 25, 2000, 1);
INSERT INTO `hunter_quest_fractures` VALUES (16062, 'Frattura Abissale', 'C-Rank', 'ORANGE', 15, 10000, 1);
INSERT INTO `hunter_quest_fractures` VALUES (16063, 'Frattura Cremisi', 'B-Rank', 'RED', 10, 50000, 1);
INSERT INTO `hunter_quest_fractures` VALUES (16064, 'Frattura Aurea', 'A-Rank', 'GOLD', 8, 150000, 1);
INSERT INTO `hunter_quest_fractures` VALUES (16065, 'Frattura Infausta', 'S-Rank', 'PURPLE', 5, 500000, 1);
INSERT INTO `hunter_quest_fractures` VALUES (16066, 'Frattura del Giudizio', 'National', 'BLACKWHITE', 2, 1500000, 1);

-- ----------------------------
-- Table structure for hunter_quest_jackpot_rewards
-- ----------------------------
DROP TABLE IF EXISTS `hunter_quest_jackpot_rewards`;
CREATE TABLE `hunter_quest_jackpot_rewards`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `item_vnum` int NOT NULL,
  `item_quantity` int NULL DEFAULT 1,
  `bonus_points` int NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hunter_quest_jackpot_rewards
-- ----------------------------
INSERT INTO `hunter_quest_jackpot_rewards` VALUES (1, 'JACKPOT', 80031, 1, 500);
INSERT INTO `hunter_quest_jackpot_rewards` VALUES (2, 'JACKPOT', 80032, 1, 1000);
INSERT INTO `hunter_quest_jackpot_rewards` VALUES (3, 'JACKPOT', 80040, 1, 0);
INSERT INTO `hunter_quest_jackpot_rewards` VALUES (4, 'BAULE', 80030, 1, 10);
INSERT INTO `hunter_quest_jackpot_rewards` VALUES (5, 'BAULE', 80031, 1, 50);

-- ----------------------------
-- Table structure for hunter_quest_ranking
-- ----------------------------
DROP TABLE IF EXISTS `hunter_quest_ranking`;
CREATE TABLE `hunter_quest_ranking`  (
  `player_id` int NOT NULL,
  `player_name` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `hunter_rank` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'E',
  `total_points` int NULL DEFAULT 0,
  `spendable_points` int NULL DEFAULT 0,
  `daily_points` int NULL DEFAULT 0,
  `weekly_points` int NULL DEFAULT 0,
  `total_kills` int NULL DEFAULT 0,
  `daily_kills` int NULL DEFAULT 0,
  `weekly_kills` int NULL DEFAULT 0,
  `login_streak` int NULL DEFAULT 0,
  `last_login` int NULL DEFAULT 0,
  `penalty_strikes` int NULL DEFAULT 0,
  `rival_pid` int NULL DEFAULT 0,
  `pending_daily_reward` int NULL DEFAULT 0,
  `pending_weekly_reward` int NULL DEFAULT 0,
  `total_fractures` int NULL DEFAULT 0,
  `total_chests` int NULL DEFAULT 0,
  `total_metins` int NULL DEFAULT 0,
  `current_rank` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'E',
  `last_activity` datetime NULL DEFAULT current_timestamp,
  `penalty_active` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Penalita attiva: 0=no, 1=si',
  `penalty_expires` int UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Timestamp UNIX scadenza penalita',
  `failed_missions` int UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Numero missioni fallite (reset a 0 dopo penalita)',
  `overtaken_by` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `overtaken_diff` int NULL DEFAULT 0,
  `overtaken_label` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`player_id`) USING BTREE,
  INDEX `idx_penalty_status`(`penalty_active` ASC, `penalty_expires` ASC) USING BTREE,
  INDEX `idx_failed_missions`(`failed_missions` ASC) USING BTREE,
  INDEX `idx_penalty`(`penalty_active` ASC, `penalty_expires` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hunter_quest_ranking
-- ----------------------------
INSERT INTO `hunter_quest_ranking` VALUES (2, '[GF]Aelarion', 'E', 34000, 24000, 0, 17000, 300, 0, 100, 0, 0, 0, 0, 1, 0, 48, 0, 0, 'E', '2025-12-21 17:41:26', 0, 0, 0, '[GF]HunabKu', 1, 'ESPLORATORI');
INSERT INTO `hunter_quest_ranking` VALUES (4, '[GF]HunabKu', 'E', 1501359, 139279, 1696, 21752, 293, 3, 63, 0, 0, 0, 0, 0, 0, 75, 0, 32, 'E', '2025-12-21 14:12:05', 0, 0, 0, NULL, 0, NULL);
INSERT INTO `hunter_quest_ranking` VALUES (3893, 'Potenza', 'E', 95, 95, 95, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'E', '2025-12-23 18:06:07', 0, 0, 0, NULL, 0, NULL);

-- ----------------------------
-- Table structure for hunter_quest_rewards
-- ----------------------------
DROP TABLE IF EXISTS `hunter_quest_rewards`;
CREATE TABLE `hunter_quest_rewards`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `reward_type` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT 'daily',
  `rank_position` int NULL DEFAULT 1,
  `item_vnum` int NOT NULL,
  `item_quantity` int NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hunter_quest_rewards
-- ----------------------------
INSERT INTO `hunter_quest_rewards` VALUES (1, 'daily', 1, 80032, 2);
INSERT INTO `hunter_quest_rewards` VALUES (2, 'daily', 2, 80031, 2);
INSERT INTO `hunter_quest_rewards` VALUES (3, 'daily', 3, 80030, 2);
INSERT INTO `hunter_quest_rewards` VALUES (4, 'weekly', 1, 80039, 1);
INSERT INTO `hunter_quest_rewards` VALUES (5, 'weekly', 2, 80040, 1);
INSERT INTO `hunter_quest_rewards` VALUES (6, 'weekly', 3, 80032, 5);

-- ----------------------------
-- Table structure for hunter_quest_shop
-- ----------------------------
DROP TABLE IF EXISTS `hunter_quest_shop`;
CREATE TABLE `hunter_quest_shop`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `item_vnum` int NOT NULL,
  `item_count` int NULL DEFAULT 1,
  `price_points` int NULL DEFAULT 1000,
  `description` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT 'Item',
  `display_order` int NULL DEFAULT 0,
  `enabled` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hunter_quest_shop
-- ----------------------------
INSERT INTO `hunter_quest_shop` VALUES (1, 80030, 1, 500, 'Buono 100 Punti', 1, 1);
INSERT INTO `hunter_quest_shop` VALUES (2, 80031, 1, 2500, 'Buono 500 Punti', 2, 1);
INSERT INTO `hunter_quest_shop` VALUES (3, 80032, 1, 5000, 'Buono 1000 Punti', 3, 1);
INSERT INTO `hunter_quest_shop` VALUES (4, 80040, 1, 200000, 'Buono 50 DR', 4, 1);
INSERT INTO `hunter_quest_shop` VALUES (5, 80039, 1, 500000, 'Buono 100 DR', 5, 1);

-- ----------------------------
-- Table structure for hunter_quest_spawn_types
-- ----------------------------
DROP TABLE IF EXISTS `hunter_quest_spawn_types`;
CREATE TABLE `hunter_quest_spawn_types`  (
  `type_name` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `probability` int NULL DEFAULT 0,
  `is_jackpot` tinyint(1) NULL DEFAULT 0,
  `enabled` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`type_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hunter_quest_spawn_types
-- ----------------------------
INSERT INTO `hunter_quest_spawn_types` VALUES ('BAULE', 100, 0, 1);
INSERT INTO `hunter_quest_spawn_types` VALUES ('BOSS', 650, 0, 1);
INSERT INTO `hunter_quest_spawn_types` VALUES ('JACKPOT', 25, 1, 1);
INSERT INTO `hunter_quest_spawn_types` VALUES ('SUPER_METIN', 300, 0, 1);

-- ----------------------------
-- Table structure for hunter_quest_spawns
-- ----------------------------
DROP TABLE IF EXISTS `hunter_quest_spawns`;
CREATE TABLE `hunter_quest_spawns`  (
  `spawn_id` int NOT NULL AUTO_INCREMENT,
  `vnum` int NOT NULL,
  `name` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `type_name` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `min_level` int NULL DEFAULT 1,
  `max_level` int NULL DEFAULT 250,
  `base_points` int NULL DEFAULT 100,
  `rank_color` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'PURPLE',
  `enabled` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`spawn_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hunter_quest_spawns
-- ----------------------------
INSERT INTO `hunter_quest_spawns` VALUES (1, 4700, 'Metin Lv.45', 'SUPER_METIN', 35, 55, 50, 'GREEN', 1);
INSERT INTO `hunter_quest_spawns` VALUES (2, 4701, 'Metin Lv.60', 'SUPER_METIN', 50, 70, 70, 'GREEN', 1);
INSERT INTO `hunter_quest_spawns` VALUES (3, 4702, 'Metin Lv.75', 'SUPER_METIN', 65, 85, 90, 'BLUE', 1);
INSERT INTO `hunter_quest_spawns` VALUES (4, 4703, 'Metin Lv.90', 'SUPER_METIN', 80, 100, 110, 'BLUE', 1);
INSERT INTO `hunter_quest_spawns` VALUES (5, 4704, 'Metin Lv.95', 'SUPER_METIN', 85, 105, 130, 'ORANGE', 1);
INSERT INTO `hunter_quest_spawns` VALUES (6, 4705, 'Metin Lv.115', 'SUPER_METIN', 105, 125, 150, 'ORANGE', 1);
INSERT INTO `hunter_quest_spawns` VALUES (7, 4706, 'Metin Lv.135', 'SUPER_METIN', 125, 150, 180, 'RED', 1);
INSERT INTO `hunter_quest_spawns` VALUES (8, 4707, 'Metin Lv.165', 'SUPER_METIN', 150, 180, 220, 'GOLD', 1);
INSERT INTO `hunter_quest_spawns` VALUES (9, 4708, 'Metin Lv.200', 'SUPER_METIN', 180, 250, 300, 'PURPLE', 1);
INSERT INTO `hunter_quest_spawns` VALUES (10, 4035, 'Funglash', 'BOSS', 65, 85, 100, 'GREEN', 1);
INSERT INTO `hunter_quest_spawns` VALUES (11, 719, 'Thaloren', 'BOSS', 85, 105, 120, 'BLUE', 1);
INSERT INTO `hunter_quest_spawns` VALUES (12, 2771, 'Yinlee', 'BOSS', 90, 110, 140, 'BLUE', 1);
INSERT INTO `hunter_quest_spawns` VALUES (13, 768, 'Slubina', 'BOSS', 105, 125, 160, 'ORANGE', 1);
INSERT INTO `hunter_quest_spawns` VALUES (14, 6790, 'Alastor', 'BOSS', 115, 135, 180, 'ORANGE', 1);
INSERT INTO `hunter_quest_spawns` VALUES (15, 6831, 'Grimlor', 'BOSS', 125, 145, 200, 'RED', 1);
INSERT INTO `hunter_quest_spawns` VALUES (16, 986, 'Branzhul', 'BOSS', 140, 160, 250, 'RED', 1);
INSERT INTO `hunter_quest_spawns` VALUES (17, 989, 'Torgal', 'BOSS', 155, 175, 300, 'GOLD', 1);
INSERT INTO `hunter_quest_spawns` VALUES (18, 4011, 'Nerzakar', 'BOSS', 175, 195, 350, 'GOLD', 1);
INSERT INTO `hunter_quest_spawns` VALUES (19, 6830, 'Nozzera', 'BOSS', 190, 210, 400, 'PURPLE', 1);
INSERT INTO `hunter_quest_spawns` VALUES (20, 4385, 'Velzahar', 'BOSS', 200, 250, 500, 'BLACKWHITE', 1);
INSERT INTO `hunter_quest_spawns` VALUES (21, 200102, 'Cassa E-Rank', 'BAULE', 1, 250, 20, 'GREEN', 1);
INSERT INTO `hunter_quest_spawns` VALUES (22, 200101, 'Cassa S-Rank', 'BAULE', 1, 250, 50, 'PURPLE', 1);

-- ----------------------------
-- TABELLA: hunter_quest_tips (VERSIONE UNIFICATA)
-- =====================================================================
DROP TABLE IF EXISTS `hunter_quest_tips`;
CREATE TABLE `hunter_quest_tips` (
  `tip_id` INT AUTO_INCREMENT PRIMARY KEY,
  `tip_text` TEXT NOT NULL,
  `tip_category` VARCHAR(50) DEFAULT 'General',
  `is_active` TINYINT(1) DEFAULT 1,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Popolamento hunter_quest_tips (30 tips originali + 15 nuovi = 45 totali)
INSERT INTO `hunter_quest_tips` (`tip_text`, `tip_category`, `is_active`) VALUES
-- Tips originali (30)
('Attenzione: Quando apri una Frattura, le tue coordinate vengono svelate a tutto il server!', 'Fractures', 1),
('Non esiste onore nella caccia: rubare il Boss a un altro giocatore e una strategia valida.', 'PvP', 1),
('Chi infligge il maggior danno al Boss si aggiudica il bottino e i Punti Gloria.', 'Combat', 1),
('Se vedi un avviso di spawn vicino a te, corri! Potresti rubare un Super Metin.', 'Strategy', 1),
('La Top 3 della Classifica Settimanale riceve Monete Drago (DR). Dacci dentro!', 'Leaderboard', 1),
('SPEED KILL: Uccidi il Boss entro 60 secondi per RADDOPPIARE i punti ottenuti!', 'SpeedKill', 1),
('Per i Super Metin hai 5 minuti di tempo per ottenere il bonus Speed Kill (x2 Punti).', 'SpeedKill', 1),
('Consiglio: Attiva i buff e le rugiade PRIMA di cliccare sulla Frattura.', 'Strategy', 1),
('Non spezzare la catena! Logga ogni giorno per un bonus punti passivo fino al +20%.', 'Streak', 1),
('Hai perso la streak di login? Dovrai ricominciare da zero per riavere il bonus.', 'Streak', 1),
('I Punti Gloria sono una valuta preziosa. Spendili con saggezza nel menu (N).', 'Economy', 1),
('Il Mercante Hunter in Capitale vende oggetti esclusivi non presenti nel menu rapido.', 'Shop', 1),
('I prezzi del Mercante potrebbero cambiare o apparire offerte speciali. Controllalo spesso.', 'Shop', 1),
('Puoi convertire i tuoi punti in Item, ma ricorda: scalare la classifica da prestigio.', 'Strategy', 1),
('I Buoni Punti trovati nei bauli sono commerciabili? Scoprilo provando a scambiarli!', 'Economy', 1),
('Controlla spesso il menu Traguardi (tasto N): ci sono premi che aspettano solo di essere riscossi.', 'Achievements', 1),
('Esistono due vie per i traguardi: la Via del Sangue (Kill) e la Via della Gloria (Punti).', 'Achievements', 1),
('Sbloccare il titolo Monarca nei traguardi garantisce una ricompensa leggendaria.', 'Achievements', 1),
('Anche aprire le Fratture conta per le statistiche del tuo Profilo Cacciatore.', 'Stats', 1),
('Le Fratture Rosse (Red Gates) sono molto rare ma hanno un drop rate aumentato.', 'Fractures', 1),
('Un Red Gate puo spawnare Boss molto piu forti del normale. Non sottovalutarli.', 'Fractures', 1),
('Se una Frattura evoca un Baule del Tesoro, considerati fortunato: e un Jackpot!', 'Fractures', 1),
('I Bauli Dimensionali possono contenere Buoni DR (Monete Drago).', 'Rewards', 1),
('Piu mostri uccidi nel mondo, piu alta e la probabilita che appaia una Frattura.', 'Mechanics', 1),
('Solo i veri Cacciatori sopravvivono ai Dungeon Break.', 'Events', 1),
('Il sistema Hunter premia la costanza, non solo la forza bruta.', 'General', 1),
('Si narra che alcuni Boss Elite nascondano segreti antichi...', 'Lore', 1),
('Il reset Giornaliero avviene ogni notte. Assicurati di aver massimizzato il punteggio.', 'Mechanics', 1),
('Guardati le spalle mentre combatti un Boss... un nemico potrebbe essere in agguato.', 'PvP', 1),
('Vuoi vedere il tuo nome in cima a tutti? Premi N e scala la Sala delle Leggende.', 'Leaderboard', 1),
-- Tips nuovi (15)
('Suggerimento: I boss danno piu punti Gloria delle creature normali!', 'Combat', 1),
('Suggerimento: Mantieni un login streak per bonus Gloria extra!', 'Streak', 1),
('Suggerimento: Completa le missioni quotidiane per massimizzare i punti!', 'Missions', 1),
('Suggerimento: Gli achievement nascosti si sbloccano con azioni speciali!', 'Achievements', 1),
('Suggerimento: Ogni rank ti da bonus permanenti a Gloria e Drop!', 'Ranks', 1),
('Suggerimento: Usa il tab What-If per pianificare la tua progressione!', 'Strategy', 1),
('Suggerimento: Evita di fallire le missioni per non ricevere penalita!', 'Penalties', 1),
('Suggerimento: I Metin distrutti contano per achievement speciali!', 'Achievements', 1),
('Suggerimento: Apri bauli per sbloccare achievement Treasure Hunter!', 'Achievements', 1),
('Suggerimento: Partecipa agli eventi per punti Gloria bonus!', 'Events', 1),
('Suggerimento: Il Rival Tracker ti mostra chi ti ha superato in classifica!', 'Leaderboard', 1),
('Suggerimento: Puoi filtrare gli achievement per categoria nel tab dedicato!', 'UI', 1),
('Suggerimento: Rank N e il massimo: +30% Gloria e +20% Drop!', 'Ranks', 1),
('Suggerimento: Login streak di 365 giorni ti rende una Leggenda!', 'Streak', 1),
('Suggerimento: Controlla le tue statistiche per vedere le fonti di Gloria!', 'Stats', 1);

INSERT INTO `hunter_quest_tips` VALUES (26, 'Il sistema Hunter premia la costanza, non solo la forza bruta.');
INSERT INTO `hunter_quest_tips` VALUES (27, 'Si narra che alcuni Boss Elite nascondano segreti antichi...');
INSERT INTO `hunter_quest_tips` VALUES (28, 'Il reset Giornaliero avviene ogni notte. Assicurati di aver massimizzato il punteggio.');
INSERT INTO `hunter_quest_tips` VALUES (29, 'Guardati le spalle mentre combatti un Boss... un nemico potrebbe essere in agguato.');
INSERT INTO `hunter_quest_tips` VALUES (30, 'Vuoi vedere il tuo nome in cima a tutti? Premi N e scala la Sala delle Leggende.');

-- ----------------------------
-- Table structure for hunter_ranks
-- ----------------------------
DROP TABLE IF EXISTS `hunter_ranks`;
CREATE TABLE `hunter_ranks`  (
  `rank_id` int NOT NULL AUTO_INCREMENT,
  `rank_code` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rank_name` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rank_title` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `min_points` int NULL DEFAULT 0,
  `max_points` int NULL DEFAULT 999999999,
  `color_hex` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT 'FF808080',
  `bonus_gloria` int NULL DEFAULT 0,
  `rank_order` int NULL DEFAULT 0,
  PRIMARY KEY (`rank_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hunter_ranks
-- ----------------------------
INSERT INTO `hunter_ranks` VALUES (1, 'E', 'E-Rank', 'Risvegliato', 0, 2000, 'FF808080', 0, 1);
INSERT INTO `hunter_ranks` VALUES (2, 'D', 'D-Rank', 'Apprendista', 2000, 10000, 'FF00AA00', 2, 2);
INSERT INTO `hunter_ranks` VALUES (3, 'C', 'C-Rank', 'Cacciatore', 10000, 50000, 'FF00CCFF', 5, 3);
INSERT INTO `hunter_ranks` VALUES (4, 'B', 'B-Rank', 'Veterano', 50000, 150000, 'FF0066FF', 8, 4);
INSERT INTO `hunter_ranks` VALUES (5, 'A', 'A-Rank', 'Maestro', 150000, 500000, 'FFAA00FF', 12, 5);
INSERT INTO `hunter_ranks` VALUES (6, 'S', 'S-Rank', 'Leggenda', 500000, 1500000, 'FFFF6600', 18, 6);
INSERT INTO `hunter_ranks` VALUES (7, 'N', 'NATIONAL', 'Monarca Nazionale', 1500000, 5000000, 'FFFF0000', 25, 7);
INSERT INTO `hunter_ranks` VALUES (8, '?', '???', 'Trascendente', 5000000, 999999999, 'FFFFFFFF', 35, 8);

-- ----------------------------
-- Table structure for hunter_scheduled_events
-- ----------------------------
DROP TABLE IF EXISTS `hunter_scheduled_events`;
CREATE TABLE `hunter_scheduled_events`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `event_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `event_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'first_rift, rift_hunt, super_metin, first_boss, boss_massacre, treasure_race, glory_rush, double_spawn, metin_frenzy, pvp_tournament, survival, team_hunt',
  `event_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `start_hour` tinyint NOT NULL DEFAULT 0,
  `start_minute` tinyint NOT NULL DEFAULT 0,
  `duration_minutes` smallint NOT NULL DEFAULT 30,
  `days_active` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1,2,3,4,5,6,7' COMMENT '1=Lun, 2=Mar, 3=Mer, 4=Gio, 5=Ven, 6=Sab, 7=Dom',
  `min_rank` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'E' COMMENT 'E, D, C, B, A, S, N',
  `reward_glory_base` int NOT NULL DEFAULT 50,
  `reward_glory_winner` int NOT NULL DEFAULT 200,
  `color_scheme` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'GOLD',
  `priority` tinyint NULL DEFAULT 5,
  `enabled` tinyint(1) NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_enabled`(`enabled` ASC) USING BTREE,
  INDEX `idx_start_hour`(`start_hour` ASC) USING BTREE,
  INDEX `idx_days_active`(`days_active` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 64 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Hunter System - Eventi Programmati 24h' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hunter_scheduled_events
-- ----------------------------
INSERT INTO `hunter_scheduled_events` VALUES (1, 'Alba del Cacciatore', 'glory_rush', 'Gloria x2 per ogni uccisione! Svegliati e guadagna!', 5, 0, 60, '1,2,3,4,5,6,7', 'E', 20, 100, 'GOLD', 5, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (2, 'Prima Frattura', 'first_rift', 'Chi trova PER PRIMO la Frattura dellAlba vince!', 6, 0, 30, '1,2,3,4,5,6,7', 'E', 50, 300, 'PURPLE', 6, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (3, 'Caccia ai Bauli Nascosti', 'treasure_race', 'Bauli speciali spawnano ovunque! Chi ne trova di piu?', 6, 30, 45, '1,2,3,4,5,6,7', 'E', 30, 200, 'GOLD', 5, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (4, 'Risveglio dei Boss', 'first_boss', 'Boss Mattutino spawna! Chi lo uccide PER PRIMO?', 7, 0, 30, '1,2,3,4,5,6,7', 'D', 60, 350, 'RED', 6, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (5, 'Metin dellAlba', 'metin_frenzy', 'Metin spawn x3! Distruggine il piu possibile!', 7, 30, 30, '1,2,3,4,5,6,7', 'E', 25, 150, 'ORANGE', 5, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (6, 'Caccia alla Frattura Blu', 'first_rift', 'Frattura Blu appare! Trovala PRIMA degli altri!', 8, 0, 20, '1,2,3,4,5,6,7', 'E', 40, 250, 'CYAN', 6, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (7, 'SuperMetin Mattutini', 'super_metin', 'SuperMetin rari spawnano! Chi ne distrugge di piu?', 8, 30, 45, '1,2,3,4,5,6,7', 'D', 70, 400, 'ORANGE', 7, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (8, 'Massacro Boss Mattina', 'boss_massacre', 'Boss ovunque! Uccidine il MASSIMO in 30 minuti!', 9, 0, 30, '1,2,3,4,5,6,7', 'D', 60, 350, 'RED', 7, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (9, 'Tesori del Mattino', 'treasure_race', 'Scrigni dorati nelle mappe D! Raccoglili tutti!', 9, 30, 30, '1,2,3,4,5,6,7', 'D', 35, 200, 'GOLD', 5, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (10, 'Doppio Spawn Boss', 'double_spawn', 'DOPPIO SPAWN BOSS per 45 minuti! Approfittane!', 10, 0, 45, '1,2,3,4,5,6,7', 'C', 80, 450, 'RED', 8, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (11, 'Sfida Fratture Multiple', 'rift_hunt', 'Quante fratture riesci a trovare in 30 min?', 10, 45, 30, '1,2,3,4,5,6,7', 'C', 90, 500, 'PURPLE', 7, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (12, 'Gloria Rush Mezzogiorno', 'glory_rush', 'GLORIA x2 per TUTTO! Farming intensivo!', 11, 30, 30, '1,2,3,4,5,6,7', 'E', 25, 120, 'GOLD', 6, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (13, 'Frattura del Mezzogiorno', 'first_rift', 'Frattura Dorata! Il PRIMO che la trova vince GROSSO!', 12, 0, 25, '1,2,3,4,5,6,7', 'C', 100, 600, 'GOLD', 8, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (14, 'Caccia al Boss Leggendario', 'first_boss', 'Boss Leggendario spawna! Chi lo abbatte PER PRIMO?', 12, 30, 30, '1,2,3,4,5,6,7', 'C', 120, 700, 'RED', 9, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (15, 'Frenesia SuperMetin', 'super_metin', 'INVASIONE SuperMetin! Distruggine piu che puoi!', 13, 0, 45, '1,2,3,4,5,6,7', 'C', 80, 450, 'ORANGE', 8, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (16, 'Corsa ai Bauli Epici', 'treasure_race', 'Bauli EPICI con loot raro! Chi ne trova di piu?', 13, 45, 30, '1,2,3,4,5,6,7', 'C', 50, 300, 'GOLD', 6, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (17, 'Massacro Pomeridiano', 'boss_massacre', 'BOSS x2 spawn! Massacrali TUTTI!', 14, 15, 45, '1,2,3,4,5,6,7', 'B', 100, 550, 'RED', 8, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (18, 'Torneo PvP Pomeriggio', 'pvp_tournament', 'Arena aperta! Combatti per la GLORIA!', 15, 0, 60, '1,2,3,4,5,6,7', 'C', 40, 800, 'RED', 9, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (19, 'Caccia Fratture Rosse', 'rift_hunt', 'Fratture Rosse ovunque! Chi ne trova di piu in 40 min?', 15, 30, 40, '1,2,3,4,5,6,7', 'B', 110, 600, 'PURPLE', 8, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (20, 'Doppio Boss Intensivo', 'double_spawn', 'TRIPLO SPAWN BOSS! Ora o mai piu!', 16, 15, 45, '1,2,3,4,5,6,7', 'B', 120, 650, 'RED', 9, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (21, 'SuperMetin Estremo', 'super_metin', 'SuperMetin RARI con drop speciale!', 17, 0, 30, '1,2,3,4,5,6,7', 'B', 90, 500, 'ORANGE', 8, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (22, 'Survival Challenge', 'survival', 'Sopravvivi 20 minuti senza morire! Bonus Gloria!', 17, 30, 25, '1,2,3,4,5,6,7', 'C', 60, 400, 'CYAN', 7, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (23, 'ORA DI PUNTA - Frattura Nera', 'first_rift', 'FRATTURA NERA! Chi la trova PER PRIMO? PREMIO ENORME!', 18, 0, 30, '1,2,3,4,5,6,7', 'B', 150, 1000, 'PURPLE', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (24, 'Gloria Rush Serale', 'glory_rush', 'GLORIA x3 per 45 minuti! FARMING MASSIMO!', 18, 30, 45, '1,2,3,4,5,6,7', 'D', 50, 200, 'GOLD', 8, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (25, 'MEGA Boss Hunt', 'first_boss', 'MEGA BOSS spawna alle 19:00! Chi lo uccide PRIMO?', 19, 0, 30, '1,2,3,4,5,6,7', 'A', 200, 1200, 'RED', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (26, 'Invasione SuperMetin', 'super_metin', 'INVASIONE TOTALE SuperMetin! Record da battere!', 19, 30, 45, '1,2,3,4,5,6,7', 'B', 100, 600, 'ORANGE', 9, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (27, 'Caccia Fratture Elite', 'rift_hunt', 'Fratture ELITE! Chi ne trova PIU di 5?', 20, 0, 40, '1,2,3,4,5,6,7', 'A', 150, 900, 'PURPLE', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (28, 'BOSS MASSACRE SERALE', 'boss_massacre', 'STERMINIO BOSS! Chi ne uccide di PIU in 30 min?', 20, 45, 30, '1,2,3,4,5,6,7', 'A', 180, 1000, 'RED', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (29, 'Arena Suprema', 'pvp_tournament', 'TORNEO PVP SERALE! Il vincitore prende TUTTO!', 21, 15, 45, '1,2,3,4,5,6,7', 'B', 80, 1500, 'RED', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (30, 'Caccia Notturna - Frattura Ombra', 'first_rift', 'Frattura dellOmbra appare SOLO di notte! Trovala!', 22, 0, 30, '1,2,3,4,5,6,7', 'A', 180, 1100, 'PURPLE', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (31, 'Boss Notturno Leggendario', 'first_boss', 'BOSS NOTTURNO! Appare solo a mezzanotte!', 22, 30, 30, '1,2,3,4,5,6,7', 'S', 250, 1500, 'RED', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (32, 'Tesori della Mezzanotte', 'treasure_race', 'Bauli LEGGENDARI solo per i nottambuli!', 23, 0, 45, '1,2,3,4,5,6,7', 'B', 100, 700, 'GOLD', 9, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (33, 'Mezzanotte - SuperMetin Rari', 'super_metin', 'SuperMetin RARISSIMI con drop unico!', 23, 45, 30, '1,2,3,4,5,6,7', 'A', 150, 900, 'ORANGE', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (34, 'Massacro di Mezzanotte', 'boss_massacre', 'BOSS SPAWN x3! Chi ne uccide di piu?', 0, 15, 45, '1,2,3,4,5,6,7', 'S', 200, 1200, 'RED', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (35, 'Frattura del Giudizio', 'first_rift', 'Frattura FINALE della notte! Premio MASSIMO!', 1, 0, 30, '1,2,3,4,5,6,7', 'A', 200, 1300, 'PURPLE', 10, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (36, 'Gloria Notturna x4', 'glory_rush', 'GLORIA x4! Solo per chi resta sveglio!', 1, 30, 60, '1,2,3,4,5,6,7', 'C', 40, 250, 'GOLD', 8, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (37, 'Silenzio della Notte', 'survival', 'Sopravvivi 30 min senza morire! Premio speciale!', 2, 30, 35, '1,2,3,4,5,6,7', 'B', 80, 500, 'CYAN', 7, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (38, 'Metin Fantasma', 'super_metin', 'Metin FANTASMA rarissimi! Solo ora!', 3, 0, 45, '1,2,3,4,5,6,7', 'C', 60, 400, 'ORANGE', 7, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (39, 'Bauli dellOscurita', 'treasure_race', 'Bauli nascosti nelloscurita! Trovane il massimo!', 3, 45, 30, '1,2,3,4,5,6,7', 'D', 40, 300, 'GOLD', 6, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (40, 'Boss Prima dellAlba', 'first_boss', 'Ultimo Boss prima dellalba! Chi lo uccide?', 4, 15, 30, '1,2,3,4,5,6,7', 'C', 70, 450, 'RED', 7, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (41, 'Doppio Spawn Finale', 'double_spawn', 'Ultimo doppio spawn della notte!', 4, 45, 30, '1,2,3,4,5,6,7', 'D', 50, 350, 'RED', 6, 1, '2025-12-24 16:44:17');
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
INSERT INTO `hunter_scheduled_events` VALUES (58, 'Lunedi Fratture', 'rift_hunt', 'LUNEDI = Giorno delle Fratture! Spawn x2!', 19, 0, 60, '1', 'C', 100, 700, 'PURPLE', 9, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (59, 'Martedi Boss Day', 'boss_massacre', 'MARTEDI = Boss Day! Spawn aumentato!', 19, 0, 60, '2', 'C', 100, 700, 'RED', 9, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (60, 'Mercoledi Arena', 'pvp_tournament', 'MERCOLEDI = Arena Day! Premi x1.5!', 20, 0, 60, '3', 'D', 60, 1000, 'RED', 9, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (61, 'Giovedi Treasure Day', 'treasure_race', 'GIOVEDI = Treasure Day! Bauli ovunque!', 19, 0, 60, '4', 'D', 80, 600, 'GOLD', 9, 1, '2025-12-24 16:44:17');
INSERT INTO `hunter_scheduled_events` VALUES (62, 'Venerdi Gloria Rush', 'glory_rush', 'VENERDI = Gloria x3 dalle 18 alle 24!', 18, 0, 360, '5', 'E', 40, 200, 'GOLD', 9, 1, '2025-12-24 16:44:17');
-- REMOVED: Test event "asdasd" with lowercase 'blue' - all color_scheme now UPPERCASE

-- ----------------------------
-- Table structure for hunter_system_status
-- ----------------------------
DROP TABLE IF EXISTS `hunter_system_status`;
CREATE TABLE `hunter_system_status`  (
  `status_key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_update` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`status_key`) USING BTREE,
  UNIQUE INDEX `status_key`(`status_key` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hunter_system_status
-- ----------------------------
INSERT INTO `hunter_system_status` VALUES ('daily_reset', 0);
INSERT INTO `hunter_system_status` VALUES ('weekly_reset', 0);

-- ----------------------------
-- Table structure for hunter_texts
-- ----------------------------
DROP TABLE IF EXISTS `hunter_texts`;
CREATE TABLE `hunter_texts`  (
  `text_key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `text_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `category` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'general',
  `color_code` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `enabled` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`text_key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hunter_texts
-- ----------------------------
INSERT INTO `hunter_texts` VALUES ('achievements_unlocked', 'TRAGUARDI SBLOCCATI: {COUNT}', 'combat', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('ach_already_claimed', '[!] RICOMPENSA GIA\' RISCOSSA', 'achievement', 'FF0000', 1);
INSERT INTO `hunter_texts` VALUES ('ach_locked', '[!] BLOCCATO - Impegnati di piu\'', 'achievement', '888888', 1);
INSERT INTO `hunter_texts` VALUES ('ach_requirement', 'Requisito: {REQ} {TYPE}', 'achievement', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('ach_reward', 'Ricompensa: x{COUNT} {ITEM}', 'achievement', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('all_missions_bonus', 'BONUS COMPLETAMENTO x1.5!', 'general', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('all_missions_complete', '=== TUTTE LE MISSIONI COMPLETE ===', 'general', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('awaken1_line1', '========================================', 'awaken', '00FFFF', 1);
INSERT INTO `hunter_texts` VALUES ('awaken1_line2', '        ...ANALISI IN CORSO...', 'awaken', 'FFFFFF', 1);
INSERT INTO `hunter_texts` VALUES ('awaken1_line3', '========================================', 'awaken', '00FFFF', 1);
INSERT INTO `hunter_texts` VALUES ('awaken1_speak', '[SYSTEM] SCANSIONE BIOLOGICA IN CORSO...', 'awaken', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('awaken2_line1', '   >> COMPATIBILITA: 100% <<', 'awaken', '00FF00', 1);
INSERT INTO `hunter_texts` VALUES ('awaken2_line2', '   >> REQUISITI: SODDISFATTI <<', 'awaken', '00FF00', 1);
INSERT INTO `hunter_texts` VALUES ('awaken2_speak', '[SYSTEM] COMPATIBILITA CONFERMATA.', 'awaken', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('awaken3_line1', '   NOME: {NAME}', 'awaken', 'FFD700', 1);
INSERT INTO `hunter_texts` VALUES ('awaken3_line2', '   RANGO INIZIALE: [E-RANK]', 'awaken', '808080', 1);
INSERT INTO `hunter_texts` VALUES ('awaken3_speak', '[SYSTEM] NUOVO CACCIATORE REGISTRATO.', 'awaken', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('awaken4_line1', '========================================', 'awaken', 'FF0000', 1);
INSERT INTO `hunter_texts` VALUES ('awaken4_line2', '   !! RISVEGLIO COMPLETATO !!', 'awaken', 'FF6600', 1);
INSERT INTO `hunter_texts` VALUES ('awaken4_line3', '========================================', 'awaken', 'FF0000', 1);
INSERT INTO `hunter_texts` VALUES ('awaken4_speak', 'RISVEGLIO COMPLETATO. BENVENUTO, {NAME}.', 'awaken', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('awaken5_line1', '====================================================', 'awaken', 'FFD700', 1);
INSERT INTO `hunter_texts` VALUES ('awaken5_line10', '   [Y] - Apri Hunter Terminal', 'awaken', '00FF00', 1);
INSERT INTO `hunter_texts` VALUES ('awaken5_line2', '        *** HUNTER SYSTEM v36.0 ATTIVATO ***', 'awaken', '00FFFF', 1);
INSERT INTO `hunter_texts` VALUES ('awaken5_line3', '====================================================', 'awaken', 'FFD700', 1);
INSERT INTO `hunter_texts` VALUES ('awaken5_line4', '   Il Sistema ti ha scelto. Da questo momento:', 'awaken', 'FFFFFF', 1);
INSERT INTO `hunter_texts` VALUES ('awaken5_line5', '   >> Ogni nemico cadra sotto la tua lama', 'awaken', '00FF00', 1);
INSERT INTO `hunter_texts` VALUES ('awaken5_line6', '   >> Ogni vittoria sara registrata', 'awaken', '00FF00', 1);
INSERT INTO `hunter_texts` VALUES ('awaken5_line7', '   >> Ogni rank sara conquistato', 'awaken', '00FF00', 1);
INSERT INTO `hunter_texts` VALUES ('awaken5_line8', '   \'Inizia con un solo passo...\'', 'awaken', 'FFAA00', 1);
INSERT INTO `hunter_texts` VALUES ('awaken5_line9', '   \'Finisci come una Leggenda.\'', 'awaken', 'FFAA00', 1);
INSERT INTO `hunter_texts` VALUES ('boss_appeared', 'PERICOLO: {NAME} E APPARSO!', 'spawn', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('chest_bonus', 'Incredibile! Il baule conteneva anche {POINTS} Gloria!', 'combat', 'FFD700', 1);
INSERT INTO `hunter_texts` VALUES ('chest_detected', 'BAULE DEL TESORO RILEVATO!', 'spawn', 'GOLD', 1);
INSERT INTO `hunter_texts` VALUES ('chest_opened', 'BAULE APERTO: OTTENUTO {ITEM}', 'combat', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('classic_gate_ask', 'Vuoi spezzare il sigillo ed entrare?', 'classic', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('classic_gate_come_back', 'Torna quando sarai piu\' forte o con un Party da 4.', 'classic', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('classic_gate_intro', 'Questo portale emana un\'energia instabile.', 'classic', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('classic_gate_not_worthy', 'Non possiedi abbastanza Gloria per questo Gate.', 'classic', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('classic_gate_party', 'Tuttavia, il tuo Party (4+) puo forzarlo!', 'classic', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('classic_gate_party_can_force', 'Tuttavia, il tuo Party (4+) puo\' forzarlo!', 'classic', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('classic_gate_req', 'Gloria Richiesta: {REQ}', 'classic', 'FF0000', 1);
INSERT INTO `hunter_texts` VALUES ('classic_gate_required', 'Gloria Richiesta: |cffFF0000%d|r', 'classic', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('classic_gate_unworthy', 'Non possiedi abbastanza Gloria per questo Gate.', 'classic', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('classic_gate_weak', 'Torna quando sarai piu forte o con un Party da 4.', 'classic', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('classic_gate_worthy', 'Il tuo Rango Hunter e sufficiente.', 'classic', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('classic_opt_close', 'Chiudi', 'classic', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('classic_opt_force', 'Forza Gate (Raid)', 'classic', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('classic_opt_open', 'Apri Gate', 'classic', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('classic_raid_announce', '|cffFF0000[RAID]|r Il Party di {PLAYER} ha forzato un Gate {RANK}!', 'classic', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('emergency_bonus_item', 'BONUS: {ITEM} x{COUNT}', 'emergency', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('emergency_complete', 'MISSIONE COMPLETATA! +{POINTS} GLORIA', 'emergency', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('emergency_failed', 'MISSIONE FALLITA.', 'emergency', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('event_ended', 'EVENTO TERMINATO: {NAME}', 'event', 'AAAAAA', 1);
INSERT INTO `hunter_texts` VALUES ('event_joined', 'Hai partecipato a {NAME}! +{GLORY} Gloria base', 'event', '00FFFF', 1);
INSERT INTO `hunter_texts` VALUES ('event_started', 'EVENTO INIZIATO: {NAME}! Partecipa ora!', 'event', '00FF00', 1);
INSERT INTO `hunter_texts` VALUES ('event_starting_soon', 'EVENTO IN ARRIVO: {NAME} tra {MINUTES} minuti!', 'event', 'FFD700', 1);
INSERT INTO `hunter_texts` VALUES ('event_winner', 'VINCITORE EVENTO: {NAME} con {POINTS} punti!', 'event', 'FFD700', 1);
INSERT INTO `hunter_texts` VALUES ('fracture_detected', 'ATTENZIONE: FRATTURA {RANK} RILEVATA.', 'fracture', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('fracture_retreat', 'TI ALLONTANI DALLA FRATTURA.', 'fracture', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('fracture_sealed', 'FRATTURA SIGILLATA. +{POINTS} GLORIA', 'fracture', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('fracture_voice_no_BLACKWHITE', 'Non sei pronto per essere giudicato.', 'fracture_voice', 'BLACKWHITE', 1);
INSERT INTO `hunter_texts` VALUES ('fracture_voice_no_BLUE', 'Il cosmo ti rifiuta.', 'fracture_voice', 'BLUE', 1);
INSERT INTO `hunter_texts` VALUES ('fracture_voice_no_GOLD', 'L\'oro non brilla per i deboli.', 'fracture_voice', 'GOLD', 1);
INSERT INTO `hunter_texts` VALUES ('fracture_voice_no_GREEN', 'Non sei ancora degno della natura.', 'fracture_voice', 'GREEN', 1);
INSERT INTO `hunter_texts` VALUES ('fracture_voice_no_ORANGE', 'L\'oscurita ti divorerebbe.', 'fracture_voice', 'ORANGE', 1);
INSERT INTO `hunter_texts` VALUES ('fracture_voice_no_PURPLE', 'Il fato ti ha gia condannato.', 'fracture_voice', 'PURPLE', 1);
INSERT INTO `hunter_texts` VALUES ('fracture_voice_no_RED', 'Troppo debole. Saresti solo cibo.', 'fracture_voice', 'RED', 1);
INSERT INTO `hunter_texts` VALUES ('fracture_voice_ok_BLACKWHITE', 'Il Giudizio Finale ti attende.', 'fracture_voice', 'BLACKWHITE', 1);
INSERT INTO `hunter_texts` VALUES ('fracture_voice_ok_BLUE', 'Le stelle hanno scelto te.', 'fracture_voice', 'BLUE', 1);
INSERT INTO `hunter_texts` VALUES ('fracture_voice_ok_GOLD', 'La gloria attende chi osa.', 'fracture_voice', 'GOLD', 1);
INSERT INTO `hunter_texts` VALUES ('fracture_voice_ok_GREEN', 'L\'energia primordiale ti chiama...', 'fracture_voice', 'GREEN', 1);
INSERT INTO `hunter_texts` VALUES ('fracture_voice_ok_ORANGE', 'L\'abisso ti fissa... e tu fissi l\'abisso.', 'fracture_voice', 'ORANGE', 1);
INSERT INTO `hunter_texts` VALUES ('fracture_voice_ok_PURPLE', 'Il destino e scritto. Cambialo.', 'fracture_voice', 'PURPLE', 1);
INSERT INTO `hunter_texts` VALUES ('fracture_voice_ok_RED', 'Il sangue chiama sangue.', 'fracture_voice', 'RED', 1);
INSERT INTO `hunter_texts` VALUES ('gate_open', 'IL SIGILLO SI SPEZZA. PREPARATI.', 'fracture', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('gate_party_error', 'ERRORE: SERVONO 4 MEMBRI VICINI.', 'fracture', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('gate_party_force', 'IL PARTY FORZA IL SIGILLO!', 'fracture', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('gate_raid_global', '[RAID] Il Party di {NAME} ha forzato un Gate {RANK}!', 'fracture', 'FF0000', 1);
INSERT INTO `hunter_texts` VALUES ('item_received', 'OGGETTO RICEVUTO: {ITEM}', 'shop', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('lv30_line1a', '========================================', 'lv30', '0099FF', 1);
INSERT INTO `hunter_texts` VALUES ('lv30_line1b', '       [ S Y S T E M ]', 'lv30', '0099FF', 1);
INSERT INTO `hunter_texts` VALUES ('lv30_line1c', '========================================', 'lv30', '0099FF', 1);
INSERT INTO `hunter_texts` VALUES ('lv30_line2a', '   HUNTER SYSTEM ATTIVATO', 'lv30', 'FFD700', 1);
INSERT INTO `hunter_texts` VALUES ('lv30_line2b', '   Benvenuto, {NAME}', 'lv30', 'FFFFFF', 1);
INSERT INTO `hunter_texts` VALUES ('lv30_line3a', '   >> Da oggi lotterai per la Gloria!', 'lv30', '00FF00', 1);
INSERT INTO `hunter_texts` VALUES ('lv30_line3b', '   >> Fratture, Classifiche, Tesori...', 'lv30', '00FF00', 1);
INSERT INTO `hunter_texts` VALUES ('lv30_line3c', '   >> Ti attendono.', 'lv30', '00FF00', 1);
INSERT INTO `hunter_texts` VALUES ('lv30_line4a', '   A R I S E', 'lv30', 'FF6600', 1);
INSERT INTO `hunter_texts` VALUES ('lv30_line4b', '   Il tuo viaggio come Hunter inizia ORA.', 'lv30', 'FFFFFF', 1);
INSERT INTO `hunter_texts` VALUES ('lv30_line4c', '   [Y] - Apri Hunter Terminal', 'lv30', '00FFFF', 1);
INSERT INTO `hunter_texts` VALUES ('lv5_line1a', '========================================', 'lv5', 'FF0000', 1);
INSERT INTO `hunter_texts` VALUES ('lv5_line1b', '   ! ! ! ANOMALIA RILEVATA ! ! !', 'lv5', 'FF0000', 1);
INSERT INTO `hunter_texts` VALUES ('lv5_line1c', '========================================', 'lv5', 'FF0000', 1);
INSERT INTO `hunter_texts` VALUES ('lv5_line2a', '   Il Sistema ti ha notato...', 'lv5', '888888', 1);
INSERT INTO `hunter_texts` VALUES ('lv5_line2b', '   Qualcosa si sta risvegliando.', 'lv5', '888888', 1);
INSERT INTO `hunter_texts` VALUES ('lv5_line3a', '   Raggiungi il livello 30...', 'lv5', 'FFD700', 1);
INSERT INTO `hunter_texts` VALUES ('lv5_line3b', '   ...e scoprirai la verita.', 'lv5', 'FFD700', 1);
INSERT INTO `hunter_texts` VALUES ('mission_all_complete', 'TUTTE LE MISSIONI COMPLETE! BONUS x1.5!', 'mission', 'FFD700', 1);
INSERT INTO `hunter_texts` VALUES ('mission_assigned', '< NUOVE MISSIONI ASSEGNATE >', 'mission', '00FFFF', 1);
INSERT INTO `hunter_texts` VALUES ('mission_complete', '< MISSIONE COMPLETATA >', 'mission', '00FF00', 1);
INSERT INTO `hunter_texts` VALUES ('mission_daily_reset', 'Missioni giornaliere resettate!', 'mission', '00FFFF', 1);
INSERT INTO `hunter_texts` VALUES ('mission_failed', '< MISSIONE FALLITA >', 'mission', 'FF0000', 1);
INSERT INTO `hunter_texts` VALUES ('mission_penalty', 'Penalita: -%d Gloria', 'general', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('mission_penalty_applied', 'PENALITA: -{PENALTY} Gloria per missioni non completate', 'mission', 'FF4444', 1);
INSERT INTO `hunter_texts` VALUES ('mission_progress', 'Progresso Missione: %d / %d', 'mission', 'FFFFFF', 1);
INSERT INTO `hunter_texts` VALUES ('mission_reward', 'Ricompensa: +%d Gloria', 'general', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('mission_time_warning', 'ATTENZIONE: {MINUTES} minuti rimasti!', 'mission', 'FFA500', 1);
INSERT INTO `hunter_texts` VALUES ('mission_type_kill_boss', 'Sconfiggi Boss', 'general', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('mission_type_kill_metin', 'Distruggi Metin', 'general', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('mission_type_kill_mob', 'Elimina Mostri', 'general', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('mission_type_seal_fracture', 'Sigilla Fratture', 'general', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('mission_type_speedkill', 'Uccisione Veloce', 'general', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('overtake_congrats', 'CONGRATULAZIONI! SEI NELLA TOP 10 {CATEGORY}!', 'overtake', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('overtake_new_king', '[NUOVO RE] {NAME} ha preso il comando della Classifica {CATEGORY}!', 'overtake', 'FFD700', 1);
INSERT INTO `hunter_texts` VALUES ('overtake_record', '[RECORD] Nuovo Punteggio: {POINTS}!', 'overtake', '00FF00', 1);
INSERT INTO `hunter_texts` VALUES ('overtake_top10', '[TOP 10] {NAME} e entrato nella Top 10 {CATEGORY}!', 'overtake', '00FFFF', 1);
INSERT INTO `hunter_texts` VALUES ('pending_daily_pos', '[DAILY RANK] Posizione: {POS}', 'pending', '00FFFF', 1);
INSERT INTO `hunter_texts` VALUES ('pending_none', 'Nessun premio in attesa al momento.', 'pending', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('pending_rewards', 'RICOMPENSE IN ATTESA. CONTROLLA IL TERMINALE.', 'pending', 'FFD700', 1);
INSERT INTO `hunter_texts` VALUES ('pending_scala', 'Scala la classifica per ottenere gloria!', 'pending', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('pending_weekly_pos', '[WEEKLY RANK] Posizione: {POS}', 'pending', 'FFD700', 1);
INSERT INTO `hunter_texts` VALUES ('rank_refreshed', '[HUNTER] Rank aggiornato: {RANK} ({POINTS} Gloria)', 'system', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('rank_up_global', '[RANK UP] {NAME} e salito al rango [{RANK}-RANK]!', 'rank', 'FFD700', 1);
INSERT INTO `hunter_texts` VALUES ('rank_up_msg', 'RANK UP! Sei ora un {RANK}-RANK Hunter!', 'rank', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('reset_daily', '|cffFFD700[HUNTER SYSTEM]|r Classifica Giornaliera Resettata! La corsa al potere ricomincia.', 'reset', 'FFD700', 1);
INSERT INTO `hunter_texts` VALUES ('reset_weekly', '|cffFF6600[HUNTER SYSTEM]|r Classifica Settimanale Resettata! I premi sono stati distribuiti.', 'reset', 'FF6600', 1);
INSERT INTO `hunter_texts` VALUES ('reward_claimed', '|cffFFD700[HUNTER]|r {PLAYER} ha riscosso il premio Top Classifica {TYPE}!', 'reward', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('reward_claimed_daily', '{NAME} ha riscosso il premio Top Classifica Giornaliera!', 'reward', 'FFD700', 1);
INSERT INTO `hunter_texts` VALUES ('reward_claimed_weekly', '{NAME} ha riscosso il premio Top Classifica Settimanale!', 'reward', 'FFD700', 1);
INSERT INTO `hunter_texts` VALUES ('reward_type_daily', 'Giornaliera', 'reward', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('reward_type_weekly', 'Settimanale', 'reward', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('shop_ask', 'Vuoi acquistare questo oggetto?', 'shop', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('shop_error', 'ERRORE: CREDITI INSUFFICIENTI.', 'shop', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('shop_error_funds', 'ERRORE: CREDITI INSUFFICIENTI.', 'shop', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('shop_opt_cancel', 'Annulla', 'shop', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('shop_opt_confirm', 'Conferma Acquisto', 'shop', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('shop_success', 'TRANSAZIONE COMPLETATA. -{POINTS} CREDITI', 'shop', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('shop_title', 'MERCANTE HUNTER', 'shop', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('spawn_alert_line1', '[HUNTER ALERT] Il Cacciatore {NAME} ha spezzato il sigillo!', 'spawn', 'FF4444', 1);
INSERT INTO `hunter_texts` VALUES ('spawn_alert_line2', 'Un {MOBNAME} ({RANK}) e apparso a ({X}, {Y})!', 'spawn', 'FF0000', 1);
INSERT INTO `hunter_texts` VALUES ('spawn_alert_location', 'Un |cffFF0000{NAME}|r ({RANK}) e\' apparso a ({X}, {Y})!', 'spawn', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('spawn_alert_seal_broken', '|cffFF4444[HUNTER ALERT]|r Il Cacciatore |cffFFD700{PLAYER}|r ha spezzato il sigillo!', 'spawn', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('spawn_boss_appeared', 'PERICOLO: {NAME} E\' APPARSO!', 'spawn', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('spawn_chest_detected', 'BAULE DEL TESORO RILEVATO!', 'spawn', 'GOLD', 1);
INSERT INTO `hunter_texts` VALUES ('target_eliminated', 'BERSAGLIO ELIMINATO: {NAME} | +{POINTS} GLORIA', 'combat', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('welcome_A_border', '====================================================', 'welcome', 'AA00FF', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_A_line1', '   !! ALLERTA !! Maestro A-Rank online !!', 'welcome', 'CC66FF', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_A_line2', '   Il Sistema si inchina al tuo potere.', 'welcome', 'CC66FF', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_A_line3', '   Sei tra i piu forti di questo mondo.', 'welcome', 'CC66FF', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_A_quote', '   \'Quando un Maestro cammina, il mondo trema.\'', 'welcome', 'AA00FF', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_A_stats', '   >> Status: MAESTRO | Autorizzazione: MASSIMA <<', 'welcome', 'AA00FF', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_A_title', '         *** [A-RANK] MAESTRO ***', 'welcome', 'AA00FF', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_B_border', '====================================================', 'welcome', '0066FF', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_B_line1', '   ATTENZIONE: Veterano B-Rank rilevato.', 'welcome', '4488FF', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_B_line2', '   Pochi raggiungono questo livello.', 'welcome', '4488FF', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_B_line3', '   Il Sistema onora il tuo cammino.', 'welcome', '4488FF', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_B_quote', '   \'I deboli temono il buio. I forti lo dominano.\'', 'welcome', '0066FF', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_B_stats', '   >> Status: ELITE | Autorizzazione: ALTA <<', 'welcome', '0066FF', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_B_title', '          ** [B-RANK] VETERANO **', 'welcome', '0066FF', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_C_border', '====================================================', 'welcome', '00FFFF', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_C_line1', '   Benvenuto, Cacciatore Esperto.', 'welcome', '44FFFF', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_C_line2', '   Le tue gesta risuonano nei registri.', 'welcome', '44FFFF', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_C_line3', '   Il Sistema ti riconosce come guerriero.', 'welcome', '44FFFF', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_C_quote', '   \'La forza non e tutto. La volonta lo e.\'', 'welcome', '00FFFF', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_C_stats', '   >> Status: ESPERTO | Missioni: DISPONIBILI <<', 'welcome', '00FFFF', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_C_title', '           * [C-RANK] CACCIATORE *', 'welcome', '00FFFF', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_D_border', '====================================================', 'welcome', '00FF00', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_D_line1', '   Il Sistema rileva la tua crescita.', 'welcome', '44FF44', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_D_line2', '   Non sei piu un semplice risvegliato.', 'welcome', '44FF44', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_D_line3', '   Continua cosi, Cacciatore.', 'welcome', '44FF44', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_D_quote', '   \'Solo chi persevera raggiunge la vetta.\'', 'welcome', '00FF00', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_D_stats', '   >> Status: CRESCITA | Potenziale: ELEVATO <<', 'welcome', '00FF00', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_D_title', '              [D-RANK] APPRENDISTA', 'welcome', '00FF00', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_E_border', '====================================================', 'welcome', '808080', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_E_line1', '   Bentornato nel Sistema, Cacciatore.', 'welcome', 'AAAAAA', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_E_line2', '   La strada e lunga, ma ogni viaggio', 'welcome', 'AAAAAA', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_E_line3', '   inizia con un singolo passo.', 'welcome', 'AAAAAA', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_E_quote', '   \'Il debole di oggi... il forte di domani.\'', 'welcome', '808080', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_E_stats', '   >> Status: ATTIVO | Minacce: IN ATTESA <<', 'welcome', '808080', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_E_title', '              [E-RANK] RISVEGLIATO', 'welcome', '808080', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_N_border', '====================================================', 'welcome', 'FF0000', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_N_line1', '   !!! ALLARME MASSIMO !!! MONARCA ONLINE !!!', 'welcome', 'FF4444', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_N_line2', '   Il Sistema stesso si piega davanti a te.', 'welcome', 'FF4444', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_N_line3', '   Tu sei oltre ogni classificazione.', 'welcome', 'FF4444', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_N_quote', '   \'Io sono il Sistema. Il Sistema sono io.\'', 'welcome', 'FF0000', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_N_stats', '   >> Status: MONARCA | Potere: ASSOLUTO <<', 'welcome', 'FF0000', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_N_title', '     ***** [NATIONAL] MONARCA *****', 'welcome', 'FF0000', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_S_border', '====================================================', 'welcome', 'FF6600', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_S_line1', '   !! EMERGENZA !! S-RANK RILEVATO !!', 'welcome', 'FFAA00', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_S_line2', '   Il Sistema trema davanti a te.', 'welcome', 'FFAA00', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_S_line3', '   Una Leggenda cammina tra i mortali.', 'welcome', 'FFAA00', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_S_quote', '   \'Le leggende non muoiono. Diventano eterne.\'', 'welcome', 'FF6600', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_S_stats', '   >> Status: LEGGENDA | Potere: INCOMMENSURABILE <<', 'welcome', 'FF6600', 1);
INSERT INTO `hunter_texts` VALUES ('welcome_S_title', '        **** [S-RANK] LEGGENDA ****', 'welcome', 'FF6600', 1);
INSERT INTO `hunter_texts` VALUES ('whatif_need_party', 'ERRORE: SERVONO 4 MEMBRI VICINI.', 'whatif', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('whatif_opt1_force', '>> FORZA [Party 4+]', 'whatif', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('whatif_opt1_ok', '>> ATTRAVERSA IL PORTALE', 'whatif', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('whatif_opt2_seal', '|| SIGILLA [+{POINTS} Gloria]', 'whatif', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('whatif_opt3_retreat', '<< INDIETREGGIA', 'whatif', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('whatif_party_force', 'IL PARTY FORZA IL SIGILLO!', 'whatif', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('whatif_retreat', 'TI ALLONTANI DALLA FRATTURA.', 'whatif', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('whatif_sealed', 'FRATTURA SIGILLATA. +{POINTS} GLORIA', 'whatif', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('whatif_seal_break', 'IL SIGILLO SI SPEZZA. PREPARATI.', 'whatif', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('winners_daily_header', '[HUNTER SYSTEM] * VINCITORI CLASSIFICA GIORNALIERA *', 'winners', '00FFFF', 1);
INSERT INTO `hunter_texts` VALUES ('winners_medal_1', '[1]', 'winners', 'FFD700', 1);
INSERT INTO `hunter_texts` VALUES ('winners_medal_2', '[2]', 'winners', 'C0C0C0', 1);
INSERT INTO `hunter_texts` VALUES ('winners_medal_3', '[3]', 'winners', 'CD7F32', 1);
INSERT INTO `hunter_texts` VALUES ('winners_score', '{NAME} - {POINTS} Gloria', 'winners', 'FFFFFF', 1);
INSERT INTO `hunter_texts` VALUES ('winners_separator', '======================================', 'winners', 'FFD700', 1);
INSERT INTO `hunter_texts` VALUES ('winners_separator_weekly', '======================================', 'winners', 'FF6600', 1);
INSERT INTO `hunter_texts` VALUES ('winners_sep_daily', '|cffFFD700======================================|r', 'winners', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('winners_sep_weekly', '|cffFF6600======================================|r', 'winners', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('winners_title_daily', '|cffFFD700[HUNTER SYSTEM]|r |cff00FFFF* VINCITORI CLASSIFICA GIORNALIERA *|r', 'winners', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('winners_title_weekly', '|cffFF6600[HUNTER SYSTEM]|r |cffFFD700** VINCITORI CLASSIFICA SETTIMANALE **|r', 'winners', NULL, 1);
INSERT INTO `hunter_texts` VALUES ('winners_weekly_header', '[HUNTER SYSTEM] ** VINCITORI CLASSIFICA SETTIMANALE **', 'winners', 'FFD700', 1);

-- ----------------------------
-- View structure for v_missions_by_rank
-- ----------------------------
DROP VIEW IF EXISTS `v_missions_by_rank`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_missions_by_rank` AS select `srv1_hunabku`.`hunter_mission_definitions`.`id` AS `id`,`srv1_hunabku`.`hunter_mission_definitions`.`mission_name` AS `mission_name`,`srv1_hunabku`.`hunter_mission_definitions`.`mission_desc` AS `mission_desc`,`srv1_hunabku`.`hunter_mission_definitions`.`mission_type` AS `mission_type`,`srv1_hunabku`.`hunter_mission_definitions`.`min_rank` AS `min_rank`,`srv1_hunabku`.`hunter_mission_definitions`.`target_vnum` AS `target_vnum`,`srv1_hunabku`.`hunter_mission_definitions`.`target_count` AS `target_count`,`srv1_hunabku`.`hunter_mission_definitions`.`time_limit_sec` AS `time_limit_sec`,`srv1_hunabku`.`hunter_mission_definitions`.`reward_glory` AS `reward_glory`,`srv1_hunabku`.`hunter_mission_definitions`.`penalty_glory` AS `penalty_glory`,`srv1_hunabku`.`hunter_mission_definitions`.`difficulty` AS `difficulty`,`srv1_hunabku`.`hunter_mission_definitions`.`weight` AS `weight` from `hunter_mission_definitions` where `srv1_hunabku`.`hunter_mission_definitions`.`enabled` = 1 order by `srv1_hunabku`.`hunter_mission_definitions`.`min_rank`,`srv1_hunabku`.`hunter_mission_definitions`.`difficulty`,`srv1_hunabku`.`hunter_mission_definitions`.`id`;

-- ----------------------------
-- View structure for v_today_events
-- ----------------------------
DROP VIEW IF EXISTS `v_today_events`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_today_events` AS select `hunter_scheduled_events`.`id` AS `id`,`hunter_scheduled_events`.`event_name` AS `event_name`,`hunter_scheduled_events`.`event_type` AS `event_type`,`hunter_scheduled_events`.`event_desc` AS `event_desc`,`hunter_scheduled_events`.`start_hour` AS `start_hour`,`hunter_scheduled_events`.`start_minute` AS `start_minute`,`hunter_scheduled_events`.`duration_minutes` AS `duration_minutes`,`hunter_scheduled_events`.`min_rank` AS `min_rank`,`hunter_scheduled_events`.`reward_glory_base` AS `reward_glory_base`,`hunter_scheduled_events`.`reward_glory_winner` AS `reward_glory_winner`,`hunter_scheduled_events`.`color_scheme` AS `color_scheme`,`hunter_scheduled_events`.`priority` AS `priority`,concat(lpad(`hunter_scheduled_events`.`start_hour`,2,'0'),':',lpad(`hunter_scheduled_events`.`start_minute`,2,'0')) AS `start_time` from `hunter_scheduled_events` where `hunter_scheduled_events`.`enabled` = 1 and find_in_set(dayofweek(curdate()),`hunter_scheduled_events`.`days_active`) > 0 order by `hunter_scheduled_events`.`start_hour`,`hunter_scheduled_events`.`start_minute`;

-- ----------------------------
-- Procedure structure for sp_apply_daily_penalties
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_apply_daily_penalties`;
delimiter ;;
CREATE PROCEDURE `sp_apply_daily_penalties`()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_player_id INT;
    DECLARE v_total_penalty INT;
    
    DECLARE cur CURSOR FOR 
        SELECT player_id, SUM(penalty_glory) as total_penalty
        FROM hunter_player_missions
        WHERE assigned_date = DATE_SUB(CURDATE(), INTERVAL 1 DAY)
          AND status = 'active'
        GROUP BY player_id;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO v_player_id, v_total_penalty;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Applica penalità
        UPDATE hunter_quest_ranking 
        SET total_points = GREATEST(0, total_points - v_total_penalty)
        WHERE player_id = v_player_id;
        
        -- Segna missioni come fallite
        UPDATE hunter_player_missions 
        SET status = 'failed'
        WHERE player_id = v_player_id 
          AND assigned_date = DATE_SUB(CURDATE(), INTERVAL 1 DAY)
          AND status = 'active';
    END LOOP;
    
    CLOSE cur;
    
    SELECT 'Penalties applied' AS result;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_assign_daily_missions
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_assign_daily_missions`;
delimiter ;;
CREATE PROCEDURE `sp_assign_daily_missions`(IN p_player_id INT,
    IN p_player_rank VARCHAR(2),
    IN p_player_name VARCHAR(50))
BEGIN
    DECLARE v_slot INT DEFAULT 1;
    DECLARE v_mission_id INT;
    DECLARE v_target_count INT;
    DECLARE v_reward INT;
    DECLARE v_penalty INT;
    DECLARE v_existing INT DEFAULT 0;
    
    SELECT COUNT(*) INTO v_existing 
    FROM hunter_player_missions 
    WHERE player_id = p_player_id AND assigned_date = CURDATE();
    
    IF v_existing >= 3 THEN
        SELECT v_existing AS missions_assigned;
    ELSE
        SET v_slot = v_existing + 1;
        
        WHILE v_slot <= 3 DO
            SELECT mission_id, target_count, gloria_reward, gloria_penalty 
            INTO v_mission_id, v_target_count, v_reward, v_penalty
            FROM hunter_mission_definitions 
            WHERE FIELD(min_rank, 'E','D','C','B','A','S','N') <= FIELD(p_player_rank, 'E','D','C','B','A','S','N')
              AND enabled = 1
              AND mission_id NOT IN (
                  SELECT mission_def_id FROM hunter_player_missions 
                  WHERE player_id = p_player_id AND assigned_date = CURDATE()
              )
            ORDER BY RAND() 
            LIMIT 1;
            
            IF v_mission_id IS NOT NULL THEN
                INSERT INTO hunter_player_missions 
                    (player_id, mission_slot, mission_def_id, assigned_date, target_count, reward_glory, penalty_glory, status)
                VALUES 
                    (p_player_id, v_slot, v_mission_id, CURDATE(), v_target_count, v_reward, v_penalty, 'active');
            END IF;
            
            SET v_slot = v_slot + 1;
            SET v_mission_id = NULL;
        END WHILE;
        
        SELECT COUNT(*) AS missions_assigned 
        FROM hunter_player_missions 
        WHERE player_id = p_player_id AND assigned_date = CURDATE();
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Event structure for evt_daily_mission_reset
-- ----------------------------
DROP EVENT IF EXISTS `evt_daily_mission_reset`;
delimiter ;;
CREATE EVENT `evt_daily_mission_reset`
ON SCHEDULE
EVERY '1' DAY STARTS '2025-12-24 00:05:00'
DO BEGIN
    -- Applica penalita per missioni non completate
    CALL sp_apply_daily_penalties();
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;

-- =====================================================================
-- TABELLE AGGIUNTIVE DA HUNTER_SYSTEM_COMPLETE_OVERHAUL
-- =====================================================================

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
DROP TABLE IF EXISTS `hunter_ui_config`;
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
-- 2. TABELLA: hunter_penalty_config
-- Configurazione sistema penalit\u00e0
-- =====================================================================
DROP TABLE IF EXISTS `hunter_penalty_config`;
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
DROP TABLE IF EXISTS `hunter_streak_milestones`;
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
-- 13. TABELLA: hunter_ui_rank_colors
-- Colori UI per ogni rank (100% configurabile)
-- =====================================================================
DROP TABLE IF EXISTS `hunter_ui_rank_colors`;
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
-- 20. SECURITY: AUDIT LOG TABLE
-- =====================================================================
DROP TABLE IF EXISTS `hunter_security_log`;
CREATE TABLE IF NOT EXISTS `hunter_security_log` (
  `log_id` BIGINT AUTO_INCREMENT PRIMARY KEY,
  `player_id` INT NOT NULL,
  `action_type` VARCHAR(50) NOT NULL,
  `action_data` TEXT,
  `ip_address` VARCHAR(45) DEFAULT NULL,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_player (player_id),
  INDEX idx_action (action_type),
  INDEX idx_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================================
-- 21. SECURITY: ADD claimed_at COLUMN FOR RACE CONDITION FIX
-- =====================================================================
ALTER TABLE `hunter_quest_player_achievements`
ADD COLUMN IF NOT EXISTS `claimed_at` DATETIME NULL DEFAULT NULL;

-- =====================================================================
-- FINE SCHEMA SQL
-- =====================================================================
-- Per applicare questo schema:
-- 1. Importa in Navicat o esegui da MySQL CLI
-- 2. Ricarica le quest con /reload q
-- 3. Usa /hunter_reload per ricaricare la config in-game
-- =====================================================================

-- =====================================================================
-- TABELLA CRITICA: hunter_quest_player_achievements
-- Traccia gli achievement sbloccati e riscossi dai player
-- =====================================================================
DROP TABLE IF EXISTS `hunter_quest_player_achievements`;
CREATE TABLE `hunter_quest_player_achievements` (
  `player_id` INT NOT NULL,
  `achievement_id` INT NOT NULL,
  `unlocked_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `claimed_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`player_id`, `achievement_id`),
  INDEX idx_player (player_id),
  INDEX idx_achievement (achievement_id),
  INDEX idx_unlocked (unlocked_at),
  INDEX idx_claimed (claimed_at),
  FOREIGN KEY (`achievement_id`) REFERENCES `hunter_quest_achievements_config`(`achievement_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================================
-- 26. TABELLA: hunter_gloria_sources_tracking
-- Traccia sorgenti Gloria per statistiche avanzate
-- =====================================================================
DROP TABLE IF EXISTS `hunter_gloria_sources_tracking`;
CREATE TABLE `hunter_gloria_sources_tracking` (
  `player_id` INT NOT NULL,
  `source_type` VARCHAR(50) NOT NULL,
  `total_gloria` BIGINT NOT NULL DEFAULT 0,
  `count_events` INT NOT NULL DEFAULT 0,
  `last_update` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`player_id`, `source_type`),
  INDEX idx_player (player_id),
  INDEX idx_source (source_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================================
-- FINE DATABASE HUNTER SYSTEM
-- =====================================================================

SET FOREIGN_KEY_CHECKS = 1;

-- =====================================================================
-- ISTRUZIONI PER L'USO:
-- =====================================================================
-- 1. Importa questo file in Navicat o da MySQL CLI
-- 2. Ricarica le quest: /reload q
-- 3. Ricarica config in-game: /hunter_reload
-- 4. Testa con: /htest_* (vari comandi di test disponibili)
-- =====================================================================
