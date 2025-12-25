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
INSERT INTO hunter_quest_config (config_key, config_value) VALUES
('rank_threshold_N', '1500000'),  -- National rank
('rank_threshold_S', '500000'),   -- S-rank
('rank_threshold_A', '150000'),   -- A-rank
('rank_threshold_B', '50000'),    -- B-rank
('rank_threshold_C', '10000'),    -- C-rank
('rank_threshold_D', '2000'),     -- D-rank
('rank_threshold_E', '0');        -- E-rank (minimo)

-- ============================================================================
-- 2. STREAK BONUS (Login consecutivi) - Giorni configurabili
-- ============================================================================
-- NOTA: I bonus percentuali esistono già nel DB come:
-- - streak_bonus_3days (già presente = 5)
-- - streak_bonus_7days (già presente = 10)
-- - streak_bonus_30days (già presente = 20)
-- Aggiungo solo i giorni configurabili per i tier:
INSERT INTO hunter_quest_config (config_key, config_value) VALUES
('streak_days_tier1', '3'),   -- Giorni per tier 1
('streak_days_tier2', '7'),   -- Giorni per tier 2
('streak_days_tier3', '30');  -- Giorni per tier 3

-- ============================================================================
-- 3. RIVAL TRACKER (Range punti per trovare rivali)
-- ============================================================================
INSERT INTO hunter_quest_config (config_key, config_value) VALUES
('rival_range_daily', '500'),        -- Classifica giornaliera
('rival_range_weekly', '2000'),      -- Classifica settimanale
('rival_range_total', '50000'),      -- Classifica Gloria totale
('rival_range_metins', '50'),        -- Classifica Metin
('rival_range_chests', '50'),        -- Classifica Bauli
('rival_range_fractures', '20');     -- Classifica Fratture

-- ============================================================================
-- 4. BONUS MULTIPLICATORI
-- ============================================================================
INSERT INTO hunter_quest_config (config_key, config_value) VALUES
('bonus_all_missions_complete', '50'),  -- Bonus % se completi tutte 3 missioni
('bonus_speed_kill_multiplier', '2');   -- Moltiplicatore speed kill

-- ============================================================================
-- 5. CONVERSIONE GLORIA → CREDITI
-- ============================================================================
INSERT INTO hunter_quest_config (config_key, config_value) VALUES
('conversion_gloria_to_credits', '10');  -- Crediti per ogni 100 Gloria

-- ============================================================================
-- NOTA: Config già esistenti nel DB (non serve inserirli)
-- ============================================================================
-- speedkill_boss_seconds = 60
-- speedkill_metin_seconds = 300
-- emergency_chance_percent = 40
-- spawn_threshold_normal = 1000
-- welcome_offline_seconds = 120
-- daily_reset_hour = 0
-- streak_bonus_3days = 5
-- streak_bonus_7days = 10
-- streak_bonus_30days = 20

-- ============================================================================
-- VERIFICA CONFIG INSERITI
-- ============================================================================
SELECT
    config_key,
    config_value
FROM hunter_quest_config
WHERE config_key LIKE 'rank_%'
   OR config_key LIKE 'streak_%'
   OR config_key LIKE 'rival_%'
   OR config_key LIKE 'bonus_%'
   OR config_key LIKE 'conversion_%'
ORDER BY config_key;
