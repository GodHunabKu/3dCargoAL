-- ============================================================================
-- FIX: Pulizia Eventi Schedulati
-- Database: srv1_hunabku
-- Tabella: hunter_scheduled_events
-- ============================================================================

USE srv1_hunabku;

-- 1. RIMUOVI evento di test
DELETE FROM hunter_scheduled_events WHERE event_name = 'asdasd';

-- 2. CORREGGI color_scheme inconsistenti (tutto UPPERCASE)
UPDATE hunter_scheduled_events
SET color_scheme = UPPER(color_scheme)
WHERE color_scheme REGEXP '[a-z]';

-- 3. VERIFICA che tutti i color_scheme siano validi
UPDATE hunter_scheduled_events
SET color_scheme = 'PURPLE'
WHERE color_scheme NOT IN ('GREEN', 'BLUE', 'ORANGE', 'RED', 'GOLD', 'PURPLE', 'BLACKWHITE', 'CYAN');

-- 4. VERIFICA spawn_chance delle fratture = 100
SELECT
    SUM(spawn_chance) as 'Totale Spawn Chance',
    CASE
        WHEN SUM(spawn_chance) = 100 THEN 'OK ✓'
        ELSE 'ERRORE - Deve essere 100!'
    END as 'Status'
FROM hunter_quest_fractures
WHERE enabled = 1;

-- 5. VERIFICA eventi duplicati (stesso orario stesso giorno)
SELECT
    start_hour,
    start_minute,
    days_active,
    COUNT(*) as 'Eventi Sovrapposti'
FROM hunter_scheduled_events
WHERE enabled = 1
GROUP BY start_hour, start_minute, days_active
HAVING COUNT(*) > 1;

-- 6. LISTA eventi per verificare copertura oraria
SELECT
    start_hour,
    COUNT(*) as 'Numero Eventi',
    GROUP_CONCAT(event_name SEPARATOR ', ') as 'Eventi'
FROM hunter_scheduled_events
WHERE enabled = 1
GROUP BY start_hour
ORDER BY start_hour;

-- 7. OPZIONALE: Disabilita eventi con reward troppo alti (se necessario)
-- UPDATE hunter_scheduled_events
-- SET enabled = 0
-- WHERE reward_glory_winner > 3000;

-- ============================================================================
-- OUTPUT: Verifica eventi per giorno della settimana
-- ============================================================================
SELECT
    CASE
        WHEN FIND_IN_SET('1', days_active) THEN 'Lunedì'
        WHEN FIND_IN_SET('2', days_active) THEN 'Martedì'
        WHEN FIND_IN_SET('3', days_active) THEN 'Mercoledì'
        WHEN FIND_IN_SET('4', days_active) THEN 'Giovedì'
        WHEN FIND_IN_SET('5', days_active) THEN 'Venerdì'
        WHEN FIND_IN_SET('6', days_active) THEN 'Sabato'
        WHEN FIND_IN_SET('7', days_active) THEN 'Domenica'
        ELSE 'Tutti i giorni'
    END as 'Giorno',
    COUNT(*) as 'Eventi Attivi'
FROM hunter_scheduled_events
WHERE enabled = 1
GROUP BY days_active;

-- ============================================================================
-- CLEANUP FINALE
-- ============================================================================
-- Rimuovi eventi con configurazioni impossibili
DELETE FROM hunter_scheduled_events
WHERE duration_minutes <= 0
   OR start_hour < 0
   OR start_hour > 23
   OR start_minute < 0
   OR start_minute > 59;

-- Ottimizza tabella dopo cleanup
OPTIMIZE TABLE hunter_scheduled_events;

SELECT 'Cleanup completato!' as 'Status';
