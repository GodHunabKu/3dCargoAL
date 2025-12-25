# HUNTER SYSTEM - TEST CHECKLIST COMPLETO

## OVERVIEW
Questo documento contiene tutti i test da eseguire per verificare il corretto funzionamento del Hunter System dopo il refactoring MANIACALE al 100% configurabile.

---

## TEST 1: Soglie Rank (100% Configurabili da DB)

### Prerequisiti
- Accesso a Navicat o MySQL CLI
- Accesso al server di gioco
- Account di test con punti Gloria variabili

### Procedura
1. **Backup Config Attuale**
   ```sql
   SELECT * FROM srv1_hunabku.hunter_quest_config WHERE config_key LIKE 'rank_threshold_%';
   ```

2. **Modifica Soglia Rank C**
   ```sql
   UPDATE srv1_hunabku.hunter_quest_config
   SET config_value = '15000'
   WHERE config_key = 'rank_threshold_C';
   ```

3. **Reload Sistema**
   - In-game: `/hunter_reload`
   - Verifica messaggio: `[HUNTER] Config ricaricata con successo!`

4. **Verifica Applicazione**
   - Player con 12000 punti Gloria dovrebbe essere **Rank D** (non più C)
   - Player con 15000+ punti dovrebbe essere **Rank C**

5. **Verifica Sync Lua↔Python**
   - Controlla rank in Lua: `/hunter_info` o syschat
   - Apri UI Hunter: rank deve corrispondere
   - Verifica colori UI: devono riflettere il nuovo rank

6. **Ripristina Config**
   ```sql
   UPDATE srv1_hunabku.hunter_quest_config
   SET config_value = '10000'
   WHERE config_key = 'rank_threshold_C';
   ```
   - `/hunter_reload`

### Criteri Successo
- [ ] Modifica DB applicata senza errori
- [ ] `/hunter_reload` funziona correttamente
- [ ] Player rank cambia in base alle nuove soglie
- [ ] UI Python mostra rank corretto
- [ ] Colori UI corrispondono al rank
- [ ] Nessun errore in syserr/syslog

---

## TEST 2: CONSTANTS (Numeri Magici Eliminati)

### Obiettivo
Verificare che tutti i numeri magici siano stati estratti in CONSTANTS e funzionino correttamente.

### Procedura
1. **Verifica Definizioni**
   - Apri `/home/user/3dCargoAL/hunter_level_bridge.lua`
   - Cerca sezione `-- CONSTANTS`
   - Verifica presenza di:
     - `SECONDS_PER_DAY = 86400`
     - `SECONDS_PER_WEEK = 604800`
     - `SECONDS_PER_HOUR = 3600`
     - `SECONDS_PER_MINUTE = 60`
     - `EPOCH_YEAR = 1970`
     - `MAX_RANK_POINTS = 999999999`
     - `CONFIG_CACHE_DURATION = 3600`

2. **Verifica Nessun Numero Hardcoded**
   ```bash
   grep -n "86400\|604800\|999999999" hunter_level_bridge.lua | grep -v "local SECONDS_PER\|local MAX_RANK"
   ```
   - Output deve essere vuoto (solo definizioni CONSTANTS)

3. **Test Funzionalità Temporali**
   - Verifica reset daily a mezzanotte
   - Verifica reset weekly ogni Lunedì
   - Verifica calcolo streak login corretto

### Criteri Successo
- [ ] Tutti i CONSTANTS definiti
- [ ] Nessun numero magico hardcoded nel codice
- [ ] Reset daily/weekly funzionano correttamente
- [ ] Streak login calcolato correttamente
- [ ] Penalty duration calcolata correttamente

---

## TEST 3: Funzioni TODO UI Implementate

### 3.1 - Penalty Box
1. Fallisci una missione volutamente
2. Verifica che la penalty venga applicata:
   - Controlla DB: `SELECT penalty_active, penalty_expires, failed_missions FROM hunter_quest_ranking WHERE player_id = <tuo_id>`
3. Funzione `__UpdatePenaltyBox()` deve:
   - Calcolare tempo rimasto correttamente
   - Mostrare strike count (X/3)
   - Mostrare tempo scadenza (Xh Ym)

### 3.2 - Rival Tracker Box
1. Fai superare da un altro player in una classifica
2. La funzione `__UpdateRivalTrackerBox()` deve:
   - Mostrare nome rivale
   - Mostrare differenza punti
   - Mostrare categoria (Daily/Weekly/Total/etc)
   - Colore rosso se sei dietro, verde se sei avanti

### 3.3 - Rank Bonus Indicator
1. Verifica che `__UpdateRankBonusIndicator()` mostri:
   - Bonus Gloria % attuale
   - Bonus Drop % attuale
   - Punti mancanti al prossimo rank

### 3.4 - Achievements Tab Refresh
1. Completa parte di un achievement (es: uccidi 5/10 boss)
2. `__RefreshAchievementsTab()` deve:
   - Aggiornare barra progresso real-time
   - Calcolare % corretta (50% in questo caso)
   - Evidenziare achievement sbloccati ma non claimed

### 3.5 - Gloria Sources Chart
1. Guadagna punti Gloria da fonti diverse:
   - Fratture
   - Missioni
   - Eventi
   - Boss
2. `__UpdateGloriaSourcesChart()` deve:
   - Calcolare percentuali correttamente
   - Aggregare totali per fonte
   - Preparare dati per rendering

### Criteri Successo
- [ ] __UpdatePenaltyBox() calcola e mostra dati corretti
- [ ] __UpdateRivalTrackerBox() traccia rivali correttamente
- [ ] __UpdateRankBonusIndicator() mostra bonus e progresso
- [ ] __RefreshAchievementsTab() aggiorna progresso real-time
- [ ] __UpdateGloriaSourcesChart() calcola percentuali corrette

---

## TEST 4: Refactoring get_rank_key() - DRY Principle

### Obiettivo
Verificare che `get_rank_key()` chiami `get_rank_index()` eliminando duplicazione logica.

### Procedura
1. **Verifica Codice**
   - Apri `hunter_level_bridge.lua`
   - Cerca funzione `get_rank_key(points)`
   - Verifica che chiami `get_rank_index(points)` invece di duplicare logica soglie

2. **Test Funzionale**
   - Player con 150000 punti:
     - `get_rank_index(150000)` deve restituire `4` (A-rank)
     - `get_rank_key(150000)` deve restituire `"A"`
   - Player con 12000 punti:
     - `get_rank_index(12000)` deve restituire `2` (C-rank)
     - `get_rank_key(12000)` deve restituire `"C"`

### Criteri Successo
- [ ] get_rank_key() non duplica logica soglie
- [ ] get_rank_key() chiama get_rank_index() correttamente
- [ ] Entrambe le funzioni restituiscono risultati coerenti
- [ ] Nessun duplicato di codice

---

## TEST 5: Error Handling - DB Config Mancante

### Obiettivo
Verificare che il sistema mostri errori espliciti se la configurazione DB è mancante.

### Procedura
1. **Simula Config Mancante**
   ```sql
   -- Backup
   CREATE TEMPORARY TABLE tmp_backup AS SELECT * FROM hunter_quest_config WHERE config_key = 'rank_threshold_N';

   -- Elimina
   DELETE FROM hunter_quest_config WHERE config_key = 'rank_threshold_N';
   ```

2. **Reload e Verifica**
   - In-game: `/hunter_reload`
   - Apri UI Hunter o esegui comando rank
   - Verifica messaggio errore:
     ```
     [HUNTER] ERRORE: Soglie rank non configurate nel DB!
     Esegui HUNTER_CONFIG_COMPLETE.sql e usa /hunter_reload
     ```

3. **Ripristina**
   ```sql
   INSERT INTO hunter_quest_config SELECT * FROM tmp_backup;
   ```
   - `/hunter_reload`

### Criteri Successo
- [ ] Sistema mostra errore chiaro e descrittivo
- [ ] Non crasha se config mancante
- [ ] Messaggio indica come risolvere (eseguire SQL)
- [ ] Sistema funziona dopo ripristino config

---

## TEST 6: Cache Config Auto-Reload

### Obiettivo
Verificare che la cache config si ricarichi automaticamente ogni ora.

### Procedura
1. **Modifica CONFIG_CACHE_DURATION** (solo per test, riduci a 60 secondi)
   ```lua
   local CONFIG_CACHE_DURATION = 60  -- 1 minuto invece di 1 ora
   ```

2. **Modifica Config DB**
   ```sql
   UPDATE hunter_quest_config SET config_value = '999' WHERE config_key = 'rank_threshold_D';
   ```

3. **Attendi 60 Secondi**
   - Non fare `/hunter_reload` manuale
   - Attendi che la cache auto-reload

4. **Verifica Applicazione**
   - Player con 1000 punti dovrebbe essere Rank D (soglia 999)
   - Verifica senza reload manuale

5. **Ripristina**
   ```sql
   UPDATE hunter_quest_config SET config_value = '2000' WHERE config_key = 'rank_threshold_D';
   ```
   - Ripristina CONFIG_CACHE_DURATION a 3600

### Criteri Successo
- [ ] Cache si auto-ricarica dopo CONFIG_CACHE_DURATION
- [ ] Modifiche DB applicate automaticamente
- [ ] Nessun bisogno di reload manuale
- [ ] Performance accettabile (non ricarica ogni secondo)

---

## TEST 7: Sincronizzazione Lua↔Python

### Obiettivo
Verificare che i dati inviati da Lua arrivino correttamente a Python UI.

### Procedura
1. **Test Rank Thresholds**
   - Login al gioco
   - Lua chiama `send_rank_thresholds()` in `on_hunter_login()`
   - Python riceve comando `HunterRankThresholds`
   - UI applica soglie via `SetRankThresholds()`
   - Verifica: apri UI, rank deve essere calcolato con soglie DB

2. **Test Penalty Status**
   - Lua invia `HunterPenaltyStatus active|expires|strikes`
   - Python chiama `HunterPenaltyStatus(active, expires, strikes)`
   - UI mostra penalty box con dati corretti

3. **Test Rival Info**
   - Lua invia `HunterRivalInfo name|diff|category`
   - Python chiama `HunterRivalInfo(name, diff, category)`
   - UI mostra rival tracker con dati corretti

4. **Test Rank Bonus**
   - Lua invia `HunterRankBonus gloria_pct|drop_pct|next_pts`
   - Python chiama `HunterRankBonus(gloria, drop, next)`
   - UI mostra bonus indicator

### Criteri Successo
- [ ] Tutti i comandi Lua→Python funzionano
- [ ] Dati parsati correttamente (split "|" OK)
- [ ] UI aggiornata con dati ricevuti
- [ ] Nessun errore di tipo/conversione

---

## TEST 8: Performance e Stress Test

### Procedura
1. **Test Reload Frequente**
   - Esegui `/hunter_reload` 10 volte di seguito
   - Verifica nessun memory leak
   - Verifica tempi reload < 1 secondo

2. **Test Molti Player Simultanei**
   - Simula 50+ player che fanno login contemporaneamente
   - Verifica `on_hunter_login()` per tutti
   - Verifica nessun lag/crash

3. **Test DB Query Load**
   - Monitora query DB durante operazioni frequenti
   - Verifica cache funziona (non riquery ogni volta)

### Criteri Successo
- [ ] Reload veloce (< 1 sec)
- [ ] Nessun memory leak
- [ ] Supporta molti player simultanei
- [ ] Cache riduce query DB

---

## TEST 9: Backward Compatibility

### Obiettivo
Verificare che il refactoring non rompa funzionalità esistenti.

### Procedura
1. **Test Sistema Missioni**
   - Accetta missione daily
   - Completa missione
   - Verifica ricompensa Gloria corretta

2. **Test Sistema Eventi**
   - Partecipa a evento
   - Verifica punti Gloria assegnati

3. **Test Classifiche**
   - Verifica ranking daily/weekly/total
   - Verifica ordinamento corretto

4. **Test Achievements**
   - Sblocca achievement
   - Verifica ricompensa claimed
   - Verifica progresso salvato

### Criteri Successo
- [ ] Tutte le feature esistenti funzionano
- [ ] Nessuna regressione
- [ ] Dati salvati correttamente
- [ ] UI responsive e funzionale

---

## TEST 10: Documentazione e Usabilità

### Verifica
- [ ] Commenti nel codice chiari e accurati
- [ ] CONSTANTS ben documentate
- [ ] Messaggi errore descrittivi
- [ ] README aggiornato con nuove feature
- [ ] SQL scripts eseguibili senza errori

---

## SUMMARY CHECKLIST

### Refactoring Completato
- [x] FIX 1: Duplicato get_rank_index() eliminato
- [x] FIX 2: Soglie rank 100% configurabili da DB
- [x] FIX 3: Numeri magici estratti in CONSTANTS
- [x] FIX 7: 5 funzioni TODO UI implementate

### Testing Completato
- [ ] Test 1: Soglie Rank configurabili
- [ ] Test 2: CONSTANTS funzionanti
- [ ] Test 3: Funzioni UI implementate
- [ ] Test 4: Refactoring DRY
- [ ] Test 5: Error handling robusto
- [ ] Test 6: Cache auto-reload
- [ ] Test 7: Sync Lua↔Python
- [ ] Test 8: Performance OK
- [ ] Test 9: Backward compatible
- [ ] Test 10: Documentazione completa

### Risultato Atteso
Sistema Hunter **100% configurabile da database** con:
- ✅ Zero numeri magici hardcoded
- ✅ Zero duplicazione logica
- ✅ Errori espliciti se config mancante
- ✅ Sync perfetto Lua↔Python
- ✅ Tutte le funzioni UI implementate
- ✅ Performance ottimizzata
- ✅ Backward compatible

---

## TROUBLESHOOTING

### Problema: Rank non si aggiorna dopo modifica DB
**Soluzione:** Esegui `/hunter_reload` in-game

### Problema: Errore "Soglie rank non configurate"
**Soluzione:** Esegui `HUNTER_CONFIG_COMPLETE.sql` per popolare DB

### Problema: UI Python mostra rank diverso da Lua
**Soluzione:** Verifica sync `HunterRankThresholds` in game.py e chiamata in `on_hunter_login()`

### Problema: Cache non si auto-ricarica
**Soluzione:** Verifica `CONFIG_CACHE_DURATION` e `_G.hunter_config_last_load`

---

**TESTING COMPLETATO DA:** _____________
**DATA:** _____________
**RISULTATO:** ⬜ PASS  ⬜ FAIL
**NOTE:** _____________________________________________
