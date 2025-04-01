#Requires AutoHotkey v2.0-a

;******HOTKEYS******
resetHotkey := "u" ;The default reset hotkey
firstDeckResetHotkey := "t" ;The hotkey used when resetting to the first deck in multi deck runs

;******SETTINGS******
sleepTime := 150 ;How long to wait before mouse inputs, longer times means more consistent but slower resets, default: 150
moveInputDelay := 5 ;How long to wait between moving the mouse and clicking left mouse button, default: 5
gameWidth := A_ScreenWidth ;The width of the game, use "A_ScreenWidth" if playing on fullscreen
gameHeight := A_ScreenHeight ;The height of the game, use "A_ScreenHeight" if playing on fullscreen
mode := 1 ;Which auto reset mode to use, 1 is single run resets, 2 is full collection resets for categories like all unlocks, 3 is for multi deck runs like 3 deck
returnMousePosition := true ;For single deck runs. Whether the hotkey should return the mouse to it's starting position after resetting, if false the mouse will be at the "New Run" position after resets
countResets := true ;Whether to automatically create and update a txt file to keep track of resets
spamDelay := 2800 ;The minimum amount of time to wait between resets, set to 2500 + the amount of milliseconds of reaction time you want if holding the hotkey. Default is 2800 (300 ms of reaction time)

;******COLLECTION RESET SETTINGS******
menuSleepTime := 3800 ;How long to wait before mouse inputs after going to the menu, dafault: 3800
resetSleepTime := 420 ;How long to wait before mouse inputs after hitting "Reset Profile" in the profile menu, default: 420
reloadSleepTime := 2300 ;How long to wait before mouse inputs when hitting "New Run" after resetting the profile, default: 2300
startNewRun := true ;Whether to automatically start a new run after resetting the collection

;******MULTI DECK SETTINGS******
deckNumber := 1 ;Which deck you want to start with after resetting to your first deck, 1 is red deck and 15 is erratic
deckArrowSleepTime := 100 ;How long to wait between clicking the arrow in the collection to change deck. Default is 100

;******SCRIPT (DO NOT ALTER)******
resetFileLocation := A_ScriptDir "\resets.txt"
resetting := false

SetTitleMatchMode 3
hotifWinActive("Balatro")
Hotkey resetHotkey, Reset
hotifWinActive("Balatro")
Hotkey firstDeckResetHotkey, Reset



Reset(hotkey)
{
    global resetting
    if resetting
    return
    resetting := true
    Switch mode
    {
        case 1: 
            NewRun
        case 2: 
            ResetCollection
        case 3: 
            if hotkey = firstDeckResetHotkey
            ResetMultiDeck
            else
            NewRun
        default: MsgBox "Invalid mode"
    }
    if countResets
    UpdateCounter
    sleep spamDelay
    resetting := false
    
}

NewRun()
{
    MouseGetPos &xpos, &ypos
    send "{esc}"
    DoMouseAction(1/2, 1/3, sleepTime)
    DoMouseAction(1/2, 7/9, sleepTime)
    if returnMousePosition
    MouseMove xpos, ypos
    
}

ResetCollection()
{
    send "{esc}"
    DoMouseAction(1/2, 4/9, sleepTime) 
    DoMouseAction(11/96, 8/9, menuSleepTime)
    DoMouseAction(61/96, 31/54, sleeptime)
    DoMouseAction(61/96, 31/54, resetSleepTime)
    if not startNewRun
    return
    DoMouseAction(7/24, 8/9, reloadSleepTime)
    DoMouseAction(1/2, 7/9, sleeptime)
}

ResetMultiDeck()
{
    send "{esc}"
    DoMouseAction(0.5, 0.6, sleepTime)
    DoMouseAction(0.38, 0.35, sleepTime)
    if deckNumber <= 7 and deckNumber > 1 {
        DoMouseAction(0.68, 0.46, sleepTime)
        for i in range(deckNumber-2)
        DoMouseAction(0.68, 0.46, deckArrowSleepTime)
    }
    if deckNumber > 7 {
        DoMouseAction(0.32, 0.46, sleepTime)
        if deckNumber < 15 {
            for i in range(15-deckNumber)
            DoMouseAction(0.32, 0.46, deckArrowSleepTime)
        }
    }
    else {
        DoMouseAction(0.32, 0.46, sleepTime)
        DoMouseAction(0.68, 0.46, deckArrowSleepTime)
    }
    sleep moveInputDelay
    send "{esc}"
    sleep sleepTime
    NewRun
}

DoMouseAction(xRatio, yRatio, time)
{
    sleep time
    MouseMove gameWidth*xRatio, gameHeight*yRatio
    sleep moveInputDelay
    send "{LButton}"
}

UpdateCounter()
{
    count := 0
    try count := FileRead(resetFileLocation)
    try FileDelete resetFileLocation
    FileAppend count + 1, resetFileLocation
}



range(a, b:=unset, c:=unset) {
   IsSet(b) ? '' : (b := a, a := 0)
   IsSet(c) ? '' : (a < b ? c := 1 : c := -1)

   pos := a < b && c > 0
   neg := a > b && c < 0
   if !(pos || neg)
      throw Error("Invalid range.")

   return (&n) => (
      n := a, a += c,
      (pos && n < b) OR (neg && n > b) 
   )
}