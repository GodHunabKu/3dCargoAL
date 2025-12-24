# -*- coding: utf-8 -*-
# HUNTER LEVEL SYSTEM v30.0 - PARSER
# Mappa i comandi server (cmdchat) sulla UI (uihunterlevel.py)

import uihunterlevel
import app
import net

def _GetWindow():
    return uihunterlevel.GetHunterLevelWindow()

# ============================================================
# NEW FEATURES COMMANDS (v30.0)
# ============================================================

def HunterSystemSpeak(args):
    """
    Mostra un messaggio in stile Sistema (Solo Leveling).
    Sintassi Lua: cmdchat("HunterSystemSpeak Messaggio")
    """
    wnd = _GetWindow()
    if wnd:
        wnd.ShowSystemMessage(str(args).replace("+", " "))

def HunterEmergency(args):
    """
    Attiva widget quest emergenza.
    Sintassi Lua: cmdchat("HunterEmergency Title|Seconds|Vnum|Count")
    """
    try:
        parts = args.split("|")
        title = parts[0].replace("+", " ")
        seconds = int(parts[1])
        vnum = int(parts[2])
        count = int(parts[3])
        wnd = _GetWindow()
        if wnd:
            wnd.StartEmergencyQuest(title, seconds, vnum, count)
    except:
        pass

def HunterEmergencyUpdate(count):
    """
    Aggiorna counter emergenza.
    Sintassi Lua: cmdchat("HunterEmergencyUpdate " .. count)
    """
    wnd = _GetWindow()
    if wnd:
        wnd.UpdateEmergencyCount(int(count))

def HunterEmergencyClose(status):
    """
    Chiude widget emergenza.
    Sintassi Lua: cmdchat("HunterEmergencyClose SUCCESS") (o FAIL)
    """
    wnd = _GetWindow()
    if wnd:
        wnd.EndEmergencyQuest(str(status))

def HunterRivalUpdate(args):
    """
    Aggiorna info rivale.
    Sintassi Lua: cmdchat("HunterRivalUpdate Name|Points")
    """
    try:
        parts = args.split("|")
        name = parts[0].replace("+", " ")
        points = int(parts[1])
        wnd = _GetWindow()
        if wnd:
            wnd.UpdateRival(name, points)
    except:
        pass

def HunterWhatIf(args):
    """
    Apre finestra scelta.
    Sintassi Lua: cmdchat("HunterWhatIf ID|Text|Opt1|Opt2|Opt3|Color")
    """
    try:
        parts = args.split("|")
        if len(parts) < 5: return # Minimo: ID, Text, O1, O2, O3, Color (Text può essere spezzato)
        
        # Parsing dal fondo per gestire i pipe nel testo
        # Struttura fissa finale: ... | Opt1 | Opt2 | Opt3 | Color
        
        colorCode = parts[-1].strip()
        # Se l'ultimo non è un colore valido, fallback (ma dovrebbe esserlo)
        if colorCode not in ["GREEN", "BLUE", "ORANGE", "RED", "GOLD", "PURPLE", "BLACKWHITE"]:
            colorCode = "PURPLE"
            
        o3 = parts[-2].replace("+", " ")
        o2 = parts[-3].replace("+", " ")
        o1 = parts[-4].replace("+", " ")
        
        qid = parts[0]
        
        # Tutto quello che c'è tra ID e Opt1 è il testo
        text_parts = parts[1:-4]
        text = "|".join(text_parts).replace("+", " ")
        
        wnd = _GetWindow()
        if wnd:
            wnd.OpenWhatIf(qid, text, o1, o2, o3, colorCode)
    except:
        import dbg
        dbg.TraceError("HunterWhatIf Error: " + str(args))

# ============================================================
# BASE SYSTEM COMMANDS (Standard)
# ============================================================

def HunterOpenWindow(args):
    wnd = _GetWindow()
    if wnd: wnd.Open()

def HunterPlayerData(args):
    # Format: name|total|spend|daily|weekly|tot_k|day_k|week_k|streak|bonus|frac|chest|metin|p_day|p_week|d_pos|w_pos
    wnd = _GetWindow()
    if not wnd: return
    try:
        p = args.split("|")
        if len(p) >= 15:
            d = {
                "name": p[0].replace("+", " "), "total_points": int(p[1]), "spendable_points": int(p[2]),
                "daily_points": int(p[3]), "weekly_points": int(p[4]), "total_kills": int(p[5]),
                "daily_kills": int(p[6]), "weekly_kills": int(p[7]), "login_streak": int(p[8]),
                "streak_bonus": int(p[9]), "total_fractures": int(p[10]), "total_chests": int(p[11]),
                "total_metins": int(p[12]), "pending_daily_reward": int(p[13]), "pending_weekly_reward": int(p[14]),
            }
            if len(p) >= 17:
                d["daily_pos"] = int(p[15])
                d["weekly_pos"] = int(p[16])
            wnd.SetPlayerData(d)
    except: pass

def HunterRankingDaily(args): _ParseRanking("daily", args)
def HunterRankingWeekly(args): _ParseRanking("weekly", args)
def HunterRankingTotal(args): _ParseRanking("total", args)
def HunterRankingDailyKills(args): _ParseRankingSimple("daily_kills", args)
def HunterRankingWeeklyKills(args): _ParseRankingSimple("weekly_kills", args)
def HunterRankingTotalKills(args): _ParseRankingSimple("total_kills", args)
def HunterRankingFractures(args): _ParseRankingSimple("fractures", args)
def HunterRankingChests(args): _ParseRankingSimple("chests", args)

def _ParseRanking(rt, args):
    wnd = _GetWindow()
    if not wnd: return
    if args == "EMPTY" or not args: wnd.SetRankingData(rt, []); return
    try:
        d = []
        for e in args.split(";"):
            if e:
                p = e.split(",")
                if len(p) >= 3: d.append({"name": p[0].replace("+", " "), "points": int(p[1]), "value": int(p[1]), "kills": int(p[2])})
        wnd.SetRankingData(rt, d)
    except: pass

def _ParseRankingSimple(rt, args):
    wnd = _GetWindow()
    if not wnd: return
    if args == "EMPTY" or not args: wnd.SetRankingData(rt, []); return
    try:
        d = []
        for e in args.split(";"):
            if e:
                p = e.split(",")
                if len(p) >= 2: d.append({"name": p[0].replace("+", " "), "value": int(p[1]), "points": int(p[1])})
        wnd.SetRankingData(rt, d)
    except: pass

def HunterShopItems(args):
    wnd = _GetWindow()
    if not wnd: return
    if args == "EMPTY" or not args: wnd.SetShopItems([]); return
    try:
        d = []
        for e in args.split(";"):
            if e:
                p = e.split(",")
                if len(p) >= 5: d.append({"id": int(p[0]), "vnum": int(p[1]), "count": int(p[2]), "price": int(p[3]), "name": p[4].replace("+", " ")})
        wnd.SetShopItems(d)
    except: pass

def HunterAchievements(args):
    wnd = _GetWindow()
    if not wnd: return
    if args == "EMPTY" or not args: wnd.SetAchievements([]); return
    try:
        d = []
        for e in args.split(";"):
            if e:
                p = e.split(",")
                if len(p) >= 7: d.append({"id": int(p[0]), "name": p[1].replace("+", " "), "type": int(p[2]), "requirement": int(p[3]), "progress": int(p[4]), "unlocked": int(p[5])==1, "claimed": int(p[6])==1})
        wnd.SetAchievements(d)
    except: pass

def HunterCalendar(args):
    wnd = _GetWindow()
    if not wnd: return
    if args == "EMPTY" or not args: wnd.SetCalendarEvents([]); return
    try:
        d = []
        for e in args.split(";"):
            if e:
                p = e.split(",")
                if len(p) >= 4: d.append({"day_index": int(p[0]), "event_name": p[1].replace("+", " "), "start_hour": int(p[2]), "end_hour": int(p[3])})
        wnd.SetCalendarEvents(d)
    except: pass

def HunterTimers(args):
    wnd = _GetWindow()
    try:
        p = args.split("|")
        if len(p) >= 2: wnd.SetTimers(int(p[0]), int(p[1]))
    except: pass

def HunterActiveEvent(args):
    wnd = _GetWindow()
    try:
        if args == "NONE" or not args: wnd.SetActiveEvent(None, "")
        else:
            p = args.split("|")
            wnd.SetActiveEvent(p[0].replace("+", " "), p[1].replace("+", " ") if len(p)>1 else "")
    except: pass

def HunterFractures(args): pass # Placeholder