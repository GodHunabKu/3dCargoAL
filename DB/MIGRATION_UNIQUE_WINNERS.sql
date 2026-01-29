-- ============================================================
-- MIGRAZIONE: Aggiunge protezione UNIQUE per eventi
-- Previene doppi vincitori e doppie iscrizioni
-- Data: 2026-01-29
-- ============================================================

-- =============================================
-- PARTE 1: VINCITORI EVENTI (hunter_event_winners)
-- =============================================

-- Step 1: Rimuovi eventuali duplicati esistenti prima di aggiungere la colonna
-- (Mantieni solo il primo vincitore per ogni evento/tipo/giorno)
CREATE TEMPORARY TABLE temp_winners_to_keep AS
SELECT MIN(id) as keep_id
FROM hunter_event_winners
WHERE winner_type IN ('first_rift', 'first_boss')
GROUP BY event_id, winner_type, DATE(won_at);

DELETE FROM hunter_event_winners
WHERE winner_type IN ('first_rift', 'first_boss')
AND id NOT IN (SELECT keep_id FROM temp_winners_to_keep);

DROP TEMPORARY TABLE temp_winners_to_keep;

-- Step 2: Aggiungi colonna generata per chiave univoca vincitori
-- Per first_rift/first_boss: garantisce UN solo vincitore per evento/giorno
-- Per lottery: usa ID quindi permette vincitori multipli
ALTER TABLE hunter_event_winners
ADD COLUMN `unique_winner_key` varchar(50) GENERATED ALWAYS AS (
    CASE
      WHEN winner_type IN ('first_rift', 'first_boss') THEN CONCAT(event_id, '_', winner_type, '_', DATE(won_at))
      ELSE CONCAT('lottery_', id)
    END
) STORED;

-- Step 3: Aggiungi indice UNIQUE sulla nuova colonna
ALTER TABLE hunter_event_winners
ADD UNIQUE INDEX `idx_unique_winner`(`unique_winner_key`);

-- =============================================
-- PARTE 2: PARTECIPANTI EVENTI (hunter_event_participants)
-- =============================================

-- Step 1: Rimuovi eventuali doppie iscrizioni (mantieni la prima)
CREATE TEMPORARY TABLE temp_participants_to_keep AS
SELECT MIN(id) as keep_id
FROM hunter_event_participants
GROUP BY event_id, player_id, DATE(joined_at);

DELETE FROM hunter_event_participants
WHERE id NOT IN (SELECT keep_id FROM temp_participants_to_keep);

DROP TEMPORARY TABLE temp_participants_to_keep;

-- Step 2: Aggiungi colonna generata per chiave univoca partecipanti
ALTER TABLE hunter_event_participants
ADD COLUMN `unique_participation_key` varchar(50) GENERATED ALWAYS AS (
    CONCAT(event_id, '_', player_id, '_', DATE(joined_at))
) STORED;

-- Step 3: Aggiungi indice UNIQUE
ALTER TABLE hunter_event_participants
ADD UNIQUE INDEX `idx_unique_participation`(`unique_participation_key`);

-- =============================================
-- CONFERMA
-- =============================================
SELECT 'MIGRAZIONE COMPLETATA!' AS status;
SELECT COUNT(*) AS total_winners FROM hunter_event_winners;
SELECT COUNT(*) AS total_participants FROM hunter_event_participants;
