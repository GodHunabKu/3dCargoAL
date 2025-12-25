-- ============================================================================
-- HUNTER SYSTEM - CONFIGURAZIONE COMPLETA NEL DATABASE
-- ============================================================================
-- Questo file aggiunge TUTTI i valori configurabili nel database
-- così puoi modificare il sistema senza toccare il codice Lua
-- ============================================================================

USE srv1_hunabku;

-- Elimina i config di esempio esistenti se ci sono
DELETE FROM hunter_quest_config WHERE config_key LIKE 'rank_%';
DELETE FROM hunter_quest_config WHERE config_key LIKE 'streak_%';
DELETE FROM hunter_quest_config WHERE config_key LIKE 'rival_%';
DELETE FROM hunter_quest_config WHERE config_key LIKE 'bonus_%';

-- ============================================================================
-- 1. SOGLIE RANK (Punti Gloria richiesti per ogni rank)
-- ============================================================================
INSERT INTO hunter_quest_config (config_key, config_value, description) VALUES
('rank_threshold_N', '1500000', 'Punti Gloria richiesti per National rank'),
('rank_threshold_S', '500000',  'Punti Gloria richiesti per S-rank'),
('rank_threshold_A', '150000',  'Punti Gloria richiesti per A-rank'),
('rank_threshold_B', '50000',   'Punti Gloria richiesti per B-rank'),
('rank_threshold_C', '10000',   'Punti Gloria richiesti per C-rank'),
('rank_threshold_D', '2000',    'Punti Gloria richiesti per D-rank'),
('rank_threshold_E', '0',       'Punti Gloria richiesti per E-rank (minimo)');

-- ============================================================================
-- 2. STREAK BONUS (Login consecutivi)
-- ============================================================================
-- NOTA: I bonus percentuali esistono già nel DB come:
-- - streak_bonus_3days (già presente = 5)
-- - streak_bonus_7days (già presente = 10)
-- - streak_bonus_30days (già presente = 20)
-- Aggiungo solo i giorni configurabili per i tier:
INSERT INTO hunter_quest_config (config_key, config_value, description) VALUES
('streak_days_tier1', '3',  'Giorni consecutivi per bonus tier 1'),
('streak_days_tier2', '7',  'Giorni consecutivi per bonus tier 2'),
('streak_days_tier3', '30', 'Giorni consecutivi per bonus tier 3');

-- ============================================================================
-- 3. RIVAL TRACKER (Range punti per trovare rivali)
-- ============================================================================
INSERT INTO hunter_quest_config (config_key, config_value, description) VALUES
('rival_range_daily',     '500',   'Range punti per Rival Tracker classifica giornaliera'),
('rival_range_weekly',    '2000',  'Range punti per Rival Tracker classifica settimanale'),
('rival_range_total',     '50000', 'Range punti per Rival Tracker classifica Gloria totale'),
('rival_range_metins',    '50',    'Range punti per Rival Tracker classifica Metin'),
('rival_range_chests',    '50',    'Range punti per Rival Tracker classifica Bauli'),
('rival_range_fractures', '20',    'Range punti per Rival Tracker classifica Fratture');

-- ============================================================================
-- 4. BONUS MULTIPLICATORI
-- ============================================================================
INSERT INTO hunter_quest_config (config_key, config_value, description) VALUES
('bonus_all_missions_complete', '50', 'Percentuale bonus Gloria se completi tutte 3 le missioni giornaliere'),
('bonus_speed_kill_multiplier', '2',  'Moltiplicatore reward per Speed Kill (Boss 60s, Metin 300s)');

-- ============================================================================
-- 5. SPEED KILL TIMERS (secondi) - Già esistono nel DB, solo commento
-- ============================================================================
-- NOTA: Questi config esistono già nel DB come:
-- - speedkill_boss_seconds (già presente = 60)
-- - speedkill_metin_seconds (già presente = 300)
-- Non serve inserirli di nuovo!

-- ============================================================================
-- 6. EMERGENCY QUEST CONFIG - Già esistono nel DB
-- ============================================================================
-- NOTA: Questi config esistono già nel DB come:
-- - emergency_chance_percent (già presente = 40)
-- - spawn_threshold_normal (già presente = 1000)
-- Non serve inserirli di nuovo!

-- ============================================================================
-- 7. CONVERSIONE GLORIA → CREDITI
-- ============================================================================
INSERT INTO hunter_quest_config (config_key, config_value, description) VALUES
('conversion_gloria_to_credits', '10', 'Quanti Crediti ottieni per ogni 100 Gloria convertiti');

-- ============================================================================
-- 8. RESET E TIMINGS - Già esistono nel DB
-- ============================================================================
-- NOTA: Questi config esistono già nel DB come:
-- - welcome_offline_seconds (già presente = 120)
-- - daily_reset_hour (già presente = 0)
-- Non serve inserirli di nuovo!
-- daily_reset_minute non esiste, ma il reset è fisso alle 00:05

-- ============================================================================
-- VERIFICA CONFIG INSERITI
-- ============================================================================
SELECT
    config_key,
    config_value,
    description
FROM hunter_quest_config
WHERE config_key LIKE 'rank_%'
   OR config_key LIKE 'streak_%'
   OR config_key LIKE 'rival_%'
   OR config_key LIKE 'bonus_%'
   OR config_key LIKE 'speed_%'
   OR config_key LIKE 'emergency_%'
   OR config_key LIKE 'conversion_%'
   OR config_key LIKE '%_reset_%'
   OR config_key LIKE 'welcome_%'
ORDER BY config_key;
