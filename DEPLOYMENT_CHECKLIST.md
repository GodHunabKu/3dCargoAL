# HUNTER SYSTEM v3.0 - DEPLOYMENT CHECKLIST

## Stato: 100% CONFIGURABILE DA DB

---

## STEP 1: PRE-DEPLOYMENT

### Verifica File Presenti
- [ ] `/home/user/3dCargoAL/HUNTER_SYSTEM_COMPLETE_OVERHAUL.sql` (Schema DB)
- [ ] `/home/user/3dCargoAL/hunter_level_bridge.lua` (Backend Lua)
- [ ] `/home/user/3dCargoAL/game.py` (Backend Python)
- [ ] `/home/user/3dCargoAL/uihunterlevel.py` (Frontend UI)
- [ ] `/home/user/3dCargoAL/hunter_test_quest.lua` (Test Quest)

### Verifica Branch Git
```bash
git branch
# Dovrebbe mostrare: claude/metin2-player-experience-FmXeU
```

### Verifica Commit
```bash
git log --oneline -6
# Dovrebbe mostrare i 6 commit FIX 4-6
```

---

## STEP 2: DATABASE DEPLOYMENT

### Importa Schema SQL
```bash
mysql -u root -p srv1_hunabku < /home/user/3dCargoAL/HUNTER_SYSTEM_COMPLETE_OVERHAUL.sql
```

### Verifica Import
```sql
-- Connetti a DB
mysql -u root -p srv1_hunabku

-- Verifica tabella colori rank
SELECT COUNT(*) FROM hunter_ui_rank_colors;
-- Atteso: 7 (E, D, C, B, A, S, N)

-- Verifica stringhe UI aggiunte
SELECT COUNT(*) FROM hunter_texts WHERE text_key LIKE 'ui_%';
-- Atteso: 35+

-- Verifica dimensioni UI
SELECT COUNT(*) FROM hunter_ui_config WHERE config_key LIKE 'ui_%';
-- Atteso: 21+

-- Verifica test mode config
SELECT config_value FROM hunter_ui_config WHERE config_key='test_mode_enabled';
-- Atteso: 0 (disabilitato di default)
```

---

## STEP 3: SERVER FILES DEPLOYMENT

### Copia File Lua
```bash
cp /home/user/3dCargoAL/hunter_level_bridge.lua /path/to/server/quest/
cp /home/user/3dCargoAL/hunter_test_quest.lua /path/to/server/quest/
```

### Copia File Python
```bash
cp /home/user/3dCargoAL/game.py /path/to/client/root/
cp /home/user/3dCargoAL/uihunterlevel.py /path/to/client/root/
```

### Verifica Permessi
```bash
chmod 644 /path/to/server/quest/*.lua
chmod 644 /path/to/client/root/*.py
```

---

## STEP 4: SERVER RELOAD

### Reload Quest (In-game GM)
```
/reload q
```

### Verifica Output
Cerca in chat:
```
[QUEST] Reloading quest file...
[QUEST] Quest reloaded successfully
```

### Verifica Syserr.txt
```bash
tail -f /path/to/server/syserr.txt
# Cerca errori Lua/Python
# Non dovrebbero esserci errori Hunter
```

---

## STEP 5: CONFIG RELOAD TEST

### Login Come GM

### Esegui Reload Config
```
/hunter_reload
```

### Verifica Output
Dovresti vedere:
```
========================================
[HUNTER] Config ricaricata!
  UI Config: X parametri
  Rank Bonuses: 7 ranks
  Penalties: 3 livelli
  Streaks: 9 milestone
  Achievements: X totali
  Tempo: <0.5s
========================================
```

---

## STEP 6: ABILITA TEST MODE (Opzionale, solo DEV)

### SQL Query
```sql
UPDATE hunter_ui_config
SET config_value='1'
WHERE config_key='test_mode_enabled';
```

### Relog

### Verifica Test Mode Attivo
Dovresti vedere in chat:
```
[HUNTER TEST] Modalità test ATTIVA
  Usa /hunter_test per aprire menu test
```

---

## STEP 7: ESEGUI TEST SUITE

### Apri Menu Test
```
/hunter_test
```

### Esegui Tutti i 10 Test
- [ ] Test 1: Soglie Rank (DB Config)
- [ ] Test 2: Colori Rank (56+ colors)
- [ ] Test 3: Stringhe UI (35+ strings)
- [ ] Test 4: Dimensioni UI (20+ dims)
- [ ] Test 5: Achievements Real-Time
- [ ] Test 6: Penalty System
- [ ] Test 7: Rival Tracker
- [ ] Test 8: Streak Milestones
- [ ] Test 9: Gloria Sources
- [ ] Test 10: Config Reload

### Verifica Risultati
Ogni test deve completare con ✓ (check verde).

---

## STEP 8: TEST MODIFICA REAL-TIME

### Test 1: Modifica Soglia Rank
```sql
-- Modifica soglia C-Rank
UPDATE hunter_ui_config
SET config_value='15000'
WHERE config_key='rank_threshold_C';
```

In-game:
```
/hunter_reload
```

Verifica: `/hunter_test` → Test 1 → Verifica nuova soglia

---

### Test 2: Modifica Colore Rank
```sql
-- Modifica border color S-Rank
UPDATE hunter_ui_rank_colors
SET border='0xFFAA00AA'
WHERE rank_code='S';
```

In-game:
```
/hunter_reload
# Relog
```

Verifica: Apri Hunter Terminal → Verifica nuovo colore S-Rank

---

### Test 3: Modifica Stringa UI
```sql
-- Modifica tab Stats
UPDATE hunter_texts
SET text_value='MY STATISTICS'
WHERE text_key='ui_tab_stats';
```

In-game:
```
# Relog
```

Verifica: Apri Hunter Terminal → Tab dovrebbe dire "MY STATISTICS"

---

### Test 4: Modifica Dimensione UI
```sql
-- Aumenta larghezza finestra
UPDATE hunter_ui_config
SET config_value='600'
WHERE config_key='ui_window_width';
```

In-game:
```
# Relog (dimensioni applicate al login)
```

Verifica: Apri Hunter Terminal → Finestra più larga

---

## STEP 9: ROLLBACK TEST (Opzionale)

### Ripristina Valori Originali
```sql
-- Ripristina soglia C-Rank
UPDATE hunter_ui_config SET config_value='10000' WHERE config_key='rank_threshold_C';

-- Ripristina colore S-Rank
UPDATE hunter_ui_rank_colors SET border='0xFFFF6600' WHERE rank_code='S';

-- Ripristina testo tab
UPDATE hunter_texts SET text_value='STATISTICHE PERSONALI' WHERE text_key='ui_tab_stats';

-- Ripristina larghezza finestra
UPDATE hunter_ui_config SET config_value='500' WHERE config_key='ui_window_width';
```

In-game:
```
/hunter_reload
# Relog
```

Verifica: Tutti i valori tornati a default

---

## STEP 10: DISABILITA TEST MODE (Produzione)

### SQL Query
```sql
UPDATE hunter_ui_config
SET config_value='0'
WHERE config_key='test_mode_enabled';
```

### Verifica
Relog → Non dovresti vedere messaggi `[HUNTER TEST]`

---

## STEP 11: VERIFICA PERFORMANCE

### Controlla Tempo Reload
```
/hunter_reload
```

Tempo atteso: < 0.5 secondi

### Monitora Query DB
```sql
-- Abilita query log (temporaneo)
SET GLOBAL general_log = 'ON';

-- Esegui /hunter_reload in-game

-- Controlla log
cat /var/log/mysql/mysql.log | grep hunter

-- Disabilita log
SET GLOBAL general_log = 'OFF';
```

### Verifica RAM Usage
```bash
ps aux | grep game99
# Check memory footprint
```

---

## STEP 12: VERIFICA COMPATIBILITÀ CLIENT

### Test Con Client Vecchio
Se possibile, testa con client che non ha le modifiche Python.

Comportamento atteso:
- Client riceve dati ma non li applica
- Nessun crash
- Funzionalità base Hunter funziona

### Test Con Client Nuovo
Client con modifiche Python dovrebbe:
- Ricevere colori da DB
- Ricevere stringhe da DB
- Ricevere dimensioni da DB
- Applicare tutto correttamente

---

## TROUBLESHOOTING

### Errore: "hunter_ui_rank_colors table doesn't exist"
**Soluzione:** Re-importa SQL schema
```bash
mysql -u root -p srv1_hunabku < HUNTER_SYSTEM_COMPLETE_OVERHAUL.sql
```

### Errore: "attempt to call nil value 'send_rank_colors'"
**Soluzione:** Verifica hunter_level_bridge.lua aggiornato e /reload q eseguito

### UI non riceve colori
**Soluzione:**
1. Verifica game.py ha handler __HunterRankColor
2. Verifica serverCommandList registrato
3. Verifica uihunterlevel.py ha UpdateRankColor()
4. Relog per ricevere colori al login

### Colori non si applicano dopo reload
**Soluzione:**
- Colori rank richiedono relog (non solo /hunter_reload)
- UpdateRankColor() popola RANK_THEMES al volo

---

## CHECKLIST FINALE

Prima di andare in produzione:

- [ ] SQL schema importato correttamente
- [ ] File Lua/Python deployati
- [ ] /reload q eseguito senza errori
- [ ] /hunter_reload funziona (< 0.5s)
- [ ] Test mode testato e disabilitato
- [ ] Tutti i 10 test passati
- [ ] Modifica real-time testata (4 test)
- [ ] Rollback testato
- [ ] Performance verificata
- [ ] Compatibilità client verificata
- [ ] Syserr.txt pulito (zero errori Hunter)
- [ ] Backup DB fatto

---

## CONTATTI SUPPORTO

In caso di problemi:
1. Controlla syserr.txt
2. Controlla mysql error log
3. Verifica SQL import completo
4. Esegui `/hunter_test` per diagnostica
5. Controlla git log per commit mancanti

---

## VERSIONING

**Versione Attuale:** v3.0
**Data Rilascio:** 2025-12-25
**Branch:** claude/metin2-player-experience-FmXeU

**Changelog:**
- v3.0: 100% configurabile da DB (FIX 4-6)
- v2.0: Sistema base configurabile (~85%)

---

## NOTE FINALI

Sistema ora completamente data-driven:
- 154+ parametri configurabili
- Zero hardcode residuo
- Modifiche real-time senza restart
- Test suite completa

Buon deployment! 🚀
