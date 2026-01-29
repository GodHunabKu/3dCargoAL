-- ============================================================
-- SCRIPT DI RESET PER APERTURA BETA
-- Esegui questo script per resettare tutti i dati di test
-- Data: 2026-01-28
-- ============================================================

-- PARTE 1: RESET DEI DATI PLAYER NELLA TABELLA CORRETTA (hunter_quest_ranking)
-- ============================================================

-- Reset TUTTI i punti e statistiche di TUTTI i player
UPDATE hunter_quest_ranking SET
    -- Reset punti
    total_points = 0,
    spendable_points = 0,
    daily_points = 0,
    weekly_points = 0,

    -- Reset kills
    total_kills = 0,
    daily_kills = 0,
    weekly_kills = 0,

    -- Reset login streak
    login_streak = 0,
    last_login = 0,

    -- Reset penalita
    penalty_strikes = 0,
    penalty_active = 0,
    penalty_expires = 0,
    failed_missions = 0,

    -- Reset rival
    rival_pid = 0,
    overtaken_by = NULL,
    overtaken_diff = 0,
    overtaken_label = NULL,

    -- Reset rewards
    pending_daily_reward = 0,
    pending_weekly_reward = 0,
    pending_karma = 0,

    -- Reset statistiche
    total_fractures = 0,
    total_chests = 0,
    total_metins = 0,

    -- Reset bauli per rank
    chests_e = 0,
    chests_d = 0,
    chests_c = 0,
    chests_b = 0,
    chests_a = 0,
    chests_s = 0,
    chests_n = 0,

    -- Reset boss kills
    boss_kills_easy = 0,
    boss_kills_medium = 0,
    boss_kills_hard = 0,
    boss_kills_elite = 0,

    -- Reset metin kills
    metin_kills_normal = 0,
    metin_kills_special = 0,

    -- Reset difese fratture
    defense_wins = 0,
    defense_losses = 0,
    elite_kills = 0,

    -- Reset rank
    hunter_rank = 'E',
    current_rank = 'E',

    -- Reset timestamp
    last_activity = NOW();

-- PARTE 2: PULIZIA TABELLE CORRELATE
-- ============================================================

-- Pulisci storico eventi
TRUNCATE TABLE hunter_event_participants;
TRUNCATE TABLE hunter_event_winners;

-- Pulisci achievements
TRUNCATE TABLE hunter_achievements_claimed;

-- Pulisci storico gate/trial
DELETE FROM hunter_gate_access WHERE 1=1;
DELETE FROM hunter_gate_history WHERE 1=1;

-- Pulisci missioni player
DELETE FROM hunter_player_missions WHERE 1=1;

-- Pulisci trial player (se esiste)
-- DELETE FROM hunter_player_trials WHERE 1=1;

-- NOTA: Le seguenti tabelle potrebbero non esistere in tutte le installazioni
-- Esegui manualmente se necessario:
-- DELETE FROM hunter_pending_rewards WHERE 1=1;
-- DELETE FROM hunter_player_stats_snapshot WHERE 1=1;
-- UPDATE hunter_system_status SET value = 0 WHERE status_key IN ('daily_reset', 'weekly_reset');

-- PARTE 3: CONFERMA
-- ============================================================
SELECT 'RESET COMPLETATO!' AS status;
SELECT COUNT(*) AS players_resettati FROM hunter_quest_ranking;
