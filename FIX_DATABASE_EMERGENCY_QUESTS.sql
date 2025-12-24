-- ============================================================================
-- FIX: Emergency Quests - Valori Impossibili da Completare
-- Database: srv1_hunabku
-- Tabella: hunter_quest_emergencies
-- ============================================================================

-- PROBLEMA: I valori attuali richiedono 4-7 kill al secondo continuativamente
-- Anche con le migliori build è IMPOSSIBILE completarli

-- FIX: Riequilibra i valori per renderli difficili ma POSSIBILI

USE srv1_hunabku;

-- Quest 1: "Sopravvivi all'Orda"
-- PRIMA: 200 kill in 45 sec (4.4 kill/sec) - IMPOSSIBILE
-- DOPO: 60 kill in 60 sec (1 kill/sec) - Difficile ma fattibile
UPDATE hunter_quest_emergencies SET
    target_count = 60,
    duration_seconds = 60,
    reward_points = 300,  -- Ridotto proporzionalmente
    description = 'Uccidi 60 mostri in 60 secondi. Fai del tuo meglio!'
WHERE id = 1;

-- Quest 2: "Distruttore di Metin"
-- PRIMA: 10 Metin in 180 sec (18 sec per metin) - Troppo veloce
-- DOPO: 5 Metin in 180 sec (36 sec per metin) - Fattibile con tp
UPDATE hunter_quest_emergencies SET
    target_count = 5,
    reward_points = 500,  -- Ridotto da 800
    description = 'Distruggi 5 Metin in 3 minuti. Preparati a correre!'
WHERE id = 2;

-- Quest 3: "Difesa Disperata"
-- PRIMA: 400 kill in 60 sec (6.6 kill/sec) - IMPOSSIBILE
-- DOPO: 120 kill in 90 sec (1.33 kill/sec) - Difficile ma possibile
UPDATE hunter_quest_emergencies SET
    target_count = 120,
    duration_seconds = 90,
    reward_points = 600,  -- Ridotto da 1000
    description = 'Elimina 120 nemici in 90 secondi. (1.3 kill al secondo)'
WHERE id = 3;

-- Quest 4: "Cacciatore di Boss"
-- PRIMA: 3 Boss in 90 sec (30 sec per boss) - Serve warp/smantellare
-- DOPO: 3 Boss in 180 sec (60 sec per boss) - Più tempo per cambiare CH
UPDATE hunter_quest_emergencies SET
    duration_seconds = 180,
    reward_points = 1000,  -- Ridotto da 1500
    description = 'Uccidi 3 Boss in 180 secondi. (Puoi cambiare CH)'
WHERE id = 4;

-- Quest 5: "Il Massacro"
-- PRIMA: 600 kill in 120 sec (5 kill/sec) - Troppo alto
-- DOPO: 250 kill in 180 sec (1.4 kill/sec) - Solo Covo 3/Atlantide con AOE
UPDATE hunter_quest_emergencies SET
    target_count = 250,
    duration_seconds = 180,
    reward_points = 1200,  -- Ridotto da 2000
    description = 'Uccidi 250 creature in 180 secondi. Serve AOE potente!'
WHERE id = 5;

-- ============================================================================
-- VERIFICA: Controlla i nuovi valori
-- ============================================================================
SELECT
    id,
    name,
    target_count,
    duration_seconds,
    ROUND(target_count / (duration_seconds / 60.0), 2) as 'Kill Per Minuto',
    ROUND(target_count / duration_seconds, 2) as 'Kill Per Secondo',
    reward_points,
    difficulty
FROM hunter_quest_emergencies
WHERE enabled = 1
ORDER BY id;

-- ============================================================================
-- OUTPUT ATTESO:
-- +----+-------------------------+--------------+-------------------+
-- | id | name                    | target_count | duration_seconds  |
-- +----+-------------------------+--------------+-------------------+
-- |  1 | Sopravvivi all'Orda    |           60 |               60  |  <- 1 kill/sec
-- |  2 | Distruttore di Metin   |            5 |              180  |  <- 36 sec/metin
-- |  3 | Difesa Disperata       |          120 |               90  |  <- 1.33 kill/sec
-- |  4 | Cacciatore di Boss     |            3 |              180  |  <- 60 sec/boss
-- |  5 | Il Massacro            |          250 |              180  |  <- 1.4 kill/sec
-- +----+-------------------------+--------------+-------------------+
-- ============================================================================

-- OPZIONALE: Se vuoi aggiungere quest più facili per rank bassi
INSERT INTO hunter_quest_emergencies
(name, description, duration_seconds, target_vnum, target_count, reward_points, reward_item_vnum, reward_item_count, enabled, min_level, max_level, difficulty)
VALUES
('Prova del Novizio', 'Uccidi 30 mostri in 60 secondi. Missione introduttiva!', 60, 0, 30, 150, 0, 0, 1, 1, 50, 'EASY'),
('Caccia Rapida', 'Uccidi 2 Boss in 120 secondi.', 120, 0, 2, 400, 0, 0, 1, 20, 80, 'NORMAL'),
('Metin Sprint', 'Distruggi 3 Metin in 150 secondi.', 150, 0, 3, 350, 0, 0, 1, 15, 90, 'NORMAL');

-- ============================================================================
-- NOTE FINALI:
-- Questi valori sono calibrati per:
-- - Build AOE media (Ninja, Sura, Mago)
-- - Spawn normali (no eventi x2)
-- - Livello 70+ con equipaggiamento decente
--
-- Se il server ha:
-- - Spawn rate aumentato → Puoi aumentare i target_count
-- - Damage molto alto → Puoi ridurre duration_seconds
-- - Giocatori casual → Lascia questi valori (equilibrati)
-- ============================================================================
