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

 Date: 27/01/2026 21:54:45
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for hunter_achievements_claimed
-- ----------------------------
DROP TABLE IF EXISTS `hunter_achievements_claimed`;
CREATE TABLE `hunter_achievements_claimed`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `player_id` int NOT NULL,
  `achievement_id` int NOT NULL,
  `claimed_at` datetime NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_player_achievement`(`player_id` ASC, `achievement_id` ASC) USING BTREE,
  INDEX `idx_player`(`player_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hunter_achievements_claimed
-- ----------------------------

-- ----------------------------
-- Table structure for hunter_chest_loot
-- ----------------------------
DROP TABLE IF EXISTS `hunter_chest_loot`;
CREATE TABLE `hunter_chest_loot`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `chest_vnum` int NOT NULL COMMENT 'VNUM baule (63000-63007) o 0=tutti',
  `min_rank_tier` int NOT NULL DEFAULT 1 COMMENT 'Rank minimo baule (1=E, 7=N)',
  `loot_type` enum('GLORY','ITEM') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'ITEM',
  `item_vnum` int NULL DEFAULT 0 COMMENT 'VNUM item (se ITEM)',
  `item_quantity` int NULL DEFAULT 1,
  `glory_min` int NULL DEFAULT 0 COMMENT 'Gloria minima (se GLORY)',
  `glory_max` int NULL DEFAULT 0 COMMENT 'Gloria massima (se GLORY)',
  `drop_chance` int NOT NULL DEFAULT 5 COMMENT '% probabilita (1-100)',
  `name` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT 'Jackpot',
  `is_jackpot` tinyint(1) NULL DEFAULT 1 COMMENT '1=mostra effetto jackpot',
  `enabled` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_chest_vnum`(`chest_vnum` ASC) USING BTREE,
  INDEX `idx_rank_tier`(`min_rank_tier` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hunter_chest_loot
-- ----------------------------
INSERT INTO `hunter_chest_loot` VALUES (1, 0, 1, 'GLORY', 0, 0, 86, 259, 15, 'Jackpot Gloria Minore', 1, 1);
INSERT INTO `hunter_chest_loot` VALUES (2, 0, 3, 'GLORY', 0, 0, 172, 518, 10, 'Jackpot Gloria', 1, 1);
INSERT INTO `hunter_chest_loot` VALUES (3, 0, 5, 'GLORY', 0, 0, 345, 864, 8, 'Jackpot Gloria Maggiore', 1, 1);
INSERT INTO `hunter_chest_loot` VALUES (4, 0, 7, 'GLORY', 0, 0, 691, 1728, 5, 'MEGA JACKPOT GLORIA', 1, 1);
INSERT INTO `hunter_chest_loot` VALUES (5, 0, 2, 'ITEM', 50160, 1, 0, 0, 8, 'Scanner di Fratture', 1, 1);
INSERT INTO `hunter_chest_loot` VALUES (6, 0, 3, 'ITEM', 50162, 1, 0, 0, 6, 'Focus del Cacciatore', 1, 1);
INSERT INTO `hunter_chest_loot` VALUES (7, 0, 4, 'ITEM', 50163, 1, 0, 0, 4, 'Chiave Dimensionale', 1, 1);
INSERT INTO `hunter_chest_loot` VALUES (8, 0, 4, 'ITEM', 50167, 1, 0, 0, 5, 'Calibratore', 1, 1);
INSERT INTO `hunter_chest_loot` VALUES (9, 0, 5, 'ITEM', 50161, 1, 0, 0, 3, 'Stabilizzatore di Rango', 1, 1);
INSERT INTO `hunter_chest_loot` VALUES (10, 0, 5, 'ITEM', 50165, 1, 0, 0, 4, 'Segnale Emergenza', 1, 1);
INSERT INTO `hunter_chest_loot` VALUES (11, 0, 6, 'ITEM', 50164, 1, 0, 0, 2, 'Sigillo di Conquista', 1, 1);
INSERT INTO `hunter_chest_loot` VALUES (12, 0, 6, 'ITEM', 50166, 1, 0, 0, 2, 'Risonatore di Gruppo', 1, 1);
INSERT INTO `hunter_chest_loot` VALUES (13, 63006, 7, 'ITEM', 50168, 1, 0, 0, 1, 'Frammento di Monarca', 1, 1);
INSERT INTO `hunter_chest_loot` VALUES (14, 0, 1, 'ITEM', 80030, 2, 0, 0, 20, 'Buono 100 Gloria x2', 0, 1);
INSERT INTO `hunter_chest_loot` VALUES (15, 0, 3, 'ITEM', 80031, 1, 0, 0, 12, 'Buono 500 Gloria', 0, 1);
INSERT INTO `hunter_chest_loot` VALUES (16, 0, 5, 'ITEM', 80032, 1, 0, 0, 8, 'Buono 1000 Gloria', 1, 1);

-- ----------------------------
-- Table structure for hunter_chest_rewards
-- ----------------------------
DROP TABLE IF EXISTS `hunter_chest_rewards`;
CREATE TABLE `hunter_chest_rewards`  (
  `vnum` int NOT NULL COMMENT 'VNUM del baule (63000-63007)',
  `name` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'Baule',
  `rank_tier` int NOT NULL DEFAULT 1 COMMENT '1=E, 2=D, 3=C, 4=B, 5=A, 6=S, 7=N',
  `glory_min` int NOT NULL DEFAULT 20 COMMENT 'Gloria minima',
  `glory_max` int NOT NULL DEFAULT 50 COMMENT 'Gloria massima',
  `item_vnum` int NULL DEFAULT 0 COMMENT 'Item bonus (0=nessuno)',
  `item_quantity` int NULL DEFAULT 1,
  `item_chance` int NULL DEFAULT 0 COMMENT '% probabilita item (0-100)',
  `color_code` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT 'GREEN',
  `enabled` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`vnum`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hunter_chest_rewards
-- ----------------------------
INSERT INTO `hunter_chest_rewards` VALUES (63000, 'Cassa E-Rank', 1, 126, 256, 80030, 1, 30, 'GREEN', 1);
INSERT INTO `hunter_chest_rewards` VALUES (63001, 'Cassa D-Rank', 2, 211, 426, 80030, 2, 25, 'BLUE', 1);
INSERT INTO `hunter_chest_rewards` VALUES (63002, 'Cassa C-Rank', 3, 227, 426, 80031, 1, 20, 'ORANGE', 1);
INSERT INTO `hunter_chest_rewards` VALUES (63003, 'Cassa B-Rank', 4, 120, 220, 80031, 2, 15, 'RED', 1);
INSERT INTO `hunter_chest_rewards` VALUES (63004, 'Cassa A-Rank', 5, 170, 300, 80032, 1, 12, 'PURPLE', 1);
INSERT INTO `hunter_chest_rewards` VALUES (63005, 'Cassa S-Rank', 6, 240, 420, 80032, 2, 10, 'GOLD', 1);
INSERT INTO `hunter_chest_rewards` VALUES (63006, 'Cassa N-Rank', 7, 350, 600, 80040, 1, 8, 'BLACKWHITE', 1);
INSERT INTO `hunter_chest_rewards` VALUES (63007, 'Cassa ???-Rank', 1, 856, 3426, 80040, 1, 50, 'PURPLE', 1);

-- ----------------------------
-- Table structure for hunter_event_participants
-- ----------------------------
DROP TABLE IF EXISTS `hunter_event_participants`;
CREATE TABLE `hunter_event_participants`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `event_id` int NOT NULL,
  `player_id` int NOT NULL,
  `player_name` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `joined_at` datetime NOT NULL DEFAULT current_timestamp,
  `unique_participation_key` varchar(50) GENERATED ALWAYS AS (
    CONCAT(event_id, '_', player_id, '_', DATE(joined_at))
  ) STORED,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_unique_participation`(`unique_participation_key`) USING BTREE,
  INDEX `idx_event_player`(`event_id` ASC, `player_id` ASC) USING BTREE,
  INDEX `idx_joined_at`(`joined_at` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hunter_event_participants
-- ----------------------------
INSERT INTO `hunter_event_participants` VALUES (1, 12, 4, '[GF]HunabKu', '2026-01-04 15:07:24');
INSERT INTO `hunter_event_participants` VALUES (2, 13, 1684, 'Pacifista', '2026-01-04 15:48:11');
INSERT INTO `hunter_event_participants` VALUES (3, 27, 4, '[GF]HunabKu', '2026-01-04 18:10:51');
INSERT INTO `hunter_event_participants` VALUES (4, 19, 4, '[GF]HunabKu', '2026-01-18 01:45:06');
INSERT INTO `hunter_event_participants` VALUES (7, 16, 4, '[GF]HunabKu', '2026-01-19 19:34:45');
INSERT INTO `hunter_event_participants` VALUES (9, 19, 4, '[GF]HunabKu', '2026-01-21 01:35:09');
INSERT INTO `hunter_event_participants` VALUES (10, 9, 4, '[GF]HunabKu', '2026-01-21 12:51:53');
INSERT INTO `hunter_event_participants` VALUES (12, 11, 4, '[GF]HunabKu', '2026-01-21 14:32:16');
INSERT INTO `hunter_event_participants` VALUES (13, 14, 3903, 'Gameplay', '2026-01-21 18:25:17');
INSERT INTO `hunter_event_participants` VALUES (14, 15, 3903, 'Gameplay', '2026-01-21 19:02:26');
INSERT INTO `hunter_event_participants` VALUES (15, 9, 4, '[GF]HunabKu', '2026-01-22 12:57:21');
INSERT INTO `hunter_event_participants` VALUES (16, 10, 4, '[GF]HunabKu', '2026-01-22 13:04:48');
INSERT INTO `hunter_event_participants` VALUES (17, 8, 3903, 'Gameplay', '2026-01-23 12:17:53');
INSERT INTO `hunter_event_participants` VALUES (18, 14, 4, '[GF]HunabKu', '2026-01-23 18:29:55');
INSERT INTO `hunter_event_participants` VALUES (19, 18, 4, '[GF]HunabKu', '2026-01-23 22:31:44');
INSERT INTO `hunter_event_participants` VALUES (20, 20, 4, '[GF]HunabKu', '2026-01-24 01:07:18');
INSERT INTO `hunter_event_participants` VALUES (21, 19, 4, '[GF]HunabKu', '2026-01-24 01:53:02');
INSERT INTO `hunter_event_participants` VALUES (22, 10, 4, '[GF]HunabKu', '2026-01-24 13:03:15');
INSERT INTO `hunter_event_participants` VALUES (23, 13, 4, '[GF]HunabKu', '2026-01-24 15:49:23');
INSERT INTO `hunter_event_participants` VALUES (24, 24, 4, '[GF]HunabKu', '2026-01-24 20:01:31');
INSERT INTO `hunter_event_participants` VALUES (25, 25, 4, '[GF]HunabKu', '2026-01-24 22:59:57');
INSERT INTO `hunter_event_participants` VALUES (26, 12, 4, '[GF]HunabKu', '2026-01-25 15:23:42');
INSERT INTO `hunter_event_participants` VALUES (27, 13, 4, '[GF]HunabKu', '2026-01-25 15:43:58');
INSERT INTO `hunter_event_participants` VALUES (28, 16, 4, '[GF]HunabKu', '2026-01-26 19:33:45');

-- ----------------------------
-- Table structure for hunter_event_winners
-- ----------------------------
DROP TABLE IF EXISTS `hunter_event_winners`;
CREATE TABLE `hunter_event_winners`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `event_id` int NOT NULL,
  `player_id` int NOT NULL,
  `player_name` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `winner_type` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `winner_data` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `won_at` datetime NOT NULL DEFAULT current_timestamp,
  `unique_winner_key` varchar(50) GENERATED ALWAYS AS (
    CASE
      WHEN winner_type IN ('first_rift', 'first_boss') THEN CONCAT(event_id, '_', winner_type, '_', DATE(won_at))
      ELSE NULL
    END
  ) STORED,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_unique_winner`(`unique_winner_key`) USING BTREE,
  INDEX `idx_event_won`(`event_id` ASC, `won_at` ASC) USING BTREE,
  INDEX `idx_player`(`player_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hunter_event_winners
-- ----------------------------
INSERT INTO `hunter_event_winners` VALUES (1, 12, 4, '[GF]HunabKu', 'first_rift', '900', '2026-01-04 15:07:24');
INSERT INTO `hunter_event_winners` VALUES (2, 27, 4, '[GF]HunabKu', 'first_rift', '2500', '2026-01-04 18:10:51');
INSERT INTO `hunter_event_winners` VALUES (3, 11, 4, '[GF]HunabKu', 'lottery', '120', '2026-01-19 15:00:06');
INSERT INTO `hunter_event_winners` VALUES (4, 14, 1, '[GF]Wesker', 'lottery', '200', '2026-01-19 18:50:01');
INSERT INTO `hunter_event_winners` VALUES (5, 16, 4, '[GF]HunabKu', 'first_boss', '1500', '2026-01-19 19:35:20');
INSERT INTO `hunter_event_winners` VALUES (6, 14, 2, '[GF]Aelarion', 'lottery', '200', '2026-01-20 18:50:31');
INSERT INTO `hunter_event_winners` VALUES (7, 9, 4, '[GF]HunabKu', 'first_boss', '700', '2026-01-21 12:52:52');
INSERT INTO `hunter_event_winners` VALUES (8, 10, 4, '[GF]HunabKu', 'lottery', '180', '2026-01-21 13:20:05');
INSERT INTO `hunter_event_winners` VALUES (9, 15, 3903, 'Gameplay', 'first_rift', '1200', '2026-01-21 19:02:26');
INSERT INTO `hunter_event_winners` VALUES (10, 9, 4, '[GF]HunabKu', 'first_boss', '700', '2026-01-22 12:58:24');
INSERT INTO `hunter_event_winners` VALUES (11, 8, 3903, 'Gameplay', 'first_rift', '600', '2026-01-23 12:17:53');
INSERT INTO `hunter_event_winners` VALUES (12, 18, 4, '[GF]HunabKu', 'first_boss', '1800', '2026-01-23 22:53:56');
INSERT INTO `hunter_event_winners` VALUES (13, 20, 4, '[GF]HunabKu', 'first_rift', '1300', '2026-01-24 01:11:45');
INSERT INTO `hunter_event_winners` VALUES (14, 24, 4, '[GF]HunabKu', 'first_boss', '3000', '2026-01-24 20:02:19');
INSERT INTO `hunter_event_winners` VALUES (15, 12, 4, '[GF]HunabKu', 'first_rift', '1089', '2026-01-25 15:23:42');

-- ----------------------------
-- Table structure for hunter_fracture_defense_config
-- ----------------------------
DROP TABLE IF EXISTS `hunter_fracture_defense_config`;
CREATE TABLE `hunter_fracture_defense_config`  (
  `config_key` varchar(64) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `config_value` int NOT NULL,
  `description` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`config_key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hunter_fracture_defense_config
-- ----------------------------
INSERT INTO `hunter_fracture_defense_config` VALUES ('check_distance', 20, 'Distanza massima dalla frattura (metri)');
INSERT INTO `hunter_fracture_defense_config` VALUES ('check_interval', 2, 'Ogni quanti secondi controllare la posizione');
INSERT INTO `hunter_fracture_defense_config` VALUES ('defense_duration', 60, 'Durata difesa in secondi (fallback generico)');
INSERT INTO `hunter_fracture_defense_config` VALUES ('defense_duration_A', 120, 'Durata difesa A-Rank (2 min)');
INSERT INTO `hunter_fracture_defense_config` VALUES ('defense_duration_B', 90, 'Durata difesa B-Rank (1.5 min)');
INSERT INTO `hunter_fracture_defense_config` VALUES ('defense_duration_C', 60, 'Durata difesa C-Rank (1 min)');
INSERT INTO `hunter_fracture_defense_config` VALUES ('defense_duration_D', 60, 'Durata difesa D-Rank (1 min)');
INSERT INTO `hunter_fracture_defense_config` VALUES ('defense_duration_E', 60, 'Durata difesa E-Rank (1 min)');
INSERT INTO `hunter_fracture_defense_config` VALUES ('defense_duration_N', 180, 'Durata difesa N-Rank (3 min)');
INSERT INTO `hunter_fracture_defense_config` VALUES ('defense_duration_S', 150, 'Durata difesa S-Rank (2.5 min)');
INSERT INTO `hunter_fracture_defense_config` VALUES ('party_all_required', 1, 'Se 1, tutti i membri party devono stare vicini');
INSERT INTO `hunter_fracture_defense_config` VALUES ('spawn_start_delay', 5, 'Secondi prima della prima ondata');

-- ----------------------------
-- Table structure for hunter_fracture_defense_waves
-- ----------------------------
DROP TABLE IF EXISTS `hunter_fracture_defense_waves`;
CREATE TABLE `hunter_fracture_defense_waves`  (
  `wave_id` int NOT NULL AUTO_INCREMENT,
  `rank_grade` varchar(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT 'E,D,C,B,A,S,N',
  `wave_number` int NOT NULL DEFAULT 1,
  `spawn_time` int NOT NULL DEFAULT 10,
  `mob_vnum` int NOT NULL,
  `mob_count` int NOT NULL DEFAULT 5,
  `spawn_radius` int NOT NULL DEFAULT 7,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`wave_id`) USING BTREE,
  INDEX `idx_rank_wave`(`rank_grade` ASC, `wave_number` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hunter_fracture_defense_waves
-- ----------------------------
INSERT INTO `hunter_fracture_defense_waves` VALUES (1, 'E', 1, 5, 7125, 2, 6, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (2, 'E', 2, 25, 7129, 2, 6, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (3, 'E', 3, 45, 7133, 2, 6, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (4, 'D', 1, 5, 7127, 2, 7, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (5, 'D', 2, 20, 7131, 2, 7, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (6, 'D', 3, 35, 7135, 2, 7, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (7, 'D', 4, 45, 7137, 2, 7, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (8, 'C', 1, 5, 7126, 2, 7, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (9, 'C', 2, 18, 7130, 2, 7, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (10, 'C', 3, 30, 7134, 2, 7, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (11, 'C', 4, 45, 7140, 2, 7, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (12, 'B', 1, 5, 7128, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (13, 'B', 2, 18, 7132, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (14, 'B', 3, 32, 7136, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (15, 'B', 4, 46, 7138, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (16, 'B', 5, 60, 7128, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (17, 'B', 6, 75, 7136, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (18, 'A', 1, 5, 7126, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (19, 'A', 2, 17, 7128, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (20, 'A', 3, 30, 7130, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (21, 'A', 4, 43, 7132, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (22, 'A', 5, 56, 7134, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (23, 'A', 6, 69, 7136, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (24, 'A', 7, 82, 7140, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (25, 'A', 8, 95, 7140, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (26, 'A', 9, 105, 7141, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (27, 'S', 1, 5, 7141, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (28, 'S', 2, 17, 7126, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (29, 'S', 3, 29, 7142, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (30, 'S', 4, 41, 7130, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (31, 'S', 5, 53, 7143, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (32, 'S', 6, 65, 7134, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (33, 'S', 7, 77, 7144, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (34, 'S', 8, 89, 7141, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (35, 'S', 9, 101, 7142, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (36, 'S', 10, 113, 7143, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (37, 'S', 11, 125, 7144, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (38, 'S', 12, 135, 7141, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (39, 'N', 1, 5, 7141, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (40, 'N', 2, 17, 7142, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (41, 'N', 3, 29, 7143, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (42, 'N', 4, 41, 7144, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (43, 'N', 5, 53, 7141, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (44, 'N', 6, 65, 7142, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (45, 'N', 7, 77, 7143, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (46, 'N', 8, 89, 7144, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (47, 'N', 9, 101, 7141, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (48, 'N', 10, 113, 7142, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (49, 'N', 11, 125, 7143, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (50, 'N', 12, 137, 7144, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (51, 'N', 13, 149, 7141, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (52, 'N', 14, 161, 7142, 2, 8, 1);
INSERT INTO `hunter_fracture_defense_waves` VALUES (53, 'N', 15, 165, 7143, 2, 8, 1);

-- ----------------------------
-- Table structure for hunter_gate_access
-- ----------------------------
DROP TABLE IF EXISTS `hunter_gate_access`;
CREATE TABLE `hunter_gate_access`  (
  `access_id` int NOT NULL AUTO_INCREMENT,
  `player_id` int NOT NULL,
  `player_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `gate_id` int NOT NULL DEFAULT 1,
  `status` enum('pending','used','expired') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'pending',
  `expires_at` datetime NOT NULL,
  `entered_at` datetime NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp,
  PRIMARY KEY (`access_id`) USING BTREE,
  UNIQUE INDEX `uk_player`(`player_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC, `expires_at` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Accessi Supremo per giocatori selezionati' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hunter_gate_access
-- ----------------------------
INSERT INTO `hunter_gate_access` VALUES (1, 4, '[GF]HunabKu', 1, 'used', '2026-01-25 16:17:07', '2026-01-25 15:16:29', '2026-01-24 15:18:27');

-- ----------------------------
-- Table structure for hunter_gate_history
-- ----------------------------
DROP TABLE IF EXISTS `hunter_gate_history`;
CREATE TABLE `hunter_gate_history`  (
  `history_id` int NOT NULL AUTO_INCREMENT,
  `player_id` int NOT NULL,
  `player_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `gate_id` int NULL DEFAULT 0,
  `gate_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `result` enum('rejection','summoned','killed') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'rejection',
  `gloria_change` int NULL DEFAULT 0,
  `created_at` datetime NULL DEFAULT current_timestamp,
  PRIMARY KEY (`history_id`) USING BTREE,
  INDEX `idx_player`(`player_id` ASC) USING BTREE,
  INDEX `idx_created`(`created_at` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Storico evocazioni Supremo' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hunter_gate_history
-- ----------------------------
INSERT INTO `hunter_gate_history` VALUES (1, 4, '[GF]HunabKu', 0, NULL, 'rejection', -500, '2026-01-24 15:17:48');
INSERT INTO `hunter_gate_history` VALUES (2, 4, '[GF]HunabKu', 0, NULL, 'rejection', -500, '2026-01-24 15:17:56');
INSERT INTO `hunter_gate_history` VALUES (3, 4, '[GF]HunabKu', 1, 'Cavaliere Oscuro', 'summoned', 0, '2026-01-24 15:22:04');
INSERT INTO `hunter_gate_history` VALUES (4, 4, '[GF]HunabKu', 0, NULL, 'rejection', -500, '2026-01-24 15:28:34');
INSERT INTO `hunter_gate_history` VALUES (5, 4, '[GF]HunabKu', 1, 'Cavaliere Oscuro', 'summoned', 0, '2026-01-24 15:29:05');
INSERT INTO `hunter_gate_history` VALUES (6, 4, '[GF]HunabKu', 1, 'Cavaliere Oscuro', 'summoned', 0, '2026-01-24 15:43:11');
INSERT INTO `hunter_gate_history` VALUES (7, 4, '[GF]HunabKu', 1, 'Cavaliere Oscuro', 'summoned', 0, '2026-01-24 15:53:42');
INSERT INTO `hunter_gate_history` VALUES (8, 4, '[GF]HunabKu', 63001, 'Supremo', '', -600, '2026-01-24 16:03:47');
INSERT INTO `hunter_gate_history` VALUES (9, 4, '[GF]HunabKu', 0, NULL, 'rejection', -500, '2026-01-24 16:12:07');
INSERT INTO `hunter_gate_history` VALUES (10, 4, '[GF]HunabKu', 0, NULL, 'rejection', -500, '2026-01-24 16:12:35');
INSERT INTO `hunter_gate_history` VALUES (11, 4, '[GF]HunabKu', 1, 'Cavaliere Oscuro', 'summoned', 0, '2026-01-24 16:17:45');
INSERT INTO `hunter_gate_history` VALUES (12, 4, '[GF]HunabKu', 63011, 'Cavaliere Oscuro', '', 750, '2026-01-24 16:18:03');
INSERT INTO `hunter_gate_history` VALUES (13, 4, '[GF]HunabKu', 63011, 'Cavaliere Oscuro', '', 750, '2026-01-24 16:18:53');
INSERT INTO `hunter_gate_history` VALUES (14, 4, '[GF]HunabKu', 1, 'Cavaliere Oscuro', 'summoned', 0, '2026-01-24 16:19:14');
INSERT INTO `hunter_gate_history` VALUES (15, 4, '[GF]HunabKu', 63011, 'Cavaliere Oscuro', '', -600, '2026-01-24 16:29:14');
INSERT INTO `hunter_gate_history` VALUES (16, 4, '[GF]HunabKu', 1, 'Cavaliere Oscuro', 'summoned', 0, '2026-01-24 16:44:03');
INSERT INTO `hunter_gate_history` VALUES (17, 4, '[GF]HunabKu', 63011, 'Cavaliere Oscuro', '', -600, '2026-01-24 16:44:46');
INSERT INTO `hunter_gate_history` VALUES (18, 4, '[GF]HunabKu', 1, 'Demone delle Ombre', 'summoned', 0, '2026-01-24 21:40:07');
INSERT INTO `hunter_gate_history` VALUES (19, 4, '[GF]HunabKu', 63012, 'Demone delle Ombre', '', 1000, '2026-01-24 21:42:41');
INSERT INTO `hunter_gate_history` VALUES (20, 4, '[GF]HunabKu', 0, NULL, 'rejection', -500, '2026-01-24 22:09:23');
INSERT INTO `hunter_gate_history` VALUES (21, 4, '[GF]HunabKu', 1, 'Demone delle Ombre', 'summoned', 0, '2026-01-24 22:10:14');
INSERT INTO `hunter_gate_history` VALUES (22, 4, '[GF]HunabKu', 0, 'Demone delle Ombre', '', 0, '2026-01-24 22:11:40');
INSERT INTO `hunter_gate_history` VALUES (23, 4, '[GF]HunabKu', 0, NULL, 'rejection', -500, '2026-01-25 14:12:35');
INSERT INTO `hunter_gate_history` VALUES (24, 4, '[GF]HunabKu', 1, 'Demone delle Ombre', 'summoned', 0, '2026-01-25 14:14:01');
INSERT INTO `hunter_gate_history` VALUES (25, 4, '[GF]HunabKu', 0, NULL, 'rejection', -500, '2026-01-25 14:17:00');
INSERT INTO `hunter_gate_history` VALUES (26, 4, '[GF]HunabKu', 63012, 'Demone delle Ombre', '', 1000, '2026-01-25 14:19:00');
INSERT INTO `hunter_gate_history` VALUES (27, 4, '[GF]HunabKu', 1, 'Demone delle Ombre', 'summoned', 0, '2026-01-25 15:16:29');
INSERT INTO `hunter_gate_history` VALUES (28, 4, '[GF]HunabKu', 63012, 'Demone delle Ombre', '', 1000, '2026-01-25 15:16:52');

-- ----------------------------
-- Table structure for hunter_item_names
-- ----------------------------
DROP TABLE IF EXISTS `hunter_item_names`;
CREATE TABLE `hunter_item_names`  (
  `vnum` int NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`vnum`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hunter_item_names
-- ----------------------------
INSERT INTO `hunter_item_names` VALUES (50160, 'Scanner di Fratture');
INSERT INTO `hunter_item_names` VALUES (50161, 'Stabilizzatore di Rango');
INSERT INTO `hunter_item_names` VALUES (50162, 'Focus del Cacciatore');
INSERT INTO `hunter_item_names` VALUES (50163, 'Chiave Dimensionale');
INSERT INTO `hunter_item_names` VALUES (50164, 'Sigillo di Conquista');
INSERT INTO `hunter_item_names` VALUES (50165, 'Segnale di Emergenza');
INSERT INTO `hunter_item_names` VALUES (50166, 'Risonatore di Gruppo');
INSERT INTO `hunter_item_names` VALUES (50167, 'Calibratore Fratture');
INSERT INTO `hunter_item_names` VALUES (50168, 'Frammento di Monarca');
INSERT INTO `hunter_item_names` VALUES (63000, 'Baule Rango E');
INSERT INTO `hunter_item_names` VALUES (63001, 'Baule Rango D');
INSERT INTO `hunter_item_names` VALUES (63002, 'Baule Rango C');
INSERT INTO `hunter_item_names` VALUES (63003, 'Baule Rango B');
INSERT INTO `hunter_item_names` VALUES (63004, 'Baule Rango A');
INSERT INTO `hunter_item_names` VALUES (63005, 'Baule Rango S');
INSERT INTO `hunter_item_names` VALUES (63006, 'Baule Rango ???');
INSERT INTO `hunter_item_names` VALUES (63007, 'Baule Speciale');
INSERT INTO `hunter_item_names` VALUES (80030, 'Buono 100 Gloria');
INSERT INTO `hunter_item_names` VALUES (80031, 'Buono 500 Gloria');
INSERT INTO `hunter_item_names` VALUES (80032, 'Buono 1000 Gloria');

-- ----------------------------
-- Table structure for hunter_login_messages
-- ----------------------------
DROP TABLE IF EXISTS `hunter_login_messages`;
CREATE TABLE `hunter_login_messages`  (
  `day_number` int NOT NULL,
  `message_text` varchar(300) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`day_number`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

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
  `mission_name` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `mission_type` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `target_vnum` int NULL DEFAULT 0,
  `target_count` int NOT NULL DEFAULT 10,
  `min_rank` varchar(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT 'E',
  `gloria_reward` int NOT NULL DEFAULT 100,
  `gloria_penalty` int NOT NULL DEFAULT 25,
  `time_limit_minutes` int NULL DEFAULT 1440,
  `enabled` tinyint(1) NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  PRIMARY KEY (`mission_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hunter_mission_definitions
-- ----------------------------
INSERT INTO `hunter_mission_definitions` VALUES (1, 'Obiettivo: Capitani Brutali', 'kill_boss', 591, 3, 'E', 252, 20, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (2, 'Epurazione: Capitano Brutali', 'kill_boss', 591, 5, 'E', 378, 30, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (3, 'Direttiva: Super Metin Lv.45', 'kill_metin', 63010, 2, 'E', 315, 25, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (4, 'Protocollo: Metin dell Oscurità', 'kill_metin', 8006, 5, 'E', 472, 40, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (5, 'Protocollo: Metin dell Invidia', 'kill_metin', 8007, 5, 'E', 472, 40, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (6, 'Sigillo: Frattura Primordiale', 'seal_fracture', 16060, 1, 'E', 378, 30, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (7, 'Sigillo: Frattura E-Rank (Ondata)', 'seal_fracture', 16060, 3, 'E', 950, 80, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (8, 'Recupero: Baule Rango E', 'open_chest', 63000, 3, 'E', 283, 20, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (9, 'Recupero: Bauli E-Rank (Massivo)', 'open_chest', 63000, 8, 'E', 791, 60, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (10, 'Caccia: Qualsiasi Bersaglio (Novizio)', 'kill_mob', 0, 300, 'E', 315, 20, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (11, 'Caccia: Eliminazione Rapida (E)', 'kill_mob', 0, 150, 'E', 188, 15, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (12, 'Demolizione: Rocce del Dolore', 'kill_metin', 8006, 8, 'E', 696, 50, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (13, 'Task: Supporto Hunter (Bauli)', 'open_chest', 63000, 5, 'E', 472, 30, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (14, 'Taglia: Capitani Villaggio 1', 'kill_boss', 591, 1, 'E', 157, 10, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (15, 'Obiettivo: Metin Invidia Elite', 'kill_metin', 8007, 10, 'E', 950, 70, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (16, 'Obiettivo: Capo Orco', 'kill_boss', 691, 1, 'D', 472, 40, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (17, 'Epurazione: Capi Orco (Valle)', 'kill_boss', 691, 3, 'D', 1268, 100, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (18, 'Taglia: Funglash', 'kill_boss', 4035, 1, 'D', 1108, 80, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (19, 'Taglia: Thaloren', 'kill_boss', 719, 1, 'D', 1268, 100, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (20, 'Direttiva: Super Metin Lv.60', 'kill_metin', 63011, 3, 'D', 633, 50, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (21, 'Direttiva: Super Metin Lv.75', 'kill_metin', 63012, 3, 'D', 791, 60, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (22, 'Protocollo: Metin dell Ombra', 'kill_metin', 8009, 6, 'D', 887, 70, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (23, 'Protocollo: Metin dell Anima', 'kill_metin', 8008, 6, 'D', 887, 70, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (24, 'Sigillo: Frattura Astrale', 'seal_fracture', 16061, 1, 'D', 633, 50, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (25, 'Sigillo: Frattura D-Rank (Ondata)', 'seal_fracture', 16061, 4, 'D', 1902, 150, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (26, 'Recupero: Baule Rango D', 'open_chest', 63001, 3, 'D', 570, 40, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (27, 'Recupero: Bauli D-Rank (Massivo)', 'open_chest', 63001, 7, 'D', 1426, 100, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (28, 'Caccia: Qualsiasi Bersaglio (Apprendista)', 'kill_mob', 0, 500, 'D', 791, 60, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (29, 'Task: Sterminio Orchi Elite', 'kill_mob', 636, 150, 'D', 696, 50, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (30, 'Obiettivo: Metin Anima Elite', 'kill_metin', 8008, 12, 'D', 1585, 120, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (31, 'Epurazione: Capi Valle Elite', 'kill_boss', 719, 3, 'D', 2853, 200, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (32, 'Taglia: Funghi Velenosi (Funglash)', 'kill_boss', 4035, 2, 'D', 1902, 150, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (33, 'Obiettivo: Nove Code', 'kill_boss', 1901, 1, 'C', 976, 100, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (34, 'Taglia: Yinlee', 'kill_boss', 2771, 1, 'C', 1220, 120, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (35, 'Taglia: Slubina', 'kill_boss', 768, 1, 'C', 1463, 150, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (36, 'Epurazione: Baronessa Ragno', 'kill_boss', 2092, 1, 'C', 1952, 200, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (37, 'Direttiva: Super Metin Lv.90', 'kill_metin', 63013, 3, 'C', 1096, 100, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (38, 'Protocollo: Metin del Diavolo', 'kill_metin', 8011, 6, 'C', 1096, 100, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (39, 'Protocollo: Metin della Morte', 'kill_metin', 8013, 6, 'C', 1096, 100, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (40, 'Sigillo: Frattura Abissale', 'seal_fracture', 16062, 1, 'C', 852, 90, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (41, 'Sigillo: Frattura C-Rank (Ondata)', 'seal_fracture', 16062, 5, 'C', 3660, 400, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (42, 'Recupero: Baule Rango C', 'open_chest', 63002, 3, 'C', 731, 70, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (43, 'Recupero: Bauli C-Rank (Massivo)', 'open_chest', 63002, 8, 'C', 2196, 250, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (44, 'Caccia: Qualsiasi Bersaglio (Cacciatore)', 'kill_mob', 0, 800, 'C', 1220, 120, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (45, 'Task: Sterminio Ragni Mortali', 'kill_mob', 2091, 300, 'C', 1220, 120, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (46, 'Epurazione: Nove Code Elite', 'kill_boss', 1901, 3, 'C', 2928, 300, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (47, 'Obiettivo: Metin Morte Elite', 'kill_metin', 8013, 12, 'C', 2440, 250, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (48, 'Taglia: Guardiani del Monte', 'kill_boss', 0, 10, 'C', 2440, 250, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (49, 'Missione: Tessitrice di Anime (Baronessa)', 'kill_boss', 2092, 2, 'C', 3906, 400, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (50, 'Obiettivo: Polifemo', 'kill_boss', 3191, 1, 'B', 1000, 250, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (51, 'Taglia: Arges (Ciclope)', 'kill_boss', 3190, 1, 'B', 800, 200, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (52, 'Epurazione: Alastor', 'kill_boss', 6790, 1, 'B', 1500, 400, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (53, 'Epurazione: Grimlor', 'kill_boss', 6831, 1, 'B', 1500, 400, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (54, 'Taglia: Branzhul', 'kill_boss', 986, 1, 'B', 1800, 450, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (55, 'Obiettivo: Wukong (Re Scimmia)', 'kill_boss', 9682, 1, 'B', 2000, 500, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (56, 'Obiettivo: Re Scorpione', 'kill_boss', 9694, 1, 'B', 2000, 500, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (57, 'Direttiva: Super Metin Lv.115', 'kill_metin', 63015, 3, 'B', 1200, 300, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (58, 'Protocollo: Metin della Vanità', 'kill_metin', 8053, 8, 'B', 1500, 400, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (59, 'Protocollo: Metin Ardente', 'kill_metin', 8052, 8, 'B', 1500, 400, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (60, 'Sigillo: Frattura Cremisi', 'seal_fracture', 16063, 1, 'B', 800, 200, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (61, 'Sigillo: Frattura B-Rank (Ondata)', 'seal_fracture', 16063, 5, 'B', 4000, 1000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (62, 'Recupero: Baule Rango B', 'open_chest', 63003, 3, 'B', 1000, 250, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (63, 'Recupero: Bauli B-Rank (Massivo)', 'open_chest', 63003, 10, 'B', 3500, 800, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (64, 'Caccia: Qualsiasi Bersaglio (Veterano)', 'kill_mob', 0, 1500, 'B', 2000, 500, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (65, 'Task: Sterminio Giganti Elite', 'kill_mob', 0, 1000, 'B', 2500, 600, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (66, 'Obiettivo: Metin Vanità Elite', 'kill_metin', 8053, 15, 'B', 3000, 700, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (67, 'Missione: Re dei Ciclopi (Polifemo)', 'kill_boss', 3191, 3, 'B', 3500, 900, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (68, 'Obiettivo: Ra (Dio Sole)', 'kill_boss', 8213, 1, 'A', 3000, 800, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (69, 'Obiettivo: Anubi', 'kill_boss', 8214, 1, 'A', 3000, 800, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (70, 'Taglia: Torgal', 'kill_boss', 989, 1, 'A', 4000, 1000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (71, 'Epurazione: Regina Giungla', 'kill_boss', 16103, 1, 'A', 5000, 1200, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (72, 'Epurazione: Signore Infernale', 'kill_boss', 29754, 1, 'A', 6000, 1500, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (73, 'Direttiva: Super Metin Lv.165', 'kill_metin', 63017, 3, 'A', 4500, 1000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (74, 'Protocollo: Metin del Faraone', 'kill_metin', 8210, 10, 'A', 4000, 1000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (75, 'Protocollo: Pietra Antica', 'kill_metin', 8207, 10, 'A', 4000, 1000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (76, 'Sigillo: Frattura Aurea', 'seal_fracture', 16064, 1, 'A', 1500, 400, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (77, 'Sigillo: Frattura A-Rank (Ondata)', 'seal_fracture', 16064, 5, 'A', 8000, 2000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (78, 'Recupero: Baule Rango A', 'open_chest', 63004, 5, 'A', 3500, 900, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (79, 'Recupero: Bauli A-Rank (Massivo)', 'open_chest', 63004, 12, 'A', 10000, 2500, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (80, 'Caccia: Qualsiasi Bersaglio (Maestro)', 'kill_mob', 0, 3000, 'A', 8000, 2000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (81, 'Task: Sterminio Sacerdoti Anubi', 'kill_mob', 0, 2000, 'A', 7000, 1800, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (82, 'Obiettivo: Metin Faraone Elite', 'kill_metin', 8210, 20, 'A', 10000, 2500, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (83, 'Taglia: I Sette Dei (Ra/Anubi)', 'kill_boss', 0, 7, 'A', 15000, 4000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (84, 'Obiettivo: Nerzakar', 'kill_boss', 4011, 1, 'S', 8000, 2000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (85, 'Obiettivo: Nozzera', 'kill_boss', 6830, 1, 'S', 10000, 2500, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (86, 'Direttiva: Super Metin Lv.200', 'kill_metin', 63018, 5, 'S', 12000, 3000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (87, 'Protocollo: Metin della Montagna', 'kill_metin', 6798, 12, 'S', 10000, 2500, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (88, 'Protocollo: Metin del Gelo', 'kill_metin', 8203, 12, 'S', 10000, 2500, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (89, 'Sigillo: Frattura Infausta', 'seal_fracture', 16065, 1, 'S', 3000, 800, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (90, 'Sigillo: Frattura S-Rank (Ondata)', 'seal_fracture', 16065, 5, 'S', 15000, 4000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (91, 'Recupero: Baule Rango S', 'open_chest', 63005, 5, 'S', 7000, 1800, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (92, 'Recupero: Bauli S-Rank (Massivo)', 'open_chest', 63005, 15, 'S', 25000, 6000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (93, 'Caccia: Qualsiasi Bersaglio (Leggenda)', 'kill_mob', 0, 5000, 'S', 20000, 5000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (94, 'Task: Sterminio Leggendario', 'kill_mob', 0, 10000, 'S', 45000, 12000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (95, 'Obiettivo: Nerzakar (Elite x3)', 'kill_boss', 4011, 3, 'S', 25000, 6000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (96, 'Taglia: Araldo di Nozzera', 'kill_boss', 6830, 3, 'S', 35000, 9000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (97, 'Obiettivo: Velzahar (Dio Finale)', 'kill_boss', 4385, 1, 'N', 30000, 8000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (98, 'Epurazione: Velzahar (Trittico)', 'kill_boss', 4385, 3, 'N', 100000, 30000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (99, 'Direttiva: Super Metin Lv.???', 'kill_metin', 63019, 10, 'N', 80000, 20000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (100, 'Protocollo: Sigillo del Monarca', 'seal_fracture', 16066, 5, 'N', 150000, 40000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (101, 'Recupero: Bauli N-Rank (Elite)', 'open_chest', 63006, 10, 'N', 100000, 25000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (102, 'Caccia: Monarca della Caccia (Mob)', 'kill_mob', 0, 20000, 'N', 200000, 50000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions` VALUES (103, 'Taglia: L Eredità del Monarca', 'open_chest', 63006, 20, 'N', 250000, 70000, 1440, 1, '2026-01-19 19:22:50');

-- ----------------------------
-- Table structure for hunter_mission_definitions_copy1
-- ----------------------------
DROP TABLE IF EXISTS `hunter_mission_definitions_copy1`;
CREATE TABLE `hunter_mission_definitions_copy1`  (
  `mission_id` int NOT NULL AUTO_INCREMENT,
  `mission_name` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `mission_type` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `target_vnum` int NULL DEFAULT 0,
  `target_count` int NOT NULL DEFAULT 10,
  `min_rank` varchar(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT 'E',
  `gloria_reward` int NOT NULL DEFAULT 100,
  `gloria_penalty` int NOT NULL DEFAULT 25,
  `time_limit_minutes` int NULL DEFAULT 1440,
  `enabled` tinyint(1) NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  PRIMARY KEY (`mission_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hunter_mission_definitions_copy1
-- ----------------------------
INSERT INTO `hunter_mission_definitions_copy1` VALUES (1, 'Obiettivo: Capitani Brutali', 'kill_boss', 591, 3, 'E', 80, 20, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (2, 'Epurazione: Capitano Brutali', 'kill_boss', 591, 5, 'E', 120, 30, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (3, 'Direttiva: Super Metin Lv.45', 'kill_metin', 63010, 2, 'E', 100, 25, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (4, 'Protocollo: Metin dell Oscurità', 'kill_metin', 8006, 5, 'E', 150, 40, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (5, 'Protocollo: Metin dell Invidia', 'kill_metin', 8007, 5, 'E', 150, 40, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (6, 'Sigillo: Frattura Primordiale', 'seal_fracture', 16060, 1, 'E', 120, 30, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (7, 'Sigillo: Frattura E-Rank (Ondata)', 'seal_fracture', 16060, 3, 'E', 300, 80, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (8, 'Recupero: Baule Rango E', 'open_chest', 63000, 3, 'E', 90, 20, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (9, 'Recupero: Bauli E-Rank (Massivo)', 'open_chest', 63000, 8, 'E', 250, 60, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (10, 'Caccia: Qualsiasi Bersaglio (Novizio)', 'kill_mob', 0, 300, 'E', 100, 20, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (11, 'Caccia: Eliminazione Rapida (E)', 'kill_mob', 0, 150, 'E', 60, 15, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (12, 'Demolizione: Rocce del Dolore', 'kill_metin', 8006, 8, 'E', 220, 50, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (13, 'Task: Supporto Hunter (Bauli)', 'open_chest', 63000, 5, 'E', 150, 30, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (14, 'Taglia: Capitani Villaggio 1', 'kill_boss', 591, 1, 'E', 50, 10, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (15, 'Obiettivo: Metin Invidia Elite', 'kill_metin', 8007, 10, 'E', 300, 70, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (16, 'Obiettivo: Capo Orco', 'kill_boss', 691, 1, 'D', 150, 40, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (17, 'Epurazione: Capi Orco (Valle)', 'kill_boss', 691, 3, 'D', 400, 100, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (18, 'Taglia: Funglash', 'kill_boss', 4035, 1, 'D', 350, 80, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (19, 'Taglia: Thaloren', 'kill_boss', 719, 1, 'D', 400, 100, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (20, 'Direttiva: Super Metin Lv.60', 'kill_metin', 63011, 3, 'D', 200, 50, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (21, 'Direttiva: Super Metin Lv.75', 'kill_metin', 63012, 3, 'D', 250, 60, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (22, 'Protocollo: Metin dell Ombra', 'kill_metin', 8009, 6, 'D', 280, 70, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (23, 'Protocollo: Metin dell Anima', 'kill_metin', 8008, 6, 'D', 280, 70, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (24, 'Sigillo: Frattura Astrale', 'seal_fracture', 16061, 1, 'D', 200, 50, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (25, 'Sigillo: Frattura D-Rank (Ondata)', 'seal_fracture', 16061, 4, 'D', 600, 150, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (26, 'Recupero: Baule Rango D', 'open_chest', 63001, 3, 'D', 180, 40, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (27, 'Recupero: Bauli D-Rank (Massivo)', 'open_chest', 63001, 7, 'D', 450, 100, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (28, 'Caccia: Qualsiasi Bersaglio (Apprendista)', 'kill_mob', 0, 500, 'D', 250, 60, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (29, 'Task: Sterminio Orchi Elite', 'kill_mob', 636, 150, 'D', 220, 50, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (30, 'Obiettivo: Metin Anima Elite', 'kill_metin', 8008, 12, 'D', 500, 120, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (31, 'Epurazione: Capi Valle Elite', 'kill_boss', 719, 3, 'D', 900, 200, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (32, 'Taglia: Funghi Velenosi (Funglash)', 'kill_boss', 4035, 2, 'D', 600, 150, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (33, 'Obiettivo: Nove Code', 'kill_boss', 1901, 1, 'C', 400, 100, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (34, 'Taglia: Yinlee', 'kill_boss', 2771, 1, 'C', 500, 120, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (35, 'Taglia: Slubina', 'kill_boss', 768, 1, 'C', 600, 150, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (36, 'Epurazione: Baronessa Ragno', 'kill_boss', 2092, 1, 'C', 800, 200, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (37, 'Direttiva: Super Metin Lv.90', 'kill_metin', 63013, 3, 'C', 450, 100, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (38, 'Protocollo: Metin del Diavolo', 'kill_metin', 8011, 6, 'C', 450, 100, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (39, 'Protocollo: Metin della Morte', 'kill_metin', 8013, 6, 'C', 450, 100, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (40, 'Sigillo: Frattura Abissale', 'seal_fracture', 16062, 1, 'C', 350, 90, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (41, 'Sigillo: Frattura C-Rank (Ondata)', 'seal_fracture', 16062, 5, 'C', 1500, 400, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (42, 'Recupero: Baule Rango C', 'open_chest', 63002, 3, 'C', 300, 70, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (43, 'Recupero: Bauli C-Rank (Massivo)', 'open_chest', 63002, 8, 'C', 900, 250, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (44, 'Caccia: Qualsiasi Bersaglio (Cacciatore)', 'kill_mob', 0, 800, 'C', 500, 120, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (45, 'Task: Sterminio Ragni Mortali', 'kill_mob', 2091, 300, 'C', 500, 120, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (46, 'Epurazione: Nove Code Elite', 'kill_boss', 1901, 3, 'C', 1200, 300, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (47, 'Obiettivo: Metin Morte Elite', 'kill_metin', 8013, 12, 'C', 1000, 250, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (48, 'Taglia: Guardiani del Monte', 'kill_boss', 0, 10, 'C', 1000, 250, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (49, 'Missione: Tessitrice di Anime (Baronessa)', 'kill_boss', 2092, 2, 'C', 1600, 400, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (50, 'Obiettivo: Polifemo', 'kill_boss', 3191, 1, 'B', 1000, 250, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (51, 'Taglia: Arges (Ciclope)', 'kill_boss', 3190, 1, 'B', 800, 200, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (52, 'Epurazione: Alastor', 'kill_boss', 6790, 1, 'B', 1500, 400, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (53, 'Epurazione: Grimlor', 'kill_boss', 6831, 1, 'B', 1500, 400, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (54, 'Taglia: Branzhul', 'kill_boss', 986, 1, 'B', 1800, 450, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (55, 'Obiettivo: Wukong (Re Scimmia)', 'kill_boss', 9682, 1, 'B', 2000, 500, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (56, 'Obiettivo: Re Scorpione', 'kill_boss', 9694, 1, 'B', 2000, 500, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (57, 'Direttiva: Super Metin Lv.115', 'kill_metin', 63015, 3, 'B', 1200, 300, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (58, 'Protocollo: Metin della Vanità', 'kill_metin', 8053, 8, 'B', 1500, 400, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (59, 'Protocollo: Metin Ardente', 'kill_metin', 8052, 8, 'B', 1500, 400, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (60, 'Sigillo: Frattura Cremisi', 'seal_fracture', 16063, 1, 'B', 800, 200, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (61, 'Sigillo: Frattura B-Rank (Ondata)', 'seal_fracture', 16063, 5, 'B', 4000, 1000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (62, 'Recupero: Baule Rango B', 'open_chest', 63003, 3, 'B', 1000, 250, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (63, 'Recupero: Bauli B-Rank (Massivo)', 'open_chest', 63003, 10, 'B', 3500, 800, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (64, 'Caccia: Qualsiasi Bersaglio (Veterano)', 'kill_mob', 0, 1500, 'B', 2000, 500, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (65, 'Task: Sterminio Giganti Elite', 'kill_mob', 0, 1000, 'B', 2500, 600, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (66, 'Obiettivo: Metin Vanità Elite', 'kill_metin', 8053, 15, 'B', 3000, 700, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (67, 'Missione: Re dei Ciclopi (Polifemo)', 'kill_boss', 3191, 3, 'B', 3500, 900, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (68, 'Obiettivo: Ra (Dio Sole)', 'kill_boss', 8213, 1, 'A', 3000, 800, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (69, 'Obiettivo: Anubi', 'kill_boss', 8214, 1, 'A', 3000, 800, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (70, 'Taglia: Torgal', 'kill_boss', 989, 1, 'A', 4000, 1000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (71, 'Epurazione: Regina Giungla', 'kill_boss', 16103, 1, 'A', 5000, 1200, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (72, 'Epurazione: Signore Infernale', 'kill_boss', 29754, 1, 'A', 6000, 1500, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (73, 'Direttiva: Super Metin Lv.165', 'kill_metin', 63017, 3, 'A', 4500, 1000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (74, 'Protocollo: Metin del Faraone', 'kill_metin', 8210, 10, 'A', 4000, 1000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (75, 'Protocollo: Pietra Antica', 'kill_metin', 8207, 10, 'A', 4000, 1000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (76, 'Sigillo: Frattura Aurea', 'seal_fracture', 16064, 1, 'A', 1500, 400, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (77, 'Sigillo: Frattura A-Rank (Ondata)', 'seal_fracture', 16064, 5, 'A', 8000, 2000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (78, 'Recupero: Baule Rango A', 'open_chest', 63004, 5, 'A', 3500, 900, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (79, 'Recupero: Bauli A-Rank (Massivo)', 'open_chest', 63004, 12, 'A', 10000, 2500, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (80, 'Caccia: Qualsiasi Bersaglio (Maestro)', 'kill_mob', 0, 3000, 'A', 8000, 2000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (81, 'Task: Sterminio Sacerdoti Anubi', 'kill_mob', 0, 2000, 'A', 7000, 1800, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (82, 'Obiettivo: Metin Faraone Elite', 'kill_metin', 8210, 20, 'A', 10000, 2500, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (83, 'Taglia: I Sette Dei (Ra/Anubi)', 'kill_boss', 0, 7, 'A', 15000, 4000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (84, 'Obiettivo: Nerzakar', 'kill_boss', 4011, 1, 'S', 8000, 2000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (85, 'Obiettivo: Nozzera', 'kill_boss', 6830, 1, 'S', 10000, 2500, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (86, 'Direttiva: Super Metin Lv.200', 'kill_metin', 63018, 5, 'S', 12000, 3000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (87, 'Protocollo: Metin della Montagna', 'kill_metin', 6798, 12, 'S', 10000, 2500, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (88, 'Protocollo: Metin del Gelo', 'kill_metin', 8203, 12, 'S', 10000, 2500, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (89, 'Sigillo: Frattura Infausta', 'seal_fracture', 16065, 1, 'S', 3000, 800, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (90, 'Sigillo: Frattura S-Rank (Ondata)', 'seal_fracture', 16065, 5, 'S', 15000, 4000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (91, 'Recupero: Baule Rango S', 'open_chest', 63005, 5, 'S', 7000, 1800, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (92, 'Recupero: Bauli S-Rank (Massivo)', 'open_chest', 63005, 15, 'S', 25000, 6000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (93, 'Caccia: Qualsiasi Bersaglio (Leggenda)', 'kill_mob', 0, 5000, 'S', 20000, 5000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (94, 'Task: Sterminio Leggendario', 'kill_mob', 0, 10000, 'S', 45000, 12000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (95, 'Obiettivo: Nerzakar (Elite x3)', 'kill_boss', 4011, 3, 'S', 25000, 6000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (96, 'Taglia: Araldo di Nozzera', 'kill_boss', 6830, 3, 'S', 35000, 9000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (97, 'Obiettivo: Velzahar (Dio Finale)', 'kill_boss', 4385, 1, 'N', 30000, 8000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (98, 'Epurazione: Velzahar (Trittico)', 'kill_boss', 4385, 3, 'N', 100000, 30000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (99, 'Direttiva: Super Metin Lv.???', 'kill_metin', 63019, 10, 'N', 80000, 20000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (100, 'Protocollo: Sigillo del Monarca', 'seal_fracture', 16066, 5, 'N', 150000, 40000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (101, 'Recupero: Bauli N-Rank (Elite)', 'open_chest', 63006, 10, 'N', 100000, 25000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (102, 'Caccia: Monarca della Caccia (Mob)', 'kill_mob', 0, 20000, 'N', 200000, 50000, 1440, 1, '2026-01-19 19:22:50');
INSERT INTO `hunter_mission_definitions_copy1` VALUES (103, 'Taglia: L Eredità del Monarca', 'open_chest', 63006, 20, 'N', 250000, 70000, 1440, 1, '2026-01-19 19:22:50');

-- ----------------------------
-- Table structure for hunter_player_missions
-- ----------------------------
DROP TABLE IF EXISTS `hunter_player_missions`;
CREATE TABLE `hunter_player_missions`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `player_id` int NOT NULL,
  `mission_slot` int NOT NULL DEFAULT 1,
  `mission_def_id` int NOT NULL,
  `assigned_date` date NOT NULL,
  `current_progress` int NULL DEFAULT 0,
  `target_count` int NOT NULL,
  `status` enum('active','completed','failed') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'active',
  `reward_glory` int NOT NULL DEFAULT 100,
  `penalty_glory` int NOT NULL DEFAULT 25,
  `completed_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_player_slot_day`(`player_id` ASC, `mission_slot` ASC, `assigned_date` ASC) USING BTREE,
  INDEX `idx_player_date`(`player_id` ASC, `assigned_date` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `mission_def_id`(`mission_def_id` ASC) USING BTREE,
  INDEX `idx_missions_player_date`(`player_id` ASC, `assigned_date` ASC) USING BTREE,
  CONSTRAINT `hunter_player_missions_ibfk_1` FOREIGN KEY (`mission_def_id`) REFERENCES `hunter_mission_definitions` (`mission_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 133 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hunter_player_missions
-- ----------------------------
INSERT INTO `hunter_player_missions` VALUES (85, 4, 1, 29, '2026-01-23', 0, 150, 'active', 220, 50, NULL);
INSERT INTO `hunter_player_missions` VALUES (86, 4, 2, 64, '2026-01-23', 131, 1500, 'active', 2000, 500, NULL);
INSERT INTO `hunter_player_missions` VALUES (87, 4, 3, 60, '2026-01-23', 1, 1, 'completed', 800, 200, '2026-01-23 18:43:06');
INSERT INTO `hunter_player_missions` VALUES (88, 2, 1, 25, '2026-01-23', 0, 4, 'active', 600, 150, NULL);
INSERT INTO `hunter_player_missions` VALUES (89, 2, 2, 28, '2026-01-23', 0, 500, 'active', 250, 60, NULL);
INSERT INTO `hunter_player_missions` VALUES (90, 2, 3, 45, '2026-01-23', 0, 300, 'active', 500, 120, NULL);
INSERT INTO `hunter_player_missions` VALUES (91, 4, 1, 42, '2026-01-24', 2, 3, 'active', 300, 70, NULL);
INSERT INTO `hunter_player_missions` VALUES (92, 4, 2, 23, '2026-01-24', 0, 6, 'active', 280, 70, NULL);
INSERT INTO `hunter_player_missions` VALUES (93, 4, 3, 34, '2026-01-24', 0, 1, 'active', 500, 120, NULL);
INSERT INTO `hunter_player_missions` VALUES (94, 1684, 1, 2, '2026-01-24', 0, 5, 'active', 120, 30, NULL);
INSERT INTO `hunter_player_missions` VALUES (95, 1684, 2, 1, '2026-01-24', 0, 3, 'active', 80, 20, NULL);
INSERT INTO `hunter_player_missions` VALUES (96, 1684, 3, 7, '2026-01-24', 1, 3, 'active', 300, 80, NULL);
INSERT INTO `hunter_player_missions` VALUES (97, 2, 1, 35, '2026-01-24', 0, 1, 'active', 600, 150, NULL);
INSERT INTO `hunter_player_missions` VALUES (98, 2, 2, 29, '2026-01-24', 0, 150, 'active', 220, 50, NULL);
INSERT INTO `hunter_player_missions` VALUES (99, 2, 3, 11, '2026-01-24', 0, 150, 'active', 60, 15, NULL);
INSERT INTO `hunter_player_missions` VALUES (100, 3906, 1, 8, '2026-01-24', 0, 3, 'active', 90, 20, NULL);
INSERT INTO `hunter_player_missions` VALUES (101, 3906, 2, 10, '2026-01-24', 300, 300, 'completed', 100, 20, '2026-01-24 18:49:50');
INSERT INTO `hunter_player_missions` VALUES (102, 3906, 3, 7, '2026-01-24', 1, 3, 'active', 300, 80, NULL);
INSERT INTO `hunter_player_missions` VALUES (103, 994, 1, 11, '2026-01-24', 0, 150, 'active', 60, 15, NULL);
INSERT INTO `hunter_player_missions` VALUES (104, 994, 2, 8, '2026-01-24', 0, 3, 'active', 90, 20, NULL);
INSERT INTO `hunter_player_missions` VALUES (105, 994, 3, 3, '2026-01-24', 0, 2, 'active', 100, 25, NULL);
INSERT INTO `hunter_player_missions` VALUES (106, 4, 1, 11, '2026-01-25', 150, 150, 'completed', 188, 15, '2026-01-25 14:26:54');
INSERT INTO `hunter_player_missions` VALUES (107, 4, 2, 34, '2026-01-25', 1, 1, 'completed', 1220, 120, '2026-01-25 15:29:43');
INSERT INTO `hunter_player_missions` VALUES (108, 4, 3, 49, '2026-01-25', 0, 2, 'active', 3906, 400, NULL);
INSERT INTO `hunter_player_missions` VALUES (109, 3903, 1, 23, '2026-01-25', 0, 6, 'active', 887, 70, NULL);
INSERT INTO `hunter_player_missions` VALUES (110, 3903, 2, 27, '2026-01-25', 0, 7, 'active', 1426, 100, NULL);
INSERT INTO `hunter_player_missions` VALUES (111, 3903, 3, 13, '2026-01-25', 0, 5, 'active', 472, 30, NULL);
INSERT INTO `hunter_player_missions` VALUES (112, 1, 1, 20, '2026-01-25', 0, 3, 'active', 633, 50, NULL);
INSERT INTO `hunter_player_missions` VALUES (113, 1, 2, 11, '2026-01-25', 0, 150, 'active', 188, 15, NULL);
INSERT INTO `hunter_player_missions` VALUES (114, 1, 3, 14, '2026-01-25', 0, 1, 'active', 157, 10, NULL);
INSERT INTO `hunter_player_missions` VALUES (115, 351, 1, 7, '2026-01-25', 0, 3, 'active', 950, 80, NULL);
INSERT INTO `hunter_player_missions` VALUES (116, 351, 2, 12, '2026-01-25', 0, 8, 'active', 696, 50, NULL);
INSERT INTO `hunter_player_missions` VALUES (117, 351, 3, 10, '2026-01-25', 0, 300, 'active', 315, 20, NULL);
INSERT INTO `hunter_player_missions` VALUES (118, 3756, 1, 3, '2026-01-25', 0, 2, 'active', 315, 25, NULL);
INSERT INTO `hunter_player_missions` VALUES (119, 3756, 2, 2, '2026-01-25', 0, 5, 'active', 378, 30, NULL);
INSERT INTO `hunter_player_missions` VALUES (120, 3756, 3, 11, '2026-01-25', 0, 150, 'active', 188, 15, NULL);
INSERT INTO `hunter_player_missions` VALUES (121, 1684, 1, 8, '2026-01-25', 0, 3, 'active', 283, 20, NULL);
INSERT INTO `hunter_player_missions` VALUES (122, 1684, 2, 13, '2026-01-25', 0, 5, 'active', 472, 30, NULL);
INSERT INTO `hunter_player_missions` VALUES (123, 1684, 3, 15, '2026-01-25', 0, 10, 'active', 950, 70, NULL);
INSERT INTO `hunter_player_missions` VALUES (124, 4, 1, 56, '2026-01-26', 0, 1, 'active', 2000, 500, NULL);
INSERT INTO `hunter_player_missions` VALUES (125, 4, 2, 59, '2026-01-26', 0, 8, 'active', 1500, 400, NULL);
INSERT INTO `hunter_player_missions` VALUES (126, 4, 3, 37, '2026-01-26', 0, 3, 'active', 1096, 100, NULL);
INSERT INTO `hunter_player_missions` VALUES (127, 1, 1, 27, '2026-01-27', 0, 7, 'active', 1426, 100, NULL);
INSERT INTO `hunter_player_missions` VALUES (128, 1, 2, 20, '2026-01-27', 0, 3, 'active', 633, 50, NULL);
INSERT INTO `hunter_player_missions` VALUES (129, 1, 3, 26, '2026-01-27', 0, 3, 'active', 570, 40, NULL);
INSERT INTO `hunter_player_missions` VALUES (130, 2, 1, 32, '2026-01-27', 0, 2, 'active', 1902, 150, NULL);
INSERT INTO `hunter_player_missions` VALUES (131, 2, 2, 46, '2026-01-27', 0, 3, 'active', 2928, 300, NULL);
INSERT INTO `hunter_player_missions` VALUES (132, 2, 3, 25, '2026-01-27', 0, 4, 'active', 1902, 150, NULL);

-- ----------------------------
-- Table structure for hunter_player_stats_snapshot
-- ----------------------------
DROP TABLE IF EXISTS `hunter_player_stats_snapshot`;
CREATE TABLE `hunter_player_stats_snapshot`  (
  `snapshot_id` bigint NOT NULL AUTO_INCREMENT,
  `player_id` int NOT NULL,
  `player_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `snapshot_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'HOURLY, DAILY, SESSION',
  `kills_count` int NOT NULL DEFAULT 0,
  `glory_earned` int NOT NULL DEFAULT 0,
  `chests_opened` int NOT NULL DEFAULT 0,
  `fractures_completed` int NOT NULL DEFAULT 0,
  `defenses_won` int NOT NULL DEFAULT 0,
  `defenses_lost` int NOT NULL DEFAULT 0,
  `avg_kill_interval_ms` int NULL DEFAULT NULL COMMENT 'Intervallo medio tra kill in ms',
  `min_kill_interval_ms` int NULL DEFAULT NULL COMMENT 'Intervallo minimo (sospetto se troppo basso)',
  `session_duration_sec` int NULL DEFAULT NULL,
  `anomaly_score` int NOT NULL DEFAULT 0 COMMENT '0-100, alto = sospetto',
  `created_at` datetime NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`snapshot_id`) USING BTREE,
  INDEX `idx_player_type`(`player_id` ASC, `snapshot_type` ASC, `created_at` ASC) USING BTREE,
  INDEX `idx_anomaly`(`anomaly_score` ASC, `created_at` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 358 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hunter_player_stats_snapshot
-- ----------------------------
INSERT INTO `hunter_player_stats_snapshot` VALUES (1, 4, '[GF]HunabKu', 'SESSION', 0, 41, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-18 01:49:16');
INSERT INTO `hunter_player_stats_snapshot` VALUES (2, 4, '[GF]HunabKu', 'SESSION', 0, 41, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-18 01:49:46');
INSERT INTO `hunter_player_stats_snapshot` VALUES (3, 4, '[GF]HunabKu', 'SESSION', 0, 82, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-18 01:55:14');
INSERT INTO `hunter_player_stats_snapshot` VALUES (4, 4, '[GF]HunabKu', 'SESSION', 0, 82, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-18 01:55:41');
INSERT INTO `hunter_player_stats_snapshot` VALUES (5, 4, '[GF]HunabKu', 'SESSION', 0, 145, 2, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 09:30:23');
INSERT INTO `hunter_player_stats_snapshot` VALUES (6, 4, '[GF]HunabKu', 'SESSION', 0, 145, 2, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 09:31:49');
INSERT INTO `hunter_player_stats_snapshot` VALUES (7, 4, '[GF]HunabKu', 'SESSION', 0, 4, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 09:36:47');
INSERT INTO `hunter_player_stats_snapshot` VALUES (8, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-19 09:42:34');
INSERT INTO `hunter_player_stats_snapshot` VALUES (9, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-19 09:45:00');
INSERT INTO `hunter_player_stats_snapshot` VALUES (10, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 09:50:53');
INSERT INTO `hunter_player_stats_snapshot` VALUES (11, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 09:55:50');
INSERT INTO `hunter_player_stats_snapshot` VALUES (12, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 10:03:17');
INSERT INTO `hunter_player_stats_snapshot` VALUES (13, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 10:08:17');
INSERT INTO `hunter_player_stats_snapshot` VALUES (14, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 10:13:17');
INSERT INTO `hunter_player_stats_snapshot` VALUES (15, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 10:14:23');
INSERT INTO `hunter_player_stats_snapshot` VALUES (16, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 10:23:59');
INSERT INTO `hunter_player_stats_snapshot` VALUES (17, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 10:28:59');
INSERT INTO `hunter_player_stats_snapshot` VALUES (18, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 10:33:59');
INSERT INTO `hunter_player_stats_snapshot` VALUES (19, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 10:38:59');
INSERT INTO `hunter_player_stats_snapshot` VALUES (20, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 10:41:56');
INSERT INTO `hunter_player_stats_snapshot` VALUES (21, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 10:46:40');
INSERT INTO `hunter_player_stats_snapshot` VALUES (22, 4, '[GF]HunabKu', 'SESSION', 2, 43, 1, 8, 0, 0, 22000, 22000, NULL, 0, '2026-01-19 14:36:48');
INSERT INTO `hunter_player_stats_snapshot` VALUES (23, 4, '[GF]HunabKu', 'SESSION', 2, 43, 1, 9, 0, 0, 22000, 22000, NULL, 0, '2026-01-19 14:41:48');
INSERT INTO `hunter_player_stats_snapshot` VALUES (24, 4, '[GF]HunabKu', 'SESSION', 2, 43, 1, 9, 0, 0, 22000, 22000, NULL, 0, '2026-01-19 14:45:26');
INSERT INTO `hunter_player_stats_snapshot` VALUES (25, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 14:51:37');
INSERT INTO `hunter_player_stats_snapshot` VALUES (26, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 17:02:38');
INSERT INTO `hunter_player_stats_snapshot` VALUES (27, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 17:07:38');
INSERT INTO `hunter_player_stats_snapshot` VALUES (28, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 17:12:38');
INSERT INTO `hunter_player_stats_snapshot` VALUES (29, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 17:17:38');
INSERT INTO `hunter_player_stats_snapshot` VALUES (30, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 17:22:38');
INSERT INTO `hunter_player_stats_snapshot` VALUES (31, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 17:27:38');
INSERT INTO `hunter_player_stats_snapshot` VALUES (32, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 17:32:38');
INSERT INTO `hunter_player_stats_snapshot` VALUES (33, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 17:37:38');
INSERT INTO `hunter_player_stats_snapshot` VALUES (34, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 17:42:38');
INSERT INTO `hunter_player_stats_snapshot` VALUES (35, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 17:47:38');
INSERT INTO `hunter_player_stats_snapshot` VALUES (36, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 17:52:38');
INSERT INTO `hunter_player_stats_snapshot` VALUES (37, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 17:57:12');
INSERT INTO `hunter_player_stats_snapshot` VALUES (38, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 18:00:00');
INSERT INTO `hunter_player_stats_snapshot` VALUES (39, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 18:05:04');
INSERT INTO `hunter_player_stats_snapshot` VALUES (40, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 18:10:04');
INSERT INTO `hunter_player_stats_snapshot` VALUES (41, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 18:15:04');
INSERT INTO `hunter_player_stats_snapshot` VALUES (42, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 18:15:22');
INSERT INTO `hunter_player_stats_snapshot` VALUES (43, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 18:20:26');
INSERT INTO `hunter_player_stats_snapshot` VALUES (44, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 18:25:26');
INSERT INTO `hunter_player_stats_snapshot` VALUES (45, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 18:30:26');
INSERT INTO `hunter_player_stats_snapshot` VALUES (46, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 18:31:23');
INSERT INTO `hunter_player_stats_snapshot` VALUES (47, 1, '[GF]Wesker', 'SESSION', 0, 868, 8, 0, 0, 0, 0, 0, NULL, 0, '2026-01-19 18:34:01');
INSERT INTO `hunter_player_stats_snapshot` VALUES (48, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 18:36:26');
INSERT INTO `hunter_player_stats_snapshot` VALUES (49, 1, '[GF]Wesker', 'SESSION', 0, 868, 8, 0, 0, 0, 0, 0, NULL, 0, '2026-01-19 18:39:01');
INSERT INTO `hunter_player_stats_snapshot` VALUES (50, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 18:41:26');
INSERT INTO `hunter_player_stats_snapshot` VALUES (51, 1, '[GF]Wesker', 'SESSION', 0, 868, 8, 0, 0, 0, 0, 0, NULL, 0, '2026-01-19 18:44:01');
INSERT INTO `hunter_player_stats_snapshot` VALUES (52, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 18:46:26');
INSERT INTO `hunter_player_stats_snapshot` VALUES (53, 1, '[GF]Wesker', 'SESSION', 0, 868, 8, 0, 0, 0, 0, 0, NULL, 0, '2026-01-19 18:49:01');
INSERT INTO `hunter_player_stats_snapshot` VALUES (54, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 18:51:26');
INSERT INTO `hunter_player_stats_snapshot` VALUES (55, 1, '[GF]Wesker', 'SESSION', 0, 1194, 13, 0, 0, 0, 0, 0, NULL, 0, '2026-01-19 18:54:01');
INSERT INTO `hunter_player_stats_snapshot` VALUES (56, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 18:56:26');
INSERT INTO `hunter_player_stats_snapshot` VALUES (57, 1, '[GF]Wesker', 'SESSION', 0, 1262, 14, 0, 0, 0, 0, 0, NULL, 0, '2026-01-19 18:59:01');
INSERT INTO `hunter_player_stats_snapshot` VALUES (58, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 19:01:26');
INSERT INTO `hunter_player_stats_snapshot` VALUES (59, 4, '[GF]HunabKu', 'SESSION', 0, 43, 1, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 19:03:24');
INSERT INTO `hunter_player_stats_snapshot` VALUES (60, 1, '[GF]Wesker', 'SESSION', 0, 1262, 14, 0, 0, 0, 0, 0, NULL, 0, '2026-01-19 19:03:24');
INSERT INTO `hunter_player_stats_snapshot` VALUES (61, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 19:37:46');
INSERT INTO `hunter_player_stats_snapshot` VALUES (62, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 19:38:04');
INSERT INTO `hunter_player_stats_snapshot` VALUES (63, 4, '[GF]HunabKu', 'SESSION', 1, 199, 1, 3, 0, 0, 0, 0, NULL, 0, '2026-01-19 19:43:14');
INSERT INTO `hunter_player_stats_snapshot` VALUES (64, 4, '[GF]HunabKu', 'SESSION', 1, 199, 1, 3, 0, 0, 0, 0, NULL, 0, '2026-01-19 19:48:09');
INSERT INTO `hunter_player_stats_snapshot` VALUES (65, 4, '[GF]HunabKu', 'SESSION', 0, 199, 1, 4, 0, 0, 0, 0, NULL, 0, '2026-01-19 19:48:52');
INSERT INTO `hunter_player_stats_snapshot` VALUES (66, 4, '[GF]HunabKu', 'SESSION', 0, 199, 1, 4, 0, 0, 0, 0, NULL, 0, '2026-01-19 19:53:55');
INSERT INTO `hunter_player_stats_snapshot` VALUES (67, 4, '[GF]HunabKu', 'SESSION', 0, 199, 1, 4, 0, 0, 0, 0, NULL, 0, '2026-01-19 19:58:55');
INSERT INTO `hunter_player_stats_snapshot` VALUES (68, 4, '[GF]HunabKu', 'SESSION', 0, 199, 1, 4, 0, 0, 0, 0, NULL, 0, '2026-01-19 20:01:08');
INSERT INTO `hunter_player_stats_snapshot` VALUES (69, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 20:08:24');
INSERT INTO `hunter_player_stats_snapshot` VALUES (70, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 20:13:27');
INSERT INTO `hunter_player_stats_snapshot` VALUES (71, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-19 20:14:45');
INSERT INTO `hunter_player_stats_snapshot` VALUES (72, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-20 01:00:22');
INSERT INTO `hunter_player_stats_snapshot` VALUES (73, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-20 01:02:50');
INSERT INTO `hunter_player_stats_snapshot` VALUES (74, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-20 01:04:02');
INSERT INTO `hunter_player_stats_snapshot` VALUES (75, 440, 'SuraF', 'SESSION', 0, 1285, 22, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 13:40:49');
INSERT INTO `hunter_player_stats_snapshot` VALUES (76, 440, 'SuraF', 'SESSION', 0, 2228, 33, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 13:45:49');
INSERT INTO `hunter_player_stats_snapshot` VALUES (77, 440, 'SuraF', 'SESSION', 0, 2228, 33, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 13:46:17');
INSERT INTO `hunter_player_stats_snapshot` VALUES (78, 440, 'SuraF', 'SESSION', 0, 11405, 47, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 13:50:12');
INSERT INTO `hunter_player_stats_snapshot` VALUES (79, 1, '[GF]Wesker', 'SESSION', 0, 627, 2, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 13:51:22');
INSERT INTO `hunter_player_stats_snapshot` VALUES (80, 440, 'SuraF', 'SESSION', 0, 11405, 47, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 13:54:58');
INSERT INTO `hunter_player_stats_snapshot` VALUES (81, 440, 'SuraF', 'SESSION', 0, 11405, 47, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 13:58:06');
INSERT INTO `hunter_player_stats_snapshot` VALUES (82, 4, '[GF]HunabKu', 'SESSION', 0, 191, 4, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 15:19:33');
INSERT INTO `hunter_player_stats_snapshot` VALUES (83, 4, '[GF]HunabKu', 'SESSION', 0, 191, 4, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 15:24:33');
INSERT INTO `hunter_player_stats_snapshot` VALUES (84, 4, '[GF]HunabKu', 'SESSION', 0, 191, 4, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 15:29:33');
INSERT INTO `hunter_player_stats_snapshot` VALUES (85, 4, '[GF]HunabKu', 'SESSION', 0, 191, 4, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 15:34:33');
INSERT INTO `hunter_player_stats_snapshot` VALUES (86, 4, '[GF]HunabKu', 'SESSION', 0, 191, 4, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 15:39:33');
INSERT INTO `hunter_player_stats_snapshot` VALUES (87, 4, '[GF]HunabKu', 'SESSION', 0, 191, 4, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 15:44:33');
INSERT INTO `hunter_player_stats_snapshot` VALUES (88, 4, '[GF]HunabKu', 'SESSION', 0, 191, 4, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 15:49:33');
INSERT INTO `hunter_player_stats_snapshot` VALUES (89, 4, '[GF]HunabKu', 'SESSION', 0, 191, 4, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 15:51:08');
INSERT INTO `hunter_player_stats_snapshot` VALUES (90, 4, '[GF]HunabKu', 'SESSION', 0, 323, 5, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 16:37:27');
INSERT INTO `hunter_player_stats_snapshot` VALUES (91, 4, '[GF]HunabKu', 'SESSION', 0, 584, 7, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 16:38:29');
INSERT INTO `hunter_player_stats_snapshot` VALUES (92, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-20 16:43:34');
INSERT INTO `hunter_player_stats_snapshot` VALUES (93, 4, '[GF]HunabKu', 'SESSION', 2, 0, 0, 1, 0, 0, 41000, 41000, NULL, 0, '2026-01-20 16:45:42');
INSERT INTO `hunter_player_stats_snapshot` VALUES (94, 3905, '123213', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-20 16:56:46');
INSERT INTO `hunter_player_stats_snapshot` VALUES (95, 3905, '123213', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-20 16:59:37');
INSERT INTO `hunter_player_stats_snapshot` VALUES (96, 3905, '123213', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-20 17:01:33');
INSERT INTO `hunter_player_stats_snapshot` VALUES (97, 3905, '123213', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-20 17:06:36');
INSERT INTO `hunter_player_stats_snapshot` VALUES (98, 3905, '123213', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-20 17:11:36');
INSERT INTO `hunter_player_stats_snapshot` VALUES (99, 3905, '123213', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-20 17:16:36');
INSERT INTO `hunter_player_stats_snapshot` VALUES (100, 3905, '123213', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-20 17:21:36');
INSERT INTO `hunter_player_stats_snapshot` VALUES (101, 3905, '123213', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-20 17:26:36');
INSERT INTO `hunter_player_stats_snapshot` VALUES (102, 3905, '123213', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-20 17:31:36');
INSERT INTO `hunter_player_stats_snapshot` VALUES (103, 3905, '123213', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-20 17:36:36');
INSERT INTO `hunter_player_stats_snapshot` VALUES (104, 3905, '123213', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-20 17:41:36');
INSERT INTO `hunter_player_stats_snapshot` VALUES (105, 3905, '123213', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-20 17:46:36');
INSERT INTO `hunter_player_stats_snapshot` VALUES (106, 3905, '123213', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-20 17:50:52');
INSERT INTO `hunter_player_stats_snapshot` VALUES (107, 3905, '123213', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-20 17:51:03');
INSERT INTO `hunter_player_stats_snapshot` VALUES (108, 3903, 'Gameplay', 'SESSION', 1, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-20 18:00:18');
INSERT INTO `hunter_player_stats_snapshot` VALUES (109, 3903, 'Gameplay', 'SESSION', 1, 106, 1, 2, 0, 0, 0, 0, NULL, 0, '2026-01-20 18:02:31');
INSERT INTO `hunter_player_stats_snapshot` VALUES (110, 2, '[GF]Aelarion', 'SESSION', 0, 520, 6, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 18:16:16');
INSERT INTO `hunter_player_stats_snapshot` VALUES (111, 2, '[GF]Aelarion', 'SESSION', 0, 520, 6, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 18:21:16');
INSERT INTO `hunter_player_stats_snapshot` VALUES (112, 2, '[GF]Aelarion', 'SESSION', 0, 520, 6, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 18:26:16');
INSERT INTO `hunter_player_stats_snapshot` VALUES (113, 2, '[GF]Aelarion', 'SESSION', 0, 520, 6, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 18:31:16');
INSERT INTO `hunter_player_stats_snapshot` VALUES (114, 2, '[GF]Aelarion', 'SESSION', 0, 520, 6, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 18:32:28');
INSERT INTO `hunter_player_stats_snapshot` VALUES (115, 2, '[GF]Aelarion', 'SESSION', 0, 520, 6, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 18:37:31');
INSERT INTO `hunter_player_stats_snapshot` VALUES (116, 2, '[GF]Aelarion', 'SESSION', 0, 520, 6, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 18:42:31');
INSERT INTO `hunter_player_stats_snapshot` VALUES (117, 2, '[GF]Aelarion', 'SESSION', 0, 520, 6, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 18:47:31');
INSERT INTO `hunter_player_stats_snapshot` VALUES (118, 2, '[GF]Aelarion', 'SESSION', 0, 520, 6, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 18:52:31');
INSERT INTO `hunter_player_stats_snapshot` VALUES (119, 2, '[GF]Aelarion', 'SESSION', 0, 520, 6, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 18:57:31');
INSERT INTO `hunter_player_stats_snapshot` VALUES (120, 2, '[GF]Aelarion', 'SESSION', 0, 520, 6, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 19:02:31');
INSERT INTO `hunter_player_stats_snapshot` VALUES (121, 2, '[GF]Aelarion', 'SESSION', 0, 520, 6, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 19:07:31');
INSERT INTO `hunter_player_stats_snapshot` VALUES (122, 2, '[GF]Aelarion', 'SESSION', 0, 520, 6, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 19:12:31');
INSERT INTO `hunter_player_stats_snapshot` VALUES (123, 2, '[GF]Aelarion', 'SESSION', 0, 520, 6, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 19:17:31');
INSERT INTO `hunter_player_stats_snapshot` VALUES (124, 2, '[GF]Aelarion', 'SESSION', 0, 520, 6, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 19:22:31');
INSERT INTO `hunter_player_stats_snapshot` VALUES (125, 2, '[GF]Aelarion', 'SESSION', 0, 520, 6, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 19:27:31');
INSERT INTO `hunter_player_stats_snapshot` VALUES (126, 2, '[GF]Aelarion', 'SESSION', 0, 520, 6, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 19:32:31');
INSERT INTO `hunter_player_stats_snapshot` VALUES (127, 2, '[GF]Aelarion', 'SESSION', 0, 520, 6, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 19:37:31');
INSERT INTO `hunter_player_stats_snapshot` VALUES (128, 2, '[GF]Aelarion', 'SESSION', 0, 520, 6, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 19:42:31');
INSERT INTO `hunter_player_stats_snapshot` VALUES (129, 2, '[GF]Aelarion', 'SESSION', 0, 520, 6, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 19:47:31');
INSERT INTO `hunter_player_stats_snapshot` VALUES (130, 2, '[GF]Aelarion', 'SESSION', 0, 520, 6, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 19:52:31');
INSERT INTO `hunter_player_stats_snapshot` VALUES (131, 2, '[GF]Aelarion', 'SESSION', 0, 520, 6, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 19:57:31');
INSERT INTO `hunter_player_stats_snapshot` VALUES (132, 2, '[GF]Aelarion', 'SESSION', 0, 520, 6, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 20:02:31');
INSERT INTO `hunter_player_stats_snapshot` VALUES (133, 2, '[GF]Aelarion', 'SESSION', 0, 520, 6, 0, 0, 0, 0, 0, NULL, 0, '2026-01-20 20:06:48');
INSERT INTO `hunter_player_stats_snapshot` VALUES (134, 4, '[GF]HunabKu', 'SESSION', 0, 112, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-21 01:35:48');
INSERT INTO `hunter_player_stats_snapshot` VALUES (135, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-21 12:54:17');
INSERT INTO `hunter_player_stats_snapshot` VALUES (136, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-21 12:56:16');
INSERT INTO `hunter_player_stats_snapshot` VALUES (137, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-21 13:01:00');
INSERT INTO `hunter_player_stats_snapshot` VALUES (138, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-21 13:06:05');
INSERT INTO `hunter_player_stats_snapshot` VALUES (139, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-21 13:11:05');
INSERT INTO `hunter_player_stats_snapshot` VALUES (140, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-21 13:16:05');
INSERT INTO `hunter_player_stats_snapshot` VALUES (141, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-21 13:21:05');
INSERT INTO `hunter_player_stats_snapshot` VALUES (142, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-21 13:26:05');
INSERT INTO `hunter_player_stats_snapshot` VALUES (143, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-21 13:31:05');
INSERT INTO `hunter_player_stats_snapshot` VALUES (144, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-21 13:34:02');
INSERT INTO `hunter_player_stats_snapshot` VALUES (145, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-21 13:39:06');
INSERT INTO `hunter_player_stats_snapshot` VALUES (146, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-21 13:44:06');
INSERT INTO `hunter_player_stats_snapshot` VALUES (147, 1684, 'Pacifista', 'SESSION', 0, 39, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-21 13:45:48');
INSERT INTO `hunter_player_stats_snapshot` VALUES (148, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 4, 0, 0, 0, 0, NULL, 0, '2026-01-21 13:49:06');
INSERT INTO `hunter_player_stats_snapshot` VALUES (149, 1684, 'Pacifista', 'SESSION', 0, 39, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-21 13:50:48');
INSERT INTO `hunter_player_stats_snapshot` VALUES (150, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 4, 0, 0, 0, 0, NULL, 0, '2026-01-21 13:54:06');
INSERT INTO `hunter_player_stats_snapshot` VALUES (151, 1684, 'Pacifista', 'SESSION', 0, 39, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-21 13:55:48');
INSERT INTO `hunter_player_stats_snapshot` VALUES (152, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 4, 0, 0, 0, 0, NULL, 0, '2026-01-21 13:59:06');
INSERT INTO `hunter_player_stats_snapshot` VALUES (153, 1684, 'Pacifista', 'SESSION', 0, 39, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-21 14:00:48');
INSERT INTO `hunter_player_stats_snapshot` VALUES (154, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 5, 0, 0, 0, 0, NULL, 0, '2026-01-21 14:04:06');
INSERT INTO `hunter_player_stats_snapshot` VALUES (155, 1684, 'Pacifista', 'SESSION', 0, 39, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-21 14:05:48');
INSERT INTO `hunter_player_stats_snapshot` VALUES (156, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 5, 0, 0, 0, 0, NULL, 0, '2026-01-21 14:09:06');
INSERT INTO `hunter_player_stats_snapshot` VALUES (157, 1684, 'Pacifista', 'SESSION', 0, 39, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-21 14:10:48');
INSERT INTO `hunter_player_stats_snapshot` VALUES (158, 1684, 'Pacifista', 'SESSION', 0, 39, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-21 14:13:37');
INSERT INTO `hunter_player_stats_snapshot` VALUES (159, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 5, 0, 0, 0, 0, NULL, 0, '2026-01-21 14:13:40');
INSERT INTO `hunter_player_stats_snapshot` VALUES (160, 4, '[GF]HunabKu', 'SESSION', 0, 21, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-21 14:21:45');
INSERT INTO `hunter_player_stats_snapshot` VALUES (161, 4, '[GF]HunabKu', 'SESSION', 0, 21, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-21 14:25:47');
INSERT INTO `hunter_player_stats_snapshot` VALUES (162, 4, '[GF]HunabKu', 'SESSION', 0, 11, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-21 14:36:31');
INSERT INTO `hunter_player_stats_snapshot` VALUES (163, 4, '[GF]HunabKu', 'SESSION', 0, 11, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-21 14:41:11');
INSERT INTO `hunter_player_stats_snapshot` VALUES (164, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-21 17:18:54');
INSERT INTO `hunter_player_stats_snapshot` VALUES (165, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-21 17:23:54');
INSERT INTO `hunter_player_stats_snapshot` VALUES (166, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-21 17:28:54');
INSERT INTO `hunter_player_stats_snapshot` VALUES (167, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-21 17:29:13');
INSERT INTO `hunter_player_stats_snapshot` VALUES (168, 3903, 'Gameplay', 'SESSION', 0, 56, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-21 18:27:36');
INSERT INTO `hunter_player_stats_snapshot` VALUES (169, 3903, 'Gameplay', 'SESSION', 0, 56, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-21 18:29:30');
INSERT INTO `hunter_player_stats_snapshot` VALUES (170, 3903, 'Gameplay', 'SESSION', 0, 56, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-21 18:41:17');
INSERT INTO `hunter_player_stats_snapshot` VALUES (171, 3903, 'Gameplay', 'SESSION', 0, 56, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-21 18:55:12');
INSERT INTO `hunter_player_stats_snapshot` VALUES (172, 3903, 'Gameplay', 'SESSION', 0, 56, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-21 19:00:12');
INSERT INTO `hunter_player_stats_snapshot` VALUES (173, 3903, 'Gameplay', 'SESSION', 1, 56, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-21 19:05:12');
INSERT INTO `hunter_player_stats_snapshot` VALUES (174, 3903, 'Gameplay', 'SESSION', 1, 56, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-21 19:10:11');
INSERT INTO `hunter_player_stats_snapshot` VALUES (175, 3903, 'Gameplay', 'SESSION', 1, 56, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-21 19:15:11');
INSERT INTO `hunter_player_stats_snapshot` VALUES (176, 3903, 'Gameplay', 'SESSION', 1, 56, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-21 19:16:20');
INSERT INTO `hunter_player_stats_snapshot` VALUES (177, 3903, 'Gameplay', 'SESSION', 0, 56, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-21 20:31:00');
INSERT INTO `hunter_player_stats_snapshot` VALUES (178, 3903, 'Gameplay', 'SESSION', 0, 56, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-21 20:36:00');
INSERT INTO `hunter_player_stats_snapshot` VALUES (179, 3903, 'Gameplay', 'SESSION', 0, 56, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-21 20:41:00');
INSERT INTO `hunter_player_stats_snapshot` VALUES (180, 3903, 'Gameplay', 'SESSION', 0, 56, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-21 20:45:59');
INSERT INTO `hunter_player_stats_snapshot` VALUES (181, 3903, 'Gameplay', 'SESSION', 0, 56, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-21 20:50:59');
INSERT INTO `hunter_player_stats_snapshot` VALUES (182, 3903, 'Gameplay', 'SESSION', 0, 56, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-21 20:55:59');
INSERT INTO `hunter_player_stats_snapshot` VALUES (183, 3903, 'Gameplay', 'SESSION', 0, 56, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-21 21:00:58');
INSERT INTO `hunter_player_stats_snapshot` VALUES (184, 3903, 'Gameplay', 'SESSION', 0, 56, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-21 21:05:58');
INSERT INTO `hunter_player_stats_snapshot` VALUES (185, 3903, 'Gameplay', 'SESSION', 0, 56, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-21 21:10:58');
INSERT INTO `hunter_player_stats_snapshot` VALUES (186, 3903, 'Gameplay', 'SESSION', 0, 56, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-21 21:15:57');
INSERT INTO `hunter_player_stats_snapshot` VALUES (187, 3903, 'Gameplay', 'SESSION', 0, 56, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-21 21:20:57');
INSERT INTO `hunter_player_stats_snapshot` VALUES (188, 3903, 'Gameplay', 'SESSION', 0, 0, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-21 21:25:57');
INSERT INTO `hunter_player_stats_snapshot` VALUES (189, 3903, 'Gameplay', 'SESSION', 0, 0, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-21 21:30:57');
INSERT INTO `hunter_player_stats_snapshot` VALUES (190, 3903, 'Gameplay', 'SESSION', 0, 0, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-21 21:35:56');
INSERT INTO `hunter_player_stats_snapshot` VALUES (191, 3903, 'Gameplay', 'SESSION', 0, 0, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-21 21:39:30');
INSERT INTO `hunter_player_stats_snapshot` VALUES (192, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-22 12:59:17');
INSERT INTO `hunter_player_stats_snapshot` VALUES (193, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-22 13:04:00');
INSERT INTO `hunter_player_stats_snapshot` VALUES (194, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-22 13:06:43');
INSERT INTO `hunter_player_stats_snapshot` VALUES (195, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-22 13:09:12');
INSERT INTO `hunter_player_stats_snapshot` VALUES (196, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-22 13:13:12');
INSERT INTO `hunter_player_stats_snapshot` VALUES (197, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-22 13:18:22');
INSERT INTO `hunter_player_stats_snapshot` VALUES (198, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-22 13:18:51');
INSERT INTO `hunter_player_stats_snapshot` VALUES (199, 3903, 'Gameplay', 'SESSION', 1, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-23 14:22:04');
INSERT INTO `hunter_player_stats_snapshot` VALUES (200, 3903, 'Gameplay', 'SESSION', 1, 56, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-23 14:27:04');
INSERT INTO `hunter_player_stats_snapshot` VALUES (201, 3903, 'Gameplay', 'SESSION', 1, 56, 0, 4, 0, 0, 0, 0, NULL, 0, '2026-01-23 14:32:04');
INSERT INTO `hunter_player_stats_snapshot` VALUES (202, 3903, 'Gameplay', 'SESSION', 1, 56, 0, 4, 0, 0, 0, 0, NULL, 0, '2026-01-23 14:37:03');
INSERT INTO `hunter_player_stats_snapshot` VALUES (203, 3903, 'Gameplay', 'SESSION', 1, 56, 0, 4, 0, 0, 0, 0, NULL, 0, '2026-01-23 14:42:03');
INSERT INTO `hunter_player_stats_snapshot` VALUES (204, 3903, 'Gameplay', 'SESSION', 1, 56, 0, 4, 0, 0, 0, 0, NULL, 0, '2026-01-23 14:47:02');
INSERT INTO `hunter_player_stats_snapshot` VALUES (205, 3903, 'Gameplay', 'SESSION', 1, 56, 0, 4, 0, 0, 0, 0, NULL, 0, '2026-01-23 14:52:02');
INSERT INTO `hunter_player_stats_snapshot` VALUES (206, 3903, 'Gameplay', 'SESSION', 1, 56, 0, 4, 0, 0, 0, 0, NULL, 0, '2026-01-23 14:57:02');
INSERT INTO `hunter_player_stats_snapshot` VALUES (207, 3903, 'Gameplay', 'SESSION', 1, 56, 0, 4, 0, 0, 0, 0, NULL, 0, '2026-01-23 15:02:02');
INSERT INTO `hunter_player_stats_snapshot` VALUES (208, 3903, 'Gameplay', 'SESSION', 1, 56, 0, 4, 0, 0, 0, 0, NULL, 0, '2026-01-23 15:07:01');
INSERT INTO `hunter_player_stats_snapshot` VALUES (209, 3903, 'Gameplay', 'SESSION', 1, 56, 0, 4, 0, 0, 0, 0, NULL, 0, '2026-01-23 15:12:01');
INSERT INTO `hunter_player_stats_snapshot` VALUES (210, 3903, 'Gameplay', 'SESSION', 1, 56, 0, 4, 0, 0, 0, 0, NULL, 0, '2026-01-23 15:17:00');
INSERT INTO `hunter_player_stats_snapshot` VALUES (211, 3903, 'Gameplay', 'SESSION', 1, 56, 0, 4, 0, 0, 0, 0, NULL, 0, '2026-01-23 15:22:00');
INSERT INTO `hunter_player_stats_snapshot` VALUES (212, 3903, 'Gameplay', 'SESSION', 1, 56, 0, 4, 0, 0, 0, 0, NULL, 0, '2026-01-23 15:25:59');
INSERT INTO `hunter_player_stats_snapshot` VALUES (213, 3903, 'Gameplay', 'SESSION', 0, 56, 0, 4, 0, 0, 0, 0, NULL, 0, '2026-01-23 15:34:32');
INSERT INTO `hunter_player_stats_snapshot` VALUES (214, 3903, 'Gameplay', 'SESSION', 0, 56, 0, 4, 0, 0, 0, 0, NULL, 0, '2026-01-23 15:36:45');
INSERT INTO `hunter_player_stats_snapshot` VALUES (215, 3903, 'Gameplay', 'SESSION', 0, 56, 0, 4, 0, 0, 0, 0, NULL, 0, '2026-01-23 15:42:20');
INSERT INTO `hunter_player_stats_snapshot` VALUES (216, 3903, 'Gameplay', 'SESSION', 0, 56, 0, 4, 0, 0, 0, 0, NULL, 0, '2026-01-23 15:47:19');
INSERT INTO `hunter_player_stats_snapshot` VALUES (217, 3903, 'Gameplay', 'SESSION', 0, 56, 0, 4, 0, 0, 0, 0, NULL, 0, '2026-01-23 15:52:18');
INSERT INTO `hunter_player_stats_snapshot` VALUES (218, 3903, 'Gameplay', 'SESSION', 0, 56, 0, 4, 0, 0, 0, 0, NULL, 0, '2026-01-23 15:57:18');
INSERT INTO `hunter_player_stats_snapshot` VALUES (219, 3903, 'Gameplay', 'SESSION', 0, 56, 0, 4, 0, 0, 0, 0, NULL, 0, '2026-01-23 16:02:18');
INSERT INTO `hunter_player_stats_snapshot` VALUES (220, 3903, 'Gameplay', 'SESSION', 0, 56, 0, 4, 0, 0, 0, 0, NULL, 0, '2026-01-23 16:07:17');
INSERT INTO `hunter_player_stats_snapshot` VALUES (221, 3903, 'Gameplay', 'SESSION', 0, 56, 0, 4, 0, 0, 0, 0, NULL, 0, '2026-01-23 16:11:49');
INSERT INTO `hunter_player_stats_snapshot` VALUES (222, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-23 17:47:31');
INSERT INTO `hunter_player_stats_snapshot` VALUES (223, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-23 17:48:12');
INSERT INTO `hunter_player_stats_snapshot` VALUES (224, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-23 17:53:16');
INSERT INTO `hunter_player_stats_snapshot` VALUES (225, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-23 17:58:16');
INSERT INTO `hunter_player_stats_snapshot` VALUES (226, 4, '[GF]HunabKu', 'SESSION', 1, 25, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-23 18:03:16');
INSERT INTO `hunter_player_stats_snapshot` VALUES (227, 4, '[GF]HunabKu', 'SESSION', 1, 57, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-23 18:08:16');
INSERT INTO `hunter_player_stats_snapshot` VALUES (228, 4, '[GF]HunabKu', 'SESSION', 1, 57, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-23 18:13:16');
INSERT INTO `hunter_player_stats_snapshot` VALUES (229, 4, '[GF]HunabKu', 'SESSION', 1, 57, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-23 18:17:12');
INSERT INTO `hunter_player_stats_snapshot` VALUES (230, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-23 18:30:23');
INSERT INTO `hunter_player_stats_snapshot` VALUES (231, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-23 18:35:27');
INSERT INTO `hunter_player_stats_snapshot` VALUES (232, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-23 18:40:27');
INSERT INTO `hunter_player_stats_snapshot` VALUES (233, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-23 18:42:04');
INSERT INTO `hunter_player_stats_snapshot` VALUES (234, 4, '[GF]HunabKu', 'SESSION', 0, 73, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-23 18:46:03');
INSERT INTO `hunter_player_stats_snapshot` VALUES (235, 4, '[GF]HunabKu', 'SESSION', 0, 21, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-23 18:57:30');
INSERT INTO `hunter_player_stats_snapshot` VALUES (236, 4, '[GF]HunabKu', 'SESSION', 3, 0, 0, 4, 0, 0, 26000, 18000, NULL, 0, '2026-01-23 21:51:14');
INSERT INTO `hunter_player_stats_snapshot` VALUES (237, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 5, 0, 0, 0, 0, NULL, 0, '2026-01-23 21:56:14');
INSERT INTO `hunter_player_stats_snapshot` VALUES (238, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 5, 0, 0, 0, 0, NULL, 0, '2026-01-23 22:01:14');
INSERT INTO `hunter_player_stats_snapshot` VALUES (239, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 5, 0, 0, 0, 0, NULL, 0, '2026-01-23 22:02:57');
INSERT INTO `hunter_player_stats_snapshot` VALUES (240, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-23 22:32:08');
INSERT INTO `hunter_player_stats_snapshot` VALUES (241, 4, '[GF]HunabKu', 'SESSION', 2, 35, 1, 3, 0, 0, 16000, 16000, NULL, 0, '2026-01-23 22:35:25');
INSERT INTO `hunter_player_stats_snapshot` VALUES (242, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-23 22:54:21');
INSERT INTO `hunter_player_stats_snapshot` VALUES (243, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-23 22:59:26');
INSERT INTO `hunter_player_stats_snapshot` VALUES (244, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-23 23:04:26');
INSERT INTO `hunter_player_stats_snapshot` VALUES (245, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-23 23:09:26');
INSERT INTO `hunter_player_stats_snapshot` VALUES (246, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-23 23:10:39');
INSERT INTO `hunter_player_stats_snapshot` VALUES (247, 4, '[GF]HunabKu', 'SESSION', 0, 24, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-23 23:55:11');
INSERT INTO `hunter_player_stats_snapshot` VALUES (248, 4, '[GF]HunabKu', 'SESSION', 0, 24, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-23 23:57:53');
INSERT INTO `hunter_player_stats_snapshot` VALUES (249, 4, '[GF]HunabKu', 'SESSION', 0, 189, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-24 00:06:20');
INSERT INTO `hunter_player_stats_snapshot` VALUES (250, 4, '[GF]HunabKu', 'SESSION', 0, 189, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-24 00:10:50');
INSERT INTO `hunter_player_stats_snapshot` VALUES (251, 4, '[GF]HunabKu', 'SESSION', 0, 168, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-24 00:12:38');
INSERT INTO `hunter_player_stats_snapshot` VALUES (252, 4, '[GF]HunabKu', 'SESSION', 0, 342, 2, 0, 0, 0, 0, 0, NULL, 0, '2026-01-24 00:17:43');
INSERT INTO `hunter_player_stats_snapshot` VALUES (253, 4, '[GF]HunabKu', 'SESSION', 1, 342, 2, 1, 0, 0, 0, 0, NULL, 0, '2026-01-24 00:22:43');
INSERT INTO `hunter_player_stats_snapshot` VALUES (254, 4, '[GF]HunabKu', 'SESSION', 1, 342, 2, 1, 0, 0, 0, 0, NULL, 0, '2026-01-24 00:23:15');
INSERT INTO `hunter_player_stats_snapshot` VALUES (255, 4, '[GF]HunabKu', 'SESSION', 1, 342, 2, 2, 0, 0, 0, 0, NULL, 0, '2026-01-24 00:28:19');
INSERT INTO `hunter_player_stats_snapshot` VALUES (256, 4, '[GF]HunabKu', 'SESSION', 1, 342, 2, 2, 0, 0, 0, 0, NULL, 0, '2026-01-24 00:33:19');
INSERT INTO `hunter_player_stats_snapshot` VALUES (257, 4, '[GF]HunabKu', 'SESSION', 1, 359, 3, 5, 0, 0, 0, 0, NULL, 0, '2026-01-24 00:38:19');
INSERT INTO `hunter_player_stats_snapshot` VALUES (258, 4, '[GF]HunabKu', 'SESSION', 1, 359, 3, 5, 0, 0, 0, 0, NULL, 0, '2026-01-24 00:43:19');
INSERT INTO `hunter_player_stats_snapshot` VALUES (259, 4, '[GF]HunabKu', 'SESSION', 1, 359, 3, 5, 0, 0, 0, 0, NULL, 0, '2026-01-24 00:48:19');
INSERT INTO `hunter_player_stats_snapshot` VALUES (260, 4, '[GF]HunabKu', 'SESSION', 1, 359, 3, 5, 0, 0, 0, 0, NULL, 0, '2026-01-24 00:53:19');
INSERT INTO `hunter_player_stats_snapshot` VALUES (261, 4, '[GF]HunabKu', 'SESSION', 1, 359, 3, 5, 0, 0, 0, 0, NULL, 0, '2026-01-24 00:55:19');
INSERT INTO `hunter_player_stats_snapshot` VALUES (262, 4, '[GF]HunabKu', 'SESSION', 0, 5, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-24 00:59:00');
INSERT INTO `hunter_player_stats_snapshot` VALUES (263, 4, '[GF]HunabKu', 'SESSION', 0, 359, 3, 5, 0, 0, 0, 0, NULL, 0, '2026-01-24 01:01:56');
INSERT INTO `hunter_player_stats_snapshot` VALUES (264, 4, '[GF]HunabKu', 'SESSION', 0, 59, 2, 0, 0, 0, 0, 0, NULL, 0, '2026-01-24 01:07:03');
INSERT INTO `hunter_player_stats_snapshot` VALUES (265, 4, '[GF]HunabKu', 'SESSION', 0, 59, 2, 1, 0, 0, 0, 0, NULL, 0, '2026-01-24 01:12:03');
INSERT INTO `hunter_player_stats_snapshot` VALUES (266, 4, '[GF]HunabKu', 'SESSION', 1, 59, 2, 2, 0, 0, 0, 0, NULL, 0, '2026-01-24 01:12:57');
INSERT INTO `hunter_player_stats_snapshot` VALUES (267, 4, '[GF]HunabKu', 'SESSION', 0, 359, 3, 6, 0, 0, 0, 0, NULL, 0, '2026-01-24 01:18:03');
INSERT INTO `hunter_player_stats_snapshot` VALUES (268, 4, '[GF]HunabKu', 'SESSION', 0, 359, 3, 7, 0, 0, 0, 0, NULL, 0, '2026-01-24 01:23:03');
INSERT INTO `hunter_player_stats_snapshot` VALUES (269, 4, '[GF]HunabKu', 'SESSION', 0, 359, 3, 7, 0, 0, 0, 0, NULL, 0, '2026-01-24 01:28:03');
INSERT INTO `hunter_player_stats_snapshot` VALUES (270, 4, '[GF]HunabKu', 'SESSION', 0, 359, 3, 7, 0, 0, 0, 0, NULL, 0, '2026-01-24 01:33:03');
INSERT INTO `hunter_player_stats_snapshot` VALUES (271, 4, '[GF]HunabKu', 'SESSION', 0, 359, 3, 7, 0, 0, 0, 0, NULL, 0, '2026-01-24 01:38:03');
INSERT INTO `hunter_player_stats_snapshot` VALUES (272, 4, '[GF]HunabKu', 'SESSION', 0, 359, 3, 7, 0, 0, 0, 0, NULL, 0, '2026-01-24 01:43:03');
INSERT INTO `hunter_player_stats_snapshot` VALUES (273, 4, '[GF]HunabKu', 'SESSION', 0, 359, 3, 7, 0, 0, 0, 0, NULL, 0, '2026-01-24 01:48:02');
INSERT INTO `hunter_player_stats_snapshot` VALUES (274, 4, '[GF]HunabKu', 'SESSION', 0, 477, 4, 7, 0, 0, 0, 0, NULL, 0, '2026-01-24 01:53:02');
INSERT INTO `hunter_player_stats_snapshot` VALUES (275, 4, '[GF]HunabKu', 'SESSION', 0, 477, 4, 7, 0, 0, 0, 0, NULL, 0, '2026-01-24 01:58:02');
INSERT INTO `hunter_player_stats_snapshot` VALUES (276, 4, '[GF]HunabKu', 'SESSION', 0, 477, 4, 7, 0, 0, 0, 0, NULL, 0, '2026-01-24 02:03:02');
INSERT INTO `hunter_player_stats_snapshot` VALUES (277, 4, '[GF]HunabKu', 'SESSION', 0, 477, 4, 7, 0, 0, 0, 0, NULL, 0, '2026-01-24 02:06:41');
INSERT INTO `hunter_player_stats_snapshot` VALUES (278, 1684, 'Pacifista', 'SESSION', 0, 38, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-24 02:37:02');
INSERT INTO `hunter_player_stats_snapshot` VALUES (279, 4, '[GF]HunabKu', 'SESSION', 0, 14, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-24 02:39:38');
INSERT INTO `hunter_player_stats_snapshot` VALUES (280, 4, '[GF]HunabKu', 'SESSION', 0, 14, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-24 02:44:38');
INSERT INTO `hunter_player_stats_snapshot` VALUES (281, 4, '[GF]HunabKu', 'SESSION', 0, 14, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-24 02:49:38');
INSERT INTO `hunter_player_stats_snapshot` VALUES (282, 4, '[GF]HunabKu', 'SESSION', 0, 14, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-24 02:50:30');
INSERT INTO `hunter_player_stats_snapshot` VALUES (283, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-24 02:54:12');
INSERT INTO `hunter_player_stats_snapshot` VALUES (284, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-24 02:55:04');
INSERT INTO `hunter_player_stats_snapshot` VALUES (285, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-24 12:55:52');
INSERT INTO `hunter_player_stats_snapshot` VALUES (286, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-24 13:04:18');
INSERT INTO `hunter_player_stats_snapshot` VALUES (287, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 3, 0, 0, 0, 0, NULL, 0, '2026-01-24 13:04:51');
INSERT INTO `hunter_player_stats_snapshot` VALUES (288, 4, '[GF]HunabKu', 'SESSION', 1, 369, 2, 7, 0, 0, 0, 0, NULL, 0, '2026-01-24 13:09:54');
INSERT INTO `hunter_player_stats_snapshot` VALUES (289, 4, '[GF]HunabKu', 'SESSION', 1, 369, 2, 7, 0, 0, 0, 0, NULL, 0, '2026-01-24 13:14:54');
INSERT INTO `hunter_player_stats_snapshot` VALUES (290, 4, '[GF]HunabKu', 'SESSION', 1, 369, 2, 7, 0, 0, 0, 0, NULL, 0, '2026-01-24 13:19:54');
INSERT INTO `hunter_player_stats_snapshot` VALUES (291, 4, '[GF]HunabKu', 'SESSION', 1, 369, 2, 7, 0, 0, 0, 0, NULL, 0, '2026-01-24 13:24:54');
INSERT INTO `hunter_player_stats_snapshot` VALUES (292, 4, '[GF]HunabKu', 'SESSION', 1, 369, 2, 7, 0, 0, 0, 0, NULL, 0, '2026-01-24 13:28:20');
INSERT INTO `hunter_player_stats_snapshot` VALUES (293, 4, '[GF]HunabKu', 'SESSION', 2, 0, 0, 2, 0, 0, 29000, 29000, NULL, 0, '2026-01-24 13:35:10');
INSERT INTO `hunter_player_stats_snapshot` VALUES (294, 4, '[GF]HunabKu', 'SESSION', 2, 0, 0, 2, 0, 0, 29000, 29000, NULL, 0, '2026-01-24 13:40:10');
INSERT INTO `hunter_player_stats_snapshot` VALUES (295, 4, '[GF]HunabKu', 'SESSION', 2, 0, 0, 2, 0, 0, 29000, 29000, NULL, 0, '2026-01-24 13:45:10');
INSERT INTO `hunter_player_stats_snapshot` VALUES (296, 4, '[GF]HunabKu', 'SESSION', 2, 0, 0, 2, 0, 0, 29000, 29000, NULL, 0, '2026-01-24 13:48:52');
INSERT INTO `hunter_player_stats_snapshot` VALUES (297, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-24 14:52:43');
INSERT INTO `hunter_player_stats_snapshot` VALUES (298, 4, '[GF]HunabKu', 'SESSION', 0, 57, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-24 15:52:41');
INSERT INTO `hunter_player_stats_snapshot` VALUES (299, 4, '[GF]HunabKu', 'SESSION', 0, 57, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-24 15:57:41');
INSERT INTO `hunter_player_stats_snapshot` VALUES (300, 4, '[GF]HunabKu', 'SESSION', 0, 57, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-24 16:02:41');
INSERT INTO `hunter_player_stats_snapshot` VALUES (301, 4, '[GF]HunabKu', 'SESSION', 0, 57, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-24 16:07:41');
INSERT INTO `hunter_player_stats_snapshot` VALUES (302, 4, '[GF]HunabKu', 'SESSION', 0, 57, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-24 16:10:06');
INSERT INTO `hunter_player_stats_snapshot` VALUES (303, 4, '[GF]HunabKu', 'SESSION', 0, 38, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-24 16:16:43');
INSERT INTO `hunter_player_stats_snapshot` VALUES (304, 4, '[GF]HunabKu', 'SESSION', 2, 0, 0, 0, 0, 0, 50000, 50000, NULL, 0, '2026-01-24 16:30:48');
INSERT INTO `hunter_player_stats_snapshot` VALUES (305, 1684, 'Pacifista', 'SESSION', 1, 0, 0, 0, 0, 0, 0, 0, NULL, 0, '2026-01-24 16:44:52');
INSERT INTO `hunter_player_stats_snapshot` VALUES (306, 1684, 'Pacifista', 'SESSION', 1, 0, 0, 0, 0, 0, 0, 0, NULL, 0, '2026-01-24 16:45:45');
INSERT INTO `hunter_player_stats_snapshot` VALUES (307, 3906, 'Monarca', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-24 18:53:08');
INSERT INTO `hunter_player_stats_snapshot` VALUES (308, 3906, 'Monarca', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-24 18:57:00');
INSERT INTO `hunter_player_stats_snapshot` VALUES (309, 3906, 'Monarca', 'SESSION', 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-24 19:05:00');
INSERT INTO `hunter_player_stats_snapshot` VALUES (310, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-24 20:05:13');
INSERT INTO `hunter_player_stats_snapshot` VALUES (311, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-24 20:07:47');
INSERT INTO `hunter_player_stats_snapshot` VALUES (312, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-24 20:10:08');
INSERT INTO `hunter_player_stats_snapshot` VALUES (313, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-24 20:15:12');
INSERT INTO `hunter_player_stats_snapshot` VALUES (314, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-24 20:18:10');
INSERT INTO `hunter_player_stats_snapshot` VALUES (315, 4, '[GF]HunabKu', 'SESSION', 0, 50, 0, 0, 0, 0, 0, 0, NULL, 0, '2026-01-24 21:38:48');
INSERT INTO `hunter_player_stats_snapshot` VALUES (316, 4, '[GF]HunabKu', 'SESSION', 1, 50, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-24 21:43:48');
INSERT INTO `hunter_player_stats_snapshot` VALUES (317, 4, '[GF]HunabKu', 'SESSION', 1, 50, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-24 21:48:48');
INSERT INTO `hunter_player_stats_snapshot` VALUES (318, 4, '[GF]HunabKu', 'SESSION', 1, 50, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-24 21:51:45');
INSERT INTO `hunter_player_stats_snapshot` VALUES (319, 4, '[GF]HunabKu', 'SESSION', 0, 776, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-24 21:56:50');
INSERT INTO `hunter_player_stats_snapshot` VALUES (320, 4, '[GF]HunabKu', 'SESSION', 0, 862, 2, 0, 0, 0, 0, 0, NULL, 0, '2026-01-24 22:01:50');
INSERT INTO `hunter_player_stats_snapshot` VALUES (321, 4, '[GF]HunabKu', 'SESSION', 0, 862, 2, 0, 0, 0, 0, 0, NULL, 0, '2026-01-24 22:06:50');
INSERT INTO `hunter_player_stats_snapshot` VALUES (322, 4, '[GF]HunabKu', 'SESSION', 0, 862, 2, 0, 0, 0, 0, 0, NULL, 0, '2026-01-24 22:11:50');
INSERT INTO `hunter_player_stats_snapshot` VALUES (323, 4, '[GF]HunabKu', 'SESSION', 0, 862, 2, 0, 0, 0, 0, 0, NULL, 0, '2026-01-24 22:14:09');
INSERT INTO `hunter_player_stats_snapshot` VALUES (324, 1684, 'Pacifista', 'SESSION', 1, 0, 0, 0, 0, 0, 0, 0, NULL, 0, '2026-01-24 22:14:11');
INSERT INTO `hunter_player_stats_snapshot` VALUES (325, 4, '[GF]HunabKu', 'SESSION', 0, 1308, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-24 23:00:19');
INSERT INTO `hunter_player_stats_snapshot` VALUES (326, 4, '[GF]HunabKu', 'SESSION', 0, 1308, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-24 23:00:48');
INSERT INTO `hunter_player_stats_snapshot` VALUES (327, 4, '[GF]HunabKu', 'SESSION', 0, 1308, 1, 0, 0, 0, 0, 0, NULL, 0, '2026-01-24 23:05:01');
INSERT INTO `hunter_player_stats_snapshot` VALUES (328, 4, '[GF]HunabKu', 'SESSION', 0, 50, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-25 14:02:28');
INSERT INTO `hunter_player_stats_snapshot` VALUES (329, 4, '[GF]HunabKu', 'SESSION', 0, 50, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-25 14:03:09');
INSERT INTO `hunter_player_stats_snapshot` VALUES (330, 4, '[GF]HunabKu', 'SESSION', 0, 50, 0, 1, 0, 0, 0, 0, NULL, 0, '2026-01-25 14:07:34');
INSERT INTO `hunter_player_stats_snapshot` VALUES (331, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 0, 0, 0, 0, 0, NULL, 0, '2026-01-25 14:19:19');
INSERT INTO `hunter_player_stats_snapshot` VALUES (332, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-25 14:24:19');
INSERT INTO `hunter_player_stats_snapshot` VALUES (333, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-25 14:25:41');
INSERT INTO `hunter_player_stats_snapshot` VALUES (334, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-25 14:37:27');
INSERT INTO `hunter_player_stats_snapshot` VALUES (335, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-25 14:42:27');
INSERT INTO `hunter_player_stats_snapshot` VALUES (336, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-25 14:47:27');
INSERT INTO `hunter_player_stats_snapshot` VALUES (337, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-25 14:52:27');
INSERT INTO `hunter_player_stats_snapshot` VALUES (338, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-25 14:57:27');
INSERT INTO `hunter_player_stats_snapshot` VALUES (339, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-25 15:02:27');
INSERT INTO `hunter_player_stats_snapshot` VALUES (340, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-25 15:07:27');
INSERT INTO `hunter_player_stats_snapshot` VALUES (341, 4, '[GF]HunabKu', 'SESSION', 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-25 15:08:44');
INSERT INTO `hunter_player_stats_snapshot` VALUES (342, 4, '[GF]HunabKu', 'SESSION', 1, 0, 0, 2, 0, 0, 0, 0, NULL, 0, '2026-01-25 15:20:11');
INSERT INTO `hunter_player_stats_snapshot` VALUES (343, 4, '[GF]HunabKu', 'SESSION', 1, 267, 1, 3, 0, 0, 0, 0, NULL, 0, '2026-01-25 15:25:11');
INSERT INTO `hunter_player_stats_snapshot` VALUES (344, 4, '[GF]HunabKu', 'SESSION', 1, 284, 1, 4, 0, 0, 0, 0, NULL, 0, '2026-01-25 15:30:11');
INSERT INTO `hunter_player_stats_snapshot` VALUES (345, 4, '[GF]HunabKu', 'SESSION', 1, 284, 1, 4, 0, 0, 0, 0, NULL, 0, '2026-01-25 15:35:11');
INSERT INTO `hunter_player_stats_snapshot` VALUES (346, 4, '[GF]HunabKu', 'SESSION', 1, 284, 1, 4, 0, 0, 0, 0, NULL, 0, '2026-01-25 15:40:11');
INSERT INTO `hunter_player_stats_snapshot` VALUES (347, 4, '[GF]HunabKu', 'SESSION', 1, 1233, 4, 4, 0, 0, 0, 0, NULL, 0, '2026-01-25 15:45:11');
INSERT INTO `hunter_player_stats_snapshot` VALUES (348, 4, '[GF]HunabKu', 'SESSION', 1, 1233, 4, 4, 0, 0, 0, 0, NULL, 0, '2026-01-25 15:45:57');
INSERT INTO `hunter_player_stats_snapshot` VALUES (349, 4, '[GF]HunabKu', 'SESSION', 0, 1233, 4, 4, 0, 0, 0, 0, NULL, 0, '2026-01-25 15:50:16');
INSERT INTO `hunter_player_stats_snapshot` VALUES (350, 4, '[GF]HunabKu', 'SESSION', 0, 599, 3, 0, 0, 0, 0, 0, NULL, 0, '2026-01-26 18:57:17');
INSERT INTO `hunter_player_stats_snapshot` VALUES (351, 4, '[GF]HunabKu', 'SESSION', 0, 599, 3, 0, 0, 0, 0, 0, NULL, 0, '2026-01-26 19:02:17');
INSERT INTO `hunter_player_stats_snapshot` VALUES (352, 4, '[GF]HunabKu', 'SESSION', 0, 599, 3, 0, 0, 0, 0, 0, NULL, 0, '2026-01-26 19:02:50');
INSERT INTO `hunter_player_stats_snapshot` VALUES (353, 4, '[GF]HunabKu', 'SESSION', 0, 516, 2, 0, 0, 0, 0, 0, NULL, 0, '2026-01-26 19:14:27');
INSERT INTO `hunter_player_stats_snapshot` VALUES (354, 4, '[GF]HunabKu', 'SESSION', 0, 516, 2, 0, 0, 0, 0, 0, NULL, 0, '2026-01-26 19:15:13');
INSERT INTO `hunter_player_stats_snapshot` VALUES (355, 4, '[GF]HunabKu', 'SESSION', 0, 1155, 4, 0, 0, 0, 0, 0, NULL, 0, '2026-01-26 19:20:16');
INSERT INTO `hunter_player_stats_snapshot` VALUES (356, 4, '[GF]HunabKu', 'SESSION', 0, 1733, 5, 0, 0, 0, 0, 0, NULL, 0, '2026-01-26 19:22:02');
INSERT INTO `hunter_player_stats_snapshot` VALUES (357, 4, '[GF]HunabKu', 'SESSION', 0, 518, 2, 0, 0, 0, 0, 0, NULL, 0, '2026-01-26 19:37:32');

-- ----------------------------
-- Table structure for hunter_player_trials
-- ----------------------------
DROP TABLE IF EXISTS `hunter_player_trials`;
CREATE TABLE `hunter_player_trials`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `player_id` int NOT NULL,
  `trial_id` int NOT NULL,
  `status` enum('locked','available','in_progress','completed','failed') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'locked',
  `boss_kills` int NOT NULL DEFAULT 0,
  `metin_kills` int NOT NULL DEFAULT 0,
  `fracture_seals` int NOT NULL DEFAULT 0,
  `chest_opens` int NOT NULL DEFAULT 0,
  `daily_missions` int NOT NULL DEFAULT 0,
  `started_at` timestamp NULL DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL COMMENT 'Se ha time limit',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_player_trial`(`player_id` ASC, `trial_id` ASC) USING BTREE,
  INDEX `trial_id`(`trial_id` ASC) USING BTREE,
  INDEX `idx_player_status`(`player_id` ASC, `status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hunter_player_trials
-- ----------------------------
INSERT INTO `hunter_player_trials` VALUES (18, 4, 1, 'completed', 3, 6, 0, 0, 0, '2025-12-30 11:41:12', '2025-12-30 11:46:42', NULL);
INSERT INTO `hunter_player_trials` VALUES (19, 4, 2, 'completed', 33, 11, 78, 37, 0, '2025-12-31 19:51:00', '2026-01-24 20:01:54', NULL);
INSERT INTO `hunter_player_trials` VALUES (20, 4, 3, 'in_progress', 4, 3, 5, 16, 0, '2026-01-24 23:01:12', NULL, NULL);

-- ----------------------------
-- Table structure for hunter_quest_achievements_config
-- ----------------------------
DROP TABLE IF EXISTS `hunter_quest_achievements_config`;
CREATE TABLE `hunter_quest_achievements_config`  (
  `id` int NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `type` int NOT NULL DEFAULT 1 COMMENT '1=Kill, 2=Glory, 3=Fracture, 4=Chest, 5=Metin, 6=Boss, 7=Mission, 8=Trial, 9=Streak, 10=Rank',
  `requirement` int NOT NULL DEFAULT 1,
  `reward_vnum` int NOT NULL DEFAULT 0,
  `reward_count` int NOT NULL DEFAULT 0,
  `reward_glory` int NOT NULL DEFAULT 0,
  `category` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'COMBAT',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_type`(`type` ASC) USING BTREE,
  INDEX `idx_enabled`(`enabled` ASC) USING BTREE,
  INDEX `idx_category`(`category` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hunter_quest_achievements_config
-- ----------------------------
INSERT INTO `hunter_quest_achievements_config` VALUES (101, 'Primo Sangue', 1, 1, 0, 0, 50, 'COMBAT', 'Uccidi il tuo primo nemico come Hunter', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (102, 'Apprendista Cacciatore', 1, 10, 0, 0, 75, 'COMBAT', 'Uccidi 10 nemici', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (103, 'Cacciatore Novizio', 1, 25, 80030, 1, 100, 'COMBAT', 'Uccidi 25 nemici', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (104, 'Cacciatore Competente', 1, 50, 80030, 2, 150, 'COMBAT', 'Uccidi 50 nemici', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (105, 'Cacciatore Esperto', 1, 100, 80030, 3, 250, 'COMBAT', 'Uccidi 100 nemici', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (106, 'Cacciatore Abile', 1, 250, 80031, 1, 400, 'COMBAT', 'Uccidi 250 nemici', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (107, 'Cacciatore Veterano', 1, 500, 80031, 2, 600, 'COMBAT', 'Uccidi 500 nemici', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (108, 'Macchina da Guerra', 1, 1000, 80031, 3, 1000, 'COMBAT', 'Uccidi 1.000 nemici', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (109, 'Massacratore', 1, 2500, 80032, 1, 1800, 'COMBAT', 'Uccidi 2.500 nemici', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (110, 'Signore della Morte', 1, 5000, 80032, 2, 3000, 'COMBAT', 'Uccidi 5.000 nemici', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (111, 'Annientatore', 1, 10000, 80032, 3, 5000, 'COMBAT', 'Uccidi 10.000 nemici', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (112, 'Flagello dei Mondi', 1, 25000, 80032, 5, 10000, 'COMBAT', 'Uccidi 25.000 nemici', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (113, 'Apocalisse Incarnata', 1, 50000, 50168, 1, 20000, 'COMBAT', 'Uccidi 50.000 nemici', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (114, 'Distruttore di Realta', 1, 100000, 50168, 3, 50000, 'COMBAT', 'Uccidi 100.000 nemici', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (201, 'Inizio del Viaggio', 2, 100, 0, 0, 32, 'GLORY', 'Accumula 100 Gloria', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (202, 'Primi Passi', 2, 500, 0, 0, 65, 'GLORY', 'Accumula 500 Gloria', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (203, 'Gloria Nascente', 2, 1000, 80030, 1, 132, 'GLORY', 'Accumula 1.000 Gloria', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (204, 'Gloria Crescente', 2, 2500, 80030, 2, 264, 'GLORY', 'Accumula 2.500 Gloria', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (205, 'Gloria Brillante', 2, 5000, 80030, 3, 462, 'GLORY', 'Accumula 5.000 Gloria', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (206, 'Gloria Splendente', 2, 10000, 80030, 5, 793, 'GLORY', 'Accumula 10.000 Gloria', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (207, 'Gloria Radiante', 2, 25000, 80031, 2, 1322, 'GLORY', 'Accumula 25.000 Gloria', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (208, 'Gloria Fulgida', 2, 50000, 80031, 3, 2380, 'GLORY', 'Accumula 50.000 Gloria', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (209, 'Gloria Maestosa', 2, 100000, 80031, 5, 3967, 'GLORY', 'Accumula 100.000 Gloria', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (210, 'Gloria Leggendaria', 2, 200000, 80032, 3, 6612, 'GLORY', 'Accumula 200.000 Gloria', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (211, 'Gloria Mitica', 2, 350000, 80032, 5, 10580, 'GLORY', 'Accumula 350.000 Gloria', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (212, 'Gloria del Monarca', 2, 500000, 80032, 10, 15870, 'GLORY', 'Accumula 500.000 Gloria', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (213, 'Gloria Celestiale', 2, 750000, 50168, 1, 23805, 'GLORY', 'Accumula 750.000 Gloria', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (214, 'Gloria Infinita', 2, 1000000, 50168, 2, 33062, 'GLORY', 'Accumula 1.000.000 Gloria', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (215, 'Gloria Trascendente', 2, 2000000, 50168, 5, 66125, 'GLORY', 'Accumula 2.000.000 Gloria', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (301, 'Prima Frattura', 3, 1, 0, 0, 50, 'FRACTURE', 'Sigilla la tua prima frattura', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (302, 'Sigillatore Novizio', 3, 5, 80030, 1, 100, 'FRACTURE', 'Sigilla 5 fratture', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (303, 'Sigillatore', 3, 10, 80030, 2, 200, 'FRACTURE', 'Sigilla 10 fratture', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (304, 'Sigillatore Esperto', 3, 25, 80030, 3, 350, 'FRACTURE', 'Sigilla 25 fratture', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (305, 'Guardiano dei Portali', 3, 50, 80031, 1, 600, 'FRACTURE', 'Sigilla 50 fratture', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (306, 'Domatore di Fratture', 3, 100, 80031, 2, 1000, 'FRACTURE', 'Sigilla 100 fratture', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (307, 'Maestro Sigillatore', 3, 200, 80031, 3, 1800, 'FRACTURE', 'Sigilla 200 fratture', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (308, 'Custode Dimensionale', 3, 350, 80032, 2, 3000, 'FRACTURE', 'Sigilla 350 fratture', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (309, 'Guardiano Supremo', 3, 500, 80032, 3, 4500, 'FRACTURE', 'Sigilla 500 fratture', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (310, 'Stabilizzatore Cosmico', 3, 750, 80032, 5, 7000, 'FRACTURE', 'Sigilla 750 fratture', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (311, 'Signore delle Fratture', 3, 1000, 50164, 2, 10000, 'FRACTURE', 'Sigilla 1.000 fratture', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (312, 'Tessitore di Realta', 3, 2000, 50164, 5, 20000, 'FRACTURE', 'Sigilla 2.000 fratture', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (401, 'Primo Tesoro', 4, 1, 0, 0, 30, 'CHEST', 'Apri il tuo primo baule', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (402, 'Cercatore', 4, 10, 80030, 1, 80, 'CHEST', 'Apri 10 bauli', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (403, 'Cercatore di Tesori', 4, 25, 80030, 2, 150, 'CHEST', 'Apri 25 bauli', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (404, 'Saccheggiatore', 4, 50, 80030, 3, 280, 'CHEST', 'Apri 50 bauli', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (405, 'Saccheggiatore Esperto', 4, 100, 80030, 5, 500, 'CHEST', 'Apri 100 bauli', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (406, 'Cacciatore di Fortune', 4, 200, 80031, 2, 900, 'CHEST', 'Apri 200 bauli', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (407, 'Maestro del Bottino', 4, 350, 80031, 3, 1500, 'CHEST', 'Apri 350 bauli', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (408, 'Collezionista Leggendario', 4, 500, 80031, 5, 2200, 'CHEST', 'Apri 500 bauli', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (409, 'Re dei Tesori', 4, 750, 80032, 2, 3500, 'CHEST', 'Apri 750 bauli', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (410, 'Imperatore del Bottino', 4, 1000, 80032, 3, 5000, 'CHEST', 'Apri 1.000 bauli', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (411, 'Drago dOro', 4, 1500, 80032, 5, 7500, 'CHEST', 'Apri 1.500 bauli', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (412, 'Avatar dellAvarizia', 4, 2500, 50163, 3, 12000, 'CHEST', 'Apri 2.500 bauli', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (501, 'Primo Metin', 5, 1, 0, 0, 50, 'METIN', 'Distruggi il tuo primo Metin', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (502, 'Distruttore di Pietre', 5, 10, 80030, 1, 120, 'METIN', 'Distruggi 10 Metin', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (503, 'Frantumatore', 5, 25, 80030, 2, 250, 'METIN', 'Distruggi 25 Metin', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (504, 'Frantumatore Esperto', 5, 50, 80030, 3, 450, 'METIN', 'Distruggi 50 Metin', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (505, 'Devastatore di Metin', 5, 100, 80031, 1, 800, 'METIN', 'Distruggi 100 Metin', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (506, 'Distruttore Implacabile', 5, 200, 80031, 2, 1400, 'METIN', 'Distruggi 200 Metin', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (507, 'Terrore dei Metin', 5, 350, 80031, 3, 2200, 'METIN', 'Distruggi 350 Metin', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (508, 'Araldo della Distruzione', 5, 500, 80032, 2, 3200, 'METIN', 'Distruggi 500 Metin', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (509, 'Flagello dei Metin', 5, 750, 80032, 3, 4800, 'METIN', 'Distruggi 750 Metin', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (510, 'Annientatore di Pietre', 5, 1000, 80032, 5, 7000, 'METIN', 'Distruggi 1.000 Metin', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (511, 'Cataclisma Vivente', 5, 2000, 50167, 3, 15000, 'METIN', 'Distruggi 2.000 Metin', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (601, 'Primo Boss', 6, 1, 0, 0, 100, 'BOSS', 'Uccidi il tuo primo Boss', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (602, 'Sfidante', 6, 5, 80030, 2, 200, 'BOSS', 'Uccidi 5 Boss', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (603, 'Uccisore di Bestie', 6, 10, 80030, 3, 350, 'BOSS', 'Uccidi 10 Boss', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (604, 'Cacciatore di Boss', 6, 25, 80031, 1, 600, 'BOSS', 'Uccidi 25 Boss', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (605, 'Cacciatore Elite', 6, 50, 80031, 2, 1000, 'BOSS', 'Uccidi 50 Boss', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (606, 'Sterminatore', 6, 100, 80031, 3, 1800, 'BOSS', 'Uccidi 100 Boss', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (607, 'Sterminatore Supremo', 6, 200, 80032, 2, 3000, 'BOSS', 'Uccidi 200 Boss', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (608, 'Campione dei Boss', 6, 350, 80032, 3, 5000, 'BOSS', 'Uccidi 350 Boss', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (609, 'Leggenda Vivente', 6, 500, 80032, 5, 7500, 'BOSS', 'Uccidi 500 Boss', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (610, 'Dio della Caccia', 6, 750, 50164, 2, 11000, 'BOSS', 'Uccidi 750 Boss', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (611, 'Ombra della Morte', 6, 1000, 50168, 1, 15000, 'BOSS', 'Uccidi 1.000 Boss', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (612, 'Nemesi degli Dei', 6, 2000, 50168, 3, 30000, 'BOSS', 'Uccidi 2.000 Boss', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (701, 'Prima Missione', 7, 1, 0, 0, 50, 'MISSION', 'Completa la tua prima missione', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (702, 'Lavoratore', 7, 5, 80030, 1, 100, 'MISSION', 'Completa 5 missioni', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (703, 'Lavoratore Affidabile', 7, 15, 80030, 2, 200, 'MISSION', 'Completa 15 missioni', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (704, 'Hunter Diligente', 7, 30, 80030, 3, 350, 'MISSION', 'Completa 30 missioni', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (705, 'Hunter Dedito', 7, 50, 80030, 5, 550, 'MISSION', 'Completa 50 missioni', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (706, 'Professionista', 7, 100, 80031, 2, 1000, 'MISSION', 'Completa 100 missioni', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (707, 'Maestro delle Missioni', 7, 200, 80031, 3, 1800, 'MISSION', 'Completa 200 missioni', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (708, 'Campione della Gilda', 7, 350, 80031, 5, 3000, 'MISSION', 'Completa 350 missioni', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (709, 'Leggenda della Gilda', 7, 500, 80032, 3, 4500, 'MISSION', 'Completa 500 missioni', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (710, 'Eroe della Gilda', 7, 750, 80032, 5, 7000, 'MISSION', 'Completa 750 missioni', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (711, 'Hunter Supremo', 7, 1000, 50162, 2, 10000, 'MISSION', 'Completa 1.000 missioni', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (712, 'Pilastro della Gilda', 7, 2000, 50162, 5, 20000, 'MISSION', 'Completa 2.000 missioni', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (801, 'Prima Prova', 8, 1, 0, 0, 100, 'TRIAL', 'Completa la tua prima Prova', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (802, 'Sfidante delle Prove', 8, 3, 80030, 2, 200, 'TRIAL', 'Completa 3 Prove', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (803, 'Veterano delle Prove', 8, 7, 80030, 3, 400, 'TRIAL', 'Completa 7 Prove', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (804, 'Esperto delle Prove', 8, 15, 80031, 1, 700, 'TRIAL', 'Completa 15 Prove', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (805, 'Maestro delle Prove', 8, 25, 80031, 2, 1100, 'TRIAL', 'Completa 25 Prove', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (806, 'Campione delle Prove', 8, 50, 80031, 3, 2000, 'TRIAL', 'Completa 50 Prove', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (807, 'Dominatore delle Prove', 8, 75, 80032, 2, 3200, 'TRIAL', 'Completa 75 Prove', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (808, 'Conquistatore delle Prove', 8, 100, 80032, 3, 4500, 'TRIAL', 'Completa 100 Prove', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (809, 'Leggenda delle Prove', 8, 150, 80032, 5, 7000, 'TRIAL', 'Completa 150 Prove', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (810, 'Essere Trascendente', 8, 250, 50168, 1, 12000, 'TRIAL', 'Completa 250 Prove', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (811, 'Avatar della Perfezione', 8, 500, 50168, 3, 25000, 'TRIAL', 'Completa 500 Prove', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (901, 'Primo Giorno', 9, 1, 0, 0, 25, 'STREAK', 'Inizia la tua prima streak', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (902, 'Costanza', 9, 3, 80030, 1, 100, 'STREAK', 'Streak di 3 giorni', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (903, 'Dedizione', 9, 7, 80030, 2, 250, 'STREAK', 'Streak di 7 giorni', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (904, 'Impegno', 9, 14, 80030, 3, 500, 'STREAK', 'Streak di 14 giorni', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (905, 'Perseveranza', 9, 21, 80031, 1, 800, 'STREAK', 'Streak di 21 giorni', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (906, 'Disciplina', 9, 30, 80031, 2, 1200, 'STREAK', 'Streak di 30 giorni', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (907, 'Disciplina di Ferro', 9, 45, 80031, 3, 1800, 'STREAK', 'Streak di 45 giorni', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (908, 'Volonta Indomabile', 9, 60, 80032, 2, 2800, 'STREAK', 'Streak di 60 giorni', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (909, 'Spirito Infrangibile', 9, 90, 80032, 3, 4500, 'STREAK', 'Streak di 90 giorni', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (910, 'Hunter Eterno', 9, 120, 80032, 5, 7000, 'STREAK', 'Streak di 120 giorni', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (911, 'Immortale', 9, 180, 50162, 2, 12000, 'STREAK', 'Streak di 180 giorni', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (912, 'Leggenda Eterna', 9, 365, 50168, 2, 25000, 'STREAK', 'Streak di 365 giorni', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (1001, 'Risveglio', 10, 1, 0, 0, 100, 'RANK', 'Diventa un Hunter E-Rank', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (1002, 'Hunter D-Rank', 10, 2, 80030, 5, 300, 'RANK', 'Raggiungi il rango D', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (1003, 'Hunter C-Rank', 10, 3, 80031, 2, 600, 'RANK', 'Raggiungi il rango C', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (1004, 'Hunter B-Rank', 10, 4, 80031, 5, 1200, 'RANK', 'Raggiungi il rango B', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (1005, 'Hunter A-Rank', 10, 5, 80032, 3, 2500, 'RANK', 'Raggiungi il rango A', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (1006, 'Hunter S-Rank', 10, 6, 80032, 7, 5000, 'RANK', 'Raggiungi il rango S', 1);
INSERT INTO `hunter_quest_achievements_config` VALUES (1007, 'MONARCA', 10, 7, 50168, 5, 15000, 'RANK', 'Ascendi al rango MONARCA', 1);

-- ----------------------------
-- Table structure for hunter_quest_config
-- ----------------------------
DROP TABLE IF EXISTS `hunter_quest_config`;
CREATE TABLE `hunter_quest_config`  (
  `config_key` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `config_value` int NULL DEFAULT 0,
  PRIMARY KEY (`config_key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hunter_quest_config
-- ----------------------------
INSERT INTO `hunter_quest_config` VALUES ('bonus_all_missions_complete', 50);
INSERT INTO `hunter_quest_config` VALUES ('bonus_speed_kill_multiplier', 2);
INSERT INTO `hunter_quest_config` VALUES ('challenge_time_seconds', 60);
INSERT INTO `hunter_quest_config` VALUES ('conversion_gloria_to_credits', 10);
INSERT INTO `hunter_quest_config` VALUES ('daily_reset_hour', 0);
INSERT INTO `hunter_quest_config` VALUES ('emergency_chance_percent', 10);
INSERT INTO `hunter_quest_config` VALUES ('first_boss_bonus', 50);
INSERT INTO `hunter_quest_config` VALUES ('first_chest_bonus', 50);
INSERT INTO `hunter_quest_config` VALUES ('first_fracture_bonus', 50);
INSERT INTO `hunter_quest_config` VALUES ('first_metin_bonus', 30);
INSERT INTO `hunter_quest_config` VALUES ('rank_threshold_A', 150000);
INSERT INTO `hunter_quest_config` VALUES ('rank_threshold_B', 50000);
INSERT INTO `hunter_quest_config` VALUES ('rank_threshold_C', 10000);
INSERT INTO `hunter_quest_config` VALUES ('rank_threshold_D', 2000);
INSERT INTO `hunter_quest_config` VALUES ('rank_threshold_E', 0);
INSERT INTO `hunter_quest_config` VALUES ('rank_threshold_N', 1500000);
INSERT INTO `hunter_quest_config` VALUES ('rank_threshold_S', 500000);
INSERT INTO `hunter_quest_config` VALUES ('rival_range_chests', 50);
INSERT INTO `hunter_quest_config` VALUES ('rival_range_daily', 500);
INSERT INTO `hunter_quest_config` VALUES ('rival_range_fractures', 20);
INSERT INTO `hunter_quest_config` VALUES ('rival_range_metins', 50);
INSERT INTO `hunter_quest_config` VALUES ('rival_range_total', 50000);
INSERT INTO `hunter_quest_config` VALUES ('rival_range_weekly', 2000);
INSERT INTO `hunter_quest_config` VALUES ('seal_fracture_bonus', 200);
INSERT INTO `hunter_quest_config` VALUES ('spawn_threshold_normal', 500);
INSERT INTO `hunter_quest_config` VALUES ('speedkill_boss_bonus_pts', 200);
INSERT INTO `hunter_quest_config` VALUES ('speedkill_boss_seconds', 60);
INSERT INTO `hunter_quest_config` VALUES ('speedkill_metin_bonus_pts', 80);
INSERT INTO `hunter_quest_config` VALUES ('speedkill_metin_seconds', 300);
INSERT INTO `hunter_quest_config` VALUES ('streak_bonus_30days', 12);
INSERT INTO `hunter_quest_config` VALUES ('streak_bonus_3days', 3);
INSERT INTO `hunter_quest_config` VALUES ('streak_bonus_7days', 7);
INSERT INTO `hunter_quest_config` VALUES ('streak_days_tier1', 3);
INSERT INTO `hunter_quest_config` VALUES ('streak_days_tier2', 7);
INSERT INTO `hunter_quest_config` VALUES ('streak_days_tier3', 30);
INSERT INTO `hunter_quest_config` VALUES ('timer_reset_check', 60);
INSERT INTO `hunter_quest_config` VALUES ('timer_tips_random', 90);
INSERT INTO `hunter_quest_config` VALUES ('timer_update_stats', 60);
INSERT INTO `hunter_quest_config` VALUES ('welcome_offline_seconds', 10);
INSERT INTO `hunter_quest_config` VALUES ('whatif_chance_percent', 10);

-- ----------------------------
-- Table structure for hunter_quest_emergencies
-- ----------------------------
DROP TABLE IF EXISTS `hunter_quest_emergencies`;
CREATE TABLE `hunter_quest_emergencies`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `description` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `duration_seconds` int NULL DEFAULT 60,
  `target_vnum` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '0',
  `target_count` int NULL DEFAULT 10,
  `reward_points` int NULL DEFAULT 100,
  `reward_item_vnum` int NULL DEFAULT 0,
  `reward_item_count` int NULL DEFAULT 0,
  `enabled` int NULL DEFAULT 1,
  `min_level` int NULL DEFAULT 1,
  `max_level` int NULL DEFAULT 120,
  `difficulty` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT 'NORMAL',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 121 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hunter_quest_emergencies
-- ----------------------------
INSERT INTO `hunter_quest_emergencies` VALUES (14, 'Predatore Apex', 'SYSTEM MESSAGE: I Signori tremano al tuo passaggio. La tua presenza deve diventare un incubo per ogni creatura dominante. Obiettivo: Elimina 8 Capitani.', 720, '591', 8, 200, 0, 0, 1, 14, 25, 'EXTREME');
INSERT INTO `hunter_quest_emergencies` VALUES (10, 'Dominio dello Spazio', 'SYSTEM MESSAGE: Il mondo si piega al tuo volere. Non limitarti a rompere le rocce. Cancella la loro esistenza. Obiettivo: Distruggi 15 Metin della Gelosia.', 450, '8007', 15, 250, 0, 0, 1, 15, 25, 'GOD_MODE');
INSERT INTO `hunter_quest_emergencies` VALUES (9, 'Collasso del Gate', 'SYSTEM MESSAGE: Attenzione! La stabilità dimensionale è allo 0%. Una pioggia di meteoriti magici sta per distruggere la zona. Obiettivo: Distruggi 12 Metin dell\'Oscurità.', 360, '8006', 12, 200, 0, 0, 1, 12, 25, 'EXTREME');
INSERT INTO `hunter_quest_emergencies` VALUES (8, 'Cristalli Corrotti', 'SYSTEM MESSAGE: Densità del mana: Critica. Queste Metin sono dure come il diamante e protette da una magia antica. Obiettivo: Distruggi 9 Metin della Gelosia.', 270, '8007', 9, 150, 0, 0, 1, 10, 25, 'HARD');
INSERT INTO `hunter_quest_emergencies` VALUES (7, 'Scheggia di Mana', 'SYSTEM MESSAGE: Rilevata una piccola anomalia. Una roccia sta emettendo mana instabile. Obiettivo: Distruggi 3 Metin dell\'Oscurità', 90, '8006', 3, 50, 0, 0, 1, 5, 25, 'EASY');
INSERT INTO `hunter_quest_emergencies` VALUES (6, 'Frattura Dimensionale', 'SYSTEM MESSAGE: Il cielo si sta crepando. Diverse pietre stanno cadendo nella tua area. Obiettivo: Distruggi 6 Metin della Gelosia.', 180, '8007', 6, 100, 0, 0, 1, 8, 25, 'NORMAL');
INSERT INTO `hunter_quest_emergencies` VALUES (5, 'Il Rituale dell\'Ombra', 'SYSTEM MESSAGE: Sorgi. Per diventare il Monarca, ti servono soldati. Crea una montagna di cadaveri e reclamali come tua armata immortale. Obiettivo: Uccidi 960 Mostri. ', 90, '0', 960, 250, 0, 0, 1, 90, 200, 'GOD_MODE');
INSERT INTO `hunter_quest_emergencies` VALUES (13, 'Maratona del Sangue', 'SYSTEM MESSAGE: Resistenza Hunter richiesta: Alta. Non fermarti a un solo trofeo. Continua a cacciare finché le tue armi non saranno smussate. Obiettivo: Elimina 5 Capitani', 450, '591', 5, 150, 0, 0, 1, 13, 25, 'HARD');
INSERT INTO `hunter_quest_emergencies` VALUES (12, 'Sterminatore di Guardiani', 'SYSTEM MESSAGE: L\'ecosistema dei Gate è instabile. Troppi mostri leader stanno emergendo. Obiettivo: Elimina 3 Capitani.', 270, '591', 3, 100, 0, 0, 1, 12, 25, 'NORMAL');
INSERT INTO `hunter_quest_emergencies` VALUES (11, 'Caccia Grossa', 'SYSTEM MESSAGE: Nuova Quest giornaliera. Un Hunter deve saper distinguere il capo dal gregge. Obiettivo: Elimina 1 Capitano.', 90, '591', 1, 50, 0, 0, 1, 10, 25, 'EASY');
INSERT INTO `hunter_quest_emergencies` VALUES (4, 'Calamità Nazionale', 'SYSTEM MESSAGE: Livello di minaccia: Catastrofico. L\'Associazione richiede un intervento immediato. Obiettivo: Uccidi 480 Mostri.', 75, '0', 480, 200, 0, 0, 1, 75, 200, 'EXTREME');
INSERT INTO `hunter_quest_emergencies` VALUES (3, 'Sopravvivenza nel Gate Rosso', 'SYSTEM MESSAGE: Sei in territorio ostile. Non c\'è via di fuga. L\'unica opzione è massacrare ogni creatura vivente per aprire l\'uscita. Obiettivo: Uccidi 240 Mostri', 60, '0', 240, 150, 0, 0, 1, 30, 200, 'HARD');
INSERT INTO `hunter_quest_emergencies` VALUES (2, 'Dungeon Break Minore', 'SYSTEM MESSAGE: Rilevata attività ostile. Un portale sta per rompersi. I mostri stanno sciamando fuori. Obiettivo: Uccidi 120 Mostri.', 45, '0', 120, 100, 0, 0, 1, 15, 200, 'NORMAL');
INSERT INTO `hunter_quest_emergencies` VALUES (1, 'Riscaldamento Mattutino', 'SYSTEM MESSAGE: Missione giornaliera accettata. Un Hunter deve mantenere i riflessi pronti. Obiettivo: Uccidi 60 Mostri.', 30, '0', 60, 50, 0, 0, 1, 5, 200, 'EASY');
INSERT INTO `hunter_quest_emergencies` VALUES (15, 'Il Collezionista di Teste', 'SYSTEM MESSAGE: Nessuno osa alzare lo sguardo. Per un Monarca, i Boss sono solo pedine da abbattere. Obiettivo: Elimina 15 Capitani.', 1080, '591', 12, 250, 0, 0, 1, 15, 25, 'GOD_MODE');
INSERT INTO `hunter_quest_emergencies` VALUES (16, 'Scheggia di Mana', 'SYSTEM MESSAGE: \"Rilevata una distorsione minore.\" Piccole pietre oscure stanno emergendo dal terreno paludoso. Obiettivo: Distruggi 3 Metin dell\'Ombra.', 60, '8009', 3, 50, 0, 0, 1, 30, 50, 'EASY');
INSERT INTO `hunter_quest_emergencies` VALUES (17, 'Frattura Dimensionale', 'SYSTEM MESSAGE: \"I tamburi di guerra risuonano.\" Queste non sono semplici rocce, ma totem evocati. Obiettivo: Distruggi 6 Metin dell\'Anima.', 120, '8008', 6, 100, 0, 0, 1, 30, 50, 'NORMAL');
INSERT INTO `hunter_quest_emergencies` VALUES (18, 'Cristalli Corrotti', 'SYSTEM MESSAGE: Allarme: Energia oscura concentrata. Gli Esoterici hanno piazzato potenti sigilli. Obiettivo: Distruggi 9 Metin dell\'Ombra.', 180, '8009', 9, 150, 0, 0, 1, 30, 50, 'HARD');
INSERT INTO `hunter_quest_emergencies` VALUES (19, 'Collasso del Gate', 'SYSTEM MESSAGE: \"La terra stessa sta urlando.\" Rocce gigantesche, pulsanti di mana viola, stanno assorbendo la forza vitale della valle. Obiettivo: Distruggi 12 Metin dell\'Anima.', 240, '8008', 12, 200, 0, 0, 1, 30, 50, 'EXTREME');
INSERT INTO `hunter_quest_emergencies` VALUES (20, 'Dominio dello Spazio', 'SYSTEM MESSAGE: \"Il dominio assoluto è a rischio.\" Queste meteore sono la fonte del potere oscuro che pervade la valle. Obiettivo: Distruggi 15 Metin dell\'Ombre.', 300, '8009', 15, 250, 0, 0, 1, 30, 50, 'GOD_MODE');
INSERT INTO `hunter_quest_emergencies` VALUES (21, 'Caccia Grossa', 'SYSTEM MESSAGE: Nuova taglia disponibile. Un Capo Orco minore sta radunando le truppe ai confini della valle. Obiettivo: Uccidi 1 Capo Orco.', 90, '691', 1, 50, 0, 0, 1, 40, 60, 'EASY');
INSERT INTO `hunter_quest_emergencies` VALUES (22, 'Sterminatore di Guardiani', 'SYSTEM MESSAGE: \"Il leader è sceso in campo.\" I Capi Orco stanno coordinando gli assalti dal centro della mappa. Obiettivo: Uccidi 3 Capi Orco.', 270, '691', 3, 100, 0, 0, 1, 42, 60, 'NORMAL');
INSERT INTO `hunter_quest_emergencies` VALUES (23, 'Maratona del Sangue', 'SYSTEM MESSAGE: Pericolo: Nemico d\'élite. I Capi Orco Rinati, benedetti dagli spiriti oscuri del tempio, stanno seminando il panico. Obiettivo: Uccidi 5 Capi Orco.', 450, '691', 5, 150, 0, 0, 1, 43, 60, 'HARD');
INSERT INTO `hunter_quest_emergencies` VALUES (24, 'Predatore Apex', 'SYSTEM MESSAGE: \"Una forza inarrestabile.\" Un\'intera legione di Capi Orco sta marciando verso il Tempio. Obiettivo: Uccidi 8 Capi Orco.', 720, '691', 8, 200, 0, 0, 1, 44, 60, 'EXTREME');
INSERT INTO `hunter_quest_emergencies` VALUES (25, 'Il Collezionista di Teste', 'SYSTEM MESSAGE: \"Il Re della Valle è qui.\" Non stai affrontando semplici mostri, ma avatar della guerra pura. Obiettivo: Uccidi 12 Capi Orco.', 1080, '691', 12, 250, 0, 0, 1, 45, 60, 'GOD_MODE');
INSERT INTO `hunter_quest_emergencies` VALUES (26, 'Scheggia di Mana', 'SYSTEM MESSAGE: \"Rilevata una distorsione minore.\" Frammenti della Metin della Morte sono emersi dal ghiaccio superficiale. Obiettivo: Distruggi 3 Metin della Morte.', 60, '8013', 3, 50, 0, 0, 1, 61, 74, 'EASY');
INSERT INTO `hunter_quest_emergencies` VALUES (27, 'Frattura Dimensionale', 'SYSTEM MESSAGE: \"Un\'ombra si allunga sulla neve.\" Le Metin del Diavolo stanno pulsando di energia oscura. Obiettivo: Distruggi 6 Metin del Diavolo.', 120, '8011', 6, 100, 0, 0, 1, 61, 74, 'NORMAL');
INSERT INTO `hunter_quest_emergencies` VALUES (28, 'Cristalli Corrotti', 'SYSTEM MESSAGE: Allarme: Picco di energia. Una concentrazione anomala di Metin della Morte sta trasformando la zona in un cimitero. Obiettivo: Distruggi 9 Metin della Morte.', 180, '8013', 9, 150, 0, 0, 1, 61, 74, 'HARD');
INSERT INTO `hunter_quest_emergencies` VALUES (29, 'Collasso del Gate', 'SYSTEM MESSAGE: \"La montagna sta urlando.\" Enormi Metin del Diavolo sono cadute dal cielo, creando crateri nel permafrost. Obiettivo: Distruggi 12 Metin del Diavolo.', 240, '8011', 12, 200, 0, 0, 1, 61, 74, 'EXTREME');
INSERT INTO `hunter_quest_emergencies` VALUES (30, 'Dominio dello Spazio', 'SYSTEM MESSAGE: \"L\'aldilà ha aperto le sue porte.\" Questa è la fonte suprema. La Metin della Morte definitiva si è manifestata. Obiettivo: Distruggi 15 Metin della Morte.', 300, '8013', 15, 250, 0, 0, 1, 61, 74, 'GOD_MODE');
INSERT INTO `hunter_quest_emergencies` VALUES (31, 'Caccia Grossa', 'SYSTEM MESSAGE: Nuova taglia disponibile. Un esemplare giovane di Nove Code è stato avvistato lontano dalla tana. Obiettivo: Uccidi 1 Nove Code.', 90, '1901', 1, 50, 0, 0, 1, 61, 74, 'EASY');
INSERT INTO `hunter_quest_emergencies` VALUES (32, 'Sterminatore di Guardiani', 'SYSTEM MESSAGE: \"Il predatore è a caccia.\" Il Nove Code sta diventando aggressivo. Ha lasciato il centro della mappa per attaccare gli intrusi. Obiettivo: Uccidi 3 Nove Code.', 270, '1901', 3, 100, 0, 0, 1, 61, 74, 'NORMAL');
INSERT INTO `hunter_quest_emergencies` VALUES (33, 'Maratona del Sangue', 'SYSTEM MESSAGE: Pericolo: Aura glaciale espansa. Lo spirito della volpe è furioso. Il Nove Code sta evocando tempeste di neve per nascondersi. Obiettivo: Uccidi 5 Nove Code.', 450, '1901', 5, 150, 0, 0, 1, 61, 74, 'HARD');
INSERT INTO `hunter_quest_emergencies` VALUES (34, 'Predatore Apex', 'SYSTEM MESSAGE: \"Una divinità caduta.\" Il Nove Code Anziano è sceso in campo. La sua pelliccia è dura come il diamante e il suo alito congela l\'anima. Obiettivo: Uccidi 8 Nove Code.', 720, '1901', 8, 200, 0, 0, 1, 61, 74, 'EXTREME');
INSERT INTO `hunter_quest_emergencies` VALUES (35, 'Il Collezionista di Teste', 'SYSTEM MESSAGE: \"Lo Spirito della Montagna si è incarnato.\" Non stai combattendo una bestia, ma l\'avatar del gelo assoluto. Obiettivo: Uccidi 12 Nove ', 1080, '1901', 12, 250, 0, 0, 1, 61, 74, 'GOD_MODE');
INSERT INTO `hunter_quest_emergencies` VALUES (36, 'Scheggia di Mana', 'SYSTEM MESSAGE: \"Rilevata una distorsione termica.\" Il suolo sta bruciando. Frammenti della Metin Ardente sono caduti nella valle. Obiettivo: Distruggi 3 Metin Ardente.', 60, '8052', 3, 50, 0, 0, 1, 76, 99, 'EASY');
INSERT INTO `hunter_quest_emergencies` VALUES (37, 'Frattura Dimensionale', 'SYSTEM MESSAGE: \"L\'orgoglio dei giganti sta prendendo forma.\" Le Metin della Vanità stanno emergendo. Non sono rocce comuni. Obiettivo: Distruggi 6 Metin della Vanità.', 120, '8053', 6, 100, 0, 0, 1, 80, 99, 'NORMAL');
INSERT INTO `hunter_quest_emergencies` VALUES (38, 'Cristalli Corrotti', 'SYSTEM MESSAGE: Allarme: Picco di energia vulcanica. Una pioggia di Metin Ardenti ha colpito l\'accampamento nemico. Obiettivo: Distruggi 9 Metin Ardente.', 180, '8052', 9, 150, 0, 0, 1, 82, 99, 'HARD');
INSERT INTO `hunter_quest_emergencies` VALUES (39, 'Collasso del Gate', 'SYSTEM MESSAGE: \"La realtà si sta distorcendo.\" Enormi Metin della Vanità stanno pulsando violentemente. Obiettivo: Distruggi 12 Metin della Vanità.', 240, '8053', 12, 200, 0, 0, 1, 84, 99, 'EXTREME');
INSERT INTO `hunter_quest_emergencies` VALUES (40, 'Dominio dello Spazio', 'SYSTEM MESSAGE: \"Il fuoco primordiale si è risvegliato.\" Questa è la fonte del potere. Obiettivo: Distruggi 15 Metin Ardente.', 300, '8052', 15, 250, 0, 0, 1, 85, 99, 'GOD_MODE');
INSERT INTO `hunter_quest_emergencies` VALUES (41, 'Caccia Grossa', 'SYSTEM MESSAGE: Nuova taglia disponibile. Un Arges, il ciclope guerriero, sta pattugliando l\'ingresso della valle. Obiettivo: Uccidi 1 Arges.', 90, '3190', 1, 50, 0, 0, 1, 85, 99, 'EASY');
INSERT INTO `hunter_quest_emergencies` VALUES (42, 'Sterminatore di Guardiani', 'SYSTEM MESSAGE: \"La terra trema sotto i suoi piedi.\" Polifemo, il signore dei Ciclopi, è sceso dal suo trono di pietra. Obiettivo: Uccidi 3 Polifemo.', 270, '3191', 3, 100, 0, 0, 1, 87, 99, 'NORMAL');
INSERT INTO `hunter_quest_emergencies` VALUES (43, 'Maratona del Sangue', 'SYSTEM MESSAGE: Pericolo: Nemici multipli. Un intero plotone di Arges ha formato un blocco difensivo. Obiettivo: Uccidi 5 Arges.', 450, '3190', 5, 150, 0, 0, 1, 89, 99, 'HARD');
INSERT INTO `hunter_quest_emergencies` VALUES (44, 'Predatore Apex', 'SYSTEM MESSAGE: \"La brutalità fatta carne.\" La guardia reale di Polifemo è in marcia. Non stai affrontando un solo mostro, ma una squadra d\'élite. Obiettivo: Uccidi 8 Polifemo.', 720, '3191', 8, 200, 0, 0, 1, 91, 99, 'EXTREME');
INSERT INTO `hunter_quest_emergencies` VALUES (45, 'Il Collezionista di Teste', 'SYSTEM MESSAGE: \"Nessuno è più grande della tua ombra.\" Un\'intera legione guidata dagli Arges antichi vuole schiacciarti come un insetto. Obiettivo: Uccidi 12 Arges.', 1080, '3190', 12, 250, 0, 0, 1, 83, 99, 'GOD_MODE');
INSERT INTO `hunter_quest_emergencies` VALUES (46, 'Scheggia di Mana', 'SYSTEM MESSAGE: \"Rilevata una distorsione temporale.\" La sabbia si muove come acqua. Frammenti della Metin del Faraone stanno emergendo. Obiettivo: Distruggi 3 Metin del Faraone.', 60, '8210', 3, 50, 0, 0, 1, 101, 124, 'EASY');
INSERT INTO `hunter_quest_emergencies` VALUES (47, 'Frattura Dimensionale', 'SYSTEM MESSAGE: \"Un eco dal passato remoto.\" Le Pietre Antiche sono sigilli dimenticati che trattenevano le maledizioni del deserto. Obiettivo: Distruggi 6 Pietra Antica.', 120, '8207', 6, 100, 0, 0, 1, 104, 124, 'NORMAL');
INSERT INTO `hunter_quest_emergencies` VALUES (48, 'Cristalli Corrotti', 'SYSTEM MESSAGE: Allarme: Energia regale corrotta. Una concentrazione di Metin del Faraone sta cercando di trasformare le Lande in un regno di morti Obiettivo: Distruggi 9 Metin del Faraone.', 180, '8210', 9, 150, 0, 0, 1, 107, 124, 'HARD');
INSERT INTO `hunter_quest_emergencies` VALUES (49, 'Collasso del Gate', 'SYSTEM MESSAGE: \"La storia si sta riscrivendo.\" Enormi Pietre Antiche stanno cadendo dal cielo, portando con sé la magia proibita dell\'era degli dei. Obiettivo: Distruggi 12 Pietra Antica.', 240, '8207', 12, 200, 0, 0, 1, 110, 124, 'EXTREME');
INSERT INTO `hunter_quest_emergencies` VALUES (50, 'Dominio dello Spazio', 'SYSTEM MESSAGE: \"Il Faraone Eterno reclama il suo trono.\" Questa è la fonte suprema. Una distesa infinita di Metin del Faraone sta oscurando il sole. Obiettivo: Distruggi 15 Metin del Faraone.', 300, '8210', 15, 250, 0, 0, 1, 113, 124, 'GOD_MODE');
INSERT INTO `hunter_quest_emergencies` VALUES (51, 'Caccia Grossa', 'SYSTEM MESSAGE: Nuova taglia disponibile.  Ra, il Dio del Sole, è sceso tra le dune per giudicare i mortali. Il suo calore è insopportabile. Obiettivo: Uccidi 1 Ra.', 90, '8213', 1, 50, 0, 0, 1, 115, 124, 'EASY');
INSERT INTO `hunter_quest_emergencies` VALUES (52, 'Sterminatore di Guardiani', 'SYSTEM MESSAGE: \"Il guardiano dei morti è qui.\" Anubi ha lasciato i cancelli dell\'oltretomba per giudicare i viventi. La sua falce reclama anime. Obiettivo: Uccidi 3 Anubi.', 270, '8214', 3, 100, 0, 0, 1, 117, 124, 'NORMAL');
INSERT INTO `hunter_quest_emergencies` VALUES (53, 'Maratona del Sangue', 'SYSTEM MESSAGE:  Pericolo: Radiazione solare critica. Gli avatar di Ra stanno bruciando tutto ciò che toccano. Non puoi nasconderti dalla loro luce. Obiettivo: Uccidi 5 Ra.', 450, '8213', 5, 150, 0, 0, 1, 119, 124, 'HARD');
INSERT INTO `hunter_quest_emergencies` VALUES (54, 'Predatore Apex', 'SYSTEM MESSAGE: \"La morte cammina sulla sabbia.\" L\'élite dei sacerdoti di Anubi è scesa in campo. Non stai affrontando semplici mostri, ma divinità della morte. Obiettivo: Uccidi 8 Anubi.', 720, '8214', 8, 200, 0, 0, 1, 121, 124, 'EXTREME');
INSERT INTO `hunter_quest_emergencies` VALUES (55, 'Il Collezionista di Teste', 'SYSTEM MESSAGE: \"Il Sole Nero è sorto.\" Ra ha scatenato la sua furia finale, evocando tempeste di fuoco solare. Vuole purificare il mondo con le fiamme. Obiettivo: Uccidi 12 Ra.', 1080, '8213', 12, 250, 0, 0, 1, 123, 124, 'GOD_MODE');
INSERT INTO `hunter_quest_emergencies` VALUES (56, 'Scheggia di Mana', 'SYSTEM MESSAGE: \"Rilevato calo termico.\" Frammenti della Metin della Montagna stanno emergendo dal permafrost. Sono rocce dure come l\'acciaio. Obiettivo: Distruggi 3 Metin della Montagna.', 60, '6798', 3, 50, 0, 0, 1, 126, 149, 'EASY');
INSERT INTO `hunter_quest_emergencies` VALUES (57, 'Frattura Dimensionale', 'SYSTEM MESSAGE: \"Un brivido corre lungo la schiena.\" Le Metin del Gelo stanno congelando l\'aria circostante. Chiunque si avvicini rischia l\'ipotermia. Obiettivo: Distruggi 6 Metin del Gelo.', 120, '8203', 6, 100, 0, 0, 1, 128, 149, 'NORMAL');
INSERT INTO `hunter_quest_emergencies` VALUES (58, 'Cristalli Corrotti', 'SYSTEM MESSAGE: Allarme: Valanga magica imminente. Una concentrazione di Metin della Montagna sta destabilizzando le vette. Obiettivo: Distruggi 9 Metin della Montagna.', 180, '6798', 9, 150, 0, 0, 1, 130, 149, 'HARD');
INSERT INTO `hunter_quest_emergencies` VALUES (59, 'Collasso del Gate', 'SYSTEM MESSAGE: \"Il tempo si è fermato.\" Enormi Metin del Gelo stanno assorbendo ogni forma di calore vitale. Obiettivo: Distruggi 12 Metin del Gelo.', 240, '8203', 12, 200, 0, 0, 1, 132, 149, 'EXTREME');
INSERT INTO `hunter_quest_emergencies` VALUES (60, 'Dominio dello Spazio', 'SYSTEM MESSAGE: \"La terra si ribella al cielo.\" Questa è la fonte suprema. Una catena montuosa di Metin sta sorgendo per schiacciare i cieli. Obiettivo: Distruggi 15 Metin della Montagna.', 300, '6798', 15, 250, 0, 0, 1, 134, 149, 'GOD_MODE');
INSERT INTO `hunter_quest_emergencies` VALUES (61, 'Caccia Grossa', 'SYSTEM MESSAGE: Nuova taglia disponibile. Un Capo Congelato sta guidando una piccola tribù di mostri delle nevi. La sua pelle di ghiaccio è spessa. Obiettivo: Uccidi 1 Capo Congelato.', 90, '6783', 1, 50, 0, 0, 1, 136, 149, 'EASY');
INSERT INTO `hunter_quest_emergencies` VALUES (62, 'Sterminatore di Guardiani', 'SYSTEM MESSAGE: \"Il comandante è sceso in campo.\" Il Capo Guerra Congelato indossa un\'armatura fatta di ghiaccio nero. Obiettivo: Uccidi 3 Capo Guerra Congelato.', 270, '6789', 3, 100, 0, 0, 1, 138, 149, 'NORMAL');
INSERT INTO `hunter_quest_emergencies` VALUES (63, 'Maratona del Sangue', 'SYSTEM MESSAGE: Pericolo: Orda in avvicinamento. I Capi Congelati si sono riuniti per un assalto massiccio. La loro forza numerica è un problema. Obiettivo: Uccidi 5 Capo Congelato.', 450, '6783', 5, 150, 0, 0, 1, 140, 149, 'HARD');
INSERT INTO `hunter_quest_emergencies` VALUES (64, 'Predatore Apex', 'SYSTEM MESSAGE: \"L\'Inverno fatto carne.\" L\'élite dei Capi Guerra è qui. Ognuno di loro ha la forza di un raid boss. Obiettivo: Uccidi 8 Capo Guerra Congelato.', 720, '6789', 8, 200, 0, 0, 1, 142, 149, 'EXTREME');
INSERT INTO `hunter_quest_emergencies` VALUES (65, 'Il Collezionista di Teste', 'SYSTEM MESSAGE: \"Il Cuore di Ghiaccio deve essere spezzato.\" Un\'armata infinita guidata dai Capi Congelati Supremi vuole trasformare il mondo. Obiettivo: Uccidi 12 Capo Congelato.', 1080, '6783', 12, 250, 0, 0, 1, 144, 149, 'GOD_MODE');
INSERT INTO `hunter_quest_emergencies` VALUES (66, 'Scheggia di Mana', 'SYSTEM MESSAGE: \"Rilevato aumento termico.\" Frammenti della Metin del Fuoco sono caduti dal cielo, incendiando il terreno. Obiettivo: Distruggi 3 Metin del Fuoco.', 60, '6801', 3, 50, 0, 0, 1, 151, 174, 'EASY');
INSERT INTO `hunter_quest_emergencies` VALUES (67, 'Frattura Dimensionale', 'SYSTEM MESSAGE: \"L\'inferno sta risalendo in superficie.\" Le Pietre Infernali stanno emergendo dalle crepe vulcaniche. Obiettivo: Distruggi 6 Pietra Infernale.', 120, '6799', 6, 100, 0, 0, 1, 153, 174, 'NORMAL');
INSERT INTO `hunter_quest_emergencies` VALUES (68, 'Cristalli Corrotti', 'SYSTEM MESSAGE:  Allarme: Eruzione magica imminente. Una concentrazione di Metin del Fuoco sta facendo ribollire il magma sotto i tuoi piedi. Obiettivo: Distruggi 9 Metin del Fuoco.', 180, '6801', 9, 150, 0, 0, 1, 155, 174, 'HARD');
INSERT INTO `hunter_quest_emergencies` VALUES (69, 'Collasso del Gate', 'SYSTEM MESSAGE: \"Il fuoco nero consuma tutto.\" Enormi Pietre Infernali pulsano di energia maligna. La loro aura sta corrompendo le creature. Obiettivo: Distruggi 12 Pietra Infernale.', 240, '6799', 12, 200, 0, 0, 1, 157, 174, 'EXTREME');
INSERT INTO `hunter_quest_emergencies` VALUES (70, 'Dominio dello Spazio', 'SYSTEM MESSAGE: \"Il mondo brucerà.\" Una distesa di Metin del Fuoco minaccia di trasformare la terra in un secondo sole. Obiettivo: Distruggi 15 Metin del Fuoco.', 300, '6801', 15, 250, 0, 0, 1, 159, 174, 'GOD_MODE');
INSERT INTO `hunter_quest_emergencies` VALUES (71, 'Caccia Grossa', 'SYSTEM MESSAGE: Nuova taglia disponibile. Un Re del Fuoco ha lasciato il suo trono di lava per sfidare gli intrusi. Obiettivo: Uccidi 1 Re del Fuoco.', 90, '34600', 1, 50, 0, 0, 1, 161, 174, 'EASY');
INSERT INTO `hunter_quest_emergencies` VALUES (72, 'Sterminatore di Guardiani', 'SYSTEM MESSAGE: \"Un ruggito scuote il vulcano.\" Il Drago di Fuoco si è svegliato. Le sue scaglie sono impenetrabili e il suo soffio scioglie la roccia. Obiettivo: Uccidi 3 Drago di Fuoco.', 270, '34601', 3, 100, 0, 0, 1, 163, 174, 'NORMAL');
INSERT INTO `hunter_quest_emergencies` VALUES (73, 'Maratona del Sangue', 'SYSTEM MESSAGE:Pericolo: Concilio dei Sovrani. Diversi Re del Fuoco si sono alleati per dominare la regione. Obiettivo: Uccidi 5 Re del Fuoco.', 450, '34600', 5, 150, 0, 0, 1, 165, 174, 'HARD');
INSERT INTO `hunter_quest_emergencies` VALUES (74, 'Predatore Apex', 'SYSTEM MESSAGE: \"Il cielo è in fiamme.\" Uno stormo di Draghi di Fuoco Antichi sta sorvolando la zona. Non stai combattendo lucertole, ma calamità volanti. Obiettivo: Uccidi 8 Drago di Fuoco.', 720, '34601', 8, 200, 0, 0, 1, 167, 174, 'EXTREME');
INSERT INTO `hunter_quest_emergencies` VALUES (75, 'Il Collezionista di Teste', 'SYSTEM MESSAGE: \"L\'Imperatore delle Fiamme è qui.\" Un\'armata infinita guidata dai Re del Fuoco Supremi vuole ridurre il mondo in cenere. Obiettivo: Uccidi 12 Re del Fuoco.', 1080, '34600', 12, 250, 0, 0, 1, 169, 174, 'GOD_MODE');
INSERT INTO `hunter_quest_emergencies` VALUES (76, 'Scheggia di Mana', 'SYSTEM MESSAGE: \"Rilevata una brezza anomala.\" Frammenti della Metin del Vento sono caduti tra gli alberi, creando vortici innaturali. Obiettivo: Distruggi 3 Metin del Vento.', 60, '6803', 3, 50, 0, 0, 1, 176, 200, 'EASY');
INSERT INTO `hunter_quest_emergencies` VALUES (77, 'Frattura Dimensionale', 'SYSTEM MESSAGE: \"Gli alberi stanno sussurrando.\" Le Metin della Foresta stanno corrompendo le radici antiche. Non sono rocce, ma parassiti magici. Obiettivo: Distruggi 6 Metin della Foresta.', 120, '6802', 6, 100, 0, 0, 1, 178, 200, 'NORMAL');
INSERT INTO `hunter_quest_emergencies` VALUES (78, 'Cristalli Corrotti', 'SYSTEM MESSAGE: Allarme: Tempesta magica in arrivo. Una concentrazione di Metin del Vento sta generando uragani taglienti come lame. Obiettivo: Distruggi 9 Metin del Vento.', 180, '6803', 9, 150, 0, 0, 1, 181, 200, 'HARD');
INSERT INTO `hunter_quest_emergencies` VALUES (79, 'Collasso del Gate', 'SYSTEM MESSAGE: \"La natura si ribella.\" Enormi Metin della Foresta pulsano di energia verde corrotta. Stanno trasformando la vegetazione. Obiettivo: Distruggi 12 Metin della Foresta.', 240, '6802', 12, 200, 0, 0, 1, 183, 200, 'EXTREME');
INSERT INTO `hunter_quest_emergencies` VALUES (80, 'Dominio dello Spazio', 'SYSTEM MESSAGE: \"Il Cielo e la Terra si scontrano.\" Questa è la fonte suprema. Una tempesta infinita generata dalle Metin del Vento. Obiettivo: Distruggi 15 Metin del Vento.', 300, '6803', 15, 250, 0, 0, 1, 185, 200, 'GOD_MODE');
INSERT INTO `hunter_quest_emergencies` VALUES (81, 'Caccia Grossa', 'SYSTEM MESSAGE: Nuova taglia disponibile. Un Lemure Outis si aggira tra le ombre degli alberi. È uno spirito minore, ma la sua magia illusoria è pericolosa. Obiettivo: Uccidi 1 Lemure Outis.', 90, '3391', 1, 50, 0, 0, 1, 187, 200, 'EASY');
INSERT INTO `hunter_quest_emergencies` VALUES (82, 'Sterminatore di Guardiani', 'SYSTEM MESSAGE: \"Un nobile decaduto è apparso.\" Il Lemure Conte comanda gli spiriti della foresta con autorità crudele. Obiettivo: Uccidi 3 Lemure Conte.', 270, '3390', 3, 100, 0, 0, 1, 189, 200, 'NORMAL');
INSERT INTO `hunter_quest_emergencies` VALUES (83, 'Maratona del Sangue', 'SYSTEM MESSAGE:  Pericolo: Imboscata spirituale. Un branco di Lemuri Outis sta accerchiando la zona. Non sono soli, attaccano in coordinazione perfetta. Obiettivo: Uccidi 5 Lemure Outis.', 450, '3391', 5, 150, 0, 0, 1, 191, 200, 'HARD');
INSERT INTO `hunter_quest_emergencies` VALUES (84, 'Predatore Apex', 'SYSTEM MESSAGE: \"L\'Aristocrazia delle Ombre.\" I Lemuri Conte più anziani si sono riuniti per un rituale oscuro. La loro magia può prosciugare la tua anima. Obiettivo: Uccidi 8 Lemure Conte.', 720, '3390', 8, 200, 0, 0, 1, 193, 200, 'EXTREME');
INSERT INTO `hunter_quest_emergencies` VALUES (85, 'Il Collezionista di Teste', 'SYSTEM MESSAGE: \"Lo Spirito Senza Nome.\" Un\'armata infinita di Lemuri Outis vuole cancellare la tua esistenza dalla memoria del mondo. Obiettivo: Uccidi 12 Lemure Outis.', 1080, '3391', 12, 250, 0, 0, 1, 195, 200, 'GOD_MODE');
INSERT INTO `hunter_quest_emergencies` VALUES (86, 'Tana del Predatore', 'SYSTEM MESSAGE: \"Rilevato ingresso sotterraneo.\" Un Gate di basso livello si è aperto nelle profondità. La Baronessa Ragno sta tessendo la sua tela. Obiettivo: Completa 1 Dungeon Biblioteca.', 90, '2092', 1, 250, 0, 0, 1, 50, 80, 'EASY');
INSERT INTO `hunter_quest_emergencies` VALUES (87, 'Il Nido della Regina', 'SYSTEM MESSAGE: \"Migliaia di occhi ti osservano.\" La covata si sta schiudendo. Obiettivo: Completa 3 Dungeon Biblioteca.', 180, '2092', 3, 300, 0, 0, 1, 55, 80, 'NORMAL');
INSERT INTO `hunter_quest_emergencies` VALUES (88, 'Raid del Veleno', 'SYSTEM MESSAGE: Pericolo: Tossicità dell\'aria elevata. La Baronessa Ragno si è evoluta. Il suo veleno corrode tutto. Obiettivo: Completa 5 Dungeon Biblioteca.', 360, '2092', 5, 350, 0, 0, 1, 60, 80, 'HARD');
INSERT INTO `hunter_quest_emergencies` VALUES (89, 'Labirinto di Seta', 'SYSTEM MESSAGE: \"Non c\'è via di fuga.\" L\'intero dungeon è diventato una trappola mortale. La Baronessa Ragno Ancestrale ti aspetta. Obiettivo: Completa 8 Dungeon Biblioteca.', 720, '2092', 8, 400, 0, 0, 1, 65, 80, 'EXTREME');
INSERT INTO `hunter_quest_emergencies` VALUES (90, 'La Tessitrice di Incubi', 'SYSTEM MESSAGE: \"La preda diventa il cacciatore.\" Questo non è un semplice nido. Obiettivo: Completa 10 Dungeon Biblioteca.', 1440, '2092', 10, 500, 0, 0, 1, 70, 80, 'GOD_MODE');
INSERT INTO `hunter_quest_emergencies` VALUES (91, 'Santuario Profanato', 'SYSTEM MESSAGE: \"Un silenzio tombale avvolge le rovine.\" Hai varcato la soglia del Tempio Maledetto. Lo Spirito della Morte ha corrotto l\'altare sacro.  Obiettivo: Completa 1 Dungeon Tempio.', 90, '1093', 1, 250, 0, 0, 1, 75, 90, 'EASY');
INSERT INTO `hunter_quest_emergencies` VALUES (92, 'Il Mietitore di Anime', 'SYSTEM MESSAGE: \"I morti non riposano qui.\" Lo Spirito della Morte sta raccogliendo energia vitale nel cuore del Tempio. Obiettivo: Completa 3 Dungeon Tempio.', 180, '1093', 3, 300, 0, 0, 1, 78, 90, 'NORMAL');
INSERT INTO `hunter_quest_emergencies` VALUES (93, 'Raid del Necromante', 'SYSTEM MESSAGE: Il Sommo Sacerdote della Morte si è manifestato. La sua falce non taglia la carne, ma l\'anima stessa. Obiettivo: Completa 5 Dungeon Tempio.', 360, '1093', 5, 350, 0, 0, 1, 80, 90, 'HARD');
INSERT INTO `hunter_quest_emergencies` VALUES (94, 'L\'Altare d\'Ossa', 'SYSTEM MESSAGE: \"L\'oscurità è assoluta.\" Lo Spirito della Morte ha evocato i suoi generali più fedeli a difesa del Tempio. Obiettivo: Completa 8 Dungeon Tempio.', 720, '1093', 8, 400, 0, 0, 1, 82, 90, 'EXTREME');
INSERT INTO `hunter_quest_emergencies` VALUES (95, 'L\'Avatar della Fine', 'SYSTEM MESSAGE: \"La Morte si inchina a te.\" Non stai affrontando un demone, ma l\'incarnazione della fine di ogni cosa. Obiettivo: Completa 10 Dungeon Tempio.', 1440, '1093', 10, 500, 0, 0, 1, 85, 90, 'GOD_MODE');
INSERT INTO `hunter_quest_emergencies` VALUES (96, 'La Prova della Scimmia', 'SYSTEM MESSAGE: \"Rilevata una forte aura combattiva.\" Un Gate si è aperto sulla cima della Collina. Wukong, il guerriero ribelle cerca sangue. Obiettivo: Completa 1 Dungeon Wukong.', 90, '9682', 1, 250, 0, 0, 1, 80, 100, 'EASY');
INSERT INTO `hunter_quest_emergencies` VALUES (97, 'Il Bastone Dorato', 'SYSTEM MESSAGE: \"Il vento porta il suono della battaglia.\" Wukong e i suoi cloni attaccano il santuario. La sua abilità marziale è leggendaria. Obiettivo: Completa 3 Dungeon Wukong.', 180, '9682', 3, 300, 0, 0, 1, 82, 100, 'NORMAL');
INSERT INTO `hunter_quest_emergencies` VALUES (98, 'Raid del Re Scimmia', 'SYSTEM MESSAGE:  Pericolo: Livello di potenza in aumento. Wukong ha rimosso i suoi sigilli. Non è più un semplice guerriero, ma una bestia indomabile. Obiettivo: Completa 5 Dungeon Wukong.', 360, '9682', 5, 350, 0, 0, 1, 85, 100, 'HARD');
INSERT INTO `hunter_quest_emergencies` VALUES (99, 'La Furia del Saggio', 'SYSTEM MESSAGE: \"La terra trema sotto il suo peso.\" Il Grande Saggio Pari al Cielo è furioso. La Collina è diventata un campo di battaglia. Obiettivo: Completa 8 Dungeon Wukong.', 720, '9682', 8, 400, 0, 0, 1, 90, 100, 'EXTREME');
INSERT INTO `hunter_quest_emergencies` VALUES (100, 'L\'Ascesa del Dio della Guerra', 'SYSTEM MESSAGE: \"Hai osato sfidare una divinità.\" Wukong ha raggiunto l\'illuminazione e vuole riscrivere le regole del mondo con la sua forza. Obiettivo: Completa 10 Dungeon Wukong.', 1440, '9682', 10, 500, 0, 0, 1, 95, 100, 'GOD_MODE');
INSERT INTO `hunter_quest_emergencies` VALUES (101, 'Tana nelle Rovine', 'SYSTEM MESSAGE: \"Rilevato movimento sotto la sabbia.\" Un Gate si è aperto tra le antiche colonne crollate. Obiettivo: Completa 1 Dungeon Re Scorpione.', 90, '9694', 1, 250, 0, 0, 1, 105, 125, 'EASY');
INSERT INTO `hunter_quest_emergencies` VALUES (102, 'Il Pungiglione Reale', 'SYSTEM MESSAGE: \"Il veleno scorre come acqua.\" Il Re Scorpione ha fortificato la sua tana. La sua corazza è spessa e la sua coda è letale. Obiettivo: Completa 3 Dungeon Re Scorpione.', 180, '9694', 3, 300, 0, 0, 1, 108, 125, 'NORMAL');
INSERT INTO `hunter_quest_emergencies` VALUES (103, 'Raid del Deserto', 'SYSTEM MESSAGE:  Pericolo: Tossicità estrema. Il Signore delle Rovine si è evoluto. Il Re Scorpione comanda un esercito di insetti giganti. Obiettivo: Completa 5 Dungeon Re Scorpione.', 360, '9694', 5, 350, 0, 0, 1, 110, 125, 'HARD');
INSERT INTO `hunter_quest_emergencies` VALUES (104, 'La Tomba di Sabbia', 'SYSTEM MESSAGE: \"Le rovine stanno crollando.\" Il Re Scorpione Ancestrale ha scatenato la sua furia, facendo tremare le fondamenta del tempio.  Obiettivo: Completa 8 Dungeon Re Scorpione.', 720, '9694', 8, 400, 0, 0, 1, 115, 125, 'EXTREME');
INSERT INTO `hunter_quest_emergencies` VALUES (105, 'L\'Imperatore del Veleno', 'SYSTEM MESSAGE: \"La sabbia si tinge di verde.\" Non stai affrontando un insetto, ma una calamità naturale.  Obiettivo: Completa 10 Dungeon Re Scorpione.', 1440, '9694', 10, 500, 0, 0, 1, 120, 125, 'GOD_MODE');
INSERT INTO `hunter_quest_emergencies` VALUES (106, 'Antro di Ghiaccio', 'SYSTEM MESSAGE: \"Rilevato calo drastico della temperatura.\" Un Gate si è formato all\'interno di una grotta ghiacciata. Obiettivo: Completa 1 Dungeon Grotta Artica.', 90, '9712', 1, 250, 0, 0, 1, 130, 150, 'EASY');
INSERT INTO `hunter_quest_emergencies` VALUES (107, 'Il Trono di Cristallo', 'SYSTEM MESSAGE:\"Il freddo ti penetra nelle ossa.\" Il Re Artico siede sul suo trono, protetto da guardiani di ghiaccio puro. Obiettivo: Completa 3 Dungeon Grotta Artica.', 180, '9712', 3, 300, 0, 0, 1, 132, 150, 'NORMAL');
INSERT INTO `hunter_quest_emergencies` VALUES (108, 'Raid della Tormenta', 'SYSTEM MESSAGE: Pericolo: Bufera magica interna. Il Signore della Grotta ha scatenato una tempesta perfetta. Obiettivo: Completa 5 Dungeon Grotta Artica.', 360, '9712', 5, 350, 0, 0, 1, 135, 150, 'HARD');
INSERT INTO `hunter_quest_emergencies` VALUES (109, 'Prigione Eterna', 'SYSTEM MESSAGE: \"Il tempo sembra essersi congelato.\" Il Re Artico Ancestrale vuole intrappolare il mondo in un blocco di ghiaccio. Obiettivo: Completa 8 Dungeon Grotta Artica.', 720, '9712', 8, 400, 0, 0, 1, 140, 150, 'EXTREME');
INSERT INTO `hunter_quest_emergencies` VALUES (110, 'L\'Era Glaciale', 'SYSTEM MESSAGE: \"L\'inverno assoluto è arrivato.\" Non stai combattendo un re, ma l\'avatar del gelo cosmico. Obiettivo: Completa 10 Dungeon Grotta Artica.', 1440, '9712', 10, 500, 0, 0, 1, 145, 150, 'GOD_MODE');
INSERT INTO `hunter_quest_emergencies` VALUES (111, 'L\'Ingresso degli Inferi', 'SYSTEM MESSAGE: \"Rilevata frattura dimensionale.\" Le Porte si sono socchiuse. Obiettivo: Completa 1 Dungeon Signore Infernale.', 90, '29754', 1, 250, 0, 0, 1, 155, 175, 'EASY');
INSERT INTO `hunter_quest_emergencies` VALUES (112, 'Il Patto di Sangue', 'SYSTEM MESSAGE: \"L\'odore dello zolfo è soffocante.\" Il Signore Infernale sta stringendo patti con le anime dannate per accrescere il suo esercito. Obiettivo: Completa 3 Dungeon Signore Infernale.', 180, '29754', 3, 300, 0, 0, 1, 158, 175, 'NORMAL');
INSERT INTO `hunter_quest_emergencies` VALUES (113, 'Raid dell\'Apocalisse', 'SYSTEM MESSAGE: Pericolo: Calore infernale critico. Il Trono di Fuoco è stato attivato. Il Signore Infernale comanda fiamme. Obiettivo: Completa 5 Dungeon Signore Infernale.', 360, '29754', 5, 350, 0, 0, 1, 160, 175, 'HARD');
INSERT INTO `hunter_quest_emergencies` VALUES (114, 'Pandemonio', 'SYSTEM MESSAGE: \"Le Porte sono spalancate.\" Il Signore Infernale Ancestrale ha trasformato il dungeon in un frammento dell\'Inferno stesso. Obiettivo: Completa 8 Dungeon Signore Infernale.', 720, '29754', 8, 400, 0, 0, 1, 165, 175, 'EXTREME');
INSERT INTO `hunter_quest_emergencies` VALUES (115, 'Il Re dei Demoni', 'SYSTEM MESSAGE: \"Lasciate ogni speranza, o voi che entrate.\" Non stai affrontando un signore, ma il sovrano assoluto del male. Obiettivo: Completa 10 Dungeon Signore Infernale.', 1440, '29754', 10, 500, 0, 0, 1, 170, 175, 'GOD_MODE');
INSERT INTO `hunter_quest_emergencies` VALUES (116, 'Sentiero Selvaggio', 'SYSTEM MESSAGE: \"Rilevata crescita vegetale anomala.\" Un Gate si è aperto nel cuore della foresta. Obiettivo: Completa 1 Dungeon Regina Giungla.', 90, '16103', 1, 250, 0, 0, 1, 175, 200, 'EASY');
INSERT INTO `hunter_quest_emergencies` VALUES (117, 'Il Trono di Spine', 'SYSTEM MESSAGE: \"La giungla è viva e ti osserva.\" La Regina della Giungla comanda bestie e piante mutate. Obiettivo: Completa 3 Dungeon Regina Giungla.', 180, '16103', 3, 300, 0, 0, 1, 178, 200, 'NORMAL');
INSERT INTO `hunter_quest_emergencies` VALUES (118, 'Raid Primordiale', 'SYSTEM MESSAGE:  Pericolo: Spore tossiche nell\'aria. La Regina della Giungla controlla il veleno e la vita stessa. Obiettivo: Completa 5 Dungeon Regina Giungla.', 360, '16103', 5, 350, 0, 0, 1, 180, 200, 'HARD');
INSERT INTO `hunter_quest_emergencies` VALUES (119, 'L\'Inferno Verde', 'SYSTEM MESSAGE: \"Non c\'è via d\'uscita dal labirinto.\" La Regina della Giungla Ancestrale ha trasformato il dungeon in una trappola vivente. Obiettivo: Completa 8 Dungeon Regina Giungla.', 720, '16103', 8, 400, 0, 0, 1, 185, 200, 'EXTREME');
INSERT INTO `hunter_quest_emergencies` VALUES (120, 'La Dea della Natura', 'SYSTEM MESSAGE: \"Il mondo tornerà alle origini.\" Non stai affrontando un mostro, ma l\'avatar di Gaia. La Regina della Giungla vuole cancellare tutto. Obiettivo: Completa 10 Dungeon Regina Giungla.', 1440, '16103', 10, 500, 0, 0, 1, 190, 200, 'GOD_MODE');

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
  `force_power_rank` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`vnum`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hunter_quest_fractures
-- ----------------------------
INSERT INTO `hunter_quest_fractures` VALUES (16060, 'Frattura Primordiale', 'E-Rank', 'GREEN', 44, 0, 1, 0);
INSERT INTO `hunter_quest_fractures` VALUES (16061, 'Frattura Astrale', 'D-Rank', 'BLUE', 30, 2000, 1, 0);
INSERT INTO `hunter_quest_fractures` VALUES (16062, 'Frattura Abissale', 'C-Rank', 'ORANGE', 15, 10000, 1, 0);
INSERT INTO `hunter_quest_fractures` VALUES (16063, 'Frattura Cremisi', 'B-Rank', 'RED', 5, 0, 1, 100);
INSERT INTO `hunter_quest_fractures` VALUES (16064, 'Frattura Aurea', 'A-Rank', 'GOLD', 3, 0, 1, 200);
INSERT INTO `hunter_quest_fractures` VALUES (16065, 'Frattura Infausta', 'S-Rank', 'PURPLE', 2, 0, 1, 350);
INSERT INTO `hunter_quest_fractures` VALUES (16066, 'Frattura Instabile', 'N-Rank', 'BLACKWHITE', 1, 0, 1, 500);
INSERT INTO `hunter_quest_fractures` VALUES (16067, 'Frattura del Tesoro', 'A-Rank', 'GOLD', 0, 150000, 0, 0);
INSERT INTO `hunter_quest_fractures` VALUES (16068, 'Frattura Maledetta', 'S-Rank', 'PURPLE', 0, 500000, 0, 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

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
  `chests_e` int UNSIGNED NOT NULL DEFAULT 0 COMMENT 'E-Rank chests opened',
  `chests_d` int UNSIGNED NOT NULL DEFAULT 0 COMMENT 'D-Rank chests opened',
  `chests_c` int UNSIGNED NOT NULL DEFAULT 0 COMMENT 'C-Rank chests opened',
  `chests_b` int UNSIGNED NOT NULL DEFAULT 0 COMMENT 'B-Rank chests opened',
  `chests_a` int UNSIGNED NOT NULL DEFAULT 0 COMMENT 'A-Rank chests opened',
  `chests_s` int UNSIGNED NOT NULL DEFAULT 0 COMMENT 'S-Rank chests opened',
  `chests_n` int UNSIGNED NOT NULL DEFAULT 0 COMMENT 'N-Rank chests opened',
  `boss_kills_easy` int UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Easy boss kills',
  `boss_kills_medium` int UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Medium boss kills',
  `boss_kills_hard` int UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Hard boss kills',
  `boss_kills_elite` int UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Elite/Epic boss kills',
  `metin_kills_normal` int UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Normal metin kills',
  `metin_kills_special` int UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Special/Event metin kills',
  `defense_wins` int UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Fracture defenses won',
  `defense_losses` int UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Fracture defenses lost',
  `elite_kills` int UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Elite mob kills',
  `pending_karma` int NULL DEFAULT 0,
  `total_metins` int NULL DEFAULT 0,
  `current_rank` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'E',
  `last_activity` datetime NULL DEFAULT current_timestamp,
  `penalty_active` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `penalty_expires` int UNSIGNED NOT NULL DEFAULT 0,
  `failed_missions` int UNSIGNED NOT NULL DEFAULT 0,
  `overtaken_by` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `overtaken_diff` int NULL DEFAULT 0,
  `overtaken_label` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`player_id`) USING BTREE,
  INDEX `idx_daily_points`(`daily_points` DESC) USING BTREE,
  INDEX `idx_weekly_points`(`weekly_points` DESC) USING BTREE,
  INDEX `idx_total_points`(`total_points` DESC) USING BTREE,
  INDEX `idx_ranking_pid`(`player_id` ASC) USING BTREE,
  INDEX `idx_ranking_daily`(`daily_points` DESC) USING BTREE,
  INDEX `idx_ranking_weekly`(`weekly_points` DESC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hunter_quest_ranking
-- ----------------------------
INSERT INTO `hunter_quest_ranking` VALUES (1, '[GF]Wesker', 'E', 2214, 66105, 1954, 1954, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'E', '2026-01-17 13:36:30', 0, 0, 0, NULL, 0, NULL);
INSERT INTO `hunter_quest_ranking` VALUES (2, '[GF]Aelarion', 'C', 34153, 24820, 520, 17670, 300, 0, 100, 0, 0, 0, 0, 0, 0, 48, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'C', '2025-12-21 17:41:26', 0, 0, 0, NULL, 0, NULL);
INSERT INTO `hunter_quest_ranking` VALUES (4, '[GF]HunabKu', 'C', 1603366, 162016, 121459, 128299, 74, 46, 74, 0, 0, 0, 0, 0, 0, 47, 56, 23, 2, 5, 1, 1, 3, 0, 23, 0, 0, 0, 16, 0, 19, 19, 39, 0, 34, 'C', '2025-12-30 11:39:29', 0, 0, 0, NULL, 0, NULL);
INSERT INTO `hunter_quest_ranking` VALUES (219, 'Anonymous', 'E', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'E', '2026-01-22 18:29:23', 0, 0, 0, NULL, 0, NULL);
INSERT INTO `hunter_quest_ranking` VALUES (351, 'LaZia', 'E', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'E', '2026-01-25 15:09:46', 0, 0, 0, NULL, 0, NULL);
INSERT INTO `hunter_quest_ranking` VALUES (440, 'SuraF', 'E', 11405, 11405, 11405, 11405, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'E', '2026-01-20 13:32:02', 0, 0, 0, NULL, 0, NULL);
INSERT INTO `hunter_quest_ranking` VALUES (994, 'Spikelino', 'E', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'E', '2026-01-24 20:20:19', 0, 0, 0, NULL, 0, NULL);
INSERT INTO `hunter_quest_ranking` VALUES (1684, 'Pacifista', 'E', 755, 580, 187, 430, 3, 2, 3, 0, 0, 0, 0, 0, 0, 1, 3, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 3, 2, 0, 3, 'E', '2026-01-04 14:59:49', 0, 0, 0, NULL, 0, NULL);
INSERT INTO `hunter_quest_ranking` VALUES (3630, 'Repiro', 'E', 150, 150, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'E', '2026-01-23 15:28:03', 0, 0, 0, NULL, 0, NULL);
INSERT INTO `hunter_quest_ranking` VALUES (3756, 'ZioFrenk', 'E', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'E', '2026-01-25 15:11:12', 0, 0, 0, NULL, 0, NULL);
INSERT INTO `hunter_quest_ranking` VALUES (3893, 'Potenza', 'E', 95, 95, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'E', '2025-12-23 18:06:07', 0, 0, 0, NULL, 0, NULL);
INSERT INTO `hunter_quest_ranking` VALUES (3895, '123123123', 'E', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'E', '2025-12-25 12:02:22', 0, 0, 0, NULL, 0, NULL);
INSERT INTO `hunter_quest_ranking` VALUES (3900, 'asdasdasd2', 'E', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'E', '2025-12-27 05:24:00', 0, 0, 0, NULL, 0, NULL);
INSERT INTO `hunter_quest_ranking` VALUES (3901, 'Spapum', 'E', 2915, 2915, 0, 65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'E', '2026-01-06 12:00:19', 0, 0, 0, NULL, 0, NULL);
INSERT INTO `hunter_quest_ranking` VALUES (3902, 'd2321', 'E', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'E', '2026-01-18 01:18:44', 0, 0, 0, NULL, 0, NULL);
INSERT INTO `hunter_quest_ranking` VALUES (3903, 'Gameplay', 'E', 3667, 1320, 1092, 1092, 6, 6, 6, 0, 0, 0, 0, 0, 0, 9, 1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 1, 0, 8, 0, 5, 0, 1, 'E', '2026-01-18 14:07:37', 0, 0, 0, NULL, 0, NULL);
INSERT INTO `hunter_quest_ranking` VALUES (3904, 'soaasdwd', 'E', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'E', '2026-01-17 18:33:50', 0, 0, 0, NULL, 0, NULL);
INSERT INTO `hunter_quest_ranking` VALUES (3905, '123213', 'E', 125, 125, 250, 250, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'E', '2026-01-20 16:51:47', 0, 0, 0, NULL, 0, NULL);
INSERT INTO `hunter_quest_ranking` VALUES (3906, 'Monarca', 'E', 350, 350, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 'E', '2026-01-24 18:48:08', 0, 0, 0, NULL, 0, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hunter_quest_shop
-- ----------------------------
INSERT INTO `hunter_quest_shop` VALUES (1, 80030, 1, 500, 'Buono 100 Punti', 1, 1);
INSERT INTO `hunter_quest_shop` VALUES (2, 80031, 1, 2500, 'Buono 500 Punti', 2, 1);
INSERT INTO `hunter_quest_shop` VALUES (3, 80032, 1, 5000, 'Buono 1000 Punti', 3, 1);
INSERT INTO `hunter_quest_shop` VALUES (4, 50163, 1, 25000, 'Chiave Dimensionale (Forza Baule)', 80, 1);
INSERT INTO `hunter_quest_shop` VALUES (5, 50168, 1, 50000, 'Frammento di Monarca (S-Rank + Focus)', 90, 1);
INSERT INTO `hunter_quest_shop` VALUES (6, 50160, 1, 1000, 'Scanner di Fratture (Evoca Subito)', 10, 1);
INSERT INTO `hunter_quest_shop` VALUES (7, 50162, 1, 2500, 'Focus del Cacciatore (+20% Gloria)', 20, 1);
INSERT INTO `hunter_quest_shop` VALUES (8, 50167, 1, 4000, 'Calibratore (Garantisce Rango C+)', 30, 1);
INSERT INTO `hunter_quest_shop` VALUES (9, 50161, 1, 7500, 'Stabilizzatore di Rango (Scegli Rank)', 40, 1);
INSERT INTO `hunter_quest_shop` VALUES (10, 50165, 1, 10000, 'Segnale d\'Emergenza (Forza Speed Kill)', 50, 1);
INSERT INTO `hunter_quest_shop` VALUES (11, 50164, 1, 12500, 'Sigillo di Conquista (Salta Difesa)', 60, 1);
INSERT INTO `hunter_quest_shop` VALUES (12, 50166, 1, 15000, 'Risonatore di Gruppo (Buff Party)', 70, 1);

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
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hunter_quest_spawn_types
-- ----------------------------
INSERT INTO `hunter_quest_spawn_types` VALUES ('BAULE', 150, 0, 1);
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
  `rank_tier` int NOT NULL DEFAULT 1 COMMENT '1=E, 2=D, 3=C, 4=B, 5=A, 6=S, 7=N',
  `enabled` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`spawn_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hunter_quest_spawns
-- ----------------------------
INSERT INTO `hunter_quest_spawns` VALUES (1, 63010, 'Metin Lv.45', 'SUPER_METIN', 35, 55, 25, 'GREEN', 1, 1);
INSERT INTO `hunter_quest_spawns` VALUES (2, 63011, 'Metin Lv.60', 'SUPER_METIN', 50, 70, 35, 'GREEN', 2, 1);
INSERT INTO `hunter_quest_spawns` VALUES (3, 63012, 'Metin Lv.75', 'SUPER_METIN', 65, 85, 50, 'BLUE', 2, 1);
INSERT INTO `hunter_quest_spawns` VALUES (4, 63013, 'Metin Lv.90', 'SUPER_METIN', 80, 100, 65, 'BLUE', 3, 1);
INSERT INTO `hunter_quest_spawns` VALUES (5, 63014, 'Metin Lv.95', 'SUPER_METIN', 85, 105, 80, 'ORANGE', 3, 1);
INSERT INTO `hunter_quest_spawns` VALUES (6, 63015, 'Metin Lv.115', 'SUPER_METIN', 105, 125, 100, 'ORANGE', 4, 1);
INSERT INTO `hunter_quest_spawns` VALUES (7, 63016, 'Metin Lv.135', 'SUPER_METIN', 125, 150, 125, 'RED', 4, 1);
INSERT INTO `hunter_quest_spawns` VALUES (8, 63017, 'Metin Lv.165', 'SUPER_METIN', 150, 180, 155, 'GOLD', 5, 1);
INSERT INTO `hunter_quest_spawns` VALUES (9, 63018, 'Metin Lv.200', 'SUPER_METIN', 180, 250, 190, 'PURPLE', 6, 1);
INSERT INTO `hunter_quest_spawns` VALUES (10, 4035, 'Funglash', 'BOSS', 65, 85, 10, 'GREEN', 1, 1);
INSERT INTO `hunter_quest_spawns` VALUES (11, 719, 'Thaloren', 'BOSS', 85, 105, 12, 'BLUE', 2, 1);
INSERT INTO `hunter_quest_spawns` VALUES (12, 2771, 'Yinlee', 'BOSS', 90, 110, 15, 'BLUE', 3, 1);
INSERT INTO `hunter_quest_spawns` VALUES (13, 768, 'Slubina', 'BOSS', 105, 125, 18, 'ORANGE', 3, 1);
INSERT INTO `hunter_quest_spawns` VALUES (14, 6790, 'Alastor', 'BOSS', 115, 135, 22, 'ORANGE', 4, 1);
INSERT INTO `hunter_quest_spawns` VALUES (15, 6831, 'Grimlor', 'BOSS', 125, 145, 28, 'RED', 4, 1);
INSERT INTO `hunter_quest_spawns` VALUES (16, 986, 'Branzhul', 'BOSS', 140, 160, 35, 'RED', 5, 1);
INSERT INTO `hunter_quest_spawns` VALUES (17, 989, 'Torgal', 'BOSS', 155, 175, 42, 'GOLD', 5, 1);
INSERT INTO `hunter_quest_spawns` VALUES (18, 4011, 'Nerzakar', 'BOSS', 175, 195, 50, 'GOLD', 6, 1);
INSERT INTO `hunter_quest_spawns` VALUES (19, 6830, 'Nozzera', 'BOSS', 190, 210, 60, 'PURPLE', 6, 1);
INSERT INTO `hunter_quest_spawns` VALUES (20, 4385, 'Velzahar', 'BOSS', 200, 250, 80, 'BLACKWHITE', 7, 1);
INSERT INTO `hunter_quest_spawns` VALUES (21, 63000, 'Cassa E-Rank', 'BAULE', 1, 250, 8, 'GREEN', 1, 1);
INSERT INTO `hunter_quest_spawns` VALUES (22, 63001, 'Cassa D-Rank', 'BAULE', 1, 250, 12, 'BLUE', 2, 1);
INSERT INTO `hunter_quest_spawns` VALUES (23, 63002, 'Cassa C-Rank', 'BAULE', 1, 250, 18, 'ORANGE', 3, 1);
INSERT INTO `hunter_quest_spawns` VALUES (24, 63003, 'Cassa B-Rank', 'BAULE', 1, 250, 25, 'RED', 4, 1);
INSERT INTO `hunter_quest_spawns` VALUES (25, 63004, 'Cassa A-Rank', 'BAULE', 1, 250, 35, 'PURPLE', 5, 1);
INSERT INTO `hunter_quest_spawns` VALUES (26, 63005, 'Cassa S-Rank', 'BAULE', 1, 250, 50, 'GOLD', 6, 1);
INSERT INTO `hunter_quest_spawns` VALUES (27, 63006, 'Cassa N-Rank', 'BAULE', 1, 250, 70, 'BLACKWHITE', 7, 1);
INSERT INTO `hunter_quest_spawns` VALUES (28, 63007, 'Cassa ???-Rank', 'BAULE', 1, 250, 90, 'PURPLE', 7, 1);
INSERT INTO `hunter_quest_spawns` VALUES (29, 63019, 'Metin Lv.???', 'SUPER_METIN', 180, 250, 300, 'BLACKWHITE', 7, 1);

-- ----------------------------
-- Table structure for hunter_quest_tips
-- ----------------------------
DROP TABLE IF EXISTS `hunter_quest_tips`;
CREATE TABLE `hunter_quest_tips`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `tip_text` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hunter_quest_tips
-- ----------------------------
INSERT INTO `hunter_quest_tips` VALUES (1, 'Le Fratture hanno 7 gradi: E(Verde), D(Blu), C(Arancio), B(Rosso), A(Oro), S(Viola), N(Bianco).');
INSERT INTO `hunter_quest_tips` VALUES (2, 'Fratture E, D, C restano anche se perdi la difesa. Puoi ritentare! Ma B+ spariscono per sempre!');
INSERT INTO `hunter_quest_tips` VALUES (3, 'Tempo difesa: E/D/C=60s, B=90s, A=120s, S=150s, N=180s. Piu alto il rank, piu tempo hai.');
INSERT INTO `hunter_quest_tips` VALUES (4, 'Se apri una frattura in party, TUTTI devono stare entro 20m. Se un membro si allontana, difesa fallisce!');
INSERT INTO `hunter_quest_tips` VALUES (5, 'In party, le FRATTURE condividono progresso! Se un membro sigilla, TUTTI ricevono gloria e missione.');
INSERT INTO `hunter_quest_tips` VALUES (6, 'Le fratture E-D sono facili. Puoi farle da solo. Non aver paura di clickarle!');
INSERT INTO `hunter_quest_tips` VALUES (7, 'Non clickare fratture se non sei pronto! La difesa inizia SUBITO. Buff prima!');
INSERT INTO `hunter_quest_tips` VALUES (8, 'Prima di aprire frattura B+, controlla che TUTTO il party sia pronto. Buff, HP, distanza!');
INSERT INTO `hunter_quest_tips` VALUES (9, 'Se un membro del party muore durante difesa, la frattura puo fallire. Proteggi i deboli!');
INSERT INTO `hunter_quest_tips` VALUES (10, 'Le Fratture appaiono uccidendo mob - ogni 500 kill (+/-30 livelli) spawna una frattura o Emergency!');
INSERT INTO `hunter_quest_tips` VALUES (11, 'PRIMA DIFESA DEL GIORNO: Completa la tua prima difesa per ottenere Gloria FISSA (100-2000 in base al rank)!');
INSERT INTO `hunter_quest_tips` VALUES (12, 'Punta a completare una frattura N-Rank come prima difesa del giorno: +2000 Gloria bonus garantiti!');
INSERT INTO `hunter_quest_tips` VALUES (13, 'I membri del party ricevono il 50% del bonus Prima Difesa del Giorno.');
INSERT INTO `hunter_quest_tips` VALUES (14, 'Il livello minimo per interagire con le fratture e 75. Prima di quel livello, concentrati sul leveling!');
INSERT INTO `hunter_quest_tips` VALUES (15, 'Il Sistema Hunter ha 7 ranghi: E, D, C, B, A, S e il leggendario N (Monarca Nazionale).');
INSERT INTO `hunter_quest_tips` VALUES (16, 'Ogni rango ti garantisce un bonus Gloria permanente: D=+2%, C=+4%, B=+6%, A=+9%, S=+13%, N=+18%!');
INSERT INTO `hunter_quest_tips` VALUES (17, 'Accedi ogni giorno per la Serie Consecutiva! 3 giorni=+5%, 7 giorni=+10%, 30 giorni=+20% Gloria!');
INSERT INTO `hunter_quest_tips` VALUES (18, 'Se salti UN SOLO giorno perdi la serie e torni a 0%. La costanza e la chiave del potere!');
INSERT INTO `hunter_quest_tips` VALUES (19, 'Bonus Rank + Streak si SOMMANO! Rank N (+18%) + Streak 30d (+20%) = +38% Gloria totale!');
INSERT INTO `hunter_quest_tips` VALUES (20, 'FIRST OF DAY: Prima Missione, Boss, Metin e Baule del giorno danno +50% Gloria extra ciascuno!');
INSERT INTO `hunter_quest_tips` VALUES (21, 'PRIMA DIFESA: La prima difesa completata del giorno da Gloria FISSA in base al rank frattura!');
INSERT INTO `hunter_quest_tips` VALUES (22, 'Puoi ottenere 5 bonus giornalieri diversi: Prima Missione, Primo Boss, Primo Metin, Primo Baule, Prima Difesa!');
INSERT INTO `hunter_quest_tips` VALUES (23, 'I bonus First of Day si resettano a mezzanotte server. Pianifica le tue sessioni!');
INSERT INTO `hunter_quest_tips` VALUES (24, 'Il Sistema Hunter si attiva dal livello 30. Ma fratture richiedono livello 75!');
INSERT INTO `hunter_quest_tips` VALUES (25, 'Ogni giorno alle 00:00 ricevi 3 Missioni Giornaliere. Completale TUTTE per un bonus Gloria x1.5!');
INSERT INTO `hunter_quest_tips` VALUES (26, 'Il bonus x1.5 vale FINO AL RESET! Se fai solo 2 missioni su 3, NON ricevi il bonus.');
INSERT INTO `hunter_quest_tips` VALUES (27, 'Le missioni NON completate ti danno penalita! Perdi gloria totale e karma. Completa sempre tutte e 3!');
INSERT INTO `hunter_quest_tips` VALUES (28, 'Boss, Metin e Bauli sono INDIVIDUALI! Solo chi uccide/apre riceve il progresso missione.');
INSERT INTO `hunter_quest_tips` VALUES (29, 'PRIMA MISSIONE DEL GIORNO: La prima missione completata da +50% Gloria extra!');
INSERT INTO `hunter_quest_tips` VALUES (30, 'Completa la missione piu facile per prima per ottenere il bonus Prima Missione velocemente!');
INSERT INTO `hunter_quest_tips` VALUES (31, 'Completare 3/3 missioni attiva anche il BONUS FRATTURE: +50% Gloria sulle fratture fino a mezzanotte!');
INSERT INTO `hunter_quest_tips` VALUES (32, 'In party, il leader puo usare Risonatore di Gruppo (15k gloria) per +30% gloria a tutti!');
INSERT INTO `hunter_quest_tips` VALUES (33, 'Comunicazione e chiave! Se apri frattura S/N avvisa il party. Servono strategie coordinate.');
INSERT INTO `hunter_quest_tips` VALUES (34, 'Party bilanciato: 1 Tank, 2-3 DPS, 1 Support. Fratture N richiedono composizione perfetta!');
INSERT INTO `hunter_quest_tips` VALUES (35, 'In party, la Gloria viene distribuita in base al livello e al danno inflitto!');
INSERT INTO `hunter_quest_tips` VALUES (36, 'Il bonus Prima Difesa viene condiviso: leader 100%, membri 50% del bonus.');
INSERT INTO `hunter_quest_tips` VALUES (37, 'Compra Scanner di Fratture (1k gloria) per trovare fratture quando vuoi. Utile per farm!');
INSERT INTO `hunter_quest_tips` VALUES (38, 'Compra Focus del Cacciatore (2.5k gloria) prima di farm session. +20% gloria per 30 min!');
INSERT INTO `hunter_quest_tips` VALUES (39, 'Calibratore (4k) aumenta chance prossima frattura sia grado alto. Usa prima di Scanner!');
INSERT INTO `hunter_quest_tips` VALUES (40, 'Stabilizzatore Portale (7.5k) aggiunge +30s al tempo di difesa. Utile per fratture difficili!');
INSERT INTO `hunter_quest_tips` VALUES (41, 'Item piu forte: Sigillo di Conquista (12.5k) = Forza apertura senza party!');
INSERT INTO `hunter_quest_tips` VALUES (42, 'La Chiave Dimensionale costa 25.000 gloria e garantisce accesso a Gate S-Rank!');
INSERT INTO `hunter_quest_tips` VALUES (43, 'Non sprecare Gloria! Prima di comprare item costosi, valuta se ti servono davvero.');
INSERT INTO `hunter_quest_tips` VALUES (44, 'Gli eventi giornalieri offrono moltiplicatori Gloria x2, x3, fino a x5! Controlla gli orari!');
INSERT INTO `hunter_quest_tips` VALUES (45, 'Eventi first_rift e first_boss: Il PRIMO giocatore a completare vince un premio enorme!');
INSERT INTO `hunter_quest_tips` VALUES (46, 'Durante gli eventi Gloria Rush, QUALSIASI attivita da Gloria moltiplicata!');
INSERT INTO `hunter_quest_tips` VALUES (47, 'Controlla il calendario eventi nel menu Hunter per pianificare le tue sessioni di farm.');
INSERT INTO `hunter_quest_tips` VALUES (48, 'Gli eventi del weekend sono i piu ricchi! Sabato e Domenica hanno i premi piu alti.');
INSERT INTO `hunter_quest_tips` VALUES (49, 'Sistema Pity: Dopo 10 difese fallite consecutive, la prossima frattura sara PIU FACILE!');
INSERT INTO `hunter_quest_tips` VALUES (50, 'Il Pity si resetta quando completi una difesa con successo.');
INSERT INTO `hunter_quest_tips` VALUES (51, 'Se fallisci troppe difese, il sistema riduce i mob e aumenta il tempo automaticamente.');

-- ----------------------------
-- Table structure for hunter_rank_trials
-- ----------------------------
DROP TABLE IF EXISTS `hunter_rank_trials`;
CREATE TABLE `hunter_rank_trials`  (
  `trial_id` int NOT NULL AUTO_INCREMENT,
  `from_rank` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Rank attuale',
  `to_rank` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Rank obiettivo',
  `trial_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trial_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `required_gloria` int NOT NULL DEFAULT 0,
  `required_level` int NOT NULL DEFAULT 1,
  `required_boss_kills` int NOT NULL DEFAULT 0,
  `boss_vnum_list` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Lista VNUM separati da virgola, NULL=qualsiasi boss',
  `required_metin_kills` int NOT NULL DEFAULT 0,
  `metin_vnum_list` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Lista VNUM, NULL=qualsiasi metin',
  `required_fracture_seals` int NOT NULL DEFAULT 0,
  `fracture_color_list` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Colori fratture, NULL=qualsiasi',
  `required_chest_opens` int NOT NULL DEFAULT 0,
  `chest_vnum_list` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'VNUM bauli, NULL=qualsiasi',
  `required_daily_missions` int NOT NULL DEFAULT 0,
  `required_daily_streaks` int NOT NULL DEFAULT 0,
  `time_limit_hours` int NULL DEFAULT NULL COMMENT 'NULL = nessun limite',
  `gloria_reward` int NOT NULL DEFAULT 0,
  `title_reward` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `item_reward_vnum` int NULL DEFAULT NULL,
  `item_reward_count` int NULL DEFAULT 1,
  `color_code` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'BLUE',
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`trial_id`) USING BTREE,
  UNIQUE INDEX `unique_rank_transition`(`from_rank` ASC, `to_rank` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hunter_rank_trials
-- ----------------------------
INSERT INTO `hunter_rank_trials` VALUES (1, 'E', 'D', 'Prova del Risvegliato', 'Dimostra di essere degno del rango D. Uccidi boss di basso livello e sigilla fratture primordiali.', 2000, 35, 3, '4035', 6, '4700,4701', 0, 'GREEN', 0, '63000', 0, 0, NULL, 500, NULL, NULL, 1, 'GREEN', 1);
INSERT INTO `hunter_rank_trials` VALUES (2, 'D', 'C', 'Prova del Cacciatore', 'Caccia boss più potenti e affronta fratture astrali. Solo i veri cacciatori sopravvivono.', 10000, 55, 5, '4035,719,2771', 10, '4701,4702,4703', 5, 'GREEN,BLUE', 5, NULL, 0, 0, NULL, 1000, NULL, NULL, 1, 'BLUE', 1);
INSERT INTO `hunter_rank_trials` VALUES (3, 'C', 'B', 'Prova del Veterano', 'Affronta le creature più pericolose. Solo i veterani possono aspirare al rango B.', 50000, 75, 10, '719,2771,768,6790', 20, '4702,4703,4704', 10, 'BLUE,ORANGE', 0, NULL, 15, 0, NULL, 2000, NULL, NULL, 1, 'ORANGE', 1);
INSERT INTO `hunter_rank_trials` VALUES (4, 'B', 'A', 'Risveglio Interiore', 'Il tuo potere interiore deve risvegliarsi. Affronta boss leggendari e fratture cremisi.', 150000, 95, 15, '6831,986,989', 30, '4704,4705,4706', 15, 'ORANGE,RED', 0, NULL, 0, 7, 168, 5000, NULL, NULL, 1, 'RED', 1);
INSERT INTO `hunter_rank_trials` VALUES (5, 'A', 'S', 'Ascensione Leggendaria', 'Solo i più potenti possono diventare leggende. Questa prova è brutale.', 500000, 115, 25, '989,4011,6830', 50, '4706,4707,4708', 25, 'RED,GOLD', 0, NULL, 0, 14, 336, 15000, 'Leggenda Vivente', NULL, 1, 'GOLD', 1);
INSERT INTO `hunter_rank_trials` VALUES (6, 'S', 'N', 'Il Giudizio Finale', 'La prova definitiva. Solo coloro che trascendono i limiti mortali possono diventare NATIONAL.', 1500000, 140, 50, '4011,6830,4385', 100, '4707,4708', 50, 'GOLD,PURPLE,BLACKWHITE', 20, '63003', 0, 30, 720, 50000, 'Monarca Nazionale', NULL, 1, 'BLACKWHITE', 1);

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
  `bonus_drop` int NULL DEFAULT 0,
  `rank_order` int NULL DEFAULT 0,
  PRIMARY KEY (`rank_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hunter_ranks
-- ----------------------------
INSERT INTO `hunter_ranks` VALUES (1, 'E', 'E-Rank', 'Risvegliato', 0, 2000, 'FF808080', 0, 0, 1);
INSERT INTO `hunter_ranks` VALUES (2, 'D', 'D-Rank', 'Apprendista', 2000, 10000, 'FF00AA00', 2, 0, 2);
INSERT INTO `hunter_ranks` VALUES (3, 'C', 'C-Rank', 'Cacciatore', 10000, 50000, 'FF00CCFF', 4, 0, 3);
INSERT INTO `hunter_ranks` VALUES (4, 'B', 'B-Rank', 'Veterano', 50000, 150000, 'FF0066FF', 6, 0, 4);
INSERT INTO `hunter_ranks` VALUES (5, 'A', 'A-Rank', 'Maestro', 150000, 500000, 'FFAA00FF', 9, 0, 5);
INSERT INTO `hunter_ranks` VALUES (6, 'S', 'S-Rank', 'Leggenda', 500000, 1500000, 'FFFF6600', 13, 0, 6);
INSERT INTO `hunter_ranks` VALUES (7, 'N', 'NATIONAL', 'Monarca Nazionale', 1500000, 5000000, 'FFFF0000', 18, 0, 7);
INSERT INTO `hunter_ranks` VALUES (8, '?', '???', 'Trascendente', 5000000, 999999999, 'FFFFFFFF', 35, 0, 8);

-- ----------------------------
-- Table structure for hunter_scheduled_events
-- ----------------------------
DROP TABLE IF EXISTS `hunter_scheduled_events`;
CREATE TABLE `hunter_scheduled_events`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `event_name` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `event_type` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `event_desc` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `start_hour` tinyint NOT NULL DEFAULT 0,
  `start_minute` tinyint NOT NULL DEFAULT 0,
  `duration_minutes` smallint NOT NULL DEFAULT 30,
  `days_active` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '1,2,3,4,5,6,7',
  `min_rank` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'E',
  `reward_glory_base` int NOT NULL DEFAULT 50,
  `reward_glory_winner` int NOT NULL DEFAULT 200,
  `color_scheme` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT 'GOLD',
  `priority` tinyint NULL DEFAULT 5,
  `enabled` tinyint(1) NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `glory_multiplier` float NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_enabled`(`enabled` ASC) USING BTREE,
  INDEX `idx_start_hour`(`start_hour` ASC) USING BTREE,
  INDEX `idx_days_active`(`days_active` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hunter_scheduled_events
-- ----------------------------
INSERT INTO `hunter_scheduled_events` VALUES (1, 'Alba del Cacciatore', 'glory_rush', 'Gloria x2 per ogni uccisione! Svegliati e guadagna!', 5, 0, 60, '1,2,3,4,5,6,7', 'E', 20, 121, 'GOLD', 5, 1, '2025-12-24 16:44:17', NULL);
INSERT INTO `hunter_scheduled_events` VALUES (2, 'Prima Frattura', 'first_rift', 'Chi trova PER PRIMO la Frattura dellAlba vince!', 6, 0, 30, '1,2,3,4,5,6,7', 'E', 50, 363, 'PURPLE', 6, 1, '2025-12-24 16:44:17', NULL);
INSERT INTO `hunter_scheduled_events` VALUES (3, 'Risveglio dei Boss', 'first_boss', 'Boss Mattutino spawna! Chi lo uccide PER PRIMO?', 7, 0, 30, '1,2,3,4,5,6,7', 'D', 60, 423, 'RED', 6, 1, '2025-12-24 16:44:17', NULL);
INSERT INTO `hunter_scheduled_events` VALUES (4, 'Caccia alle Fratture', 'fracture_hunter', 'Chi sigilla PIU fratture in 20 minuti vince!', 8, 0, 20, '1,2,3,4,5,6,7', 'E', 40, 302, 'PURPLE', 5, 1, '2025-12-26 12:00:00', NULL);
INSERT INTO `hunter_scheduled_events` VALUES (5, 'Caccia ai Bauli', 'chest_hunter', 'Chi apre PIU bauli in 20 minuti vince!', 9, 0, 20, '1,2,3,4,5,6,7', 'E', 35, 242, 'GOLD', 5, 1, '2025-12-26 12:00:00', NULL);
INSERT INTO `hunter_scheduled_events` VALUES (6, 'Caccia ai Boss', 'boss_hunter', 'Chi uccide PIU boss in 20 minuti vince!', 10, 0, 20, '1,2,3,4,5,6,7', 'D', 70, 484, 'RED', 6, 1, '2025-12-26 12:00:00', NULL);
INSERT INTO `hunter_scheduled_events` VALUES (7, 'Gloria Rush Mezzogiorno', 'glory_rush', 'GLORIA x2 per TUTTO! Farming intensivo!', 11, 30, 30, '1,2,3,4,5,6,7', 'E', 25, 145, 'GOLD', 6, 1, '2025-12-24 16:44:17', NULL);
INSERT INTO `hunter_scheduled_events` VALUES (8, 'Frattura del Mezzogiorno', 'first_rift', 'Frattura Dorata! Il PRIMO che la trova vince GROSSO!', 12, 0, 25, '1,2,3,4,5,6,7', 'C', 100, 726, 'GOLD', 8, 1, '2025-12-24 16:44:17', NULL);
INSERT INTO `hunter_scheduled_events` VALUES (9, 'Caccia al Boss Leggendario', 'first_boss', 'Boss Leggendario spawna! Chi lo abbatte PER PRIMO?', 12, 30, 30, '1,2,3,4,5,6,7', 'C', 120, 847, 'RED', 9, 1, '2025-12-24 16:44:17', NULL);
INSERT INTO `hunter_scheduled_events` VALUES (10, 'Caccia ai Metin', 'metin_hunter', 'Chi distrugge PIU metin in 20 minuti vince!', 13, 0, 20, '1,2,3,4,5,6,7', 'E', 30, 217, 'ORANGE', 5, 1, '2025-12-26 12:00:00', NULL);
INSERT INTO `hunter_scheduled_events` VALUES (11, 'Gloria Rush Pomeriggio', 'glory_rush', 'GLORIA x2 per TUTTO! Continua a farmare!', 14, 30, 30, '1,2,3,4,5,6,7', 'E', 25, 145, 'GOLD', 6, 1, '2025-12-26 12:00:00', NULL);
INSERT INTO `hunter_scheduled_events` VALUES (12, 'Frattura Pomeridiana', 'first_rift', 'Frattura Epica! Trovala PRIMA degli altri!', 15, 0, 30, '1,2,3,4,5,6,7', 'B', 150, 1089, 'PURPLE', 8, 1, '2025-12-26 12:00:00', NULL);
INSERT INTO `hunter_scheduled_events` VALUES (13, 'Boss Elite Hunt', 'first_boss', 'Boss Elite spawna! Chi lo uccide PER PRIMO?', 15, 30, 30, '1,2,3,4,5,6,7', 'B', 180, 1210, 'RED', 9, 1, '2025-12-26 12:00:00', NULL);
INSERT INTO `hunter_scheduled_events` VALUES (14, 'Gloria Rush Sera', 'glory_rush', 'GLORIA x3 per 45 minuti! FARMING MASSIMO!', 18, 5, 45, '1,2,3,4,5,6,7', 'D', 50, 242, 'GOLD', 8, 1, '2025-12-24 16:44:17', NULL);
INSERT INTO `hunter_scheduled_events` VALUES (15, 'Frattura della Sera', 'first_rift', 'Frattura della Sera! Trovala per prima!', 19, 0, 30, '1,2,3,4,5,6,7', 'A', 200, 1452, 'GOLD', 10, 1, '2025-12-26 12:00:00', NULL);
INSERT INTO `hunter_scheduled_events` VALUES (16, 'MEGA Boss Hunt', 'first_boss', 'MEGA BOSS spawna! Chi lo uccide PRIMO?', 19, 30, 30, '1,2,3,4,5,6,7', 'A', 250, 1815, 'RED', 10, 1, '2025-12-24 16:44:17', NULL);
INSERT INTO `hunter_scheduled_events` VALUES (17, 'Frattura Notturna', 'first_rift', 'Frattura dellOmbra appare SOLO di notte! Trovala!', 22, 0, 30, '1,2,3,4,5,6,7', 'A', 180, 1331, 'PURPLE', 10, 1, '2025-12-24 16:44:17', NULL);
INSERT INTO `hunter_scheduled_events` VALUES (18, 'Boss Notturno Leggendario', 'first_boss', 'BOSS NOTTURNO! Appare solo a mezzanotte!', 22, 30, 30, '1,2,3,4,5,6,7', 'S', 300, 2178, 'RED', 10, 1, '2025-12-24 16:44:17', NULL);
INSERT INTO `hunter_scheduled_events` VALUES (19, 'Gloria Notturna x4', 'glory_rush', 'GLORIA x4! Solo per chi resta sveglio!', 1, 30, 60, '1,2,3,4,5,6,7', 'C', 40, 302, 'GOLD', 8, 1, '2025-12-24 16:44:17', 4);
INSERT INTO `hunter_scheduled_events` VALUES (20, 'Frattura del Giudizio', 'first_rift', 'Frattura FINALE della notte! Premio MASSIMO!', 1, 0, 30, '1,2,3,4,5,6,7', 'A', 200, 1573, 'PURPLE', 10, 1, '2025-12-24 16:44:17', NULL);
INSERT INTO `hunter_scheduled_events` VALUES (21, 'Boss Prima dellAlba', 'first_boss', 'Ultimo Boss prima dellalba! Chi lo uccide?', 4, 15, 30, '1,2,3,4,5,6,7', 'C', 70, 544, 'RED', 7, 1, '2025-12-24 16:44:17', NULL);
INSERT INTO `hunter_scheduled_events` VALUES (22, 'Sabato Gloria x3', 'glory_rush', 'WEEKEND! Gloria TRIPLA tutto il giorno!', 10, 0, 120, '6', 'E', 30, 181, 'GOLD', 8, 1, '2025-12-24 16:44:17', 3);
INSERT INTO `hunter_scheduled_events` VALUES (23, 'Sabato Frattura Dorata', 'first_rift', 'Frattura DORATA del weekend! Premio x2!', 11, 0, 30, '6', 'C', 150, 1089, 'GOLD', 9, 1, '2025-12-24 16:44:17', NULL);
INSERT INTO `hunter_scheduled_events` VALUES (24, 'WORLD BOSS Sabato', 'first_boss', 'WORLD BOSS SETTIMANALE! Chi lo uccide?', 20, 0, 60, '6', 'S', 400, 3630, 'RED', 10, 1, '2025-12-24 16:44:17', NULL);
INSERT INTO `hunter_scheduled_events` VALUES (25, 'Notte Sabato - Tutto x4', 'glory_rush', 'GLORIA x4 tutta la notte di sabato!', 22, 0, 120, '6', 'D', 50, 363, 'GOLD', 9, 1, '2025-12-24 16:44:17', 4);
INSERT INTO `hunter_scheduled_events` VALUES (26, 'Domenica Relax Gloria x2', 'glory_rush', 'Domenica tranquilla con Gloria x2!', 9, 0, 180, '7', 'E', 25, 145, 'GOLD', 7, 1, '2025-12-24 16:44:17', NULL);
INSERT INTO `hunter_scheduled_events` VALUES (27, 'Frattura Domenicale', 'first_rift', 'Frattura della Domenica! Trovala!', 18, 0, 30, '7', 'S', 350, 3025, 'PURPLE', 10, 1, '2025-12-24 16:44:17', NULL);
INSERT INTO `hunter_scheduled_events` VALUES (28, 'BOSS FINALE SETTIMANALE', 'first_boss', 'IL BOSS PIU FORTE! Chi lo abbatte?', 20, 0, 60, '7', 'S', 500, 4840, 'RED', 10, 1, '2025-12-24 16:44:17', NULL);
INSERT INTO `hunter_scheduled_events` VALUES (29, 'Countdown Settimana', 'glory_rush', 'Ultime ore! Gloria x5!', 22, 0, 120, '7', 'E', 60, 423, 'GOLD', 10, 1, '2025-12-24 16:44:17', NULL);

-- ----------------------------
-- Table structure for hunter_security_logs
-- ----------------------------
DROP TABLE IF EXISTS `hunter_security_logs`;
CREATE TABLE `hunter_security_logs`  (
  `log_id` bigint NOT NULL AUTO_INCREMENT,
  `player_id` int NOT NULL,
  `player_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `log_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'SPAWN, DEFENSE, REWARD, KILL, FRACTURE, CHEST, GLORY, SUSPICIOUS',
  `severity` enum('INFO','WARNING','ALERT','CRITICAL') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'INFO',
  `action` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Azione eseguita',
  `details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT 'Dettagli JSON',
  `map_index` int NULL DEFAULT 0,
  `position_x` int NULL DEFAULT 0,
  `position_y` int NULL DEFAULT 0,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`log_id`) USING BTREE,
  INDEX `idx_player`(`player_id` ASC, `created_at` ASC) USING BTREE,
  INDEX `idx_type_severity`(`log_type` ASC, `severity` ASC, `created_at` ASC) USING BTREE,
  INDEX `idx_created`(`created_at` ASC) USING BTREE,
  INDEX `idx_severity`(`severity` ASC, `created_at` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 393 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hunter_security_logs
-- ----------------------------
INSERT INTO `hunter_security_logs` VALUES (1, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4086 rank=E-Rank', 2, 9589, 2432, NULL, '2026-01-17 10:14:50');
INSERT INTO `hunter_security_logs` VALUES (2, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=4086 reason=TEMPO SCADUTO! Mob rimasti: 1', 2, 9588, 2434, NULL, '2026-01-17 10:15:49');
INSERT INTO `hunter_security_logs` VALUES (3, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=41 items=none total_session=1', 2, 9639, 2874, NULL, '2026-01-18 01:45:06');
INSERT INTO `hunter_security_logs` VALUES (4, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=82 items=none total_session=1', 2, 9726, 2944, NULL, '2026-01-18 01:50:25');
INSERT INTO `hunter_security_logs` VALUES (5, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=21 items=none total_session=1', 2, 9536, 3126, NULL, '2026-01-19 09:26:46');
INSERT INTO `hunter_security_logs` VALUES (6, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=26 items=Buono 100 Gloria total_session=2', 2, 9516, 3115, NULL, '2026-01-19 09:27:10');
INSERT INTO `hunter_security_logs` VALUES (7, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4433 rank=E-Rank', 2, 9529, 3124, NULL, '2026-01-19 09:29:09');
INSERT INTO `hunter_security_logs` VALUES (8, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=4433 rank=E-Rank', 2, 9527, 3124, NULL, '2026-01-19 09:30:09');
INSERT INTO `hunter_security_logs` VALUES (9, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9527, 3124, NULL, '2026-01-19 09:30:16');
INSERT INTO `hunter_security_logs` VALUES (10, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9297, 2946, NULL, '2026-01-19 09:34:00');
INSERT INTO `hunter_security_logs` VALUES (11, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=4 items=none total_session=1', 2, 9309, 2957, NULL, '2026-01-19 09:35:27');
INSERT INTO `hunter_security_logs` VALUES (12, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9309, 2957, NULL, '2026-01-19 09:38:56');
INSERT INTO `hunter_security_logs` VALUES (13, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=2', 2, 9774, 2959, NULL, '2026-01-19 09:42:26');
INSERT INTO `hunter_security_logs` VALUES (14, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9789, 2978, NULL, '2026-01-19 09:46:34');
INSERT INTO `hunter_security_logs` VALUES (15, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4696 rank=E-Rank', 2, 9682, 2938, NULL, '2026-01-19 09:59:01');
INSERT INTO `hunter_security_logs` VALUES (16, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=4696 reason=TEMPO SCADUTO! Mob rimasti: 1', 2, 9680, 2932, NULL, '2026-01-19 10:00:01');
INSERT INTO `hunter_security_logs` VALUES (17, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4696 rank=E-Rank', 2, 9683, 2938, NULL, '2026-01-19 10:00:13');
INSERT INTO `hunter_security_logs` VALUES (18, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=4696 reason=TEMPO SCADUTO! Mob rimasti: 3', 2, 9687, 2947, NULL, '2026-01-19 10:01:13');
INSERT INTO `hunter_security_logs` VALUES (19, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4265 rank=E-Rank', 2, 9732, 2954, NULL, '2026-01-19 10:20:15');
INSERT INTO `hunter_security_logs` VALUES (20, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=4265 rank=E-Rank', 2, 9732, 2953, NULL, '2026-01-19 10:21:15');
INSERT INTO `hunter_security_logs` VALUES (21, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9732, 2953, NULL, '2026-01-19 10:21:26');
INSERT INTO `hunter_security_logs` VALUES (22, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4495 rank=E-Rank', 2, 9774, 2978, NULL, '2026-01-19 14:32:56');
INSERT INTO `hunter_security_logs` VALUES (23, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=4495 rank=E-Rank', 2, 9779, 2978, NULL, '2026-01-19 14:33:56');
INSERT INTO `hunter_security_logs` VALUES (24, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9773, 2978, NULL, '2026-01-19 14:34:02');
INSERT INTO `hunter_security_logs` VALUES (25, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=2', 2, 9775, 2977, NULL, '2026-01-19 14:34:32');
INSERT INTO `hunter_security_logs` VALUES (26, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=3', 2, 9771, 2972, NULL, '2026-01-19 14:34:50');
INSERT INTO `hunter_security_logs` VALUES (27, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=4', 2, 9771, 2976, NULL, '2026-01-19 14:35:13');
INSERT INTO `hunter_security_logs` VALUES (28, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=5', 2, 9773, 2973, NULL, '2026-01-19 14:35:40');
INSERT INTO `hunter_security_logs` VALUES (29, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=6', 2, 9768, 2970, NULL, '2026-01-19 14:36:11');
INSERT INTO `hunter_security_logs` VALUES (30, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=7', 2, 9769, 2970, NULL, '2026-01-19 14:36:14');
INSERT INTO `hunter_security_logs` VALUES (31, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=43 items=none total_session=1', 2, 9774, 2970, NULL, '2026-01-19 14:36:30');
INSERT INTO `hunter_security_logs` VALUES (32, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=8', 2, 9767, 2965, NULL, '2026-01-19 14:36:48');
INSERT INTO `hunter_security_logs` VALUES (33, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=9', 2, 9766, 2967, NULL, '2026-01-19 14:39:12');
INSERT INTO `hunter_security_logs` VALUES (34, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=43 items=none total_session=1', 2, 9804, 3030, NULL, '2026-01-19 14:49:49');
INSERT INTO `hunter_security_logs` VALUES (35, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9799, 3017, NULL, '2026-01-19 14:50:06');
INSERT INTO `hunter_security_logs` VALUES (36, 1, '[GF]Wesker', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=118 items=none total_session=1', 2, 9651, 2752, NULL, '2026-01-19 18:29:59');
INSERT INTO `hunter_security_logs` VALUES (37, 1, '[GF]Wesker', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=82 items=none total_session=2', 2, 9651, 2757, NULL, '2026-01-19 18:31:18');
INSERT INTO `hunter_security_logs` VALUES (38, 1, '[GF]Wesker', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=124 items=Buono 100 Gloria total_session=3', 2, 9657, 2751, NULL, '2026-01-19 18:31:54');
INSERT INTO `hunter_security_logs` VALUES (39, 1, '[GF]Wesker', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=94 items=none total_session=4', 2, 9656, 2752, NULL, '2026-01-19 18:32:44');
INSERT INTO `hunter_security_logs` VALUES (40, 1, '[GF]Wesker', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=80 items=none total_session=5', 2, 9666, 2758, NULL, '2026-01-19 18:32:49');
INSERT INTO `hunter_security_logs` VALUES (41, 1, '[GF]Wesker', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=128 items=Buono 100 Gloria total_session=6', 2, 9674, 2762, NULL, '2026-01-19 18:32:55');
INSERT INTO `hunter_security_logs` VALUES (42, 1, '[GF]Wesker', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=72 items=none total_session=7', 2, 9677, 2764, NULL, '2026-01-19 18:33:09');
INSERT INTO `hunter_security_logs` VALUES (43, 1, '[GF]Wesker', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=120 items=none total_session=8', 2, 9677, 2764, NULL, '2026-01-19 18:33:14');
INSERT INTO `hunter_security_logs` VALUES (44, 1, '[GF]Wesker', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=52 items=none total_session=9', 2, 9655, 2756, NULL, '2026-01-19 18:53:11');
INSERT INTO `hunter_security_logs` VALUES (45, 1, '[GF]Wesker', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=43 items=none total_session=10', 2, 9653, 2756, NULL, '2026-01-19 18:53:15');
INSERT INTO `hunter_security_logs` VALUES (46, 1, '[GF]Wesker', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=63 items=none total_session=11', 2, 9653, 2756, NULL, '2026-01-19 18:53:22');
INSERT INTO `hunter_security_logs` VALUES (47, 1, '[GF]Wesker', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=52 items=none total_session=12', 2, 9653, 2756, NULL, '2026-01-19 18:53:26');
INSERT INTO `hunter_security_logs` VALUES (48, 1, '[GF]Wesker', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=35 items=none total_session=13', 2, 9653, 2756, NULL, '2026-01-19 18:53:33');
INSERT INTO `hunter_security_logs` VALUES (49, 1, '[GF]Wesker', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=68 items=none total_session=14', 2, 9653, 2756, NULL, '2026-01-19 18:55:20');
INSERT INTO `hunter_security_logs` VALUES (50, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9668, 2725, NULL, '2026-01-19 19:34:45');
INSERT INTO `hunter_security_logs` VALUES (51, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4427 rank=S-Rank', 2, 9672, 2726, NULL, '2026-01-19 19:36:20');
INSERT INTO `hunter_security_logs` VALUES (52, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4427 rank=S-Rank', 2, 9677, 2724, NULL, '2026-01-19 19:38:40');
INSERT INTO `hunter_security_logs` VALUES (53, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=4427 reason=[GF]HunabKu si e\' allontanato!', 2, 9704, 2683, NULL, '2026-01-19 19:38:46');
INSERT INTO `hunter_security_logs` VALUES (54, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4464 rank=S-Rank', 2, 9851, 2713, NULL, '2026-01-19 19:39:00');
INSERT INTO `hunter_security_logs` VALUES (55, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=4464 rank=S-Rank', 2, 9856, 2709, NULL, '2026-01-19 19:41:30');
INSERT INTO `hunter_security_logs` VALUES (56, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=2', 2, 9857, 2705, NULL, '2026-01-19 19:41:38');
INSERT INTO `hunter_security_logs` VALUES (57, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa D-Rank glory=73 items=none total_session=1', 2, 9856, 2706, NULL, '2026-01-19 19:41:47');
INSERT INTO `hunter_security_logs` VALUES (58, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=3', 2, 9854, 2715, NULL, '2026-01-19 19:42:09');
INSERT INTO `hunter_security_logs` VALUES (59, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=5177 rank=S-Rank', 2, 9845, 2797, NULL, '2026-01-19 19:47:59');
INSERT INTO `hunter_security_logs` VALUES (60, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=5177 reason=[GF]HunabKu si e\' allontanato!', 2, 9832, 2818, NULL, '2026-01-19 19:48:01');
INSERT INTO `hunter_security_logs` VALUES (61, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=5227 rank=S-Rank', 2, 9832, 2818, NULL, '2026-01-19 19:48:08');
INSERT INTO `hunter_security_logs` VALUES (62, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=4', 2, 9677, 2766, NULL, '2026-01-19 19:48:48');
INSERT INTO `hunter_security_logs` VALUES (63, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4372 rank=N-Rank', 2, 9669, 2732, NULL, '2026-01-19 19:51:22');
INSERT INTO `hunter_security_logs` VALUES (64, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=4372 rank=N-Rank', 2, 9666, 2733, NULL, '2026-01-19 19:54:22');
INSERT INTO `hunter_security_logs` VALUES (65, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4098 rank=S-Rank', 2, 9778, 2702, NULL, '2026-01-19 20:06:05');
INSERT INTO `hunter_security_logs` VALUES (66, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=4098 reason=[GF]HunabKu si e\' allontanato!', 2, 9743, 2690, NULL, '2026-01-19 20:06:19');
INSERT INTO `hunter_security_logs` VALUES (67, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9826, 2715, NULL, '2026-01-19 20:06:35');
INSERT INTO `hunter_security_logs` VALUES (68, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4125 rank=S-Rank', 2, 9748, 2690, NULL, '2026-01-19 20:08:23');
INSERT INTO `hunter_security_logs` VALUES (69, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4125 rank=S-Rank', 2, 9746, 2692, NULL, '2026-01-19 20:08:38');
INSERT INTO `hunter_security_logs` VALUES (70, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=4125 reason=[GF]HunabKu si e\' allontanato!', 2, 9766, 2694, NULL, '2026-01-19 20:08:44');
INSERT INTO `hunter_security_logs` VALUES (71, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4231 rank=D-Rank', 2, 9677, 2700, NULL, '2026-01-19 20:14:00');
INSERT INTO `hunter_security_logs` VALUES (72, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=4231 reason=[GF]HunabKu si e\' allontanato!', 2, 9638, 2691, NULL, '2026-01-19 20:14:10');
INSERT INTO `hunter_security_logs` VALUES (73, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4400 rank=E-Rank', 2, 9730, 2947, NULL, '2026-01-20 00:57:28');
INSERT INTO `hunter_security_logs` VALUES (74, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=4400 rank=E-Rank', 2, 9726, 2940, NULL, '2026-01-20 00:58:28');
INSERT INTO `hunter_security_logs` VALUES (75, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9724, 2941, NULL, '2026-01-20 00:58:38');
INSERT INTO `hunter_security_logs` VALUES (76, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4415 rank=N-Rank', 2, 9673, 2718, NULL, '2026-01-20 01:26:18');
INSERT INTO `hunter_security_logs` VALUES (77, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=4415 reason=[GF]HunabKu si e\' allontanato!', 2, 9683, 2679, NULL, '2026-01-20 01:26:42');
INSERT INTO `hunter_security_logs` VALUES (78, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=32 items=none total_session=1', 2, 9873, 3125, NULL, '2026-01-20 13:35:58');
INSERT INTO `hunter_security_logs` VALUES (79, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=44 items=none total_session=2', 2, 9871, 3117, NULL, '2026-01-20 13:36:05');
INSERT INTO `hunter_security_logs` VALUES (80, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=43 items=none total_session=3', 2, 9872, 3120, NULL, '2026-01-20 13:36:32');
INSERT INTO `hunter_security_logs` VALUES (81, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=33 items=none total_session=4', 2, 9872, 3120, NULL, '2026-01-20 13:36:37');
INSERT INTO `hunter_security_logs` VALUES (82, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=52 items=none total_session=5', 2, 9872, 3117, NULL, '2026-01-20 13:36:42');
INSERT INTO `hunter_security_logs` VALUES (83, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=60 items=none total_session=6', 2, 9874, 3119, NULL, '2026-01-20 13:36:47');
INSERT INTO `hunter_security_logs` VALUES (84, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=50 items=Buono 100 Gloria total_session=7', 2, 9874, 3119, NULL, '2026-01-20 13:36:58');
INSERT INTO `hunter_security_logs` VALUES (85, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=47 items=none total_session=8', 2, 9874, 3119, NULL, '2026-01-20 13:37:07');
INSERT INTO `hunter_security_logs` VALUES (86, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=39 items=none total_session=9', 2, 9874, 3121, NULL, '2026-01-20 13:37:12');
INSERT INTO `hunter_security_logs` VALUES (87, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=35 items=none total_session=10', 2, 9875, 3120, NULL, '2026-01-20 13:37:17');
INSERT INTO `hunter_security_logs` VALUES (88, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=33 items=none total_session=11', 2, 9876, 3118, NULL, '2026-01-20 13:37:23');
INSERT INTO `hunter_security_logs` VALUES (89, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=44 items=none total_session=12', 2, 9872, 3122, NULL, '2026-01-20 13:37:43');
INSERT INTO `hunter_security_logs` VALUES (90, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=30 items=Buono 100 Gloria total_session=13', 2, 9870, 3121, NULL, '2026-01-20 13:37:47');
INSERT INTO `hunter_security_logs` VALUES (91, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=32 items=Buono 100 Gloria total_session=14', 2, 9870, 3121, NULL, '2026-01-20 13:37:56');
INSERT INTO `hunter_security_logs` VALUES (92, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=40 items=none total_session=15', 2, 9870, 3121, NULL, '2026-01-20 13:38:02');
INSERT INTO `hunter_security_logs` VALUES (93, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=44 items=none total_session=16', 2, 9870, 3121, NULL, '2026-01-20 13:38:08');
INSERT INTO `hunter_security_logs` VALUES (94, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=38 items=none total_session=17', 2, 9871, 3124, NULL, '2026-01-20 13:38:26');
INSERT INTO `hunter_security_logs` VALUES (95, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=60 items=Buono 100 Gloria total_session=18', 2, 9871, 3124, NULL, '2026-01-20 13:38:31');
INSERT INTO `hunter_security_logs` VALUES (96, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=34 items=none total_session=19', 2, 9868, 3122, NULL, '2026-01-20 13:38:59');
INSERT INTO `hunter_security_logs` VALUES (97, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=57 items=none total_session=20', 2, 9868, 3122, NULL, '2026-01-20 13:39:04');
INSERT INTO `hunter_security_logs` VALUES (98, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=49 items=none total_session=21', 2, 9870, 3120, NULL, '2026-01-20 13:39:30');
INSERT INTO `hunter_security_logs` VALUES (99, 440, 'SuraF', 'CHEST', 'ALERT', 'HIGH_CHEST_RATE', 'total=21 elapsed=212 rate_per_hour=356.6', 2, 9870, 3120, NULL, '2026-01-20 13:39:30');
INSERT INTO `hunter_security_logs` VALUES (100, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=41 items=none total_session=22', 2, 9870, 3122, NULL, '2026-01-20 13:40:14');
INSERT INTO `hunter_security_logs` VALUES (101, 440, 'SuraF', 'CHEST', 'ALERT', 'HIGH_CHEST_RATE', 'total=22 elapsed=256 rate_per_hour=309.4', 2, 9870, 3122, NULL, '2026-01-20 13:40:14');
INSERT INTO `hunter_security_logs` VALUES (102, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=59 items=none total_session=23', 2, 9871, 3125, NULL, '2026-01-20 13:42:13');
INSERT INTO `hunter_security_logs` VALUES (103, 440, 'SuraF', 'CHEST', 'ALERT', 'HIGH_CHEST_RATE', 'total=23 elapsed=375 rate_per_hour=220.8', 2, 9871, 3125, NULL, '2026-01-20 13:42:13');
INSERT INTO `hunter_security_logs` VALUES (104, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=49 items=none total_session=24', 2, 9871, 3125, NULL, '2026-01-20 13:42:55');
INSERT INTO `hunter_security_logs` VALUES (105, 440, 'SuraF', 'CHEST', 'ALERT', 'HIGH_CHEST_RATE', 'total=24 elapsed=417 rate_per_hour=207.2', 2, 9871, 3125, NULL, '2026-01-20 13:42:55');
INSERT INTO `hunter_security_logs` VALUES (106, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=33 items=none total_session=25', 2, 9869, 3124, NULL, '2026-01-20 13:43:54');
INSERT INTO `hunter_security_logs` VALUES (107, 440, 'SuraF', 'CHEST', 'ALERT', 'HIGH_CHEST_RATE', 'total=25 elapsed=476 rate_per_hour=189.1', 2, 9869, 3124, NULL, '2026-01-20 13:43:54');
INSERT INTO `hunter_security_logs` VALUES (108, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=43 items=none total_session=26', 2, 9869, 3124, NULL, '2026-01-20 13:43:59');
INSERT INTO `hunter_security_logs` VALUES (109, 440, 'SuraF', 'CHEST', 'ALERT', 'HIGH_CHEST_RATE', 'total=26 elapsed=481 rate_per_hour=194.6', 2, 9869, 3124, NULL, '2026-01-20 13:43:59');
INSERT INTO `hunter_security_logs` VALUES (110, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=54 items=Buono 100 Gloria total_session=27', 2, 9869, 3125, NULL, '2026-01-20 13:44:05');
INSERT INTO `hunter_security_logs` VALUES (111, 440, 'SuraF', 'CHEST', 'ALERT', 'HIGH_CHEST_RATE', 'total=27 elapsed=487 rate_per_hour=199.6', 2, 9869, 3125, NULL, '2026-01-20 13:44:05');
INSERT INTO `hunter_security_logs` VALUES (112, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=45 items=none total_session=28', 2, 9869, 3127, NULL, '2026-01-20 13:44:11');
INSERT INTO `hunter_security_logs` VALUES (113, 440, 'SuraF', 'CHEST', 'ALERT', 'HIGH_CHEST_RATE', 'total=28 elapsed=493 rate_per_hour=204.5', 2, 9869, 3127, NULL, '2026-01-20 13:44:11');
INSERT INTO `hunter_security_logs` VALUES (114, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=53 items=none total_session=29', 2, 9868, 3131, NULL, '2026-01-20 13:44:36');
INSERT INTO `hunter_security_logs` VALUES (115, 440, 'SuraF', 'CHEST', 'ALERT', 'HIGH_CHEST_RATE', 'total=29 elapsed=518 rate_per_hour=201.5', 2, 9868, 3131, NULL, '2026-01-20 13:44:36');
INSERT INTO `hunter_security_logs` VALUES (116, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=46 items=Buono 100 Gloria total_session=30', 2, 9870, 3132, NULL, '2026-01-20 13:44:41');
INSERT INTO `hunter_security_logs` VALUES (117, 440, 'SuraF', 'CHEST', 'ALERT', 'HIGH_CHEST_RATE', 'total=30 elapsed=523 rate_per_hour=206.5', 2, 9870, 3132, NULL, '2026-01-20 13:44:41');
INSERT INTO `hunter_security_logs` VALUES (118, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=58 items=none total_session=31', 2, 9865, 3131, NULL, '2026-01-20 13:44:46');
INSERT INTO `hunter_security_logs` VALUES (119, 440, 'SuraF', 'CHEST', 'ALERT', 'HIGH_CHEST_RATE', 'total=31 elapsed=528 rate_per_hour=211.4', 2, 9865, 3131, NULL, '2026-01-20 13:44:46');
INSERT INTO `hunter_security_logs` VALUES (120, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa C-Rank glory=150 items=none total_session=32', 2, 9876, 3126, NULL, '2026-01-20 13:45:20');
INSERT INTO `hunter_security_logs` VALUES (121, 440, 'SuraF', 'CHEST', 'ALERT', 'HIGH_CHEST_RATE', 'total=32 elapsed=562 rate_per_hour=205.0', 2, 9876, 3126, NULL, '2026-01-20 13:45:20');
INSERT INTO `hunter_security_logs` VALUES (122, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa N-Rank glory=353 items=Item_80040 total_session=33', 2, 9869, 3119, NULL, '2026-01-20 13:45:44');
INSERT INTO `hunter_security_logs` VALUES (123, 440, 'SuraF', 'CHEST', 'ALERT', 'HIGH_CHEST_RATE', 'total=33 elapsed=586 rate_per_hour=202.7', 2, 9869, 3119, NULL, '2026-01-20 13:45:44');
INSERT INTO `hunter_security_logs` VALUES (124, 1, '[GF]Wesker', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa D-Rank glory=70 items=none total_session=1', 2, 9869, 3114, NULL, '2026-01-20 13:46:39');
INSERT INTO `hunter_security_logs` VALUES (125, 1, '[GF]Wesker', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa S-Rank glory=411 items=none total_session=2', 2, 9869, 3114, NULL, '2026-01-20 13:46:44');
INSERT INTO `hunter_security_logs` VALUES (126, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa B-Rank glory=188 items=none total_session=34', 2, 9872, 3117, NULL, '2026-01-20 13:46:50');
INSERT INTO `hunter_security_logs` VALUES (127, 440, 'SuraF', 'CHEST', 'ALERT', 'HIGH_CHEST_RATE', 'total=34 elapsed=652 rate_per_hour=187.7', 2, 9872, 3117, NULL, '2026-01-20 13:46:50');
INSERT INTO `hunter_security_logs` VALUES (128, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa A-Rank glory=286 items=none total_session=35', 2, 9867, 3123, NULL, '2026-01-20 13:46:55');
INSERT INTO `hunter_security_logs` VALUES (129, 440, 'SuraF', 'CHEST', 'ALERT', 'HIGH_CHEST_RATE', 'total=35 elapsed=657 rate_per_hour=191.8', 2, 9867, 3123, NULL, '2026-01-20 13:46:55');
INSERT INTO `hunter_security_logs` VALUES (130, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa N-Rank glory=436 items=none total_session=36', 2, 9871, 3117, NULL, '2026-01-20 13:47:23');
INSERT INTO `hunter_security_logs` VALUES (131, 440, 'SuraF', 'CHEST', 'ALERT', 'HIGH_CHEST_RATE', 'total=36 elapsed=685 rate_per_hour=189.2', 2, 9871, 3117, NULL, '2026-01-20 13:47:23');
INSERT INTO `hunter_security_logs` VALUES (132, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa N-Rank glory=396 items=none total_session=37', 2, 9867, 3117, NULL, '2026-01-20 13:47:31');
INSERT INTO `hunter_security_logs` VALUES (133, 440, 'SuraF', 'CHEST', 'ALERT', 'HIGH_CHEST_RATE', 'total=37 elapsed=693 rate_per_hour=192.2', 2, 9867, 3117, NULL, '2026-01-20 13:47:31');
INSERT INTO `hunter_security_logs` VALUES (134, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa N-Rank glory=429 items=none total_session=38', 2, 9867, 3116, NULL, '2026-01-20 13:47:41');
INSERT INTO `hunter_security_logs` VALUES (135, 440, 'SuraF', 'CHEST', 'ALERT', 'HIGH_CHEST_RATE', 'total=38 elapsed=703 rate_per_hour=194.6', 2, 9867, 3116, NULL, '2026-01-20 13:47:41');
INSERT INTO `hunter_security_logs` VALUES (136, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa N-Rank glory=460 items=none total_session=39', 2, 9867, 3116, NULL, '2026-01-20 13:47:50');
INSERT INTO `hunter_security_logs` VALUES (137, 440, 'SuraF', 'CHEST', 'ALERT', 'HIGH_CHEST_RATE', 'total=39 elapsed=712 rate_per_hour=197.2', 2, 9867, 3116, NULL, '2026-01-20 13:47:50');
INSERT INTO `hunter_security_logs` VALUES (138, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa N-Rank glory=510 items=none total_session=40', 2, 9869, 3117, NULL, '2026-01-20 13:48:14');
INSERT INTO `hunter_security_logs` VALUES (139, 440, 'SuraF', 'CHEST', 'ALERT', 'HIGH_CHEST_RATE', 'total=40 elapsed=736 rate_per_hour=195.7', 2, 9869, 3117, NULL, '2026-01-20 13:48:14');
INSERT INTO `hunter_security_logs` VALUES (140, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa N-Rank glory=420 items=none total_session=41', 2, 9869, 3117, NULL, '2026-01-20 13:48:22');
INSERT INTO `hunter_security_logs` VALUES (141, 440, 'SuraF', 'CHEST', 'ALERT', 'HIGH_CHEST_RATE', 'total=41 elapsed=744 rate_per_hour=198.4', 2, 9869, 3117, NULL, '2026-01-20 13:48:22');
INSERT INTO `hunter_security_logs` VALUES (142, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa N-Rank glory=352 items=none total_session=42', 2, 9869, 3117, NULL, '2026-01-20 13:48:28');
INSERT INTO `hunter_security_logs` VALUES (143, 440, 'SuraF', 'CHEST', 'ALERT', 'HIGH_CHEST_RATE', 'total=42 elapsed=750 rate_per_hour=201.6', 2, 9869, 3117, NULL, '2026-01-20 13:48:28');
INSERT INTO `hunter_security_logs` VALUES (144, 440, 'SuraF', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=7343 rank=E-Rank', 2, 9869, 3117, NULL, '2026-01-20 13:48:41');
INSERT INTO `hunter_security_logs` VALUES (145, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa N-Rank glory=673 items=none total_session=43', 2, 9869, 3117, NULL, '2026-01-20 13:48:51');
INSERT INTO `hunter_security_logs` VALUES (146, 440, 'SuraF', 'CHEST', 'ALERT', 'HIGH_CHEST_RATE', 'total=43 elapsed=773 rate_per_hour=200.3', 2, 9869, 3117, NULL, '2026-01-20 13:48:51');
INSERT INTO `hunter_security_logs` VALUES (147, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa N-Rank glory=524 items=none total_session=44', 2, 9869, 3117, NULL, '2026-01-20 13:48:59');
INSERT INTO `hunter_security_logs` VALUES (148, 440, 'SuraF', 'CHEST', 'ALERT', 'HIGH_CHEST_RATE', 'total=44 elapsed=781 rate_per_hour=202.8', 2, 9869, 3117, NULL, '2026-01-20 13:48:59');
INSERT INTO `hunter_security_logs` VALUES (149, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa N-Rank glory=486 items=none total_session=45', 2, 9869, 3117, NULL, '2026-01-20 13:49:06');
INSERT INTO `hunter_security_logs` VALUES (150, 440, 'SuraF', 'CHEST', 'ALERT', 'HIGH_CHEST_RATE', 'total=45 elapsed=788 rate_per_hour=205.6', 2, 9869, 3117, NULL, '2026-01-20 13:49:06');
INSERT INTO `hunter_security_logs` VALUES (151, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa N-Rank glory=452 items=none total_session=46', 2, 9869, 3117, NULL, '2026-01-20 13:49:17');
INSERT INTO `hunter_security_logs` VALUES (152, 440, 'SuraF', 'CHEST', 'ALERT', 'HIGH_CHEST_RATE', 'total=46 elapsed=799 rate_per_hour=207.3', 2, 9869, 3117, NULL, '2026-01-20 13:49:17');
INSERT INTO `hunter_security_logs` VALUES (153, 440, 'SuraF', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa N-Rank glory=517 items=none total_session=47', 2, 9869, 3110, NULL, '2026-01-20 13:49:25');
INSERT INTO `hunter_security_logs` VALUES (154, 440, 'SuraF', 'CHEST', 'ALERT', 'HIGH_CHEST_RATE', 'total=47 elapsed=807 rate_per_hour=209.7', 2, 9869, 3110, NULL, '2026-01-20 13:49:25');
INSERT INTO `hunter_security_logs` VALUES (155, 440, 'SuraF', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=7343 reason=TEMPO SCADUTO! Mob rimasti: 5', 2, 9864, 3113, NULL, '2026-01-20 13:49:41');
INSERT INTO `hunter_security_logs` VALUES (156, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=22 items=none total_session=1', 2, 9686, 2776, NULL, '2026-01-20 15:17:23');
INSERT INTO `hunter_security_logs` VALUES (157, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa D-Rank glory=33 items=none total_session=2', 2, 9681, 2767, NULL, '2026-01-20 15:17:29');
INSERT INTO `hunter_security_logs` VALUES (158, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa C-Rank glory=67 items=none total_session=3', 2, 9679, 2757, NULL, '2026-01-20 15:17:35');
INSERT INTO `hunter_security_logs` VALUES (159, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa B-Rank glory=69 items=none total_session=4', 2, 9675, 2744, NULL, '2026-01-20 15:17:42');
INSERT INTO `hunter_security_logs` VALUES (160, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa D-Rank glory=36 items=none total_session=1', 2, 9795, 3011, NULL, '2026-01-20 16:37:03');
INSERT INTO `hunter_security_logs` VALUES (161, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa A-Rank glory=113 items=Buono 1000 Gloria total_session=2', 2, 9794, 3010, NULL, '2026-01-20 16:37:09');
INSERT INTO `hunter_security_logs` VALUES (162, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa C-Rank glory=73 items=none total_session=3', 2, 9789, 3007, NULL, '2026-01-20 16:37:15');
INSERT INTO `hunter_security_logs` VALUES (163, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=22 items=none total_session=4', 2, 9788, 3006, NULL, '2026-01-20 16:37:20');
INSERT INTO `hunter_security_logs` VALUES (164, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa B-Rank glory=79 items=none total_session=5', 2, 9787, 3006, NULL, '2026-01-20 16:37:24');
INSERT INTO `hunter_security_logs` VALUES (165, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa B-Rank glory=87 items=none total_session=6', 2, 9786, 3013, NULL, '2026-01-20 16:37:30');
INSERT INTO `hunter_security_logs` VALUES (166, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa D-Rank glory=56 items=Buono 100 Gloria x2 total_session=7', 2, 9783, 3008, NULL, '2026-01-20 16:37:39');
INSERT INTO `hunter_security_logs` VALUES (167, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=5932 rank=E-Rank', 6, 5609, 3318, NULL, '2026-01-20 16:42:24');
INSERT INTO `hunter_security_logs` VALUES (168, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=5932 rank=E-Rank', 6, 5611, 3317, NULL, '2026-01-20 16:43:24');
INSERT INTO `hunter_security_logs` VALUES (169, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 6, 5611, 3317, NULL, '2026-01-20 16:43:34');
INSERT INTO `hunter_security_logs` VALUES (170, 3905, '123213', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=5842 rank=A-Rank', 2, 9570, 2435, NULL, '2026-01-20 16:49:05');
INSERT INTO `hunter_security_logs` VALUES (171, 3905, '123213', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=5842 reason=123213 si e\' allontanato!', 2, 9629, 2453, NULL, '2026-01-20 16:49:21');
INSERT INTO `hunter_security_logs` VALUES (172, 3905, '123213', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=6376 rank=E-Rank', 2, 9568, 2357, NULL, '2026-01-20 16:50:29');
INSERT INTO `hunter_security_logs` VALUES (173, 3905, '123213', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=6376 rank=E-Rank', 2, 9570, 2358, NULL, '2026-01-20 16:51:29');
INSERT INTO `hunter_security_logs` VALUES (174, 3905, '123213', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=6376 rank=E-Rank', 2, 9568, 2358, NULL, '2026-01-20 16:52:33');
INSERT INTO `hunter_security_logs` VALUES (175, 3905, '123213', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=6376 rank=E-Rank', 2, 9571, 2361, NULL, '2026-01-20 16:53:33');
INSERT INTO `hunter_security_logs` VALUES (176, 3905, '123213', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9565, 2361, NULL, '2026-01-20 16:53:39');
INSERT INTO `hunter_security_logs` VALUES (177, 3903, 'Gameplay', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 8, 2948, 3585, NULL, '2026-01-20 17:56:57');
INSERT INTO `hunter_security_logs` VALUES (178, 3903, 'Gameplay', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=12993 rank=A-Rank', 8, 2948, 3586, NULL, '2026-01-20 17:59:02');
INSERT INTO `hunter_security_logs` VALUES (179, 3903, 'Gameplay', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=12993 rank=A-Rank', 8, 2950, 3591, NULL, '2026-01-20 18:01:02');
INSERT INTO `hunter_security_logs` VALUES (180, 3903, 'Gameplay', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=2', 8, 2950, 3595, NULL, '2026-01-20 18:01:08');
INSERT INTO `hunter_security_logs` VALUES (181, 3903, 'Gameplay', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=50 items=none total_session=1', 8, 2953, 3595, NULL, '2026-01-20 18:01:10');
INSERT INTO `hunter_security_logs` VALUES (182, 2, '[GF]Aelarion', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=116 items=Buono 100 Gloria total_session=1', 6, 6087, 2866, NULL, '2026-01-20 18:13:15');
INSERT INTO `hunter_security_logs` VALUES (183, 2, '[GF]Aelarion', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=70 items=none total_session=2', 6, 6091, 2870, NULL, '2026-01-20 18:13:33');
INSERT INTO `hunter_security_logs` VALUES (184, 2, '[GF]Aelarion', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=60 items=Buono 100 Gloria total_session=3', 6, 6088, 2870, NULL, '2026-01-20 18:13:58');
INSERT INTO `hunter_security_logs` VALUES (185, 2, '[GF]Aelarion', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=66 items=none total_session=4', 6, 6087, 2868, NULL, '2026-01-20 18:14:15');
INSERT INTO `hunter_security_logs` VALUES (186, 2, '[GF]Aelarion', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=94 items=none total_session=5', 6, 6087, 2868, NULL, '2026-01-20 18:14:43');
INSERT INTO `hunter_security_logs` VALUES (187, 2, '[GF]Aelarion', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=114 items=none total_session=6', 6, 6087, 2868, NULL, '2026-01-20 18:15:38');
INSERT INTO `hunter_security_logs` VALUES (188, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=112 items=none total_session=1', 6, 6152, 2956, NULL, '2026-01-21 01:35:09');
INSERT INTO `hunter_security_logs` VALUES (189, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4333 rank=E-Rank', 2, 9846, 2723, NULL, '2026-01-21 12:50:53');
INSERT INTO `hunter_security_logs` VALUES (190, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=4333 rank=E-Rank', 2, 9849, 2726, NULL, '2026-01-21 12:51:53');
INSERT INTO `hunter_security_logs` VALUES (191, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9849, 2726, NULL, '2026-01-21 12:52:43');
INSERT INTO `hunter_security_logs` VALUES (192, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=2', 2, 9847, 2731, NULL, '2026-01-21 13:04:31');
INSERT INTO `hunter_security_logs` VALUES (193, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=3', 2, 9849, 2723, NULL, '2026-01-21 13:05:03');
INSERT INTO `hunter_security_logs` VALUES (194, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=5954 rank=E-Rank', 2, 9678, 2768, NULL, '2026-01-21 13:43:37');
INSERT INTO `hunter_security_logs` VALUES (195, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=5954 rank=E-Rank', 2, 9682, 2767, NULL, '2026-01-21 13:44:37');
INSERT INTO `hunter_security_logs` VALUES (196, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=4', 2, 9682, 2767, NULL, '2026-01-21 13:45:02');
INSERT INTO `hunter_security_logs` VALUES (197, 1684, 'Pacifista', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=39 items=none total_session=1', 2, 9683, 2766, NULL, '2026-01-21 13:45:07');
INSERT INTO `hunter_security_logs` VALUES (198, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=6264 rank=E-Rank', 2, 9681, 2762, NULL, '2026-01-21 14:02:52');
INSERT INTO `hunter_security_logs` VALUES (199, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=6264 rank=E-Rank', 2, 9685, 2766, NULL, '2026-01-21 14:03:52');
INSERT INTO `hunter_security_logs` VALUES (200, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=5', 2, 9685, 2766, NULL, '2026-01-21 14:03:58');
INSERT INTO `hunter_security_logs` VALUES (201, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4054 rank=E-Rank', 2, 9645, 2902, NULL, '2026-01-21 14:17:01');
INSERT INTO `hunter_security_logs` VALUES (202, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=4054 reason=[GF]HunabKu si e\' allontanato!', 2, 9671, 2911, NULL, '2026-01-21 14:17:07');
INSERT INTO `hunter_security_logs` VALUES (203, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4054 rank=E-Rank', 2, 9649, 2903, NULL, '2026-01-21 14:17:19');
INSERT INTO `hunter_security_logs` VALUES (204, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=4054 rank=E-Rank', 2, 9649, 2904, NULL, '2026-01-21 14:18:19');
INSERT INTO `hunter_security_logs` VALUES (205, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=21 items=none total_session=1', 2, 9649, 2902, NULL, '2026-01-21 14:20:10');
INSERT INTO `hunter_security_logs` VALUES (206, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=5099 rank=D-Rank', 2, 9751, 2937, NULL, '2026-01-21 14:31:16');
INSERT INTO `hunter_security_logs` VALUES (207, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=5099 rank=D-Rank', 2, 9751, 2939, NULL, '2026-01-21 14:32:16');
INSERT INTO `hunter_security_logs` VALUES (208, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9749, 2945, NULL, '2026-01-21 14:32:34');
INSERT INTO `hunter_security_logs` VALUES (209, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4177 rank=E-Rank', 2, 9638, 2790, NULL, '2026-01-21 17:14:10');
INSERT INTO `hunter_security_logs` VALUES (210, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=4177 reason=TEMPO SCADUTO! Mob rimasti: 6', 2, 9638, 2792, NULL, '2026-01-21 17:15:10');
INSERT INTO `hunter_security_logs` VALUES (211, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9638, 2792, NULL, '2026-01-21 17:16:36');
INSERT INTO `hunter_security_logs` VALUES (212, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4177 rank=E-Rank', 2, 9640, 2794, NULL, '2026-01-21 17:18:32');
INSERT INTO `hunter_security_logs` VALUES (213, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=4177 reason=TEMPO SCADUTO! Mob rimasti: 6', 2, 9640, 2797, NULL, '2026-01-21 17:19:32');
INSERT INTO `hunter_security_logs` VALUES (214, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4177 rank=E-Rank', 2, 9640, 2797, NULL, '2026-01-21 17:20:48');
INSERT INTO `hunter_security_logs` VALUES (215, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=4177 reason=TEMPO SCADUTO! Mob rimasti: 3', 2, 9639, 2794, NULL, '2026-01-21 17:21:48');
INSERT INTO `hunter_security_logs` VALUES (216, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4177 rank=E-Rank', 2, 9638, 2792, NULL, '2026-01-21 17:22:03');
INSERT INTO `hunter_security_logs` VALUES (217, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=4177 rank=E-Rank', 2, 9638, 2791, NULL, '2026-01-21 17:23:03');
INSERT INTO `hunter_security_logs` VALUES (218, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=2', 2, 9638, 2791, NULL, '2026-01-21 17:27:09');
INSERT INTO `hunter_security_logs` VALUES (219, 3903, 'Gameplay', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=12162 rank=E-Rank', 8, 2926, 3604, NULL, '2026-01-21 18:24:17');
INSERT INTO `hunter_security_logs` VALUES (220, 3903, 'Gameplay', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=12162 rank=E-Rank', 8, 2926, 3604, NULL, '2026-01-21 18:25:17');
INSERT INTO `hunter_security_logs` VALUES (221, 3903, 'Gameplay', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 8, 2926, 3604, NULL, '2026-01-21 18:25:43');
INSERT INTO `hunter_security_logs` VALUES (222, 3903, 'Gameplay', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=18903 rank=E-Rank', 8, 2940, 3635, NULL, '2026-01-21 19:01:26');
INSERT INTO `hunter_security_logs` VALUES (223, 3903, 'Gameplay', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=18903 rank=E-Rank', 8, 2940, 3635, NULL, '2026-01-21 19:02:26');
INSERT INTO `hunter_security_logs` VALUES (224, 3903, 'Gameplay', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=2', 8, 2940, 3635, NULL, '2026-01-21 19:02:31');
INSERT INTO `hunter_security_logs` VALUES (225, 3903, 'Gameplay', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=23577 rank=E-Rank', 8, 2920, 3622, NULL, '2026-01-21 19:09:41');
INSERT INTO `hunter_security_logs` VALUES (226, 3903, 'Gameplay', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=23577 rank=E-Rank', 8, 2920, 3622, NULL, '2026-01-21 19:10:41');
INSERT INTO `hunter_security_logs` VALUES (227, 3903, 'Gameplay', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=3', 8, 2920, 3622, NULL, '2026-01-21 19:12:41');
INSERT INTO `hunter_security_logs` VALUES (228, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=14926 rank=E-Rank', 2, 9659, 2927, NULL, '2026-01-22 12:57:03');
INSERT INTO `hunter_security_logs` VALUES (229, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=14926 reason=[GF]HunabKu si e\' allontanato!', 2, 9706, 2928, NULL, '2026-01-22 12:57:07');
INSERT INTO `hunter_security_logs` VALUES (230, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9668, 2925, NULL, '2026-01-22 12:57:21');
INSERT INTO `hunter_security_logs` VALUES (231, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=2', 2, 9668, 2925, NULL, '2026-01-22 12:57:34');
INSERT INTO `hunter_security_logs` VALUES (232, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=14926 rank=E-Rank', 2, 9668, 2925, NULL, '2026-01-22 12:57:42');
INSERT INTO `hunter_security_logs` VALUES (233, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=14926 reason=TEMPO SCADUTO! Mob rimasti: 5', 2, 9670, 2923, NULL, '2026-01-22 12:58:42');
INSERT INTO `hunter_security_logs` VALUES (234, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9659, 2913, NULL, '2026-01-22 13:04:48');
INSERT INTO `hunter_security_logs` VALUES (235, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4077 rank=E-Rank', 2, 9659, 2913, NULL, '2026-01-22 13:05:47');
INSERT INTO `hunter_security_logs` VALUES (236, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9659, 2913, NULL, '2026-01-22 13:07:38');
INSERT INTO `hunter_security_logs` VALUES (237, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=2', 2, 9683, 2774, NULL, '2026-01-22 13:09:29');
INSERT INTO `hunter_security_logs` VALUES (238, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=3', 2, 9646, 2906, NULL, '2026-01-22 13:09:50');
INSERT INTO `hunter_security_logs` VALUES (239, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4139 rank=E-Rank', 2, 9659, 2927, NULL, '2026-01-22 13:10:23');
INSERT INTO `hunter_security_logs` VALUES (240, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=4139 reason=TEMPO SCADUTO! Mob rimasti: 6', 2, 9657, 2929, NULL, '2026-01-22 13:11:23');
INSERT INTO `hunter_security_logs` VALUES (241, 3903, 'Gameplay', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=630 rank=E-Rank', 210012, 8051, 6707, NULL, '2026-01-23 12:16:53');
INSERT INTO `hunter_security_logs` VALUES (242, 3903, 'Gameplay', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=630 rank=E-Rank', 210012, 8052, 6704, NULL, '2026-01-23 12:17:53');
INSERT INTO `hunter_security_logs` VALUES (243, 3903, 'Gameplay', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=20799 rank=E-Rank', 8, 2635, 3335, NULL, '2026-01-23 14:19:46');
INSERT INTO `hunter_security_logs` VALUES (244, 3903, 'Gameplay', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=20799 rank=E-Rank', 8, 2635, 3335, NULL, '2026-01-23 14:20:46');
INSERT INTO `hunter_security_logs` VALUES (245, 3903, 'Gameplay', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 8, 2635, 3335, NULL, '2026-01-23 14:20:56');
INSERT INTO `hunter_security_logs` VALUES (246, 3903, 'Gameplay', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=22494 rank=E-Rank', 8, 2636, 3335, NULL, '2026-01-23 14:21:50');
INSERT INTO `hunter_security_logs` VALUES (247, 3903, 'Gameplay', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=22494 rank=E-Rank', 8, 2636, 3335, NULL, '2026-01-23 14:22:50');
INSERT INTO `hunter_security_logs` VALUES (248, 3903, 'Gameplay', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=2', 8, 2636, 3335, NULL, '2026-01-23 14:22:56');
INSERT INTO `hunter_security_logs` VALUES (249, 3903, 'Gameplay', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=18574 rank=E-Rank', 8, 2617, 3298, NULL, '2026-01-23 14:24:03');
INSERT INTO `hunter_security_logs` VALUES (250, 3903, 'Gameplay', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=18574 rank=E-Rank', 8, 2617, 3297, NULL, '2026-01-23 14:25:03');
INSERT INTO `hunter_security_logs` VALUES (251, 3903, 'Gameplay', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=3', 8, 2617, 3297, NULL, '2026-01-23 14:25:07');
INSERT INTO `hunter_security_logs` VALUES (252, 3903, 'Gameplay', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=17763 rank=E-Rank', 8, 2650, 3271, NULL, '2026-01-23 14:26:35');
INSERT INTO `hunter_security_logs` VALUES (253, 3903, 'Gameplay', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=17763 rank=E-Rank', 8, 2649, 3269, NULL, '2026-01-23 14:27:35');
INSERT INTO `hunter_security_logs` VALUES (254, 3903, 'Gameplay', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=4', 8, 2649, 3269, NULL, '2026-01-23 14:27:39');
INSERT INTO `hunter_security_logs` VALUES (255, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=5337 rank=E-Rank', 2, 9844, 2859, NULL, '2026-01-23 17:44:43');
INSERT INTO `hunter_security_logs` VALUES (256, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=5337 rank=E-Rank', 2, 9846, 2859, NULL, '2026-01-23 17:45:43');
INSERT INTO `hunter_security_logs` VALUES (257, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9846, 2859, NULL, '2026-01-23 17:45:51');
INSERT INTO `hunter_security_logs` VALUES (258, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=2', 2, 9646, 2875, NULL, '2026-01-23 17:49:01');
INSERT INTO `hunter_security_logs` VALUES (259, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=5484 rank=B-Rank', 2, 9635, 2875, NULL, '2026-01-23 17:49:33');
INSERT INTO `hunter_security_logs` VALUES (260, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=5484 rank=B-Rank', 2, 9632, 2870, NULL, '2026-01-23 17:51:03');
INSERT INTO `hunter_security_logs` VALUES (261, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=3', 2, 9631, 2875, NULL, '2026-01-23 17:51:08');
INSERT INTO `hunter_security_logs` VALUES (262, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4065 rank=B-Rank', 2, 9639, 2881, NULL, '2026-01-23 18:28:25');
INSERT INTO `hunter_security_logs` VALUES (263, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=4065 rank=B-Rank', 2, 9641, 2881, NULL, '2026-01-23 18:29:55');
INSERT INTO `hunter_security_logs` VALUES (264, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9641, 2881, NULL, '2026-01-23 18:30:13');
INSERT INTO `hunter_security_logs` VALUES (265, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=2', 2, 9641, 2876, NULL, '2026-01-23 18:36:58');
INSERT INTO `hunter_security_logs` VALUES (266, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9643, 2878, NULL, '2026-01-23 18:43:06');
INSERT INTO `hunter_security_logs` VALUES (267, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=21 items=none total_session=1', 2, 9648, 2876, NULL, '2026-01-23 18:55:20');
INSERT INTO `hunter_security_logs` VALUES (268, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9651, 2914, NULL, '2026-01-23 21:48:41');
INSERT INTO `hunter_security_logs` VALUES (269, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=2', 2, 9659, 2922, NULL, '2026-01-23 21:49:17');
INSERT INTO `hunter_security_logs` VALUES (270, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=3', 2, 9658, 2921, NULL, '2026-01-23 21:49:36');
INSERT INTO `hunter_security_logs` VALUES (271, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=4', 2, 9656, 2920, NULL, '2026-01-23 21:50:08');
INSERT INTO `hunter_security_logs` VALUES (272, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4397 rank=D-Rank', 2, 9659, 2921, NULL, '2026-01-23 21:51:45');
INSERT INTO `hunter_security_logs` VALUES (273, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=4397 rank=D-Rank', 2, 9662, 2920, NULL, '2026-01-23 21:52:45');
INSERT INTO `hunter_security_logs` VALUES (274, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=5', 2, 9662, 2920, NULL, '2026-01-23 21:52:55');
INSERT INTO `hunter_security_logs` VALUES (275, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9792, 2963, NULL, '2026-01-23 22:31:44');
INSERT INTO `hunter_security_logs` VALUES (276, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=2', 2, 9794, 2967, NULL, '2026-01-23 22:32:09');
INSERT INTO `hunter_security_logs` VALUES (277, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4139 rank=E-Rank', 2, 9808, 3031, NULL, '2026-01-23 22:32:26');
INSERT INTO `hunter_security_logs` VALUES (278, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=4139 reason=[GF]HunabKu si e\' allontanato!', 2, 9848, 3074, NULL, '2026-01-23 22:32:32');
INSERT INTO `hunter_security_logs` VALUES (279, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=3', 2, 9807, 3039, NULL, '2026-01-23 22:32:41');
INSERT INTO `hunter_security_logs` VALUES (280, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=35 items=none total_session=1', 2, 9816, 3039, NULL, '2026-01-23 22:32:52');
INSERT INTO `hunter_security_logs` VALUES (281, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9680, 2772, NULL, '2026-01-23 22:53:34');
INSERT INTO `hunter_security_logs` VALUES (282, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=2', 2, 9638, 2880, NULL, '2026-01-23 22:53:49');
INSERT INTO `hunter_security_logs` VALUES (283, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=24 items=none total_session=1', 2, 9646, 2795, NULL, '2026-01-23 23:55:06');
INSERT INTO `hunter_security_logs` VALUES (284, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa S-Rank glory=189 items=none total_session=1', 2, 9646, 2877, NULL, '2026-01-24 00:05:50');
INSERT INTO `hunter_security_logs` VALUES (285, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa S-Rank glory=168 items=none total_session=1', 2, 9647, 2918, NULL, '2026-01-24 00:12:17');
INSERT INTO `hunter_security_logs` VALUES (286, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa S-Rank glory=174 items=none total_session=2', 2, 9648, 2885, NULL, '2026-01-24 00:13:01');
INSERT INTO `hunter_security_logs` VALUES (287, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4149 rank=E-Rank', 2, 9571, 2498, NULL, '2026-01-24 00:16:40');
INSERT INTO `hunter_security_logs` VALUES (288, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=4149 rank=E-Rank', 2, 9572, 2494, NULL, '2026-01-24 00:17:40');
INSERT INTO `hunter_security_logs` VALUES (289, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9573, 2495, NULL, '2026-01-24 00:18:41');
INSERT INTO `hunter_security_logs` VALUES (290, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4322 rank=N-Rank', 2, 9670, 2753, NULL, '2026-01-24 00:26:36');
INSERT INTO `hunter_security_logs` VALUES (291, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=4322 reason=[GF]HunabKu si e\' allontanato!', 2, 9680, 2728, NULL, '2026-01-24 00:26:48');
INSERT INTO `hunter_security_logs` VALUES (292, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=2', 2, 9666, 2760, NULL, '2026-01-24 00:27:15');
INSERT INTO `hunter_security_logs` VALUES (293, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=3', 2, 9848, 2997, NULL, '2026-01-24 00:35:54');
INSERT INTO `hunter_security_logs` VALUES (294, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=17 items=none total_session=3', 2, 9848, 2997, NULL, '2026-01-24 00:36:04');
INSERT INTO `hunter_security_logs` VALUES (295, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=4', 2, 9849, 2995, NULL, '2026-01-24 00:36:35');
INSERT INTO `hunter_security_logs` VALUES (296, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=5348 rank=E-Rank', 2, 9851, 2989, NULL, '2026-01-24 00:37:07');
INSERT INTO `hunter_security_logs` VALUES (297, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=5348 reason=[GF]HunabKu si e\' allontanato!', 2, 9867, 2971, NULL, '2026-01-24 00:37:11');
INSERT INTO `hunter_security_logs` VALUES (298, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=5', 2, 9850, 2983, NULL, '2026-01-24 00:37:22');
INSERT INTO `hunter_security_logs` VALUES (299, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=5 items=none total_session=1', 6, 6154, 2922, NULL, '2026-01-24 00:56:25');
INSERT INTO `hunter_security_logs` VALUES (300, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa C-Rank glory=54 items=none total_session=2', 6, 5929, 2427, NULL, '2026-01-24 01:05:22');
INSERT INTO `hunter_security_logs` VALUES (301, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 6, 5975, 2407, NULL, '2026-01-24 01:07:18');
INSERT INTO `hunter_security_logs` VALUES (302, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=6115 rank=N-Rank', 6, 5970, 2412, NULL, '2026-01-24 01:08:45');
INSERT INTO `hunter_security_logs` VALUES (303, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=6115 rank=N-Rank', 6, 5970, 2412, NULL, '2026-01-24 01:11:45');
INSERT INTO `hunter_security_logs` VALUES (304, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=2', 6, 5970, 2412, NULL, '2026-01-24 01:12:38');
INSERT INTO `hunter_security_logs` VALUES (305, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=6', 2, 9680, 2770, NULL, '2026-01-24 01:16:50');
INSERT INTO `hunter_security_logs` VALUES (306, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=7', 2, 9669, 2748, NULL, '2026-01-24 01:18:49');
INSERT INTO `hunter_security_logs` VALUES (307, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=7134 rank=E-Rank', 2, 9558, 2610, NULL, '2026-01-24 01:46:45');
INSERT INTO `hunter_security_logs` VALUES (308, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=118 items=none total_session=4', 2, 9557, 2607, NULL, '2026-01-24 01:53:02');
INSERT INTO `hunter_security_logs` VALUES (309, 1684, 'Pacifista', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4267 rank=N-Rank', 2, 9596, 2668, NULL, '2026-01-24 02:02:19');
INSERT INTO `hunter_security_logs` VALUES (310, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4267 rank=N-Rank', 2, 9601, 2668, NULL, '2026-01-24 02:06:34');
INSERT INTO `hunter_security_logs` VALUES (311, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4321 rank=C-Rank', 2, 9678, 2768, NULL, '2026-01-24 02:06:55');
INSERT INTO `hunter_security_logs` VALUES (312, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=4321 reason=TEMPO SCADUTO! Mob rimasti: 8', 2, 9678, 2768, NULL, '2026-01-24 02:07:55');
INSERT INTO `hunter_security_logs` VALUES (313, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4321 rank=C-Rank', 2, 9678, 2768, NULL, '2026-01-24 02:08:20');
INSERT INTO `hunter_security_logs` VALUES (314, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=4321 reason=[GF]HunabKu si e\' allontanato!', 2, 9627, 2762, NULL, '2026-01-24 02:08:24');
INSERT INTO `hunter_security_logs` VALUES (315, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=7503 rank=E-Rank', 2, 9646, 2869, NULL, '2026-01-24 02:08:54');
INSERT INTO `hunter_security_logs` VALUES (316, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=7503 rank=E-Rank', 2, 9646, 2869, NULL, '2026-01-24 02:23:10');
INSERT INTO `hunter_security_logs` VALUES (317, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=7503 reason=TEMPO SCADUTO! Mob rimasti: 6', 2, 9646, 2869, NULL, '2026-01-24 02:24:10');
INSERT INTO `hunter_security_logs` VALUES (318, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4088 rank=E-Rank', 2, 9642, 2864, NULL, '2026-01-24 02:34:51');
INSERT INTO `hunter_security_logs` VALUES (319, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=4088 rank=E-Rank', 2, 9634, 2858, NULL, '2026-01-24 02:35:51');
INSERT INTO `hunter_security_logs` VALUES (320, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9645, 2867, NULL, '2026-01-24 02:36:09');
INSERT INTO `hunter_security_logs` VALUES (321, 1684, 'Pacifista', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=38 items=none total_session=1', 2, 9641, 2870, NULL, '2026-01-24 02:36:44');
INSERT INTO `hunter_security_logs` VALUES (322, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4091 rank=E-Rank', 2, 9646, 2791, NULL, '2026-01-24 02:52:49');
INSERT INTO `hunter_security_logs` VALUES (323, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=4091 reason=[GF]HunabKu si e\' allontanato!', 2, 9673, 2738, NULL, '2026-01-24 02:52:53');
INSERT INTO `hunter_security_logs` VALUES (324, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9644, 2787, NULL, '2026-01-24 02:53:02');
INSERT INTO `hunter_security_logs` VALUES (325, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=2', 2, 9643, 2884, NULL, '2026-01-24 02:53:17');
INSERT INTO `hunter_security_logs` VALUES (326, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=3', 2, 9644, 2876, NULL, '2026-01-24 13:03:15');
INSERT INTO `hunter_security_logs` VALUES (327, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=4', 2, 9682, 2768, NULL, '2026-01-24 13:07:03');
INSERT INTO `hunter_security_logs` VALUES (328, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=5', 2, 9640, 2889, NULL, '2026-01-24 13:07:18');
INSERT INTO `hunter_security_logs` VALUES (329, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa A-Rank glory=128 items=none total_session=1', 2, 9640, 2889, NULL, '2026-01-24 13:07:22');
INSERT INTO `hunter_security_logs` VALUES (330, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=6', 2, 9653, 2932, NULL, '2026-01-24 13:07:46');
INSERT INTO `hunter_security_logs` VALUES (331, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa B-Rank glory=100 items=none total_session=2', 2, 9653, 2932, NULL, '2026-01-24 13:07:48');
INSERT INTO `hunter_security_logs` VALUES (332, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=7', 2, 9666, 2919, NULL, '2026-01-24 13:07:58');
INSERT INTO `hunter_security_logs` VALUES (333, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4120 rank=E-Rank', 2, 9403, 2928, NULL, '2026-01-24 13:30:58');
INSERT INTO `hunter_security_logs` VALUES (334, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=4120 reason=[GF]HunabKu si e\' allontanato!', 2, 9404, 2949, NULL, '2026-01-24 13:31:02');
INSERT INTO `hunter_security_logs` VALUES (335, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4120 rank=E-Rank', 2, 9402, 2930, NULL, '2026-01-24 13:31:08');
INSERT INTO `hunter_security_logs` VALUES (336, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=4120 reason=[GF]HunabKu si e\' allontanato!', 2, 9397, 2971, NULL, '2026-01-24 13:31:26');
INSERT INTO `hunter_security_logs` VALUES (337, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9403, 2930, NULL, '2026-01-24 13:31:34');
INSERT INTO `hunter_security_logs` VALUES (338, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=2', 2, 9392, 2953, NULL, '2026-01-24 13:32:12');
INSERT INTO `hunter_security_logs` VALUES (339, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa D-Rank glory=57 items=none total_session=1', 2, 9639, 2879, NULL, '2026-01-24 15:49:23');
INSERT INTO `hunter_security_logs` VALUES (340, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa D-Rank glory=38 items=none total_session=1', 2, 9650, 2885, NULL, '2026-01-24 16:14:48');
INSERT INTO `hunter_security_logs` VALUES (341, 3906, 'Monarca', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=7417 rank=E-Rank', 2, 9597, 2371, NULL, '2026-01-24 18:50:50');
INSERT INTO `hunter_security_logs` VALUES (342, 3906, 'Monarca', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=7417 rank=E-Rank', 2, 9598, 2367, NULL, '2026-01-24 18:51:50');
INSERT INTO `hunter_security_logs` VALUES (343, 3906, 'Monarca', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9598, 2367, NULL, '2026-01-24 18:52:17');
INSERT INTO `hunter_security_logs` VALUES (344, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4059 rank=E-Rank', 2, 9701, 2931, NULL, '2026-01-24 20:00:31');
INSERT INTO `hunter_security_logs` VALUES (345, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=4059 rank=E-Rank', 2, 9703, 2933, NULL, '2026-01-24 20:01:31');
INSERT INTO `hunter_security_logs` VALUES (346, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9703, 2933, NULL, '2026-01-24 20:01:54');
INSERT INTO `hunter_security_logs` VALUES (347, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4249 rank=E-Rank', 2, 9709, 2935, NULL, '2026-01-24 20:03:28');
INSERT INTO `hunter_security_logs` VALUES (348, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=4249 rank=E-Rank', 2, 9711, 2935, NULL, '2026-01-24 20:04:28');
INSERT INTO `hunter_security_logs` VALUES (349, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=2', 2, 9711, 2935, NULL, '2026-01-24 20:04:33');
INSERT INTO `hunter_security_logs` VALUES (350, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4388 rank=E-Rank', 2, 9711, 2935, NULL, '2026-01-24 20:04:40');
INSERT INTO `hunter_security_logs` VALUES (351, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=4388 rank=E-Rank', 2, 9710, 2938, NULL, '2026-01-24 20:05:40');
INSERT INTO `hunter_security_logs` VALUES (352, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4307 rank=E-Rank', 2, 9645, 2894, NULL, '2026-01-24 21:37:23');
INSERT INTO `hunter_security_logs` VALUES (353, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=4307 rank=E-Rank', 2, 9645, 2893, NULL, '2026-01-24 21:38:23');
INSERT INTO `hunter_security_logs` VALUES (354, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9645, 2893, NULL, '2026-01-24 21:39:42');
INSERT INTO `hunter_security_logs` VALUES (355, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4904 rank=S-Rank', 2, 9564, 2264, NULL, '2026-01-24 21:47:41');
INSERT INTO `hunter_security_logs` VALUES (356, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=4904 reason=[GF]HunabKu si e\' allontanato!', 2, 9582, 2281, NULL, '2026-01-24 21:47:51');
INSERT INTO `hunter_security_logs` VALUES (357, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa C-Rank glory=776 items=none total_session=1', 6, 5609, 3262, NULL, '2026-01-24 21:56:02');
INSERT INTO `hunter_security_logs` VALUES (358, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=86 items=Buono 100 Gloria total_session=2', 6, 5636, 3383, NULL, '2026-01-24 21:59:19');
INSERT INTO `hunter_security_logs` VALUES (359, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=1308 items=none total_session=1', 2, 9674, 2767, NULL, '2026-01-24 22:59:57');
INSERT INTO `hunter_security_logs` VALUES (360, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=18726 rank=E-Rank', 2, 9772, 2965, NULL, '2026-01-25 14:01:10');
INSERT INTO `hunter_security_logs` VALUES (361, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=18726 rank=E-Rank', 2, 9771, 2970, NULL, '2026-01-25 14:02:10');
INSERT INTO `hunter_security_logs` VALUES (362, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9771, 2970, NULL, '2026-01-25 14:02:18');
INSERT INTO `hunter_security_logs` VALUES (363, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=1', 2, 9960, 2724, NULL, '2026-01-25 14:19:31');
INSERT INTO `hunter_security_logs` VALUES (364, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=2', 2, 9967, 2731, NULL, '2026-01-25 14:21:06');
INSERT INTO `hunter_security_logs` VALUES (365, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=5273 rank=E-Rank', 2, 9642, 2877, NULL, '2026-01-25 15:22:42');
INSERT INTO `hunter_security_logs` VALUES (366, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_SUCCESS', 'fracture_vid=5273 rank=E-Rank', 2, 9647, 2878, NULL, '2026-01-25 15:23:42');
INSERT INTO `hunter_security_logs` VALUES (367, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=3', 2, 9648, 2875, NULL, '2026-01-25 15:24:56');
INSERT INTO `hunter_security_logs` VALUES (368, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=192 items=none total_session=1', 2, 9648, 2875, NULL, '2026-01-25 15:25:07');
INSERT INTO `hunter_security_logs` VALUES (369, 4, '[GF]HunabKu', 'FRACTURE', 'INFO', 'FRACTURE_SEALED', 'fracture_id=0 rank=E glory=0 total_seals=4', 2, 9646, 2866, NULL, '2026-01-25 15:26:01');
INSERT INTO `hunter_security_logs` VALUES (370, 1684, 'Pacifista', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=5494 rank=E-Rank', 2, 9656, 2922, NULL, '2026-01-25 15:31:38');
INSERT INTO `hunter_security_logs` VALUES (371, 1684, 'Pacifista', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=5494 reason=Pacifista si e\' allontanato!', 2, 9659, 2899, NULL, '2026-01-25 15:32:02');
INSERT INTO `hunter_security_logs` VALUES (372, 1684, 'Pacifista', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=5494 rank=E-Rank', 2, 9657, 2923, NULL, '2026-01-25 15:32:16');
INSERT INTO `hunter_security_logs` VALUES (373, 1684, 'Pacifista', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=5494 reason=Pacifista si e\' allontanato!', 2, 9690, 2939, NULL, '2026-01-25 15:32:26');
INSERT INTO `hunter_security_logs` VALUES (374, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=5504 rank=N-Rank', 2, 9663, 2922, NULL, '2026-01-25 15:32:49');
INSERT INTO `hunter_security_logs` VALUES (375, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=5504 reason=[GF]HunabKu si e\' allontanato!', 2, 9639, 2901, NULL, '2026-01-25 15:33:27');
INSERT INTO `hunter_security_logs` VALUES (376, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_STARTED', 'fracture_id=4368 rank=E-Rank', 2, 9894, 2668, NULL, '2026-01-25 15:36:35');
INSERT INTO `hunter_security_logs` VALUES (377, 4, '[GF]HunabKu', 'DEFENSE', 'INFO', 'DEFENSE_FAILED', 'fracture_vid=4368 reason=[GF]HunabKu si e\' allontanato!', 2, 9892, 2704, NULL, '2026-01-25 15:36:47');
INSERT INTO `hunter_security_logs` VALUES (378, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=299 items=Buono 100 Gloria total_session=2', 2, 9925, 2695, NULL, '2026-01-25 15:43:58');
INSERT INTO `hunter_security_logs` VALUES (379, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=242 items=none total_session=3', 2, 9925, 2695, NULL, '2026-01-25 15:44:13');
INSERT INTO `hunter_security_logs` VALUES (380, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa C-Rank glory=408 items=none total_session=4', 2, 9925, 2695, NULL, '2026-01-25 15:45:06');
INSERT INTO `hunter_security_logs` VALUES (381, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=185 items=none total_session=1', 2, 9633, 2666, NULL, '2026-01-26 18:56:09');
INSERT INTO `hunter_security_logs` VALUES (382, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=240 items=none total_session=2', 2, 9633, 2666, NULL, '2026-01-26 18:56:18');
INSERT INTO `hunter_security_logs` VALUES (383, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=174 items=Buono 100 Gloria total_session=3', 2, 9632, 2665, NULL, '2026-01-26 18:56:27');
INSERT INTO `hunter_security_logs` VALUES (384, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=160 items=none total_session=1', 2, 9634, 2665, NULL, '2026-01-26 19:10:19');
INSERT INTO `hunter_security_logs` VALUES (385, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=188 items=Buono 100 Gloria total_session=2', 2, 9634, 2665, NULL, '2026-01-26 19:10:27');
INSERT INTO `hunter_security_logs` VALUES (386, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=160 items=none total_session=1', 2, 9638, 2664, NULL, '2026-01-26 19:15:00');
INSERT INTO `hunter_security_logs` VALUES (387, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=188 items=Buono 100 Gloria total_session=2', 2, 9638, 2664, NULL, '2026-01-26 19:15:06');
INSERT INTO `hunter_security_logs` VALUES (388, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=132 items=none total_session=3', 2, 9677, 2759, NULL, '2026-01-26 19:15:24');
INSERT INTO `hunter_security_logs` VALUES (389, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa C-Rank glory=309 items=none total_session=4', 2, 9672, 2760, NULL, '2026-01-26 19:15:32');
INSERT INTO `hunter_security_logs` VALUES (390, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa C-Rank glory=404 items=none total_session=5', 2, 9671, 2759, NULL, '2026-01-26 19:20:51');
INSERT INTO `hunter_security_logs` VALUES (391, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=278 items=none total_session=1', 2, 9668, 2762, NULL, '2026-01-26 19:33:45');
INSERT INTO `hunter_security_logs` VALUES (392, 4, '[GF]HunabKu', 'CHEST', 'INFO', 'CHEST_OPENED', 'type=Cassa E-Rank glory=240 items=none total_session=2', 2, 9668, 2762, NULL, '2026-01-26 19:33:55');

-- ----------------------------
-- Table structure for hunter_shop_purchases
-- ----------------------------
DROP TABLE IF EXISTS `hunter_shop_purchases`;
CREATE TABLE `hunter_shop_purchases`  (
  `purchase_id` bigint NOT NULL AUTO_INCREMENT,
  `player_id` int NOT NULL,
  `player_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `item_id` int NOT NULL COMMENT 'ID from hunter_quest_shop',
  `item_vnum` int NOT NULL COMMENT 'Actual item vnum purchased',
  `item_count` int NOT NULL DEFAULT 1,
  `price_paid` int NOT NULL COMMENT 'Glory points spent',
  `purchased_at` datetime NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`purchase_id`) USING BTREE,
  INDEX `idx_player_id`(`player_id` ASC) USING BTREE,
  INDEX `idx_purchased_at`(`purchased_at` ASC) USING BTREE,
  INDEX `idx_item_id`(`item_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Shop purchase audit log' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hunter_shop_purchases
-- ----------------------------

-- ----------------------------
-- Table structure for hunter_supremo_config
-- ----------------------------
DROP TABLE IF EXISTS `hunter_supremo_config`;
CREATE TABLE `hunter_supremo_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT,
  `rank_code` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'E,D,C,B,A,S,N',
  `supremo_vnum` int NOT NULL COMMENT 'VNUM del mob boss',
  `supremo_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Nome visualizzato',
  `gloria_reward` int NULL DEFAULT 0 COMMENT 'Gloria per uccisione (futuro)',
  `min_level` int NULL DEFAULT 1 COMMENT 'Livello minimo richiesto',
  `enabled` tinyint(1) NULL DEFAULT 1 COMMENT '1=attivo, 0=disattivato',
  PRIMARY KEY (`config_id`) USING BTREE,
  UNIQUE INDEX `rank_code`(`rank_code` ASC) USING BTREE,
  INDEX `idx_rank`(`rank_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hunter_supremo_config
-- ----------------------------
INSERT INTO `hunter_supremo_config` VALUES (1, 'E', 63010, 'Ombra Minore', 500, 30, 1);
INSERT INTO `hunter_supremo_config` VALUES (2, 'D', 63011, 'Cavaliere Oscuro', 750, 40, 1);
INSERT INTO `hunter_supremo_config` VALUES (3, 'C', 63012, 'Demone delle Ombre', 1000, 50, 1);
INSERT INTO `hunter_supremo_config` VALUES (4, 'B', 63013, 'Signore dell Abisso', 1500, 60, 1);
INSERT INTO `hunter_supremo_config` VALUES (5, 'A', 63014, 'Arconte Infernale', 2000, 70, 1);
INSERT INTO `hunter_supremo_config` VALUES (6, 'S', 63015, 'Monarca delle Tenebre', 3000, 80, 1);
INSERT INTO `hunter_supremo_config` VALUES (7, 'N', 63016, 'Re dei Supremi', 5000, 90, 1);

-- ----------------------------
-- Table structure for hunter_supremo_log
-- ----------------------------
DROP TABLE IF EXISTS `hunter_supremo_log`;
CREATE TABLE `hunter_supremo_log`  (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `summoner_id` int NOT NULL,
  `summoner_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `supremo_vnum` int NOT NULL,
  `supremo_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `supremo_rank` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `map_index` int NOT NULL DEFAULT 2,
  `coord_x` int NOT NULL DEFAULT 724,
  `coord_y` int NOT NULL DEFAULT 657,
  `spawned_at` datetime NULL DEFAULT current_timestamp,
  `killed_at` datetime NULL DEFAULT NULL,
  `killer_id` int NULL DEFAULT NULL,
  `killer_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status` enum('alive','killed','despawned') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'alive',
  `killed_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `gloria_awarded` int NULL DEFAULT 0,
  PRIMARY KEY (`log_id`) USING BTREE,
  INDEX `idx_summoner`(`summoner_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_spawned`(`spawned_at` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Log evocazioni Supremo' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hunter_supremo_log
-- ----------------------------
INSERT INTO `hunter_supremo_log` VALUES (1, 4, '[GF]HunabKu', 63001, 'Cavaliere Oscuro', 'D', 2, 9937, 2704, '2026-01-24 15:04:23', NULL, NULL, NULL, 'alive', NULL, 0);
INSERT INTO `hunter_supremo_log` VALUES (2, 4, '[GF]HunabKu', 63001, 'Cavaliere Oscuro', 'D', 2, 9937, 2702, '2026-01-24 15:05:26', NULL, NULL, NULL, 'alive', NULL, 0);
INSERT INTO `hunter_supremo_log` VALUES (3, 4, '[GF]HunabKu', 63001, 'Cavaliere Oscuro', 'D', 2, 9772, 2699, '2026-01-24 15:22:04', NULL, NULL, NULL, 'alive', NULL, 0);
INSERT INTO `hunter_supremo_log` VALUES (4, 4, '[GF]HunabKu', 63001, 'Cavaliere Oscuro', 'D', 2, 9842, 2712, '2026-01-24 15:28:29', NULL, NULL, NULL, 'alive', NULL, 0);
INSERT INTO `hunter_supremo_log` VALUES (5, 4, '[GF]HunabKu', 63001, 'Cavaliere Oscuro', 'D', 2, 9840, 2708, '2026-01-24 15:29:05', NULL, NULL, NULL, 'alive', NULL, 0);
INSERT INTO `hunter_supremo_log` VALUES (6, 4, '[GF]HunabKu', 63001, 'Cavaliere Oscuro', 'D', 2, 9638, 2880, '2026-01-24 15:43:11', NULL, NULL, NULL, '', NULL, 0);
INSERT INTO `hunter_supremo_log` VALUES (7, 4, '[GF]HunabKu', 63001, 'Cavaliere Oscuro', 'D', 2, 9644, 2874, '2026-01-24 15:53:42', NULL, NULL, NULL, '', NULL, 0);
INSERT INTO `hunter_supremo_log` VALUES (8, 4, '[GF]HunabKu', 63001, 'Cavaliere Oscuro', 'D', 2, 9650, 2885, '2026-01-24 16:13:06', NULL, NULL, NULL, '', NULL, 0);
INSERT INTO `hunter_supremo_log` VALUES (9, 4, '[GF]HunabKu', 63011, 'Cavaliere Oscuro', 'D', 2, 9650, 2885, '2026-01-24 16:17:45', NULL, NULL, NULL, '', NULL, 0);
INSERT INTO `hunter_supremo_log` VALUES (10, 4, '[GF]HunabKu', 63011, 'Cavaliere Oscuro', 'D', 2, 9654, 2889, '2026-01-24 16:18:50', NULL, NULL, NULL, '', NULL, 0);
INSERT INTO `hunter_supremo_log` VALUES (11, 4, '[GF]HunabKu', 63011, 'Cavaliere Oscuro', 'D', 2, 9654, 2889, '2026-01-24 16:19:14', NULL, NULL, NULL, '', NULL, 0);
INSERT INTO `hunter_supremo_log` VALUES (12, 4, '[GF]HunabKu', 63011, 'Cavaliere Oscuro', 'D', 2, 9652, 2890, '2026-01-24 16:44:03', NULL, NULL, NULL, '', NULL, 0);
INSERT INTO `hunter_supremo_log` VALUES (13, 4, '[GF]HunabKu', 63012, 'Demone delle Ombre', 'C', 2, 9650, 2901, '2026-01-24 21:40:07', NULL, NULL, NULL, '', NULL, 0);
INSERT INTO `hunter_supremo_log` VALUES (14, 4, '[GF]HunabKu', 63012, 'Demone delle Ombre', 'C', 6, 5624, 3308, '2026-01-24 22:10:14', NULL, NULL, NULL, '', NULL, 0);
INSERT INTO `hunter_supremo_log` VALUES (15, 4, '[GF]HunabKu', 63012, 'Demone delle Ombre', 'C', 2, 9967, 2701, '2026-01-25 14:14:01', NULL, NULL, NULL, '', NULL, 0);
INSERT INTO `hunter_supremo_log` VALUES (16, 4, '[GF]HunabKu', 63012, 'Demone delle Ombre', 'C', 2, 9639, 2870, '2026-01-25 15:16:29', NULL, NULL, NULL, '', NULL, 0);

-- ----------------------------
-- Table structure for hunter_supremo_settings
-- ----------------------------
DROP TABLE IF EXISTS `hunter_supremo_settings`;
CREATE TABLE `hunter_supremo_settings`  (
  `setting_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `setting_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`setting_key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hunter_supremo_settings
-- ----------------------------
INSERT INTO `hunter_supremo_settings` VALUES ('access_duration_hours', '2', 'Ore di validita accesso dopo selezione');
INSERT INTO `hunter_supremo_settings` VALUES ('challenge_duration', '600', 'Durata sfida Supremo in secondi (10 minuti)');
INSERT INTO `hunter_supremo_settings` VALUES ('cooldown_seconds', '600', 'Cooldown globale tra spawn in secondi (300 = 5 minuti)');
INSERT INTO `hunter_supremo_settings` VALUES ('fail_penalty', '500', 'Penalità base Gloria per fallimento');
INSERT INTO `hunter_supremo_settings` VALUES ('max_distance', '4000', 'Distanza massima dal Supremo (unita di gioco, 4000 = 40 metri)');
INSERT INTO `hunter_supremo_settings` VALUES ('rejection_penalty', '500', 'Gloria persa se parli con NPC senza essere selezionato');
INSERT INTO `hunter_supremo_settings` VALUES ('spawn_count', '1', 'Numero di mob da spawnare');

-- ----------------------------
-- Table structure for hunter_suspicious_players
-- ----------------------------
DROP TABLE IF EXISTS `hunter_suspicious_players`;
CREATE TABLE `hunter_suspicious_players`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `player_id` int NOT NULL,
  `player_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `alert_count` int NOT NULL DEFAULT 1,
  `first_alert_at` datetime NOT NULL DEFAULT current_timestamp,
  `last_alert_at` datetime NOT NULL DEFAULT current_timestamp,
  `status` enum('MONITORING','WARNED','BANNED') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'MONITORING',
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_player`(`player_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC, `alert_count` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hunter_suspicious_players
-- ----------------------------
INSERT INTO `hunter_suspicious_players` VALUES (1, 440, 'SuraF', 'HIGH_CHEST_RATE | HIGH_CHEST_RATE | HIGH_CHEST_RATE | HIGH_CHEST_RATE | HIGH_CHEST_RATE | HIGH_CHEST_RATE | HIGH_CHEST_RATE | HIGH_CHEST_RATE | HIGH_CHEST_RATE | HIGH_CHEST_RATE | HIGH_CHEST_RATE | HIGH_CHEST_RATE | HIGH_CHEST_RATE | HIGH_CHEST_RATE | HIG', 27, '2026-01-20 13:39:30', '2026-01-20 13:49:25', 'MONITORING', NULL);

-- ----------------------------
-- Table structure for hunter_system_status
-- ----------------------------
DROP TABLE IF EXISTS `hunter_system_status`;
CREATE TABLE `hunter_system_status`  (
  `status_key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_update` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`status_key`) USING BTREE,
  UNIQUE INDEX `status_key`(`status_key` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

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
  `text_key` varchar(64) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `text_value` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `category` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT 'general',
  `color_code` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `enabled` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`text_key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

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
-- View structure for v_hunter_daily_summary
-- ----------------------------
DROP VIEW IF EXISTS `v_hunter_daily_summary`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_hunter_daily_summary` AS select `hunter_security_logs`.`player_id` AS `player_id`,`hunter_security_logs`.`player_name` AS `player_name`,cast(`hunter_security_logs`.`created_at` as date) AS `log_date`,count(0) AS `total_logs`,sum(case when `hunter_security_logs`.`severity` = 'INFO' then 1 else 0 end) AS `info_count`,sum(case when `hunter_security_logs`.`severity` = 'WARNING' then 1 else 0 end) AS `warning_count`,sum(case when `hunter_security_logs`.`severity` = 'ALERT' then 1 else 0 end) AS `alert_count`,sum(case when `hunter_security_logs`.`severity` = 'CRITICAL' then 1 else 0 end) AS `critical_count`,sum(case when `hunter_security_logs`.`log_type` = 'SPAWN' then 1 else 0 end) AS `spawn_logs`,sum(case when `hunter_security_logs`.`log_type` = 'DEFENSE' then 1 else 0 end) AS `defense_logs`,sum(case when `hunter_security_logs`.`log_type` = 'REWARD' then 1 else 0 end) AS `reward_logs`,sum(case when `hunter_security_logs`.`log_type` = 'GLORY' then 1 else 0 end) AS `glory_logs` from `hunter_security_logs` group by `hunter_security_logs`.`player_id`,`hunter_security_logs`.`player_name`,cast(`hunter_security_logs`.`created_at` as date);

-- ----------------------------
-- View structure for v_hunter_suspicious_activity
-- ----------------------------
DROP VIEW IF EXISTS `v_hunter_suspicious_activity`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_hunter_suspicious_activity` AS select `l`.`log_id` AS `log_id`,`l`.`player_id` AS `player_id`,`l`.`player_name` AS `player_name`,`l`.`log_type` AS `log_type`,`l`.`severity` AS `severity`,`l`.`action` AS `action`,`l`.`details` AS `details`,`l`.`map_index` AS `map_index`,`l`.`position_x` AS `position_x`,`l`.`position_y` AS `position_y`,`l`.`created_at` AS `created_at`,`s`.`alert_count` AS `alert_count`,`s`.`status` AS `player_status` from (`hunter_security_logs` `l` left join `hunter_suspicious_players` `s` on(`l`.`player_id` = `s`.`player_id`)) where `l`.`severity` in ('WARNING','ALERT','CRITICAL') order by `l`.`created_at` desc;

-- ----------------------------
-- View structure for v_missions_by_rank
-- ----------------------------
DROP VIEW IF EXISTS `v_missions_by_rank`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_missions_by_rank` AS select `hunter_mission_definitions`.`mission_id` AS `id`,`hunter_mission_definitions`.`mission_name` AS `mission_name`,`hunter_mission_definitions`.`mission_name` AS `mission_desc`,`hunter_mission_definitions`.`mission_type` AS `mission_type`,`hunter_mission_definitions`.`min_rank` AS `min_rank`,`hunter_mission_definitions`.`target_vnum` AS `target_vnum`,`hunter_mission_definitions`.`target_count` AS `target_count`,`hunter_mission_definitions`.`time_limit_minutes` * 60 AS `time_limit_sec`,`hunter_mission_definitions`.`gloria_reward` AS `reward_glory`,`hunter_mission_definitions`.`gloria_penalty` AS `penalty_glory`,'NORMAL' AS `difficulty`,1 AS `weight` from `hunter_mission_definitions` where `hunter_mission_definitions`.`enabled` = 1 order by `hunter_mission_definitions`.`min_rank`,`hunter_mission_definitions`.`mission_id`;

-- ----------------------------
-- View structure for v_today_events
-- ----------------------------
DROP VIEW IF EXISTS `v_today_events`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_today_events` AS select `hunter_scheduled_events`.`id` AS `id`,`hunter_scheduled_events`.`event_name` AS `event_name`,`hunter_scheduled_events`.`event_type` AS `event_type`,`hunter_scheduled_events`.`event_desc` AS `event_desc`,`hunter_scheduled_events`.`start_hour` AS `start_hour`,`hunter_scheduled_events`.`start_minute` AS `start_minute`,`hunter_scheduled_events`.`duration_minutes` AS `duration_minutes`,`hunter_scheduled_events`.`min_rank` AS `min_rank`,`hunter_scheduled_events`.`reward_glory_base` AS `reward_glory_base`,`hunter_scheduled_events`.`reward_glory_winner` AS `reward_glory_winner`,`hunter_scheduled_events`.`color_scheme` AS `color_scheme`,`hunter_scheduled_events`.`priority` AS `priority`,concat(lpad(`hunter_scheduled_events`.`start_hour`,2,'0'),':',lpad(`hunter_scheduled_events`.`start_minute`,2,'0')) AS `start_time` from `hunter_scheduled_events` where `hunter_scheduled_events`.`enabled` = 1 and find_in_set(dayofweek(curdate()),`hunter_scheduled_events`.`days_active`) > 0 order by `hunter_scheduled_events`.`start_hour`,`hunter_scheduled_events`.`start_minute`;

-- ----------------------------
-- Function structure for fn_rank_to_num
-- ----------------------------
DROP FUNCTION IF EXISTS `fn_rank_to_num`;
delimiter ;;
CREATE FUNCTION `fn_rank_to_num`(p_rank VARCHAR(2))
 RETURNS int(11)
  DETERMINISTIC
BEGIN
    CASE p_rank
        WHEN 'E' THEN RETURN 0;
        WHEN 'D' THEN RETURN 1;
        WHEN 'C' THEN RETURN 2;
        WHEN 'B' THEN RETURN 3;
        WHEN 'A' THEN RETURN 4;
        WHEN 'S' THEN RETURN 5;
        WHEN 'N' THEN RETURN 6;
        ELSE RETURN 0;
    END CASE;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for get_dynamic_translation
-- ----------------------------
DROP FUNCTION IF EXISTS `get_dynamic_translation`;
delimiter ;;
CREATE FUNCTION `get_dynamic_translation`(p_table_name VARCHAR(50),
    p_record_id INT,
    p_field_name VARCHAR(50),
    p_lang_code VARCHAR(5),
    p_fallback TEXT)
 RETURNS text CHARSET utf8mb4 COLLATE utf8mb4_general_ci
  DETERMINISTIC
BEGIN
    DECLARE v_translated TEXT;
    
    SELECT translated_text INTO v_translated
    FROM hunter_dynamic_translations
    WHERE table_name = p_table_name
    AND record_id = p_record_id
    AND field_name = p_field_name
    AND lang_code = p_lang_code
    LIMIT 1;
    
    IF v_translated IS NULL THEN
        -- Prova inglese come fallback
        SELECT translated_text INTO v_translated
        FROM hunter_dynamic_translations
        WHERE table_name = p_table_name
        AND record_id = p_record_id
        AND field_name = p_field_name
        AND lang_code = 'en'
        LIMIT 1;
    END IF;
    
    IF v_translated IS NULL THEN
        RETURN p_fallback;
    END IF;
    
    RETURN v_translated;
END
;;
delimiter ;

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
        IF done THEN LEAVE read_loop; END IF;
        
        UPDATE hunter_quest_ranking 
        SET total_points = GREATEST(0, total_points - v_total_penalty)
        WHERE player_id = v_player_id;
        
        UPDATE hunter_player_missions 
        SET status = 'failed'
        WHERE player_id = v_player_id 
          AND assigned_date = DATE_SUB(CURDATE(), INTERVAL 1 DAY)
          AND status = 'active';
    END LOOP;
    CLOSE cur;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_assign_daily_missions
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_assign_daily_missions`;
delimiter ;;
CREATE PROCEDURE `sp_assign_daily_missions`(IN p_player_id INT, IN p_rank VARCHAR(2), IN p_player_name VARCHAR(64))
BEGIN
    DECLARE v_today DATE;
    DECLARE v_existing INT DEFAULT 0;
    DECLARE v_player_rank_num INT;
    DECLARE v_mission1_id INT DEFAULT NULL;
    DECLARE v_mission2_id INT DEFAULT NULL;
    DECLARE v_mission3_id INT DEFAULT NULL;
    DECLARE v_mission1_target INT;
    DECLARE v_mission2_target INT;
    DECLARE v_mission3_target INT;
    DECLARE v_mission1_reward INT;
    DECLARE v_mission2_reward INT;
    DECLARE v_mission3_reward INT;
    DECLARE v_mission1_penalty INT;
    DECLARE v_mission2_penalty INT;
    DECLARE v_mission3_penalty INT;
    
    SET v_today = CURDATE();
    SET v_player_rank_num = fn_rank_to_num(p_rank);
    
    -- Controlla missioni esistenti oggi
    SELECT COUNT(*) INTO v_existing FROM hunter_player_missions WHERE player_id = p_player_id AND assigned_date = v_today;
    
    -- Se ne ha meno di 3 (o 0), rigenera
    IF v_existing < 3 THEN
        DELETE FROM hunter_player_missions WHERE player_id = p_player_id AND assigned_date = v_today;
        
        -- Slot 1
        SELECT mission_id, target_count, gloria_reward, gloria_penalty 
        INTO v_mission1_id, v_mission1_target, v_mission1_reward, v_mission1_penalty
        FROM hunter_mission_definitions WHERE enabled = 1 AND fn_rank_to_num(min_rank) <= v_player_rank_num
        ORDER BY RAND() LIMIT 1;
        
        -- Slot 2
        SELECT mission_id, target_count, gloria_reward, gloria_penalty 
        INTO v_mission2_id, v_mission2_target, v_mission2_reward, v_mission2_penalty
        FROM hunter_mission_definitions WHERE enabled = 1 AND fn_rank_to_num(min_rank) <= v_player_rank_num AND mission_id != IFNULL(v_mission1_id, -1)
        ORDER BY RAND() LIMIT 1;
        
        -- Slot 3
        SELECT mission_id, target_count, gloria_reward, gloria_penalty 
        INTO v_mission3_id, v_mission3_target, v_mission3_reward, v_mission3_penalty
        FROM hunter_mission_definitions WHERE enabled = 1 AND fn_rank_to_num(min_rank) <= v_player_rank_num AND mission_id != IFNULL(v_mission1_id, -1) AND mission_id != IFNULL(v_mission2_id, -1)
        ORDER BY RAND() LIMIT 1;
        
        IF v_mission1_id IS NOT NULL THEN
            INSERT INTO hunter_player_missions (player_id, mission_slot, mission_def_id, assigned_date, current_progress, target_count, status, reward_glory, penalty_glory)
            VALUES (p_player_id, 1, v_mission1_id, v_today, 0, v_mission1_target, 'active', v_mission1_reward, v_mission1_penalty);
        END IF;
        IF v_mission2_id IS NOT NULL THEN
            INSERT INTO hunter_player_missions (player_id, mission_slot, mission_def_id, assigned_date, current_progress, target_count, status, reward_glory, penalty_glory)
            VALUES (p_player_id, 2, v_mission2_id, v_today, 0, v_mission2_target, 'active', v_mission2_reward, v_mission2_penalty);
        END IF;
        IF v_mission3_id IS NOT NULL THEN
            INSERT INTO hunter_player_missions (player_id, mission_slot, mission_def_id, assigned_date, current_progress, target_count, status, reward_glory, penalty_glory)
            VALUES (p_player_id, 3, v_mission3_id, v_today, 0, v_mission3_target, 'active', v_mission3_reward, v_mission3_penalty);
        END IF;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_check_gate_access
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_check_gate_access`;
delimiter ;;
CREATE PROCEDURE `sp_check_gate_access`(IN p_player_id INT,
    OUT p_has_access TINYINT,
    OUT p_gate_id INT,
    OUT p_gate_name VARCHAR(64),
    OUT p_remaining_seconds INT,
    OUT p_color_code VARCHAR(16))
BEGIN
    SELECT 
        1,
        ga.gate_id,
        gc.gate_name,
        GREATEST(0, TIMESTAMPDIFF(SECOND, NOW(), ga.expires_at)),
        gc.color_code
    INTO p_has_access, p_gate_id, p_gate_name, p_remaining_seconds, p_color_code
    FROM hunter_gate_access ga
    JOIN hunter_gate_config gc ON ga.gate_id = gc.gate_id
    WHERE ga.player_id = p_player_id
      AND ga.status = 'pending'
      AND ga.expires_at > NOW()
    LIMIT 1;
    
    IF p_has_access IS NULL THEN
        SET p_has_access = 0;
        SET p_gate_id = 0;
        SET p_gate_name = '';
        SET p_remaining_seconds = 0;
        SET p_color_code = '';
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_check_trial_complete
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_check_trial_complete`;
delimiter ;;
CREATE PROCEDURE `sp_check_trial_complete`(IN p_player_id INT,
    OUT p_completed TINYINT,
    OUT p_new_rank VARCHAR(2),
    OUT p_gloria_reward INT,
    OUT p_title_reward VARCHAR(64))
BEGIN
    DECLARE v_trial_id INT;
    DECLARE v_boss_kills INT;
    DECLARE v_metin_kills INT;
    DECLARE v_fracture_seals INT;
    DECLARE v_chest_opens INT;
    DECLARE v_daily_missions INT;
    DECLARE v_req_boss INT;
    DECLARE v_req_metin INT;
    DECLARE v_req_fracture INT;
    DECLARE v_req_chest INT;
    DECLARE v_req_daily INT;
    
    SET p_completed = 0;
    
    SELECT pt.trial_id, pt.boss_kills, pt.metin_kills, pt.fracture_seals, pt.chest_opens, pt.daily_missions,
           rt.required_boss_kills, rt.required_metin_kills, rt.required_fracture_seals, rt.required_chest_opens, rt.required_daily_missions,
           rt.to_rank, rt.gloria_reward, rt.title_reward
    INTO v_trial_id, v_boss_kills, v_metin_kills, v_fracture_seals, v_chest_opens, v_daily_missions,
         v_req_boss, v_req_metin, v_req_fracture, v_req_chest, v_req_daily,
         p_new_rank, p_gloria_reward, p_title_reward
    FROM hunter_player_trials pt
    JOIN hunter_rank_trials rt ON pt.trial_id = rt.trial_id
    WHERE pt.player_id = p_player_id AND pt.status = 'in_progress'
    LIMIT 1;
    
    IF v_trial_id IS NOT NULL THEN
        IF v_boss_kills >= v_req_boss 
           AND v_metin_kills >= v_req_metin 
           AND v_fracture_seals >= v_req_fracture 
           AND v_chest_opens >= v_req_chest 
           AND v_daily_missions >= v_req_daily THEN
            
            -- Completa la prova
            UPDATE hunter_player_trials SET status = 'completed', completed_at = NOW() WHERE player_id = p_player_id AND trial_id = v_trial_id;
            
            -- Aggiorna rank e gloria
            UPDATE hunter_quest_ranking 
            SET hunter_rank = p_new_rank, 
                current_rank = p_new_rank,
                total_points = total_points + p_gloria_reward
            WHERE player_id = p_player_id;
            
            SET p_completed = 1;
        END IF;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_complete_gate
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_complete_gate`;
delimiter ;;
CREATE PROCEDURE `sp_complete_gate`(IN p_player_id INT,
    IN p_result VARCHAR(16),
    OUT p_gloria_change INT)
BEGIN
    DECLARE v_access_id INT;
    DECLARE v_gate_id INT;
    DECLARE v_gate_name VARCHAR(64);
    DECLARE v_entered_at TIMESTAMP;
    DECLARE v_gloria_reward INT;
    DECLARE v_gloria_penalty INT;
    DECLARE v_duration INT;
    
    -- Trova l'accesso attivo
    SELECT ga.access_id, ga.gate_id, gc.gate_name, ga.entered_at, gc.gloria_reward, gc.gloria_penalty
    INTO v_access_id, v_gate_id, v_gate_name, v_entered_at, v_gloria_reward, v_gloria_penalty
    FROM hunter_gate_access ga
    JOIN hunter_gate_config gc ON ga.gate_id = gc.gate_id
    WHERE ga.player_id = p_player_id AND ga.status = 'entered'
    LIMIT 1;
    
    IF v_access_id IS NOT NULL THEN
        SET v_duration = TIMESTAMPDIFF(SECOND, v_entered_at, NOW());
        
        IF p_result = 'completed' THEN
            SET p_gloria_change = v_gloria_reward;
            UPDATE hunter_gate_access SET status = 'completed', completed_at = NOW(), gloria_earned = v_gloria_reward WHERE access_id = v_access_id;
        ELSE
            SET p_gloria_change = -v_gloria_penalty;
            UPDATE hunter_gate_access SET status = 'failed', completed_at = NOW(), gloria_earned = -v_gloria_penalty WHERE access_id = v_access_id;
        END IF;
        
        -- Aggiorna Gloria del giocatore
        UPDATE hunter_quest_ranking 
        SET total_points = GREATEST(0, total_points + p_gloria_change),
            daily_points = daily_points + GREATEST(0, p_gloria_change)
        WHERE player_id = p_player_id;
        
        -- Inserisci in history
        INSERT INTO hunter_gate_history (player_id, player_name, gate_id, gate_name, result, gloria_change, duration_seconds)
        SELECT p_player_id, player_name, v_gate_id, v_gate_name, p_result, p_gloria_change, v_duration
        FROM hunter_quest_ranking WHERE player_id = p_player_id;
    ELSE
        SET p_gloria_change = 0;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_distribute_party_glory
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_distribute_party_glory`;
delimiter ;;
CREATE PROCEDURE `sp_distribute_party_glory`(IN p_opener_id INT,
    IN p_opener_name VARCHAR(50),
    IN p_base_glory INT,
    IN p_source_type VARCHAR(50),
    IN p_source_name VARCHAR(100))
BEGIN
    DECLARE v_party_id INT DEFAULT 0;
    DECLARE v_member_count INT DEFAULT 0;
    DECLARE v_share_per_member INT DEFAULT 0;
    
    -- Trova il party_id del giocatore che ha aperto
    SELECT pid INTO v_party_id 
    FROM player.player 
    WHERE id = p_opener_id;
    
    -- Se non ha party (pid=0), assegna tutto a lui
    IF v_party_id IS NULL OR v_party_id = 0 THEN
        -- Assegna direttamente all'opener
        UPDATE srv1_hunabku.hunter_quest_ranking 
        SET total_points = total_points + p_base_glory,
            spendable_points = spendable_points + p_base_glory
        WHERE player_id = p_opener_id;
    ELSE
        -- Conta i membri del party
        SELECT COUNT(*) INTO v_member_count 
        FROM player.player 
        WHERE pid = v_party_id;
        
        IF v_member_count < 1 THEN SET v_member_count = 1; END IF;
        
        -- Calcola la quota per membro (divisione equa semplice)
        SET v_share_per_member = FLOOR(p_base_glory / v_member_count);
        IF v_share_per_member < 1 THEN SET v_share_per_member = 1; END IF;
        
        -- Inserisci ricompense pendenti per TUTTI i membri del party
        INSERT INTO srv1_hunabku.hunter_pending_rewards 
            (player_id, player_name, glory_amount, source_type, source_name, opener_id, opener_name)
        SELECT 
            p.id,
            p.name,
            v_share_per_member,
            p_source_type,
            p_source_name,
            p_opener_id,
            p_opener_name
        FROM player.player p
        WHERE p.pid = v_party_id;
        
        -- Assegna subito la gloria a tutti i membri del party
        UPDATE srv1_hunabku.hunter_quest_ranking r
        INNER JOIN player.player p ON r.player_id = p.id
        SET r.total_points = r.total_points + v_share_per_member,
            r.spendable_points = r.spendable_points + v_share_per_member
        WHERE p.pid = v_party_id;
        
        -- Marca le ricompense come consegnate
        UPDATE srv1_hunabku.hunter_pending_rewards
        SET claimed = 1, claimed_at = NOW()
        WHERE opener_id = p_opener_id 
        AND source_name = p_source_name
        AND claimed = 0;
    END IF;
    
    -- Ritorna il numero di membri che hanno ricevuto
    SELECT v_member_count AS members_rewarded, v_share_per_member AS glory_each;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_distribute_party_glory_merit
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_distribute_party_glory_merit`;
delimiter ;;
CREATE PROCEDURE `sp_distribute_party_glory_merit`(IN p_opener_id INT,
    IN p_opener_name VARCHAR(50),
    IN p_base_glory INT,
    IN p_source_type VARCHAR(50),
    IN p_source_name VARCHAR(100))
BEGIN
    DECLARE v_party_id INT DEFAULT 0;
    DECLARE v_total_power INT DEFAULT 0;
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_pid INT;
    DECLARE v_pname VARCHAR(50);
    DECLARE v_points INT;
    DECLARE v_grade VARCHAR(5);
    DECLARE v_power INT;
    DECLARE v_share INT;
    DECLARE v_member_count INT DEFAULT 0;
    
    -- Cursore per iterare sui membri del party
    DECLARE member_cursor CURSOR FOR
        SELECT p.id, p.name, COALESCE(r.total_points, 0) as points
        FROM player.player p
        LEFT JOIN srv1_hunabku.hunter_quest_ranking r ON p.id = r.player_id
        WHERE p.pid = v_party_id;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- Trova il party_id
    SELECT pid INTO v_party_id 
    FROM player.player 
    WHERE id = p_opener_id;
    
    -- Se non ha party, assegna tutto a lui
    IF v_party_id IS NULL OR v_party_id = 0 THEN
        UPDATE srv1_hunabku.hunter_quest_ranking 
        SET total_points = total_points + p_base_glory,
            spendable_points = spendable_points + p_base_glory
        WHERE player_id = p_opener_id;
        
        SELECT 1 AS members_rewarded, p_base_glory AS glory_each;
    ELSE
        -- Calcola il power totale del party
        SELECT SUM(
            CASE 
                WHEN COALESCE(r.total_points, 0) >= 100000 THEN 250  -- N
                WHEN COALESCE(r.total_points, 0) >= 50000 THEN 150   -- S
                WHEN COALESCE(r.total_points, 0) >= 20000 THEN 80    -- A
                WHEN COALESCE(r.total_points, 0) >= 8000 THEN 40     -- B
                WHEN COALESCE(r.total_points, 0) >= 3000 THEN 15     -- C
                WHEN COALESCE(r.total_points, 0) >= 500 THEN 5       -- D
                ELSE 1                                               -- E
            END
        ) INTO v_total_power
        FROM player.player p
        LEFT JOIN srv1_hunabku.hunter_quest_ranking r ON p.id = r.player_id
        WHERE p.pid = v_party_id;
        
        IF v_total_power < 1 THEN SET v_total_power = 1; END IF;
        
        -- Itera sui membri e distribuisci per meritocrazia
        OPEN member_cursor;
        
        read_loop: LOOP
            FETCH member_cursor INTO v_pid, v_pname, v_points;
            IF done THEN
                LEAVE read_loop;
            END IF;
            
            -- Calcola il power rank di questo membro
            SET v_power = CASE 
                WHEN v_points >= 100000 THEN 250
                WHEN v_points >= 50000 THEN 150
                WHEN v_points >= 20000 THEN 80
                WHEN v_points >= 8000 THEN 40
                WHEN v_points >= 3000 THEN 15
                WHEN v_points >= 500 THEN 5
                ELSE 1
            END;
            
            -- Calcola la quota basata sul power rank
            SET v_share = FLOOR((v_power * p_base_glory) / v_total_power);
            IF v_share < 1 THEN SET v_share = 1; END IF;
            
            -- Assegna la gloria
            UPDATE srv1_hunabku.hunter_quest_ranking 
            SET total_points = total_points + v_share,
                spendable_points = spendable_points + v_share
            WHERE player_id = v_pid;
            
            -- Se non esiste il record, crealo
            IF ROW_COUNT() = 0 THEN
                INSERT INTO srv1_hunabku.hunter_quest_ranking 
                    (player_id, player_name, total_points, spendable_points)
                VALUES (v_pid, v_pname, v_share, v_share)
                ON DUPLICATE KEY UPDATE
                    total_points = total_points + v_share,
                    spendable_points = spendable_points + v_share;
            END IF;
            
            -- Log nella tabella pending (per storico)
            INSERT INTO srv1_hunabku.hunter_pending_rewards 
                (player_id, player_name, glory_amount, source_type, source_name, opener_id, opener_name, claimed, claimed_at)
            VALUES (v_pid, v_pname, v_share, p_source_type, p_source_name, p_opener_id, p_opener_name, 1, NOW());
            
            SET v_member_count = v_member_count + 1;
        END LOOP;
        
        CLOSE member_cursor;
        
        SELECT v_member_count AS members_rewarded, p_base_glory AS total_glory;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_enter_gate
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_enter_gate`;
delimiter ;;
CREATE PROCEDURE `sp_enter_gate`(IN p_player_id INT,
    IN p_access_id INT,
    OUT p_success TINYINT,
    OUT p_dungeon_index INT,
    OUT p_duration_minutes INT)
BEGIN
    DECLARE v_gate_id INT;
    
    SELECT ga.gate_id, gc.dungeon_index, gc.duration_minutes
    INTO v_gate_id, p_dungeon_index, p_duration_minutes
    FROM hunter_gate_access ga
    JOIN hunter_gate_config gc ON ga.gate_id = gc.gate_id
    WHERE ga.access_id = p_access_id
      AND ga.player_id = p_player_id
      AND ga.status = 'pending'
      AND ga.expires_at > NOW();
    
    IF v_gate_id IS NOT NULL THEN
        UPDATE hunter_gate_access 
        SET status = 'entered', entered_at = NOW()
        WHERE access_id = p_access_id;
        SET p_success = 1;
    ELSE
        SET p_success = 0;
        SET p_dungeon_index = 0;
        SET p_duration_minutes = 0;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_get_party_notifications
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_get_party_notifications`;
delimiter ;;
CREATE PROCEDURE `sp_get_party_notifications`(IN p_player_id INT)
BEGIN
    -- Seleziona tutte le notifiche non ancora mostrate (max 5 alla volta)
    SELECT id, notification_type, source_name, glory_received, glory_total,
           actor_name, actor_rank, color_code, extra_data, created_at
    FROM srv1_hunabku.hunter_party_notifications
    WHERE player_id = p_player_id AND shown = 0
    ORDER BY created_at ASC
    LIMIT 5;
    
    -- Marca come mostrate
    UPDATE srv1_hunabku.hunter_party_notifications
    SET shown = 1, shown_at = NOW()
    WHERE player_id = p_player_id AND shown = 0
    LIMIT 5;
    
    -- Pulizia vecchie notifiche (oltre 1 ora)
    DELETE FROM srv1_hunabku.hunter_party_notifications
    WHERE created_at < DATE_SUB(NOW(), INTERVAL 1 HOUR);
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_hunter_activity
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_hunter_activity`;
delimiter ;;
CREATE PROCEDURE `sp_hunter_activity`(IN p_player_id INT,
    IN p_player_name VARCHAR(24),
    IN p_activity_type VARCHAR(30),
    IN p_vnum INT,
    IN p_amount INT,
    IN p_metadata JSON)
BEGIN
    DECLARE v_base_points INT DEFAULT 0;
    DECLARE v_vnum_type VARCHAR(20) DEFAULT 'mob';
    DECLARE v_current_rank CHAR(1) DEFAULT 'E';
    DECLARE v_streak_bonus DECIMAL(5,2) DEFAULT 0;
    DECLARE v_event_mult DECIMAL(3,2) DEFAULT 1.00;
    DECLARE v_final_glory INT DEFAULT 0;
    DECLARE v_is_boss TINYINT DEFAULT 0;
    DECLARE v_is_metin TINYINT DEFAULT 0;
    DECLARE v_speed_kill_bonus TINYINT DEFAULT 0;
    
    INSERT INTO hunter_players (player_id, player_name, created_at)
    VALUES (p_player_id, p_player_name, NOW())
    ON DUPLICATE KEY UPDATE player_name = p_player_name;
    
    SELECT current_rank,
           CASE 
               WHEN login_streak >= 30 THEN 0.20
               WHEN login_streak >= 14 THEN 0.15
               WHEN login_streak >= 7 THEN 0.10
               WHEN login_streak >= 3 THEN 0.05
               ELSE 0
           END
    INTO v_current_rank, v_streak_bonus
    FROM hunter_players WHERE player_id = p_player_id;
    
    IF p_activity_type IN ('kill_mob', 'kill_boss', 'kill_metin') THEN
        SELECT COALESCE(base_points, 1), 
               COALESCE(vnum_type, 'mob'),
               COALESCE(event_multiplier, 1.00),
               COALESCE(speed_kill_bonus, 0)
        INTO v_base_points, v_vnum_type, v_event_mult, v_speed_kill_bonus
        FROM hunter_vnum_registry WHERE vnum = p_vnum;
        
        IF v_base_points = 0 THEN SET v_base_points = 1; END IF;
        SET v_is_boss = IF(v_vnum_type IN ('boss', 'super_boss'), 1, 0);
        SET v_is_metin = IF(v_vnum_type IN ('metin', 'super_metin'), 1, 0);
        SET v_final_glory = FLOOR(v_base_points * v_event_mult * (1 + v_streak_bonus));
        
        IF p_amount = 1 AND v_speed_kill_bonus = 1 THEN
            SET v_final_glory = v_final_glory * 2;
        END IF;
        
        UPDATE hunter_players SET
            pending_glory = pending_glory + v_final_glory,
            pending_kills = pending_kills + 1,
            total_bosses = total_bosses + v_is_boss,
            total_metins = total_metins + v_is_metin,
            trial_boss_kills = trial_boss_kills + IF(trial_id > 0, v_is_boss, 0),
            trial_metin_kills = trial_metin_kills + IF(trial_id > 0, v_is_metin, 0)
        WHERE player_id = p_player_id;
        
    ELSEIF p_activity_type = 'open_chest' THEN
        SELECT COALESCE(base_points, 50) INTO v_final_glory FROM hunter_vnum_registry WHERE vnum = p_vnum;
        IF v_final_glory = 0 THEN SET v_final_glory = 50; END IF;
        UPDATE hunter_players SET
            pending_glory = pending_glory + v_final_glory,
            total_chests = total_chests + 1,
            trial_chest_opens = trial_chest_opens + IF(trial_id > 0, 1, 0)
        WHERE player_id = p_player_id;
        
    ELSEIF p_activity_type = 'seal_fracture' THEN
        SET v_final_glory = p_amount;
        UPDATE hunter_players SET
            pending_glory = pending_glory + v_final_glory,
            total_fractures = total_fractures + 1,
            trial_fracture_seals = trial_fracture_seals + IF(trial_id > 0, 1, 0)
        WHERE player_id = p_player_id;
        
    ELSEIF p_activity_type = 'complete_mission' THEN
        SET v_final_glory = p_amount;
        UPDATE hunter_players SET
            pending_glory = pending_glory + v_final_glory,
            trial_daily_missions = trial_daily_missions + IF(trial_id > 0, 1, 0)
        WHERE player_id = p_player_id;
        
    ELSEIF p_activity_type = 'complete_trial' THEN
        SET v_final_glory = p_amount;
        UPDATE hunter_players SET
            pending_glory = pending_glory + v_final_glory,
            trial_id = 0, trial_boss_kills = 0, trial_metin_kills = 0,
            trial_fracture_seals = 0, trial_chest_opens = 0, trial_daily_missions = 0,
            trial_started_at = NULL, trial_expires_at = NULL
        WHERE player_id = p_player_id;
        
    ELSEIF p_activity_type = 'enter_gate' THEN
        UPDATE hunter_players SET
            gate_id = p_vnum,
            gate_entered_at = NOW(),
            gate_expires_at = DATE_ADD(NOW(), INTERVAL p_amount MINUTE)
        WHERE player_id = p_player_id;
        
    ELSEIF p_activity_type = 'complete_gate' THEN
        SET v_final_glory = p_amount;
        UPDATE hunter_players SET
            pending_glory = pending_glory + v_final_glory,
            gate_id = 0, gate_entered_at = NULL, gate_expires_at = NULL
        WHERE player_id = p_player_id;
        
    ELSEIF p_activity_type = 'fail_gate' THEN
        SET v_final_glory = -p_amount;
        UPDATE hunter_players SET
            total_glory = GREATEST(0, total_glory - p_amount),
            gate_id = 0, gate_entered_at = NULL, gate_expires_at = NULL
        WHERE player_id = p_player_id;
        
    ELSEIF p_activity_type = 'login_bonus' THEN
        UPDATE hunter_players SET
            login_streak = IF(last_login = DATE_SUB(CURDATE(), INTERVAL 1 DAY), login_streak + 1, 1),
            last_login = CURDATE()
        WHERE player_id = p_player_id;
        
    ELSEIF p_activity_type = 'convert_credits' THEN
        UPDATE hunter_players SET
            spendable_credits = spendable_credits + p_amount,
            total_glory = GREATEST(0, total_glory - (p_amount * 10))
        WHERE player_id = p_player_id;
        
    ELSEIF p_activity_type = 'shop_purchase' THEN
        UPDATE hunter_players SET
            spendable_credits = GREATEST(0, spendable_credits - p_amount)
        WHERE player_id = p_player_id;
    END IF;
    
    IF v_final_glory != 0 OR p_activity_type IN ('enter_gate', 'login_bonus', 'shop_purchase') THEN
        INSERT INTO hunter_activity_log (player_id, activity_type, vnum, glory_change, metadata)
        VALUES (p_player_id, p_activity_type, p_vnum, v_final_glory, p_metadata);
    END IF;
    
    SELECT v_final_glory AS glory_earned, v_vnum_type AS vnum_type, v_is_boss AS is_boss, v_is_metin AS is_metin;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_hunter_assign_missions
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_hunter_assign_missions`;
delimiter ;;
CREATE PROCEDURE `sp_hunter_assign_missions`(IN p_player_id INT)
BEGIN
    DECLARE v_rank CHAR(1);
    DECLARE v_today DATE;
    DECLARE v_count INT;
    
    SET v_today = CURDATE();
    SELECT COUNT(*) INTO v_count FROM hunter_player_missions WHERE player_id = p_player_id AND assigned_at = v_today;
    
    IF v_count > 0 THEN
        SELECT pm.slot, pm.mission_id, pm.current_progress, pm.status, m.mission_name, m.mission_type, 
               m.target_vnum, m.target_count, m.glory_reward, m.glory_penalty
        FROM hunter_player_missions pm JOIN hunter_missions m ON pm.mission_id = m.mission_id
        WHERE pm.player_id = p_player_id AND pm.assigned_at = v_today ORDER BY pm.slot;
    ELSE
        SELECT current_rank INTO v_rank FROM hunter_players WHERE player_id = p_player_id;
        
        INSERT INTO hunter_player_missions (player_id, slot, mission_id, assigned_at)
        SELECT p_player_id, 0, mission_id, v_today FROM hunter_missions
        WHERE is_active = 1 AND min_rank <= v_rank ORDER BY RAND() * weight DESC LIMIT 1;
        
        INSERT INTO hunter_player_missions (player_id, slot, mission_id, assigned_at)
        SELECT p_player_id, 1, mission_id, v_today FROM hunter_missions
        WHERE is_active = 1 AND min_rank <= v_rank AND mission_id NOT IN 
            (SELECT mission_id FROM hunter_player_missions WHERE player_id = p_player_id AND assigned_at = v_today)
        ORDER BY RAND() * weight DESC LIMIT 1;
        
        INSERT INTO hunter_player_missions (player_id, slot, mission_id, assigned_at)
        SELECT p_player_id, 2, mission_id, v_today FROM hunter_missions
        WHERE is_active = 1 AND min_rank <= v_rank AND mission_id NOT IN 
            (SELECT mission_id FROM hunter_player_missions WHERE player_id = p_player_id AND assigned_at = v_today)
        ORDER BY RAND() * weight DESC LIMIT 1;
        
        SELECT pm.slot, pm.mission_id, pm.current_progress, pm.status, m.mission_name, m.mission_type,
               m.target_vnum, m.target_count, m.glory_reward, m.glory_penalty
        FROM hunter_player_missions pm JOIN hunter_missions m ON pm.mission_id = m.mission_id
        WHERE pm.player_id = p_player_id AND pm.assigned_at = v_today ORDER BY pm.slot;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_hunter_daily_reset
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_hunter_daily_reset`;
delimiter ;;
CREATE PROCEDURE `sp_hunter_daily_reset`()
BEGIN
    CALL sp_hunter_flush_pending();
    UPDATE hunter_players SET daily_glory = 0, daily_kills = 0, daily_position = 0;
    UPDATE hunter_player_missions SET status = 'failed' WHERE status = 'active' AND assigned_at < CURDATE();
    SELECT 'DAILY_RESET_COMPLETE' AS status;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_hunter_flush_pending
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_hunter_flush_pending`;
delimiter ;;
CREATE PROCEDURE `sp_hunter_flush_pending`()
BEGIN
    UPDATE hunter_players SET
        total_glory = total_glory + pending_glory,
        daily_glory = daily_glory + pending_glory,
        weekly_glory = weekly_glory + pending_glory,
        total_kills = total_kills + pending_kills,
        daily_kills = daily_kills + pending_kills,
        weekly_kills = weekly_kills + pending_kills,
        pending_glory = 0, pending_kills = 0, last_flush = NOW()
    WHERE pending_glory > 0 OR pending_kills > 0;
    
    UPDATE hunter_players SET current_rank = 
        CASE 
            WHEN total_glory >= 1500000 THEN 'N'
            WHEN total_glory >= 500000 THEN 'S'
            WHEN total_glory >= 150000 THEN 'A'
            WHEN total_glory >= 50000 THEN 'B'
            WHEN total_glory >= 10000 THEN 'C'
            WHEN total_glory >= 2000 THEN 'D'
            ELSE 'E'
        END;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_hunter_get_active_events
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_hunter_get_active_events`;
delimiter ;;
CREATE PROCEDURE `sp_hunter_get_active_events`()
BEGIN
    DECLARE v_day INT;
    DECLARE v_hour INT;
    
    SET v_day = DAYOFWEEK(NOW());
    SET v_hour = HOUR(NOW());
    
    SELECT event_id, event_name, event_type, glory_multiplier, min_rank, color_code, description
    FROM hunter_events
    WHERE is_active = 1
      AND FIND_IN_SET(v_day, days_active) > 0
      AND v_hour >= start_hour
      AND v_hour < (start_hour + CEIL(duration_minutes / 60));
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_hunter_get_player
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_hunter_get_player`;
delimiter ;;
CREATE PROCEDURE `sp_hunter_get_player`(IN p_player_id INT)
BEGIN
    SELECT p.*, t.trial_name, t.to_rank, t.boss_kills_req, t.metin_kills_req,
           t.fracture_seals_req, t.chest_opens_req, t.daily_missions_req,
           t.glory_reward AS trial_glory_reward, t.color_code AS trial_color
    FROM hunter_players p
    LEFT JOIN hunter_trials t ON p.trial_id = t.trial_id
    WHERE p.player_id = p_player_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_hunter_get_ranking
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_hunter_get_ranking`;
delimiter ;;
CREATE PROCEDURE `sp_hunter_get_ranking`(IN p_type VARCHAR(20), IN p_limit INT)
BEGIN
    IF p_type = 'daily' THEN
        SELECT player_name, daily_glory AS glory, daily_kills AS kills, current_rank
        FROM hunter_players WHERE daily_glory > 0 ORDER BY daily_glory DESC LIMIT p_limit;
    ELSEIF p_type = 'weekly' THEN
        SELECT player_name, weekly_glory AS glory, weekly_kills AS kills, current_rank
        FROM hunter_players WHERE weekly_glory > 0 ORDER BY weekly_glory DESC LIMIT p_limit;
    ELSE
        SELECT player_name, total_glory AS glory, total_kills AS kills, current_rank
        FROM hunter_players WHERE total_glory > 0 ORDER BY total_glory DESC LIMIT p_limit;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_hunter_log
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_hunter_log`;
delimiter ;;
CREATE PROCEDURE `sp_hunter_log`(IN p_player_id INT,
    IN p_player_name VARCHAR(50),
    IN p_log_type VARCHAR(32),
    IN p_severity VARCHAR(16),
    IN p_action VARCHAR(64),
    IN p_details TEXT,
    IN p_map_index INT,
    IN p_pos_x INT,
    IN p_pos_y INT)
BEGIN
    INSERT INTO hunter_security_logs 
        (player_id, player_name, log_type, severity, action, details, map_index, position_x, position_y)
    VALUES 
        (p_player_id, p_player_name, p_log_type, p_severity, p_action, p_details, p_map_index, p_pos_x, p_pos_y);
    
    -- Se severity alta, aggiorna/inserisci in suspicious_players
    IF p_severity IN ('ALERT', 'CRITICAL') THEN
        INSERT INTO hunter_suspicious_players (player_id, player_name, reason, alert_count, first_alert_at, last_alert_at)
        VALUES (p_player_id, p_player_name, p_action, 1, NOW(), NOW())
        ON DUPLICATE KEY UPDATE 
            alert_count = alert_count + 1,
            last_alert_at = NOW(),
            reason = CONCAT(reason, ' | ', p_action);
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_hunter_log_cleanup
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_hunter_log_cleanup`;
delimiter ;;
CREATE PROCEDURE `sp_hunter_log_cleanup`()
BEGIN
    -- Elimina log INFO piu vecchi di 7 giorni
    DELETE FROM hunter_security_logs 
    WHERE severity = 'INFO' AND created_at < DATE_SUB(NOW(), INTERVAL 7 DAY);
    
    -- Elimina log WARNING piu vecchi di 30 giorni
    DELETE FROM hunter_security_logs 
    WHERE severity = 'WARNING' AND created_at < DATE_SUB(NOW(), INTERVAL 30 DAY);
    
    -- Mantieni ALERT e CRITICAL per 90 giorni
    DELETE FROM hunter_security_logs 
    WHERE severity IN ('ALERT', 'CRITICAL') AND created_at < DATE_SUB(NOW(), INTERVAL 90 DAY);
    
    -- Elimina snapshot piu vecchi di 30 giorni
    DELETE FROM hunter_player_stats_snapshot
    WHERE created_at < DATE_SUB(NOW(), INTERVAL 30 DAY);
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_hunter_start_trial
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_hunter_start_trial`;
delimiter ;;
CREATE PROCEDURE `sp_hunter_start_trial`(IN p_player_id INT)
BEGIN
    DECLARE v_rank CHAR(1);
    DECLARE v_trial_id INT;
    DECLARE v_duration INT;
    
    SELECT current_rank INTO v_rank FROM hunter_players WHERE player_id = p_player_id;
    SELECT trial_id, duration_hours INTO v_trial_id, v_duration FROM hunter_trials WHERE from_rank = v_rank LIMIT 1;
    
    IF v_trial_id IS NOT NULL THEN
        UPDATE hunter_players SET
            trial_id = v_trial_id, trial_boss_kills = 0, trial_metin_kills = 0,
            trial_fracture_seals = 0, trial_chest_opens = 0, trial_daily_missions = 0,
            trial_started_at = NOW(), trial_expires_at = DATE_ADD(NOW(), INTERVAL v_duration HOUR)
        WHERE player_id = p_player_id;
        
        SELECT t.*, p.trial_expires_at FROM hunter_trials t
        JOIN hunter_players p ON p.trial_id = t.trial_id
        WHERE t.trial_id = v_trial_id AND p.player_id = p_player_id;
    ELSE
        SELECT 'NO_TRIAL' AS error;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_hunter_update_mission
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_hunter_update_mission`;
delimiter ;;
CREATE PROCEDURE `sp_hunter_update_mission`(IN p_player_id INT,
    IN p_mission_type VARCHAR(20),
    IN p_vnum INT,
    IN p_increment INT)
BEGIN
    DECLARE v_today DATE;
    SET v_today = CURDATE();
    
    -- Aggiorna progresso per missioni attive che matchano il tipo
    UPDATE hunter_player_missions pm
    JOIN hunter_missions m ON pm.mission_id = m.mission_id
    SET pm.current_progress = pm.current_progress + p_increment,
        pm.status = CASE 
            WHEN pm.current_progress + p_increment >= m.target_count THEN 'completed'
            ELSE 'active'
        END,
        pm.completed_at = CASE
            WHEN pm.current_progress + p_increment >= m.target_count THEN NOW()
            ELSE NULL
        END
    WHERE pm.player_id = p_player_id
      AND pm.assigned_at = v_today
      AND pm.status = 'active'
      AND (
          m.mission_type = p_mission_type
          OR (m.mission_type = 'kill_any' AND p_mission_type IN ('kill_mob', 'kill_boss', 'kill_metin'))
          OR (m.mission_type = 'kill_vnum' AND m.target_vnum = p_vnum)
      );
    
    -- Ritorna stato missioni aggiornate
    SELECT pm.slot, pm.mission_id, pm.current_progress, pm.status, 
           m.mission_name, m.target_count, m.glory_reward, m.glory_penalty
    FROM hunter_player_missions pm
    JOIN hunter_missions m ON pm.mission_id = m.mission_id
    WHERE pm.player_id = p_player_id AND pm.assigned_at = v_today;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_hunter_weekly_reset
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_hunter_weekly_reset`;
delimiter ;;
CREATE PROCEDURE `sp_hunter_weekly_reset`()
BEGIN
    CALL sp_hunter_daily_reset();
    UPDATE hunter_players SET weekly_glory = 0, weekly_kills = 0, weekly_position = 0;
    SELECT 'WEEKLY_RESET_COMPLETE' AS status;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_notify_party_glory
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_notify_party_glory`;
delimiter ;;
CREATE PROCEDURE `sp_notify_party_glory`(IN p_actor_id INT,
    IN p_actor_name VARCHAR(50),
    IN p_actor_rank VARCHAR(10),
    IN p_notification_type VARCHAR(30),
    IN p_source_name VARCHAR(100),
    IN p_glory_total INT,
    IN p_color_code VARCHAR(20),
    IN p_extra_data VARCHAR(255))
BEGIN
    DECLARE v_party_id INT DEFAULT 0;
    DECLARE v_total_power INT DEFAULT 0;
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_pid INT;
    DECLARE v_pname VARCHAR(50);
    DECLARE v_points INT;
    DECLARE v_power INT;
    DECLARE v_share INT;
    
    DECLARE member_cursor CURSOR FOR
        SELECT p.id, p.name, COALESCE(r.total_points, 0) as points
        FROM player.player p
        LEFT JOIN srv1_hunabku.hunter_quest_ranking r ON p.id = r.player_id
        WHERE p.pid = v_party_id;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- Trova il party_id
    SELECT pid INTO v_party_id 
    FROM player.player 
    WHERE id = p_actor_id;
    
    -- Se non ha party, notifica solo a lui
    IF v_party_id IS NULL OR v_party_id = 0 THEN
        INSERT INTO srv1_hunabku.hunter_party_notifications 
            (player_id, notification_type, source_name, glory_received, glory_total, 
             actor_name, actor_rank, color_code, extra_data)
        VALUES (p_actor_id, p_notification_type, p_source_name, p_glory_total, p_glory_total,
                p_actor_name, p_actor_rank, p_color_code, p_extra_data);
    ELSE
        -- Calcola power totale per meritocrazia
        SELECT SUM(
            CASE 
                WHEN COALESCE(r.total_points, 0) >= 100000 THEN 250
                WHEN COALESCE(r.total_points, 0) >= 50000 THEN 150
                WHEN COALESCE(r.total_points, 0) >= 20000 THEN 80
                WHEN COALESCE(r.total_points, 0) >= 8000 THEN 40
                WHEN COALESCE(r.total_points, 0) >= 3000 THEN 15
                WHEN COALESCE(r.total_points, 0) >= 500 THEN 5
                ELSE 1
            END
        ) INTO v_total_power
        FROM player.player p
        LEFT JOIN srv1_hunabku.hunter_quest_ranking r ON p.id = r.player_id
        WHERE p.pid = v_party_id;
        
        IF v_total_power < 1 THEN SET v_total_power = 1; END IF;
        
        -- Crea notifica per ogni membro del party
        OPEN member_cursor;
        
        notify_loop: LOOP
            FETCH member_cursor INTO v_pid, v_pname, v_points;
            IF done THEN
                LEAVE notify_loop;
            END IF;
            
            -- Calcola la quota di gloria per questo membro
            SET v_power = CASE 
                WHEN v_points >= 100000 THEN 250
                WHEN v_points >= 50000 THEN 150
                WHEN v_points >= 20000 THEN 80
                WHEN v_points >= 8000 THEN 40
                WHEN v_points >= 3000 THEN 15
                WHEN v_points >= 500 THEN 5
                ELSE 1
            END;
            
            SET v_share = FLOOR((v_power * p_glory_total) / v_total_power);
            IF v_share < 1 THEN SET v_share = 1; END IF;
            
            -- Inserisci notifica
            INSERT INTO srv1_hunabku.hunter_party_notifications 
                (player_id, notification_type, source_name, glory_received, glory_total, 
                 actor_name, actor_rank, color_code, extra_data)
            VALUES (v_pid, p_notification_type, p_source_name, v_share, p_glory_total,
                    p_actor_name, p_actor_rank, p_color_code, p_extra_data);
        END LOOP;
        
        CLOSE member_cursor;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_party_glory_complete
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_party_glory_complete`;
delimiter ;;
CREATE PROCEDURE `sp_party_glory_complete`(IN p_actor_id INT,
    IN p_actor_name VARCHAR(50),
    IN p_base_glory INT,
    IN p_source_type VARCHAR(30),
    IN p_source_name VARCHAR(100),
    IN p_color_code VARCHAR(20),
    IN p_extra_data VARCHAR(255))
BEGIN
    DECLARE v_party_id INT DEFAULT 0;
    DECLARE v_total_power INT DEFAULT 0;
    DECLARE v_actor_rank VARCHAR(10) DEFAULT 'E';
    DECLARE v_actor_points INT DEFAULT 0;
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_pid INT;
    DECLARE v_pname VARCHAR(50);
    DECLARE v_points INT;
    DECLARE v_power INT;
    DECLARE v_share INT;
    DECLARE v_member_count INT DEFAULT 0;
    
    DECLARE member_cursor CURSOR FOR
        SELECT p.id, p.name, COALESCE(r.total_points, 0) as points
        FROM player.player p
        LEFT JOIN srv1_hunabku.hunter_quest_ranking r ON p.id = r.player_id
        WHERE p.pid = v_party_id;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- Ottieni rank dell'attore
    SELECT COALESCE(total_points, 0) INTO v_actor_points
    FROM srv1_hunabku.hunter_quest_ranking
    WHERE player_id = p_actor_id;
    
    SET v_actor_rank = CASE 
        WHEN v_actor_points >= 100000 THEN 'N'
        WHEN v_actor_points >= 50000 THEN 'S'
        WHEN v_actor_points >= 20000 THEN 'A'
        WHEN v_actor_points >= 8000 THEN 'B'
        WHEN v_actor_points >= 3000 THEN 'C'
        WHEN v_actor_points >= 500 THEN 'D'
        ELSE 'E'
    END;
    
    -- Trova il party_id
    SELECT pid INTO v_party_id 
    FROM player.player 
    WHERE id = p_actor_id;
    
    -- === SOLO PLAYER (no party) ===
    IF v_party_id IS NULL OR v_party_id = 0 THEN
        -- Assegna gloria
        UPDATE srv1_hunabku.hunter_quest_ranking 
        SET total_points = total_points + p_base_glory,
            spendable_points = spendable_points + p_base_glory
        WHERE player_id = p_actor_id;
        
        -- Crea notifica
        INSERT INTO srv1_hunabku.hunter_party_notifications 
            (player_id, notification_type, source_name, glory_received, glory_total, 
             actor_name, actor_rank, color_code, extra_data)
        VALUES (p_actor_id, p_source_type, p_source_name, p_base_glory, p_base_glory,
                p_actor_name, v_actor_rank, p_color_code, p_extra_data);
        
        SELECT 1 AS members_rewarded, p_base_glory AS glory_each, v_actor_rank AS actor_rank;
    
    -- === PARTY MODE ===
    ELSE
        -- Calcola power totale
        SELECT SUM(
            CASE 
                WHEN COALESCE(r.total_points, 0) >= 100000 THEN 250
                WHEN COALESCE(r.total_points, 0) >= 50000 THEN 150
                WHEN COALESCE(r.total_points, 0) >= 20000 THEN 80
                WHEN COALESCE(r.total_points, 0) >= 8000 THEN 40
                WHEN COALESCE(r.total_points, 0) >= 3000 THEN 15
                WHEN COALESCE(r.total_points, 0) >= 500 THEN 5
                ELSE 1
            END
        ) INTO v_total_power
        FROM player.player p
        LEFT JOIN srv1_hunabku.hunter_quest_ranking r ON p.id = r.player_id
        WHERE p.pid = v_party_id;
        
        IF v_total_power < 1 THEN SET v_total_power = 1; END IF;
        
        -- Itera e distribuisci + notifica
        OPEN member_cursor;
        
        party_loop: LOOP
            FETCH member_cursor INTO v_pid, v_pname, v_points;
            IF done THEN
                LEAVE party_loop;
            END IF;
            
            -- Power di questo membro
            SET v_power = CASE 
                WHEN v_points >= 100000 THEN 250
                WHEN v_points >= 50000 THEN 150
                WHEN v_points >= 20000 THEN 80
                WHEN v_points >= 8000 THEN 40
                WHEN v_points >= 3000 THEN 15
                WHEN v_points >= 500 THEN 5
                ELSE 1
            END;
            
            -- Quota gloria
            SET v_share = FLOOR((v_power * p_base_glory) / v_total_power);
            IF v_share < 1 THEN SET v_share = 1; END IF;
            
            -- Assegna gloria
            INSERT INTO srv1_hunabku.hunter_quest_ranking 
                (player_id, player_name, total_points, spendable_points)
            VALUES (v_pid, v_pname, v_share, v_share)
            ON DUPLICATE KEY UPDATE
                total_points = total_points + v_share,
                spendable_points = spendable_points + v_share;
            
            -- Crea notifica
            INSERT INTO srv1_hunabku.hunter_party_notifications 
                (player_id, notification_type, source_name, glory_received, glory_total, 
                 actor_name, actor_rank, color_code, extra_data)
            VALUES (v_pid, p_source_type, p_source_name, v_share, p_base_glory,
                    p_actor_name, v_actor_rank, p_color_code, p_extra_data);
            
            -- Log storico
            INSERT INTO srv1_hunabku.hunter_pending_rewards 
                (player_id, player_name, glory_amount, source_type, source_name, 
                 opener_id, opener_name, claimed, claimed_at)
            VALUES (v_pid, v_pname, v_share, p_source_type, p_source_name, 
                    p_actor_id, p_actor_name, 1, NOW());
            
            SET v_member_count = v_member_count + 1;
        END LOOP;
        
        CLOSE member_cursor;
        
        SELECT v_member_count AS members_rewarded, p_base_glory AS total_glory, v_actor_rank AS actor_rank;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_select_gate_players
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_gate_players`;
delimiter ;;
CREATE PROCEDURE `sp_select_gate_players`()
BEGIN
    DECLARE v_players_count INT;
    DECLARE v_access_hours INT;
    DECLARE v_min_rank VARCHAR(2);
    DECLARE v_min_level INT;
    DECLARE v_min_points INT;
    DECLARE v_gate_id INT;
    
    -- Leggi config
    SELECT players_per_selection, access_duration_hours, min_rank, min_level, min_total_points
    INTO v_players_count, v_access_hours, v_min_rank, v_min_level, v_min_points
    FROM hunter_gate_selection_config LIMIT 1;
    
    -- Seleziona un gate casuale abilitato
    SELECT gate_id INTO v_gate_id 
    FROM hunter_gate_config 
    WHERE enabled = 1 
    ORDER BY RAND() 
    LIMIT 1;
    
    IF v_gate_id IS NOT NULL THEN
        -- Inserisci giocatori selezionati casualmente
        INSERT INTO hunter_gate_access (player_id, player_name, gate_id, expires_at)
        SELECT 
            r.player_id,
            r.player_name,
            v_gate_id,
            DATE_ADD(NOW(), INTERVAL v_access_hours HOUR)
        FROM hunter_quest_ranking r
        WHERE r.total_points >= v_min_points
          AND NOT EXISTS (
              -- Non selezionare chi ha già un accesso pending
              SELECT 1 FROM hunter_gate_access ga 
              WHERE ga.player_id = r.player_id 
              AND ga.status = 'pending' 
              AND ga.expires_at > NOW()
          )
          AND NOT EXISTS (
              -- Non selezionare chi ha completato un gate nelle ultime 24 ore
              SELECT 1 FROM hunter_gate_history gh
              WHERE gh.player_id = r.player_id
              AND gh.completed_at > DATE_SUB(NOW(), INTERVAL 24 HOUR)
          )
        ORDER BY RAND()
        LIMIT v_players_count;
        
        -- Aggiorna timestamp ultima selezione
        UPDATE hunter_gate_selection_config SET last_selection_at = NOW();
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_start_rank_trial
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_start_rank_trial`;
delimiter ;;
CREATE PROCEDURE `sp_start_rank_trial`(IN p_player_id INT,
    IN p_current_rank VARCHAR(2),
    OUT p_trial_id INT,
    OUT p_trial_name VARCHAR(128),
    OUT p_success TINYINT,
    OUT p_message VARCHAR(255))
BEGIN
    DECLARE v_player_gloria INT;
    DECLARE v_player_level INT;
    DECLARE v_required_gloria INT;
    DECLARE v_required_level INT;
    DECLARE v_time_limit INT;
    DECLARE v_existing_status VARCHAR(20);

    -- Trova la prova disponibile per il rank attuale
    SELECT trial_id, trial_name, required_gloria, required_level, time_limit_hours
    INTO p_trial_id, p_trial_name, v_required_gloria, v_required_level, v_time_limit
    FROM hunter_rank_trials
    WHERE from_rank = p_current_rank AND enabled = 1
    LIMIT 1;
    
    IF p_trial_id IS NULL THEN
        SET p_success = 0;
        SET p_message = 'Nessuna prova disponibile per il tuo rank.';
    ELSE
        -- Controlla se il giocatore ha GIA' una riga per questa prova
        SELECT status INTO v_existing_status
        FROM hunter_player_trials
        WHERE player_id = p_player_id AND trial_id = p_trial_id;
        
        -- Se la prova è già in corso o completata, non fare nulla e esci
        IF v_existing_status = 'in_progress' OR v_existing_status = 'completed' THEN
            SET p_success = 0;
            SET p_message = 'Prova già in corso o completata.';
        ELSE
            -- Controlla i requisiti solo se la prova non è attiva
            SELECT total_points INTO v_player_gloria FROM hunter_quest_ranking WHERE player_id = p_player_id;
            
            -- Ottieni il livello del giocatore (questo richiede un modo per passarlo o assumerlo)
            -- Per ora, omettiamo il controllo del livello qui e lo lasciamo alla quest LUA
            
            IF v_player_gloria < v_required_gloria THEN
                SET p_success = 0;
                SET p_message = CONCAT('Gloria insufficiente. Richiesti: ', v_required_gloria);
            ELSE
                -- INIZIA LA PROVA: Usa INSERT IGNORE per creare la riga solo se non esiste.
                -- Se esiste (ma è 'failed' o altro), l'UPDATE successivo la resetterà.
                
                INSERT INTO hunter_player_trials (player_id, trial_id, status, started_at, expires_at, boss_kills, metin_kills, fracture_seals, chest_opens, daily_missions)
                VALUES (p_player_id, p_trial_id, 'in_progress', NOW(), 
                        IF(v_time_limit IS NOT NULL, DATE_ADD(NOW(), INTERVAL v_time_limit HOUR), NULL),
                        0, 0, 0, 0, 0)
                ON DUPLICATE KEY UPDATE 
                    status = 'in_progress', 
                    started_at = NOW(),
                    expires_at = IF(v_time_limit IS NOT NULL, DATE_ADD(NOW(), INTERVAL v_time_limit HOUR), NULL),
                    boss_kills = 0, 
                    metin_kills = 0, 
                    fracture_seals = 0, 
                    chest_opens = 0, 
                    daily_missions = 0;

                SET p_success = 1;
                SET p_message = CONCAT('Prova iniziata: ', p_trial_name);
            END IF;
        END IF;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_update_trial_progress
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_trial_progress`;
delimiter ;;
CREATE PROCEDURE `sp_update_trial_progress`(IN p_player_id INT,
    IN p_progress_type VARCHAR(32),
    IN p_vnum INT,
    IN p_amount INT)
BEGIN
    DECLARE v_trial_id INT;
    DECLARE v_boss_list VARCHAR(255);
    DECLARE v_metin_list VARCHAR(255);
    DECLARE v_fracture_list VARCHAR(128);
    DECLARE v_chest_list VARCHAR(255);
    DECLARE v_vnum_str VARCHAR(16);
    
    SET v_vnum_str = CAST(p_vnum AS CHAR);
    
    -- Trova prova in corso
    SELECT pt.trial_id, rt.boss_vnum_list, rt.metin_vnum_list, rt.fracture_color_list, rt.chest_vnum_list
    INTO v_trial_id, v_boss_list, v_metin_list, v_fracture_list, v_chest_list
    FROM hunter_player_trials pt
    JOIN hunter_rank_trials rt ON pt.trial_id = rt.trial_id
    WHERE pt.player_id = p_player_id AND pt.status = 'in_progress'
    AND (pt.expires_at IS NULL OR pt.expires_at > NOW())
    LIMIT 1;
    
    IF v_trial_id IS NOT NULL THEN
        CASE p_progress_type
            WHEN 'boss_kill' THEN
                IF v_boss_list IS NULL OR FIND_IN_SET(v_vnum_str, v_boss_list) > 0 THEN
                    UPDATE hunter_player_trials SET boss_kills = boss_kills + p_amount WHERE player_id = p_player_id AND trial_id = v_trial_id;
                END IF;
            WHEN 'metin_kill' THEN
                IF v_metin_list IS NULL OR FIND_IN_SET(v_vnum_str, v_metin_list) > 0 THEN
                    UPDATE hunter_player_trials SET metin_kills = metin_kills + p_amount WHERE player_id = p_player_id AND trial_id = v_trial_id;
                END IF;
            WHEN 'fracture_seal' THEN
                -- p_vnum qui è il colore come stringa (passato come 0 se non serve)
                UPDATE hunter_player_trials SET fracture_seals = fracture_seals + p_amount WHERE player_id = p_player_id AND trial_id = v_trial_id;
            WHEN 'chest_open' THEN
                IF v_chest_list IS NULL OR FIND_IN_SET(v_vnum_str, v_chest_list) > 0 THEN
                    UPDATE hunter_player_trials SET chest_opens = chest_opens + p_amount WHERE player_id = p_player_id AND trial_id = v_trial_id;
                END IF;
            WHEN 'daily_mission' THEN
                UPDATE hunter_player_trials SET daily_missions = daily_missions + p_amount WHERE player_id = p_player_id AND trial_id = v_trial_id;
        END CASE;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Event structure for evt_check_trial_expiration
-- ----------------------------
DROP EVENT IF EXISTS `evt_check_trial_expiration`;
delimiter ;;
CREATE EVENT `evt_check_trial_expiration`
ON SCHEDULE
EVERY '5' MINUTE STARTS '2026-01-12 16:53:12'
DO BEGIN
    -- Mark expired trials as failed
    UPDATE srv1_hunabku.hunter_player_trials
    SET status = 'failed'
    WHERE status = 'in_progress'
    AND expires_at IS NOT NULL
    AND expires_at < NOW();

    -- Clear expired penalties
    UPDATE srv1_hunabku.hunter_quest_ranking
    SET penalty_active = 0
    WHERE penalty_active = 1
    AND penalty_expires < UNIX_TIMESTAMP();
END
;;
delimiter ;

-- ----------------------------
-- Event structure for evt_daily_cleanup
-- ----------------------------
DROP EVENT IF EXISTS `evt_daily_cleanup`;
delimiter ;;
CREATE EVENT `evt_daily_cleanup`
ON SCHEDULE
EVERY '1' DAY STARTS '2026-01-12 00:05:00'
DO BEGIN
    -- Cleanup old security logs
    DELETE FROM srv1_hunabku.hunter_security_logs
    WHERE created_at < DATE_SUB(NOW(), INTERVAL 30 DAY);

    -- Cleanup old gate access records
    DELETE FROM srv1_hunabku.hunter_gate_access
    WHERE status IN ('expired', 'completed', 'failed')
    AND updated_at < DATE_SUB(NOW(), INTERVAL 7 DAY);

    -- Cleanup old mission records (keep 30 days)
    DELETE FROM srv1_hunabku.hunter_player_missions
    WHERE assigned_date < DATE_SUB(CURDATE(), INTERVAL 30 DAY);

    -- Cleanup old stats snapshots
    DELETE FROM srv1_hunabku.hunter_player_stats_snapshot
    WHERE created_at < DATE_SUB(NOW(), INTERVAL 7 DAY);
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

-- ----------------------------
-- Event structure for evt_expire_trials
-- ----------------------------
DROP EVENT IF EXISTS `evt_expire_trials`;
delimiter ;;
CREATE EVENT `evt_expire_trials`
ON SCHEDULE
EVERY '1' HOUR STARTS '2025-12-29 15:17:44'
DO BEGIN
    UPDATE hunter_player_trials 
    SET status = 'expired' 
    WHERE status = 'in_progress' 
    AND expires_at < NOW();
    
    DELETE FROM hunter_player_missions 
    WHERE assigned_date < CURDATE() - INTERVAL 7 DAY;
END
;;
delimiter ;

-- ----------------------------
-- Event structure for evt_gate_expire_access
-- ----------------------------
DROP EVENT IF EXISTS `evt_gate_expire_access`;
delimiter ;;
CREATE EVENT `evt_gate_expire_access`
ON SCHEDULE
EVERY '1' HOUR STARTS '2025-12-27 02:42:42'
DO UPDATE hunter_gate_access 
    SET status = 'expired'
    WHERE status = 'pending' AND expires_at < NOW()
;;
delimiter ;

-- ----------------------------
-- Event structure for evt_gate_player_selection
-- ----------------------------
DROP EVENT IF EXISTS `evt_gate_player_selection`;
delimiter ;;
CREATE EVENT `evt_gate_player_selection`
ON SCHEDULE
EVERY '4' HOUR STARTS '2025-12-27 02:42:42'
DO CALL sp_select_gate_players()
;;
delimiter ;

-- ----------------------------
-- Event structure for evt_hunter_log_cleanup
-- ----------------------------
DROP EVENT IF EXISTS `evt_hunter_log_cleanup`;
delimiter ;;
CREATE EVENT `evt_hunter_log_cleanup`
ON SCHEDULE
EVERY '1' WEEK STARTS '2026-01-07 04:00:00'
DO CALL sp_hunter_log_cleanup()
;;
delimiter ;

-- ----------------------------
-- Event structure for evt_trial_expire
-- ----------------------------
DROP EVENT IF EXISTS `evt_trial_expire`;
delimiter ;;
CREATE EVENT `evt_trial_expire`
ON SCHEDULE
EVERY '1' HOUR STARTS '2025-12-27 02:42:42'
DO UPDATE hunter_player_trials 
    SET status = 'failed'
    WHERE status = 'in_progress' 
    AND expires_at IS NOT NULL 
    AND expires_at < NOW()
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
