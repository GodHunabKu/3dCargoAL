# -*- coding: utf-8 -*-
# ============================================================================
# FIX: Sistema Coda Messaggi per SystemMessageWindow
# Da inserire in: uihunterlevel_whatif.py alla classe SystemMessageWindow
# ============================================================================

# SOSTITUIRE la classe SystemMessageWindow (linea 324-424) con questa versione:

class SystemMessageWindow(ui.Window):
    """Messaggio di sistema con colori dinamici basati sul rank + CODA MESSAGGI"""
    def __init__(self):
        ui.Window.__init__(self)
        self.SetSize(500, 60)
        screenWidth = wndMgr.GetScreenWidth()
        self.SetPosition((screenWidth - 500) / 2, 150)
        self.AddFlag("not_pick")
        self.AddFlag("float")

        self.currentColor = 0xFF0099FF  # Default blu

        # FIX: Coda messaggi per evitare sovrapposizioni
        self.messageQueue = []
        self.currentMessage = None
        self.messageDelay = 4.0  # 4 secondi per messaggio

        # Sfondo
        self.bg = ui.Bar()
        self.bg.SetParent(self)
        self.bg.SetPosition(0, 0)
        self.bg.SetSize(500, 60)
        self.bg.SetColor(COLOR_BG_DARK)
        self.bg.Show()

        # Bordi (salvati per aggiornamento colori)
        self.borders = []
        color = FRACTURE_SCHEMES["BLUE"]["border"]
        # Top
        b1 = ui.Bar(); b1.SetParent(self); b1.SetPosition(0, 0); b1.SetSize(500, 2); b1.SetColor(color); b1.Show()
        self.borders.append(b1)
        # Bottom
        b2 = ui.Bar(); b2.SetParent(self); b2.SetPosition(0, 58); b2.SetSize(500, 2); b2.SetColor(color); b2.Show()
        self.borders.append(b2)
        # Left
        b3 = ui.Bar(); b3.SetParent(self); b3.SetPosition(0, 0); b3.SetSize(2, 60); b3.SetColor(color); b3.Show()
        self.borders.append(b3)
        # Right
        b4 = ui.Bar(); b4.SetParent(self); b4.SetPosition(498, 0); b4.SetSize(2, 60); b4.SetColor(color); b4.Show()
        self.borders.append(b4)

        self.text = ui.TextLine()
        self.text.SetParent(self)
        self.text.SetPosition(250, 20)
        self.text.SetHorizontalAlignCenter()
        self.text.SetPackedFontColor(FRACTURE_SCHEMES["BLUE"]["title"])
        self.text.SetOutline()
        self.text.Show()

        self.endTime = 0

    def __UpdateColors(self, color):
        """Aggiorna i colori dei bordi e del testo"""
        self.currentColor = color
        for b in self.borders:
            b.SetColor(color)
        self.text.SetPackedFontColor(color)

    def ShowMessage(self, msg, color=None):
        """
        FIX: Aggiungi messaggio alla CODA invece di mostrare subito
        Questo previene che i messaggi si sovrascrivano
        """
        # Ricalcola posizione per sicurezza
        screenWidth = wndMgr.GetScreenWidth()
        self.SetPosition((screenWidth - 500) / 2, 150)

        # Determina colore
        finalColor = self.currentColor
        if color:
            if isinstance(color, int):
                finalColor = color
            else:
                finalColor = self.__GetColorFromKey(color)

        # Aggiungi alla coda
        self.messageQueue.append((msg.replace("+", " "), finalColor))

        # Se non c'è messaggio corrente, mostra subito il prossimo
        if not self.currentMessage:
            self.ShowNextMessage()

    def ShowNextMessage(self):
        """Mostra il prossimo messaggio in coda"""
        if len(self.messageQueue) > 0:
            msg, color = self.messageQueue.pop(0)

            # Aggiorna visuale
            self.__UpdateColors(color)
            self.text.SetText(msg)

            # Salva messaggio corrente
            self.currentMessage = msg
            self.endTime = app.GetTime() + self.messageDelay

            # Mostra finestra
            self.Show()
            self.SetTop()
        else:
            self.currentMessage = None

    def __GetColorFromKey(self, colorKey):
        """Converte chiave colore (E,D,C,BLUE,GREEN...) in intero"""
        # Colori per rank giocatore
        RANK_COLORS = {
            "E": 0xFF808080,  # Grigio
            "D": 0xFF00FF00,  # Verde
            "C": 0xFF00FFFF,  # Cyan
            "B": 0xFF0066FF,  # Blu
            "A": 0xFFAA00FF,  # Viola
            "S": 0xFFFF6600,  # Arancione
            "N": 0xFFFF0000,  # Rosso
        }
        # Colori per fratture
        FRACTURE_COLORS = {
            "GREEN": 0xFF00FF00,       # Verde Neon
            "BLUE": 0xFF0099FF,        # Blu System
            "ORANGE": 0xFFFF6600,      # Arancione Fuoco
            "RED": 0xFFFF0000,         # Rosso Sangue
            "GOLD": 0xFFFFD700,        # Oro
            "PURPLE": 0xFF9900FF,      # Viola Ombra
            "BLACKWHITE": 0xFFFFFFFF,  # Bianco
        }
        # Prova prima i colori frattura, poi i rank
        return FRACTURE_COLORS.get(colorKey, RANK_COLORS.get(colorKey, 0xFF808080))

    def SetRankColor(self, colorKey):
        """Imposta il colore e aggiorna visualmente - supporta sia rank (E,D,C...) che fratture (GREEN,BLUE...)"""
        color = self.__GetColorFromKey(colorKey)
        self.__UpdateColors(color)

    def OnUpdate(self):
        """FIX: Quando il messaggio scade, mostra il prossimo in coda"""
        if self.endTime > 0 and app.GetTime() > self.endTime:
            self.Hide()
            self.endTime = 0
            self.currentMessage = None
            # Mostra il prossimo messaggio se ce ne sono
            self.ShowNextMessage()

    def GetQueueLength(self):
        """Ritorna il numero di messaggi in coda (per debug)"""
        return len(self.messageQueue)

    def ClearQueue(self):
        """Svuota la coda messaggi (per situazioni speciali)"""
        self.messageQueue = []
        self.Hide()
        self.currentMessage = None
        self.endTime = 0
