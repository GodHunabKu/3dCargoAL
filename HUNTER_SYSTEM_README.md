# HUNTER SYSTEM - COMPLETE OVERHAUL DOCUMENTATION

## Panoramica

Il **Hunter System Complete Overhaul** rende il sistema Hunter **100% configurabile da database** con **reload real-time** senza necessità di riavvio server o rilogging player.

Ogni aspetto del sistema (colori UI, bonus rank, achievement, penalità, streak milestones, messaggi) è ora gestibile tramite **Navicat** con applicazione immediata tramite il comando `/hunter_reload`.

---

## Indice

1. [Database Schema](#database-schema)
2. [Configurazione UI](#configurazione-ui)
3. [Rank Bonuses](#rank-bonuses)
4. [Penalty System](#penalty-system)
5. [Streak Milestones](#streak-milestones)
6. [Achievement System](#achievement-system)
7. [Gloria Sources Tracking](#gloria-sources-tracking)
8. [Random Tips](#random-tips)
9. [Comandi Admin](#comandi-admin)
10. [Integrazione & Usage](#integrazione--usage)
11. [Troubleshooting](#troubleshooting)

---

## Database Schema

### Tabelle Principali

#### 1. `hunter_ui_config`
Contiene tutti i parametri UI configurabili.

**Struttura:**
```sql
CREATE TABLE hunter_ui_config (
  config_key VARCHAR(50) PRIMARY KEY,
  config_value VARCHAR(255),
  config_type ENUM('int', 'string', 'bool', 'color'),
  description VARCHAR(255)
);
```

**Parametri Disponibili:**

##### Colori Rank
- `rank_X_bg_color`: Colore background per rank X (E,D,C,B,A,S,N)
- `rank_X_border_color`: Colore bordo per rank X
- `rank_X_text_color`: Colore testo per rank X

##### Dimensioni Finestre
- `main_window_width`: Larghezza finestra principale (default: 800)
- `main_window_height`: Altezza finestra principale (default: 600)
- `achievement_popup_width`: Larghezza popup achievement (default: 500)
- `achievement_popup_height`: Altezza popup achievement (default: 200)

##### Timeout Animazioni
- `achievement_popup_duration`: Durata popup achievement in secondi (default: 10)
- `fade_in_duration`: Durata fade-in in millisecondi (default: 300)
- `fade_out_duration`: Durata fade-out in millisecondi (default: 300)
- `glow_animation_speed`: Velocità animazione glow (default: 2)

##### Messaggi Sistema
- `window_title`: Titolo finestra principale
- `tab_stats_title`: Titolo tab Statistiche
- `tab_achievements_title`: Titolo tab Achievement
- `tab_leaderboard_title`: Titolo tab Classifica
- `label_penalty_active`: Label penalità attiva
- `achievement_unlock_title`: Titolo popup achievement
- `reload_success_msg`: Messaggio reload successo

##### Settings Vari
- `enable_sound_notifications`: Abilita notifiche sonore (bool)
- `enable_achievement_popups`: Abilita popup achievement (bool)
- `auto_claim_achievements`: Riscossione automatica (bool)
- `random_tip_interval`: Intervallo random tips in secondi (default: 300)

---

#### 2. `hunter_rank_bonuses`
Configurazione bonus per ogni rank.

**Struttura:**
```sql
CREATE TABLE hunter_rank_bonuses (
  rank_code VARCHAR(1) PRIMARY KEY,
  rank_name VARCHAR(50),
  min_points INT,
  max_points INT,
  bonus_gloria_percent INT,
  bonus_drop_percent INT,
  rank_color_hex VARCHAR(8),
  rank_title VARCHAR(100)
);
```

**Esempio:**
```sql
INSERT INTO hunter_rank_bonuses VALUES
('E', 'Novizio', 0, 999, 0, 0, '0xFFCCCCCC', 'Cacciatore Novizio'),
('D', 'Apprendista', 1000, 4999, 5, 2, '0xFF00FF00', 'Cacciatore Apprendista'),
('C', 'Esperto', 5000, 19999, 10, 5, '0xFF00BFFF', 'Cacciatore Esperto'),
('B', 'Veterano', 20000, 49999, 15, 8, '0xFFFF00FF', 'Cacciatore Veterano'),
('A', 'Elite', 50000, 99999, 20, 12, '0xFFFF8C00', 'Cacciatore Elite'),
('S', 'Maestro', 100000, 249999, 25, 15, '0xFFFF0000', 'Maestro Cacciatore'),
('N', 'Leggenda', 250000, 999999999, 30, 20, '0xFFFFD700', 'Leggenda Vivente');
```

**Modifica Bonus:**
```sql
-- Aumenta bonus Gloria rank S da 25% a 30%
UPDATE hunter_rank_bonuses SET bonus_gloria_percent = 30 WHERE rank_code = 'S';

-- Poi ricarica con /hunter_reload
```

---

#### 3. `hunter_penalty_config`
Configurazione sistema penalità a 3 livelli.

**Struttura:**
```sql
CREATE TABLE hunter_penalty_config (
  penalty_level INT PRIMARY KEY,
  strikes_required INT,
  duration_hours INT,
  gloria_malus_percent INT,
  penalty_message TEXT
);
```

**Livelli Penalità:**
- **Livello 1**: 1 strike → 6 ore, -10% Gloria
- **Livello 2**: 2 strikes → 24 ore, -25% Gloria
- **Livello 3**: 3 strikes → 72 ore, -50% Gloria (warning ban)

**Esempio Modifica:**
```sql
-- Rendi penalità livello 2 più severa
UPDATE hunter_penalty_config SET duration_hours = 48, gloria_malus_percent = 35 WHERE penalty_level = 2;
```

---

#### 4. `hunter_streak_milestones`
Milestone e ricompense per login streak.

**Struttura:**
```sql
CREATE TABLE hunter_streak_milestones (
  streak_days INT PRIMARY KEY,
  bonus_percent INT,
  milestone_message TEXT,
  reward_vnum INT,
  reward_count INT
);
```

**Milestone Default:**
- 3 giorni: +5% Gloria
- 7 giorni: +10% Gloria + 3x Item
- 14 giorni: +15% Gloria + 5x Item
- 30 giorni: +25% Gloria + Item Speciale
- 180 giorni: +40% Gloria
- 365 giorni: +50% Gloria (OLIMPO!)

**Aggiungere Nuova Milestone:**
```sql
INSERT INTO hunter_streak_milestones
(streak_days, bonus_percent, milestone_message, reward_vnum, reward_count)
VALUES
(45, 22, '🔥 Streak 45 giorni! +22% bonus gloria!', 50011, 6);
```

---

#### 5. `hunter_quest_achievements_config` (Estesa)
Configurazione achievement con 8 tipi.

**Nuove Colonne:**
```sql
ALTER TABLE hunter_quest_achievements_config
ADD COLUMN achievement_type INT DEFAULT 1,
ADD COLUMN achievement_category VARCHAR(50) DEFAULT 'General',
ADD COLUMN is_hidden TINYINT(1) DEFAULT 0,
ADD COLUMN icon_path VARCHAR(100) DEFAULT NULL;
```

**Achievement Types:**
1. **Kill Count**: Uccisioni totali
2. **Glory Points**: Punti gloria accumulati
3. **Boss Kills**: Boss uccisi
4. **Metin Destroyed**: Metin distrutti
5. **Chests Opened**: Bauli aperti
6. **Login Streak**: Giorni di streak
7. **Missions Completed**: Missioni completate
8. **Events Participated**: Eventi a cui si è partecipato

**Aggiungere Achievement:**
```sql
INSERT INTO hunter_quest_achievements_config
(achievement_id, achievement_name, achievement_desc, requirement_value,
 reward_vnum, reward_count, achievement_type, achievement_category, icon_path)
VALUES
(801, 'Partecipante Assiduo', 'Partecipa a 10 eventi', 10, 50011, 2, 8, 'Event Champion', 'achievement_event_1.tga');
```

---

#### 6. `hunter_gloria_sources_tracking`
Tracciamento sorgenti punti Gloria per statistiche.

**Struttura:**
```sql
CREATE TABLE hunter_gloria_sources_tracking (
  player_id INT,
  source_type VARCHAR(50), -- FRACTURE, MISSION, EVENT, EMERGENCY, BOSS, STREAK
  total_gloria BIGINT,
  count_events INT,
  PRIMARY KEY (player_id, source_type)
);
```

Questa tabella si popola automaticamente quando il player guadagna Gloria da varie fonti.

---

#### 7. `hunter_quest_tips`
Tips random mostrati al login.

**Struttura:**
```sql
CREATE TABLE hunter_quest_tips (
  tip_id INT AUTO_INCREMENT PRIMARY KEY,
  tip_text TEXT,
  tip_category VARCHAR(50),
  is_active TINYINT(1) DEFAULT 1
);
```

**Aggiungere Tip:**
```sql
INSERT INTO hunter_quest_tips (tip_text, tip_category)
VALUES ('Suggerimento: Gli achievement nascosti si sbloccano con azioni speciali!', 'Achievements');
```

**Disabilitare Tip:**
```sql
UPDATE hunter_quest_tips SET is_active = 0 WHERE tip_id = 5;
```

---

## Configurazione UI

### Come Modificare Colori

**Esempio: Cambiare colore rank S da rosso a viola**
```sql
UPDATE hunter_ui_config SET config_value = '0xFFAA00FF' WHERE config_key = 'rank_S_border_color';
UPDATE hunter_ui_config SET config_value = '0xFF5A005A' WHERE config_key = 'rank_S_bg_color';
```

Poi in-game: `/hunter_reload`

### Come Modificare Dimensioni Finestre

```sql
UPDATE hunter_ui_config SET config_value = '900' WHERE config_key = 'main_window_width';
UPDATE hunter_ui_config SET config_value = '700' WHERE config_key = 'main_window_height';
```

---

## Rank Bonuses

### Visualizzare Bonus Attuali

```sql
SELECT rank_code, rank_name, min_points, bonus_gloria_percent, bonus_drop_percent
FROM hunter_rank_bonuses
ORDER BY min_points;
```

### Modificare Soglie Rank

```sql
-- Abbassa soglia rank N da 250.000 a 200.000 punti
UPDATE hunter_rank_bonuses SET min_points = 200000 WHERE rank_code = 'N';
```

### Aggiungere Nuovo Rank

```sql
INSERT INTO hunter_rank_bonuses VALUES
('X', 'Immortale', 500000, 999999999, 40, 25, '0xFFFF00FF', 'Cacciatore Immortale');
```

---

## Penalty System

### Visualizzare Penalità Attive

```sql
SELECT p.name, r.penalty_active, r.penalty_expires, r.failed_missions, r.penalty_malus
FROM hunter_quest_ranking r
JOIN player p ON r.player_id = p.id
WHERE r.penalty_active = 1;
```

### Rimuovere Penalità Manualmente

```sql
-- Rimuovi penalità a player_id 123
UPDATE hunter_quest_ranking
SET penalty_active = 0, penalty_malus = 0, failed_missions = 0
WHERE player_id = 123;
```

### Reset Strike

```sql
-- Reset strike a tutti i player
UPDATE hunter_quest_ranking SET failed_missions = 0;
```

---

## Streak Milestones

### Visualizzare Milestone

```sql
SELECT * FROM hunter_streak_milestones ORDER BY streak_days;
```

### Modificare Ricompensa

```sql
-- Cambia ricompensa streak 7 giorni
UPDATE hunter_streak_milestones
SET reward_vnum = 50012, reward_count = 5
WHERE streak_days = 7;
```

---

## Achievement System

### Filtrare Achievement per Tipo

```sql
-- Mostra solo achievement Boss
SELECT achievement_id, achievement_name, requirement_value, reward_count
FROM hunter_quest_achievements_config
WHERE achievement_type = 3
ORDER BY requirement_value;
```

### Achievement Nascosti

```sql
-- Nascondi achievement finché non viene sbloccato
UPDATE hunter_quest_achievements_config SET is_hidden = 1 WHERE achievement_id = 706;
```

### Visualizzare Progresso Player

Il progresso viene salvato in quest flags:
- `hq_ach_prog_1`: Kill Count
- `hq_ach_prog_2`: Glory Points
- `hq_ach_prog_3`: Boss Kills
- `hq_ach_prog_4`: Metin Destroyed
- `hq_ach_prog_5`: Chests Opened
- `hq_ach_prog_6`: Login Streak
- `hq_ach_prog_7`: Missions Completed
- `hq_ach_prog_8`: Events Participated

---

## Gloria Sources Tracking

### Visualizzare Statistiche Player

```sql
SELECT source_type, total_gloria, count_events
FROM hunter_gloria_sources_tracking
WHERE player_id = 123;
```

**Output Esempio:**
```
FRACTURE    | 15000 | 50
MISSION     | 8000  | 25
EVENT       | 12000 | 15
EMERGENCY   | 5000  | 10
BOSS        | 20000 | 30
```

Queste stats vengono mostrate come **Pie Chart** nel Tab Statistiche.

---

## Random Tips

### Gestione Tips

```sql
-- Visualizza tutti i tips attivi
SELECT * FROM hunter_quest_tips WHERE is_active = 1;

-- Aggiungi nuovo tip
INSERT INTO hunter_quest_tips (tip_text, tip_category)
VALUES ('Suggerimento: Completa le missioni quotidiane per massimizzare i punti!', 'Missions');

-- Disabilita tip
UPDATE hunter_quest_tips SET is_active = 0 WHERE tip_id = 3;
```

I tips vengono mostrati al **login** dopo 3 secondi dal welcome message.

---

## Comandi Admin

### `/hunter_reload`
Ricarica **TUTTE** le configurazioni dal database senza restart/relog.

**Cosa viene ricaricato:**
- UI Config (60+ parametri)
- Rank Bonuses (7 ranks)
- Penalty Config (3 livelli)
- Streak Milestones (9 milestone)
- Achievement Config (50+ achievements)

**Output:**
```
========================================
[HUNTER] Config ricaricata!
  UI Config: 65 parametri
  Rank Bonuses: 7 ranks
  Penalties: 3 livelli
  Streaks: 9 milestone
  Achievements: 52 totali
  Tempo: 0.12s
========================================
```

### `/hunter_claim <achievement_id>`
Riscuote ricompensa achievement sbloccato.

**Esempio:**
```
/hunter_claim 101
```

---

## Integrazione & Usage

### Login Handler Integration

Nel file quest che gestisce il login, chiama:
```lua
when login begin
    -- ... existing code ...

    hunter_level_bridge.on_hunter_login()  -- Inizializza tutto!
end
```

Questo singolo comando:
1. Ricarica config se necessario
2. Controlla scadenza penalità
3. Invia penalty status al client
4. Invia rival info
5. Invia rank bonus
6. Invia gloria sources stats
7. Invia achievement progress
8. Mostra random tip
9. Controlla streak milestone

### Achievement Tracking Integration

#### Quando Player Uccide Mob
```lua
when XXXX.kill begin  -- XXXX = mob vnum
    local mob_info = hunter_level_bridge.get_mob_info(npc.get_race())

    -- ... calcolo punti, ecc ...

    -- Track achievements automaticamente
    hunter_level_bridge.on_mob_kill_achievements(npc.get_race(), mob_info)
end
```

#### Quando Player Guadagna Gloria
```lua
-- Dopo aver dato punti gloria
hunter_level_bridge.on_gloria_gained_achievements(gloria_amount, "FRACTURE")  -- o "MISSION", "EVENT", ecc.
```

#### Quando Player Completa Missione
```lua
-- Dopo missione completata
hunter_level_bridge.on_mission_complete_achievements()
```

#### Quando Player Partecipa a Evento
```lua
-- Quando partecipa a evento
hunter_level_bridge.on_event_participate_achievements()
```

### Penalty Application

Quando una missione fallisce:
```lua
-- Applica penalità automatica
hunter_level_bridge.apply_mission_failure_penalty()
```

Questo:
1. Incrementa strike count
2. Se strike >= soglia, attiva penalità
3. Applica malus Gloria
4. Invia notifica al player
5. Aggiorna UI

---

## Troubleshooting

### Config Non Si Ricarica

**Problema:** `/hunter_reload` non aggiorna i valori.

**Soluzione:**
1. Verifica che sei GM: `pc.is_gm()` deve essere true
2. Controlla syserr per errori MySQL
3. Verifica che le tabelle esistano: `SHOW TABLES LIKE 'hunter_%'`

### Achievement Non Si Sbloccano

**Problema:** Progresso achievement non aggiorna.

**Soluzione:**
1. Verifica che il tracking sia integrato nel kill handler
2. Controlla quest flags: `pc.getqf("hq_ach_prog_X")`
3. Verifica requirement_value in DB

### Penalità Non Scade

**Problema:** Penalità rimane attiva anche dopo scadenza.

**Soluzione:**
1. Verifica timestamp: `SELECT penalty_expires FROM hunter_quest_ranking WHERE player_id = XXX`
2. Forza check: `hunter_level_bridge.check_penalty_expiration()`
3. Rimuovi manualmente se necessario

### Popup Achievement Non Appare

**Problema:** Achievement unlock notification non si mostra.

**Soluzione:**
1. Verifica che `enable_achievement_popups = true` in hunter_ui_config
2. Controlla che AchievementUnlockWindow sia caricata
3. Verifica syserr Python client

### Gloria Sources Non Trackano

**Problema:** Statistiche sorgenti gloria sono vuote.

**Soluzione:**
1. Verifica che `track_gloria_source()` sia chiamata quando si danno punti
2. Controlla tabella: `SELECT * FROM hunter_gloria_sources_tracking WHERE player_id = XXX`
3. Assicurati che source_type sia valido (FRACTURE, MISSION, EVENT, EMERGENCY, BOSS, STREAK)

---

## Query Utili

### Top 10 Player per Achievement Sbloccati
```sql
SELECT p.name, COUNT(*) as achievements_unlocked
FROM hunter_quest_player_achievements a
JOIN player p ON a.player_id = p.id
GROUP BY p.name
ORDER BY achievements_unlocked DESC
LIMIT 10;
```

### Player con Streak Più Lunghi
```sql
SELECT p.name, r.login_streak
FROM hunter_quest_ranking r
JOIN player p ON r.player_id = p.id
ORDER BY r.login_streak DESC
LIMIT 10;
```

### Distribuzione Gloria per Sorgente (Server-Wide)
```sql
SELECT source_type, SUM(total_gloria) as total, SUM(count_events) as events
FROM hunter_gloria_sources_tracking
GROUP BY source_type
ORDER BY total DESC;
```

---

## Best Practices

1. **Backup Prima di Modifiche**: Fai sempre backup delle tabelle prima di modifiche massive
2. **Test su Test Server**: Testa modifiche config su test server prima di production
3. **Reload Graduale**: Ricarica config durante orari di basso traffico
4. **Monitor Performance**: Controlla query time dopo modifiche config massive
5. **Versionamento**: Traccia modifiche config in changelog

---

## Changelog

### v1.0.0 - Complete Overhaul
- ✅ Sistema cache + reload real-time
- ✅ 60+ parametri UI configurabili
- ✅ Achievement system (8 tipi, 50+ achievements)
- ✅ Streak milestones (9 milestone)
- ✅ Penalty system (3 livelli)
- ✅ Gloria sources tracking
- ✅ Random tips system
- ✅ Rival tracker integration
- ✅ Rank bonus sender
- ✅ Achievement unlock popup con animazioni

---

## Supporto

Per bug, richieste features o domande:
1. Controlla questo README
2. Verifica Troubleshooting section
3. Controlla syserr server + client
4. Contatta developer con:
   - Descrizione problema
   - Step per riprodurre
   - Log rilevanti

---

**Fine Documentazione**
