-- ============================================================================
-- HUNTER SYSTEM - ALL FIXES AND IMPROVEMENTS
-- Database: srv1_hunabku
-- Apply this file AFTER importing the complete database
-- ============================================================================

USE srv1_hunabku;

-- ============================================================================
-- FIX 1: EMERGENCY QUESTS - Rebalance impossible values
-- ============================================================================

-- Quest 1: "Sopravvivi all'Orda"
-- BEFORE: 200 kills in 45 sec (4.4 kill/sec) - IMPOSSIBLE
-- AFTER: 60 kills in 60 sec (1 kill/sec) - Hard but doable
UPDATE hunter_quest_emergencies SET
    target_count = 60,
    duration_seconds = 60,
    reward_points = 300,
    description = 'Uccidi 60 mostri in 60 secondi. Fai del tuo meglio!',
    difficulty = 'HARD'
WHERE id = 1;

-- Quest 2: "Distruttore di Metin"
-- BEFORE: 10 Metin in 180 sec (18 sec per metin) - Too fast
-- AFTER: 5 Metin in 180 sec (36 sec per metin) - Doable with teleport
UPDATE hunter_quest_emergencies SET
    target_count = 5,
    reward_points = 500,
    description = 'Distruggi 5 Metin in 3 minuti. Preparati a correre!',
    difficulty = 'HARD'
WHERE id = 2;

-- Quest 3: "Difesa Disperata"
-- BEFORE: 400 kills in 60 sec (6.6 kill/sec) - IMPOSSIBLE
-- AFTER: 120 kills in 90 sec (1.33 kill/sec) - Hard but possible
UPDATE hunter_quest_emergencies SET
    target_count = 120,
    duration_seconds = 90,
    reward_points = 600,
    description = 'Elimina 120 nemici in 90 secondi. (1.3 kill al secondo)',
    difficulty = 'EXTREME'
WHERE id = 3;

-- Quest 4: "Cacciatore di Boss"
-- BEFORE: 3 Boss in 90 sec (30 sec per boss) - Need warp/smantellare
-- AFTER: 3 Boss in 180 sec (60 sec per boss) - More time to change CH
UPDATE hunter_quest_emergencies SET
    duration_seconds = 180,
    reward_points = 1000,
    description = 'Uccidi 3 Boss in 180 secondi. (Puoi cambiare CH)',
    difficulty = 'EXTREME'
WHERE id = 4;

-- Quest 5: "Il Massacro"
-- BEFORE: 600 kills in 120 sec (5 kill/sec) - Too high
-- AFTER: 250 kills in 180 sec (1.4 kill/sec) - Only Covo 3/Atlantis with AOE
UPDATE hunter_quest_emergencies SET
    target_count = 250,
    duration_seconds = 180,
    reward_points = 1200,
    description = 'Uccidi 250 creature in 180 secondi. Serve AOE potente!',
    difficulty = 'GOD_MODE'
WHERE id = 5;

-- Add easier quests for low ranks
INSERT INTO hunter_quest_emergencies
(name, description, duration_seconds, target_vnum, target_count, reward_points, reward_item_vnum, reward_item_count, enabled, min_level, max_level, difficulty)
VALUES
('Prova del Novizio', 'Uccidi 30 mostri in 60 secondi. Missione introduttiva!', 60, 0, 30, 150, 0, 0, 1, 1, 50, 'EASY'),
('Caccia Rapida', 'Uccidi 2 Boss in 120 secondi.', 120, 0, 2, 400, 0, 0, 1, 20, 80, 'NORMAL'),
('Metin Sprint', 'Distruggi 3 Metin in 150 secondi.', 150, 0, 3, 350, 0, 0, 1, 15, 90, 'NORMAL');

-- ============================================================================
-- FIX 2: SCHEDULED EVENTS - Remove test event and normalize colors
-- ============================================================================

-- Remove test event "asdasd"
DELETE FROM hunter_scheduled_events WHERE event_name = 'asdasd';

-- Normalize color_scheme to UPPERCASE
UPDATE hunter_scheduled_events
SET color_scheme = UPPER(color_scheme)
WHERE color_scheme REGEXP '[a-z]';

-- Fix invalid color_scheme values
UPDATE hunter_scheduled_events
SET color_scheme = 'PURPLE'
WHERE color_scheme NOT IN ('GREEN', 'BLUE', 'ORANGE', 'RED', 'GOLD', 'PURPLE', 'BLACKWHITE', 'CYAN');

-- Remove events with invalid configurations
DELETE FROM hunter_scheduled_events
WHERE duration_minutes <= 0
   OR start_hour < 0
   OR start_hour > 23
   OR start_minute < 0
   OR start_minute > 59;

-- ============================================================================
-- VERIFICATION QUERIES
-- ============================================================================

-- Verify emergency quests are balanced
SELECT
    id,
    name,
    target_count,
    duration_seconds,
    ROUND(target_count / duration_seconds, 2) as 'Kill Per Secondo',
    reward_points,
    difficulty
FROM hunter_quest_emergencies
WHERE enabled = 1
ORDER BY id;

-- Verify scheduled events are clean
SELECT COUNT(*) as 'Total Active Events'
FROM hunter_scheduled_events
WHERE enabled = 1;

-- Check for duplicate events (same time, same day)
SELECT
    start_hour,
    start_minute,
    days_active,
    COUNT(*) as 'Eventi Sovrapposti'
FROM hunter_scheduled_events
WHERE enabled = 1
GROUP BY start_hour, start_minute, days_active
HAVING COUNT(*) > 1;

-- Optimize tables after changes
OPTIMIZE TABLE hunter_quest_emergencies;
OPTIMIZE TABLE hunter_scheduled_events;

SELECT 'All fixes applied successfully!' as 'Status';
