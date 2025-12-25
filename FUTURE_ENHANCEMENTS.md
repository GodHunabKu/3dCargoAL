# HUNTER SYSTEM - FUTURE ENHANCEMENTS

## Overview

Questo documento descrive i miglioramenti futuri pianificati per portare il Hunter System da **~85% configurabile** a **100% configurabile**. Questi fix non sono stati implementati nella v2.0 ma sono documentati per future iterazioni.

---

## FIX 4: Sposta 56+ Colori Rank in DB (hunter_ui_rank_colors)

### Status: 📋 PIANIFICATO

### Problema Attuale
In `uihunterlevel.py` (linee 29-163) ci sono **56+ colori hardcoded** nel dict `RANK_THEMES`:

```python
RANK_THEMES = {
    "E": {
        "bg_dark": 0xEE0D0D0D,        # Hardcoded
        "bg_medium": 0xEE1A1A1A,      # Hardcoded
        "bg_light": 0xEE2A2A2A,       # Hardcoded
        "border": 0xFF555555,         # Hardcoded
        # ... 56+ linee di colori
    },
    # ... rank D, C, B, A, S, N
}
```

### Soluzione Proposta

#### A. Crea Tabella DB
```sql
CREATE TABLE IF NOT EXISTS hunter_ui_rank_colors (
  rank_code VARCHAR(1) PRIMARY KEY,
  bg_dark VARCHAR(10),
  bg_medium VARCHAR(10),
  bg_light VARCHAR(10),
  border VARCHAR(10),
  accent VARCHAR(10),
  text_title VARCHAR(10),
  text_value VARCHAR(10),
  text_muted VARCHAR(10),
  bar_fill VARCHAR(10),
  glow VARCHAR(10),
  btn_normal VARCHAR(10),
  btn_hover VARCHAR(10),
  btn_down VARCHAR(10)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Popola con colori attuali
INSERT INTO hunter_ui_rank_colors VALUES
('E', '0xEE0D0D0D', '0xEE1A1A1A', '0xEE2A2A2A', '0xFF555555', '0xFF808080', '0xFFFFFFFF', '0xFFCCCCCC', '0xFF888888', '0xFF555555', '0x33FFFFFF', '0xFF1A1A1A', '0xFF2A2A2A', '0xFF3A3A3A'),
('D', '0xEE0A1A0A', '0xEE0F2A0F', '0xEE153A15', '0xFF00AA00', '0xFF00FF00', '0xFFFFFFFF', '0xFF00FF00', '0xFF009900', '0xFF00AA00', '0x3300FF00', '0xFF0F2A0F', '0xFF153A15', '0xFF1A4A1A'),
-- ... altre 5 righe per rank C, B, A, S, N
```

#### B. Invia Colori a Python (Lua)
```lua
-- In hunter_level_bridge.lua
function send_rank_colors()
    local c, d = mysql_direct_query("SELECT rank_code, bg_dark, bg_medium, bg_light, border, accent, text_title, text_value, text_muted, bar_fill, glow, btn_normal, btn_hover, btn_down FROM srv1_hunabku.hunter_ui_rank_colors ORDER BY rank_code")
    if c > 0 then
        for i = 1, c do
            local data = d[i].rank_code .. "|" .. d[i].bg_dark .. "|" .. d[i].bg_medium .. "|" .. d[i].bg_light .. "|" .. d[i].border .. "|" .. d[i].accent .. "|" .. d[i].text_title .. "|" .. d[i].text_value .. "|" .. d[i].text_muted .. "|" .. d[i].bar_fill .. "|" .. d[i].glow .. "|" .. d[i].btn_normal .. "|" .. d[i].btn_hover .. "|" .. d[i].btn_down
            cmdchat("HunterRankColor " .. data)
        end
    end
end

-- Chiama in on_hunter_login()
```

#### C. Ricevi in Python (game.py)
```python
def __HunterRankColor(self, data):
    """Riceve colori tema rank - Format: rank|bg_dark|bg_medium|...|btn_down"""
    if self.interface:
        self.interface.UpdateRankColor(data)

# Registra
serverCommandList["HunterRankColor"] = self.__HunterRankColor
```

#### D. Applica in UI (uihunterlevel.py)
```python
# Inizializza vuoto, popolato da server
RANK_THEMES = {}

def UpdateRankColor(self, data):
    """Aggiorna colori rank da server"""
    parts = data.split("|")
    if len(parts) == 14:  # rank + 13 colori
        rank = parts[0]
        RANK_THEMES[rank] = {
            "bg_dark": int(parts[1], 16),
            "bg_medium": int(parts[2], 16),
            "bg_light": int(parts[3], 16),
            "border": int(parts[4], 16),
            "accent": int(parts[5], 16),
            "text_title": int(parts[6], 16),
            "text_value": int(parts[7], 16),
            "text_muted": int(parts[8], 16),
            "bar_fill": int(parts[9], 16),
            "glow": int(parts[10], 16),
            "btn_normal": int(parts[11], 16),
            "btn_hover": int(parts[12], 16),
            "btn_down": int(parts[13], 16),
        }
        # Refresh tema UI se necessario
        self.RefreshTheme()
```

### Benefici
- ✅ 56+ colori configurabili da DB
- ✅ Modifiche colori senza restart client
- ✅ Temi stagionali/eventi facilmente implementabili
- ✅ Personalizzazione completa UI

### Effort
- **Tempo Stimato:** 2-3 ore
- **Complessità:** Media
- **File da Modificare:** 3 (SQL, Lua, Python)

---

## FIX 5: Sposta 35+ Stringhe UI in DB (hunter_texts)

### Status: 📋 PIANIFICATO

### Problema Attuale
Circa **35+ stringhe UI** sono hardcoded in `uihunterlevel.py`:

```python
titleText.SetText("STATISTICHE PERSONALI")  # Hardcoded
tabButton.SetText("Achievement")            # Hardcoded
labelRank.SetText("Rank:")                  # Hardcoded
# ... 32+ stringhe hardcoded
```

### Soluzione Proposta

#### A. Estendi Tabella hunter_texts
La tabella `hunter_texts` esiste già, basta popolarla:

```sql
-- UI Titles
INSERT INTO hunter_texts VALUES ('ui_tab_stats', 'STATISTICHE PERSONALI');
INSERT INTO hunter_texts VALUES ('ui_tab_achievements', 'TRAGUARDI');
INSERT INTO hunter_texts VALUES ('ui_tab_ranking', 'SALA DELLE LEGGENDE');
INSERT INTO hunter_texts VALUES ('ui_tab_events', 'EVENTI DEL GIORNO');
INSERT INTO hunter_texts VALUES ('ui_tab_guide', 'GUIDA COMPLETA');

-- UI Labels
INSERT INTO hunter_texts VALUES ('ui_label_rank', 'Rank:');
INSERT INTO hunter_texts VALUES ('ui_label_gloria', 'Punti Gloria:');
INSERT INTO hunter_texts VALUES ('ui_label_kills', 'Uccisioni:');
INSERT INTO hunter_texts VALUES ('ui_label_streak', 'Streak Login:');
INSERT INTO hunter_texts VALUES ('ui_label_missions', 'Missioni Completate:');

-- UI Sections
INSERT INTO hunter_texts VALUES ('ui_section_today', 'OGGI');
INSERT INTO hunter_texts VALUES ('ui_section_total', 'TOTALE');
INSERT INTO hunter_texts VALUES ('ui_section_economy', 'ECONOMIA');
INSERT INTO hunter_texts VALUES ('ui_section_records', 'RECORD');

-- UI Messages
INSERT INTO hunter_texts VALUES ('ui_msg_no_data', 'Nessun dato disponibile');
INSERT INTO hunter_texts VALUES ('ui_msg_loading', 'Caricamento...');
INSERT INTO hunter_texts VALUES ('ui_msg_error', 'Errore nel caricamento dati');

-- ... totale 35+ stringhe
```

#### B. Invia Stringhe a Python (Lua)
```lua
function send_ui_texts()
    local keys = {
        "ui_tab_stats", "ui_tab_achievements", "ui_tab_ranking", "ui_tab_events", "ui_tab_guide",
        "ui_label_rank", "ui_label_gloria", "ui_label_kills", "ui_label_streak", "ui_label_missions",
        "ui_section_today", "ui_section_total", "ui_section_economy", "ui_section_records",
        "ui_msg_no_data", "ui_msg_loading", "ui_msg_error"
        -- ... tutte le 35+ chiavi
    }

    for _, key in ipairs(keys) do
        local text = hunter_level_bridge.get_text(key) or ""
        cmdchat("HunterUIText " .. key .. "|" .. text)
    end
end

-- Chiama in on_hunter_login()
```

#### C. Ricevi in Python (game.py)
```python
def __HunterUIText(self, data):
    """Riceve stringhe UI - Format: key|text"""
    if self.interface:
        parts = data.split("|", 1)
        if len(parts) == 2:
            self.interface.UpdateUIText(parts[0], parts[1])

# Registra
serverCommandList["HunterUIText"] = self.__HunterUIText
```

#### D. Applica in UI (uihunterlevel.py)
```python
# Global dict
UI_TEXTS = {}

def UpdateUIText(self, key, text):
    """Aggiorna stringa UI"""
    UI_TEXTS[key] = text

# Usa ovunque
titleText.SetText(UI_TEXTS.get("ui_tab_stats", "STATS"))  # Fallback se manca
tabButton.SetText(UI_TEXTS.get("ui_tab_achievements", "ACHIEVEMENTS"))
labelRank.SetText(UI_TEXTS.get("ui_label_rank", "Rank:"))
# ... tutte le 35+ stringhe
```

### Benefici
- ✅ Localizzazione facile (Italiano/Inglese/etc)
- ✅ Modifica testi UI senza ricompilare
- ✅ A/B testing UI copy
- ✅ Testi evento/stagionali dinamici

### Effort
- **Tempo Stimato:** 3-4 ore
- **Complessità:** Media-Alta (molte stringhe da identificare)
- **File da Modificare:** 3 (SQL, Lua, Python)

---

## FIX 6: Configura Dimensioni UI da DB (hunter_ui_config)

### Status: 📋 PIANIFICATO

### Problema Attuale
Circa **20+ dimensioni UI** sono hardcoded in `uihunterlevel.py`:

```python
WINDOW_WIDTH = 500        # Hardcoded
WINDOW_HEIGHT = 520       # Hardcoded
HEADER_HEIGHT = 95        # Hardcoded
CONTENT_HEIGHT = 300      # Hardcoded
TAB_HEIGHT = 28           # Hardcoded
FOOTER_HEIGHT = 35        # Hardcoded
# ... 14+ dimensioni hardcoded
```

### Soluzione Proposta

#### A. Aggiungi Parametri in hunter_ui_config
```sql
-- Dimensioni Finestra Principale
INSERT INTO hunter_ui_config VALUES ('window_width', '500', 'int', 'Larghezza finestra principale');
INSERT INTO hunter_ui_config VALUES ('window_height', '520', 'int', 'Altezza finestra principale');
INSERT INTO hunter_ui_config VALUES ('window_min_width', '400', 'int', 'Larghezza minima finestra');
INSERT INTO hunter_ui_config VALUES ('window_max_width', '800', 'int', 'Larghezza massima finestra');

-- Dimensioni Sezioni
INSERT INTO hunter_ui_config VALUES ('header_height', '95', 'int', 'Altezza header');
INSERT INTO hunter_ui_config VALUES ('content_height', '300', 'int', 'Altezza contenuto');
INSERT INTO hunter_ui_config VALUES ('tab_height', '28', 'int', 'Altezza tab');
INSERT INTO hunter_ui_config VALUES ('footer_height', '35', 'int', 'Altezza footer');

-- Spaziatura
INSERT INTO hunter_ui_config VALUES ('padding_small', '5', 'int', 'Padding piccolo');
INSERT INTO hunter_ui_config VALUES ('padding_medium', '10', 'int', 'Padding medio');
INSERT INTO hunter_ui_config VALUES ('padding_large', '15', 'int', 'Padding grande');
INSERT INTO hunter_ui_config VALUES ('margin_between_elements', '8', 'int', 'Margine tra elementi');

-- Font Sizes
INSERT INTO hunter_ui_config VALUES ('font_size_title', '18', 'int', 'Dimensione font titolo');
INSERT INTO hunter_ui_config VALUES ('font_size_normal', '12', 'int', 'Dimensione font normale');
INSERT INTO hunter_ui_config VALUES ('font_size_small', '10', 'int', 'Dimensione font piccolo');

-- Icon Sizes
INSERT INTO hunter_ui_config VALUES ('icon_size_large', '64', 'int', 'Dimensione icona grande');
INSERT INTO hunter_ui_config VALUES ('icon_size_medium', '32', 'int', 'Dimensione icona media');
INSERT INTO hunter_ui_config VALUES ('icon_size_small', '16', 'int', 'Dimensione icona piccola');

-- Popup/Dialog
INSERT INTO hunter_ui_config VALUES ('popup_width', '400', 'int', 'Larghezza popup');
INSERT INTO hunter_ui_config VALUES ('popup_height', '250', 'int', 'Altezza popup');
INSERT INTO hunter_ui_config VALUES ('achievement_popup_width', '350', 'int', 'Larghezza popup achievement');
INSERT INTO hunter_ui_config VALUES ('achievement_popup_height', '150', 'int', 'Altezza popup achievement');

-- Totale: 20+ parametri dimensioni
```

#### B. Invia Dimensioni a Python (Lua)
```lua
function send_ui_dimensions()
    local dims = {}

    -- Finestra
    dims.window_width = tonumber(hunter_level_bridge.get_config("window_width")) or 500
    dims.window_height = tonumber(hunter_level_bridge.get_config("window_height")) or 520

    -- Sezioni
    dims.header_height = tonumber(hunter_level_bridge.get_config("header_height")) or 95
    dims.content_height = tonumber(hunter_level_bridge.get_config("content_height")) or 300
    dims.tab_height = tonumber(hunter_level_bridge.get_config("tab_height")) or 28
    dims.footer_height = tonumber(hunter_level_bridge.get_config("footer_height")) or 35

    -- Spaziatura
    dims.padding_small = tonumber(hunter_level_bridge.get_config("padding_small")) or 5
    dims.padding_medium = tonumber(hunter_level_bridge.get_config("padding_medium")) or 10
    dims.padding_large = tonumber(hunter_level_bridge.get_config("padding_large")) or 15

    -- ... tutte le altre dimensioni

    -- Format: pipe-separated (come rank thresholds)
    local data = dims.window_width .. "|" .. dims.window_height .. "|" .. dims.header_height .. "|" .. dims.content_height .. "|" .. dims.tab_height .. "|" .. dims.footer_height .. "|" .. dims.padding_small .. "|" .. dims.padding_medium .. "|" .. dims.padding_large
    -- ... continua per tutte le 20+ dimensioni

    cmdchat("HunterUIDimensions " .. data)
end

-- Chiama in on_hunter_login()
```

#### C. Ricevi in Python (game.py)
```python
def __HunterUIDimensions(self, data):
    """Riceve dimensioni UI - Format: pipe-separated 20+ values"""
    if self.interface:
        self.interface.SetUIDimensions(data)

# Registra
serverCommandList["HunterUIDimensions"] = self.__HunterUIDimensions
```

#### D. Applica in UI (uihunterlevel.py)
```python
# Defaults, sovrascritti da server
UI_DIMENSIONS = {
    "window_width": 500,
    "window_height": 520,
    "header_height": 95,
    "content_height": 300,
    "tab_height": 28,
    "footer_height": 35,
    "padding_small": 5,
    "padding_medium": 10,
    "padding_large": 15,
    # ... altre 11+ dimensioni
}

def SetUIDimensions(self, data):
    """Aggiorna dimensioni UI da server"""
    parts = data.split("|")
    if len(parts) >= 20:  # Almeno 20 dimensioni
        UI_DIMENSIONS["window_width"] = int(parts[0])
        UI_DIMENSIONS["window_height"] = int(parts[1])
        UI_DIMENSIONS["header_height"] = int(parts[2])
        UI_DIMENSIONS["content_height"] = int(parts[3])
        UI_DIMENSIONS["tab_height"] = int(parts[4])
        UI_DIMENSIONS["footer_height"] = int(parts[5])
        UI_DIMENSIONS["padding_small"] = int(parts[6])
        UI_DIMENSIONS["padding_medium"] = int(parts[7])
        UI_DIMENSIONS["padding_large"] = int(parts[8])
        # ... parse altre 11+ dimensioni

        # Applica dimensioni
        self.SetSize(UI_DIMENSIONS["window_width"], UI_DIMENSIONS["window_height"])
        self.header.SetSize(UI_DIMENSIONS["window_width"], UI_DIMENSIONS["header_height"])
        # ... applica tutte le dimensioni

def GetDimension(self, key):
    """Helper per ottenere dimensione"""
    return UI_DIMENSIONS.get(key, 0)

# Usa ovunque nel codice
self.SetSize(self.GetDimension("window_width"), self.GetDimension("window_height"))
header.SetPosition(0, 0)
header.SetSize(self.GetDimension("window_width"), self.GetDimension("header_height"))
content.SetPosition(self.GetDimension("padding_medium"), self.GetDimension("header_height"))
# ... tutte le 50+ posizioni/dimensioni
```

### Benefici
- ✅ Layout UI completamente personalizzabile
- ✅ Supporto multi-risoluzione facile
- ✅ A/B testing layout UI
- ✅ UI responsive senza ricompilare

### Effort
- **Tempo Stimato:** 4-5 ore
- **Complessità:** Alta (molti elementi UI da aggiornare)
- **File da Modificare:** 3 (SQL, Lua, Python)

---

## Roadmap Implementazione

### Fase 1: Quick Wins (1-2 giorni)
- [ ] FIX 5: Stringhe UI (più facile, impatto alto su localizzazione)

### Fase 2: Visual Improvements (2-3 giorni)
- [ ] FIX 4: Colori Rank (impatto visivo massimo)

### Fase 3: Advanced (3-4 giorni)
- [ ] FIX 6: Dimensioni UI (più complesso, richiede test estensivi)

### Totale: 6-9 giorni per completare 100%

---

## Testing Aggiuntivo Richiesto

Una volta implementati i fix 4-6, aggiungi questi test al `TEST_HUNTER_SYSTEM.md`:

### Test 11: Colori Rank Configurabili
1. Modifica colore border rank S in `hunter_ui_rank_colors`
2. `/hunter_reload`
3. Verifica nuovo colore applicato in UI
4. Test con tutti e 7 i rank

### Test 12: Stringhe UI Multilingua
1. Modifica stringhe in `hunter_texts` (es: Italiano → Inglese)
2. `/hunter_reload`
3. Relog player
4. Verifica nuove stringhe in UI
5. Test tutte le 35+ stringhe

### Test 13: Dimensioni UI Responsive
1. Modifica `window_width` da 500 a 700
2. Modifica `padding_medium` da 10 a 20
3. Relog player
4. Verifica layout corretto con nuove dimensioni
5. Test edge cases (dimensioni minime/massime)

---

## Metriche Obiettivo

### v2.0 (Attuale)
- ✅ **85%** configurabile da DB
  - Soglie rank ✅
  - Bonus rank ✅
  - Penalties ✅
  - Achievements ✅
  - Streak milestones ✅
  - Timeout/CONSTANTS ✅
  - Colori rank ❌ (hardcoded)
  - Stringhe UI ❌ (hardcoded)
  - Dimensioni UI ❌ (hardcoded)

### v3.0 (Target)
- 🎯 **100%** configurabile da DB
  - Soglie rank ✅
  - Bonus rank ✅
  - Penalties ✅
  - Achievements ✅
  - Streak milestones ✅
  - Timeout/CONSTANTS ✅
  - Colori rank ✅ (FIX 4)
  - Stringhe UI ✅ (FIX 5)
  - Dimensioni UI ✅ (FIX 6)

---

## Conclusione

I fix 4-6 sono **opzionali ma altamente raccomandati** per raggiungere il **100% configurabile**. Possono essere implementati in fasi successive senza impattare le funzionalità attuali.

**Priorità Suggerita:**
1. FIX 5 (Stringhe) → Abilita localizzazione
2. FIX 4 (Colori) → Massimo impatto visivo
3. FIX 6 (Dimensioni) → Massima flessibilità layout

**Beneficio Finale:** Sistema Hunter completamente data-driven, zero ricompilazioni per modifiche UI/UX.
