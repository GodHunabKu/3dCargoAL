-- ============================================================
-- FIX STORED PROCEDURES - Usa hunter_quest_ranking invece di hunter_players
-- PROBLEMA: Le stored procedures originali usano una tabella "hunter_players"
--           che NON ESISTE. I dati reali sono in "hunter_quest_ranking".
-- Data: 2026-01-28
-- ============================================================

-- ----------------------------
-- FIX: sp_hunter_daily_reset
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_hunter_daily_reset`;
delimiter ;;
CREATE PROCEDURE `sp_hunter_daily_reset`()
BEGIN
    -- Reset punti e kills giornalieri nella tabella CORRETTA
    UPDATE hunter_quest_ranking SET
        daily_points = 0,
        daily_kills = 0,
        pending_daily_reward = 0
    WHERE daily_points > 0 OR daily_kills > 0;

    -- Aggiorna anche le missioni scadute
    UPDATE hunter_player_missions SET status = 'failed'
    WHERE status = 'active' AND assigned_at < CURDATE();

    SELECT 'DAILY_RESET_COMPLETE' AS status, ROW_COUNT() AS players_affected;
END
;;
delimiter ;

-- ----------------------------
-- FIX: sp_hunter_weekly_reset
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_hunter_weekly_reset`;
delimiter ;;
CREATE PROCEDURE `sp_hunter_weekly_reset`()
BEGIN
    -- Prima fai il reset giornaliero
    CALL sp_hunter_daily_reset();

    -- Poi reset punti e kills settimanali
    UPDATE hunter_quest_ranking SET
        weekly_points = 0,
        weekly_kills = 0,
        pending_weekly_reward = 0
    WHERE weekly_points > 0 OR weekly_kills > 0;

    SELECT 'WEEKLY_RESET_COMPLETE' AS status, ROW_COUNT() AS players_affected;
END
;;
delimiter ;

-- ----------------------------
-- FIX: sp_hunter_get_ranking (usa tabella corretta)
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_hunter_get_ranking`;
delimiter ;;
CREATE PROCEDURE `sp_hunter_get_ranking`(IN p_type VARCHAR(20), IN p_limit INT)
BEGIN
    IF p_type = 'daily' THEN
        SELECT player_name, daily_points AS glory, daily_kills AS kills, hunter_rank AS current_rank
        FROM hunter_quest_ranking WHERE daily_points > 0 ORDER BY daily_points DESC LIMIT p_limit;
    ELSEIF p_type = 'weekly' THEN
        SELECT player_name, weekly_points AS glory, weekly_kills AS kills, hunter_rank AS current_rank
        FROM hunter_quest_ranking WHERE weekly_points > 0 ORDER BY weekly_points DESC LIMIT p_limit;
    ELSEIF p_type = 'total' THEN
        SELECT player_name, total_points AS glory, total_kills AS kills, hunter_rank AS current_rank
        FROM hunter_quest_ranking WHERE total_points > 0 ORDER BY total_points DESC LIMIT p_limit;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- FIX: sp_hunter_flush_pending (usa tabella corretta)
-- Questa procedura non sembra necessaria dato che usiamo hunter_quest_ranking
-- che non ha campi "pending_glory" separati, ma la ricreiamo per consistenza
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_hunter_flush_pending`;
delimiter ;;
CREATE PROCEDURE `sp_hunter_flush_pending`()
BEGIN
    -- Aggiorna i rank in base ai punti totali
    UPDATE hunter_quest_ranking SET
        hunter_rank = CASE
            WHEN total_points >= 1500000 THEN 'N'
            WHEN total_points >= 500000 THEN 'S'
            WHEN total_points >= 150000 THEN 'A'
            WHEN total_points >= 50000 THEN 'B'
            WHEN total_points >= 10000 THEN 'C'
            WHEN total_points >= 2000 THEN 'D'
            ELSE 'E'
        END,
        current_rank = CASE
            WHEN total_points >= 1500000 THEN 'N'
            WHEN total_points >= 500000 THEN 'S'
            WHEN total_points >= 150000 THEN 'A'
            WHEN total_points >= 50000 THEN 'B'
            WHEN total_points >= 10000 THEN 'C'
            WHEN total_points >= 2000 THEN 'D'
            ELSE 'E'
        END;

    SELECT 'FLUSH_COMPLETE' AS status;
END
;;
delimiter ;

-- ----------------------------
-- FIX: sp_hunter_get_player (usa tabella corretta)
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_hunter_get_player`;
delimiter ;;
CREATE PROCEDURE `sp_hunter_get_player`(IN p_player_id INT)
BEGIN
    SELECT r.*, t.trial_name, t.to_rank, t.boss_kills_req, t.metin_kills_req,
           t.fracture_seals_req, t.chest_opens_req, t.daily_missions_req,
           t.glory_reward AS trial_glory_reward, t.color_code AS trial_color
    FROM hunter_quest_ranking r
    LEFT JOIN hunter_trials t ON r.player_id = t.trial_id
    WHERE r.player_id = p_player_id;
END
;;
delimiter ;

-- ============================================================
-- CONFERMA
-- ============================================================
SELECT 'STORED PROCEDURES CORRETTE!' AS status;
