-- ============================================================================
-- STORED PROCEDURE: Assegnazione Missioni Giornaliere
-- Database: srv1_hunabku
-- ============================================================================

USE srv1_hunabku;

DROP PROCEDURE IF EXISTS sp_assign_daily_missions;

DELIMITER $$

CREATE PROCEDURE sp_assign_daily_missions(
    IN p_player_id INT,
    IN p_rank VARCHAR(2),
    IN p_player_name VARCHAR(24)
)
BEGIN
    DECLARE v_today DATE;
    DECLARE v_mission_count INT;
    DECLARE v_slot INT DEFAULT 1;
    DECLARE done INT DEFAULT 0;

    -- Variabili per il cursore (DEVONO essere dichiarate prima del cursore!)
    DECLARE v_mission_id INT;
    DECLARE v_mission_name VARCHAR(100);
    DECLARE v_mission_type VARCHAR(20);
    DECLARE v_target_vnum INT;
    DECLARE v_target_count INT;
    DECLARE v_reward INT;
    DECLARE v_penalty INT;
    DECLARE v_time_limit INT;

    -- Cursore per selezionare 3 missioni random appropriate per il rank
    DECLARE mission_cursor CURSOR FOR
        SELECT mission_id, mission_name, mission_type, target_vnum, target_count,
               gloria_reward, gloria_penalty, time_limit_minutes
        FROM hunter_mission_definitions
        WHERE enabled = 1
          AND min_rank <= p_rank
        ORDER BY RAND()
        LIMIT 3;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Ottieni la data di oggi
    SET v_today = CURDATE();

    -- Controlla se ci sono già missioni per oggi
    SELECT COUNT(*) INTO v_mission_count
    FROM hunter_player_missions
    WHERE player_id = p_player_id
      AND assigned_date = v_today;

    -- Se ha già 3 missioni, esci
    IF v_mission_count >= 3 THEN
        SELECT 'Already assigned' AS result;
    ELSE
        -- Cancella eventuali missioni vecchie o incomplete di oggi
        DELETE FROM hunter_player_missions
        WHERE player_id = p_player_id
          AND assigned_date = v_today;

        -- Apri il cursore e assegna 3 missioni
        OPEN mission_cursor;

        read_loop: LOOP
            FETCH mission_cursor INTO v_mission_id, v_mission_name, v_mission_type,
                                     v_target_vnum, v_target_count, v_reward, v_penalty, v_time_limit;

            IF done THEN
                LEAVE read_loop;
            END IF;

            -- Inserisci la missione
            INSERT INTO hunter_player_missions (
                player_id, mission_slot, mission_def_id, assigned_date,
                current_progress, target_count, status, reward_glory, penalty_glory
            ) VALUES (
                p_player_id, v_slot, v_mission_id, v_today,
                0, v_target_count, 'active', v_reward, v_penalty
            );

            SET v_slot = v_slot + 1;

            IF v_slot > 3 THEN
                LEAVE read_loop;
            END IF;
        END LOOP;

        CLOSE mission_cursor;

        SELECT 'Missions assigned' AS result, v_slot - 1 AS count;
    END IF;
END$$

DELIMITER ;

-- Test della stored procedure (commentato - rimuovi i -- per testare)
-- CALL sp_assign_daily_missions(4, 'E', 'TestPlayer');
-- SELECT * FROM hunter_player_missions WHERE player_id = 4;

SELECT 'Stored procedure creata con successo!' AS Status;
