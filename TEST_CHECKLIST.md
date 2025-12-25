# ⚠️ CHECKLIST TEST OBBLIGATORI - DA FARE IN-GAME

## 🔴 **NON HO POTUTO TESTARE QUESTI ASPETTI:**

### **1. Sistema Coda Messaggi**

**POTENZIALE PROBLEMA:**
`OnUpdate()` potrebbe non essere chiamato se la finestra non è registrata correttamente.

**TEST DA FARE:**
```python
# In-game, apri console Python e testa:
import uihunterlevel
wnd = uihunterlevel.GetHunterLevelWindow()

# Test 1: Verifica coda funziona
wnd.ShowSystemMessage("Messaggio 1", "E")
wnd.ShowSystemMessage("Messaggio 2", "D")
wnd.ShowSystemMessage("Messaggio 3", "C")

# Aspetta 4 secondi tra ogni messaggio
# Se vedi tutti e 3 in sequenza = ✅ OK
# Se vedi solo l'ultimo = ❌ OnUpdate non funziona
```

**SE NON FUNZIONA:**
Il problema è che `OnUpdate()` non viene chiamato per `ui.Window` base.

**FIX:**
```python
# In uihunterlevel_whatif.py, cambia linea 324:
# DA:
class SystemMessageWindow(ui.Window):

# A:
class SystemMessageWindow(ui.ScriptWindow):
```

---

### **2. Parsing Rank dal Lua**

**POTENZIALE PROBLEMA:**
Il formato del messaggio dal Lua potrebbe essere diverso da quello che mi aspetto.

**TEST DA FARE:**
```lua
-- Nel server Lua, aggiungi debug:
syschat("[DEBUG] Invio: " .. "E|Test messaggio")
cmdchat("HunterSystemSpeak E|Test messaggio")
```

```python
# Nel client Python hunterlevel.py, aggiungi dopo linea 25:
import chat
chat.AppendChat(chat.CHAT_TYPE_INFO, "[DEBUG] Ricevuto: " + str(args))
chat.AppendChat(chat.CHAT_TYPE_INFO, "[DEBUG] RankKey: " + str(parts[0]))
chat.AppendChat(chat.CHAT_TYPE_INFO, "[DEBUG] Message: " + str(parts[1]))
```

**Verifica chat:**
```
[DEBUG] Ricevuto: E|Test messaggio
[DEBUG] RankKey: E
[DEBUG] Message: Test messaggio
```

**SE IL FORMATO È DIVERSO:**
Adatta il parsing in `hunterlevel.py:25-29`

---

### **3. Posizionamenti GUI**

**POTENZIALE PROBLEMA:**
Le coordinate potrebbero non essere perfette per la tua risoluzione.

**TEST DA FARE:**
1. Login in-game
2. Attiva un evento schedulato
3. Apri finestra Hunter Terminal
4. Triggera un emergency quest
5. Verifica se le finestre si sovrappongono

**SE SI SOVRAPPONGONO:**
Modifica le coordinate in `uihunterlevel_whatif.py`:

```python
# SystemMessageWindow (linea 330):
Y = 150  # Cambia se troppo alta/bassa

# EmergencyQuestWindow (linea 434):
Y = 220  # Cambia se si sovrappone a SystemMessage

# EventStatusWindow (linea 677):
Y = 200  # Cambia se si sovrappone ad altro

# RivalTrackerWindow (linea 576):
defaultY = 80
eventActiveY = 270  # Cambia se si sovrappone
```

---

### **4. Database SQL Import**

**POTENZIALE PROBLEMA:**
Encoding, foreign keys, o tabelle esistenti.

**TEST DA FARE:**
```bash
# Backup prima!
mysqldump -u root -p srv1_hunabku > backup_$(date +%Y%m%d).sql

# Poi importa:
mysql -u root -p srv1_hunabku < HUNTER_DATABASE_FIXED_FINAL.sql
```

**SE DA ERRORE:**

**Errore 1: "Table already exists"**
```sql
-- Droppa le tabelle prima:
DROP TABLE IF EXISTS hunter_quest_emergencies;
DROP TABLE IF EXISTS hunter_scheduled_events;
-- Poi re-importa
```

**Errore 2: "Charset issues"**
```sql
-- All'inizio del file SQL, aggiungi:
SET NAMES utf8mb4;
SET character_set_client = utf8mb4;
```

**Errore 3: "Foreign key constraint fails"**
```sql
-- All'inizio del file:
SET FOREIGN_KEY_CHECKS = 0;
-- Alla fine:
SET FOREIGN_KEY_CHECKS = 1;
```

---

### **5. Colori Rank Visibili**

**POTENZIALE PROBLEMA:**
I colori potrebbero non essere abbastanza visibili su tutti gli sfondi.

**TEST DA FARE:**
1. Testa ogni rank (E, D, C, B, A, S, N)
2. Verifica se i colori si distinguono bene

**SE I COLORI NON SI VEDONO BENE:**
Modifica in `uihunterlevel_whatif.py` linee 385-393:

```python
RANK_COLORS = {
    "E": 0xFFAAAAAA,  # Se grigio troppo scuro → più chiaro
    "D": 0xFF00FF00,  # Se verde troppo brillante → più scuro
    # ecc...
}
```

---

## ✅ **COSA DOVREBBE FUNZIONARE AL 100%:**

1. ✅ **Sintassi codice** - Nessun errore Python
2. ✅ **Logica parsing** - Split su "|" corretto
3. ✅ **Database SQL** - Sintassi MySQL valida
4. ✅ **Struttura coda** - Logica append/pop corretta

---

## 🎯 **TEST RAPIDO (5 MINUTI):**

### **Test 1: Verifica parsing**
```
Login → Uccidi mob → Rank up
Vedi messaggio colorato? → ✅ OK / ❌ NO
```

### **Test 2: Verifica coda**
```
Spam 5 kill rapidi → Aspetta
Vedi tutti i messaggi in sequenza? → ✅ OK / ❌ NO
```

### **Test 3: Verifica posizioni**
```
Apri tutto (Hunter Terminal + Evento + Emergency)
Si sovrappongono? → ❌ NO = ✅ OK / ✅ SI = ❌ PROBLEMA
```

### **Test 4: Verifica database**
```
mysql> SELECT COUNT(*) FROM hunter_quest_emergencies;
Risultato: 8 → ✅ OK
```

---

## 🔧 **SE QUALCOSA NON FUNZIONA:**

### **Opzione 1: Debug Mode**
Aggiungi questo all'inizio di `hunterlevel.py`:

```python
import chat
DEBUG_MODE = True

def debug_log(msg):
    if DEBUG_MODE:
        chat.AppendChat(chat.CHAT_TYPE_INFO, "[HUNTER DEBUG] " + str(msg))
```

Poi usa `debug_log()` ovunque per capire cosa succede.

### **Opzione 2: Rollback Sicuro**
Se tutto si rompe:
```bash
# Torna al commit precedente:
git checkout a7a637f  # Ultimo commit prima dei fix finali

# Oppure:
git revert e7cf226
```

### **Opzione 3: Chiedi aiuto**
Se qualcosa non va, dammi:
1. Screenshot errori console Python
2. Log MySQL se import fallisce
3. Screenshot sovrapposizioni GUI
4. Output debug_log()

E fixo immediatamente!

---

## 📊 **PROBABILITÀ DI SUCCESSO:**

| Componente | Probabilità | Motivo |
|------------|-------------|--------|
| Parsing Rank | 95% | Logica semplice, ma formato potrebbe variare |
| Sistema Coda | 80% | OnUpdate() dovrebbe funzionare, ma dipende da ui.Window |
| Posizionamenti | 90% | Coordinate calcolate bene, ma dipende da risoluzione |
| Database SQL | 98% | Sintassi corretta, solo encoding potrebbe dare problemi |
| Colori | 100% | Valori hex standard, funzioneranno |

**MEDIA: ~92% probabilità che funzioni tutto al primo colpo**

---

## 💡 **RACCOMANDAZIONE:**

**Fai i test in questo ordine:**
1. ✅ Importa database (low risk)
2. ✅ Test parsing rank (critical)
3. ✅ Test coda messaggi (critical)
4. ✅ Test posizionamenti (nice to have)
5. ✅ Tweaking colori (optional)

**Se 1-3 funzionano = sei al 90% anche se 4-5 necessitano aggiustamenti!**

---

**Mi dispiace non poter testare in-game, ma ho fatto il meglio che potevo senza accesso al client! 🙏**
