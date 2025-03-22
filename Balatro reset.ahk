#Requires AutoHotkey v2.0-a

;******HOTKEYS******
resetHotkey := "u" ;The reset hotkey

;******SETTINGS******
sleepTime := 150 ;How long to wait before mouse inputs, longer times means more consistent but slower resets, default: 150
moveInputDelay := 5 ;How long to wait between moving the mouse and clicking left mouse button, default: 5
gameWidth := A_ScreenWidth ;The width of the game, use "A_ScreenWidth" if playing on fullscreen
gameHeight := A_ScreenHeight ;The height of the game, use "A_ScreenHeight" if playing on fullscreen
mode := 1 ;Which auto reset mode to use, 1 is single run resets, 2 is full collection resets for categories like all unlocks
returnMousePosition := true ;For single deck runs. Whether the hotkey should return the mouse to it's starting position after resetting, if false the mouse will be at the "New Run" position after resets
countResets := true ;Whether to automatically create and update a txt file to keep track of resets

;******COLLECTION RESET SETTINGS******
menuSleepTime := 3800 ;How long to wait before mouse inputs after going to the menu, dafault: 3800
resetSleepTime := 420 ;How long to wait before mouse inputs after hitting "Reset Profile" in the profile menu, default: 420
reloadSleepTime := 2300 ;How long to wait before mouse inputs when hitting "New Run" after resetting the profile, default: 2300
startNewRun := true ;Whether to automatically start a new run after resetting the collection


;******SCRIPT (DO NOT ALTER)******
resetFileLocation := A_ScriptDir "\resets.txt"
SetTitleMatchMode 3
hotifWinActive("Balatro")
Hotkey resetHotkey, Reset

Reset(a)
{
    Switch mode
    {
        case 1: NewRun
        case 2: ResetCollection
        default: MsgBox "Invalid mode"
    }
    if countResets
     UpdateCounter
}

NewRun()
{
    MouseGetPos &xpos, &ypos
    send "{esc}"
    sleep sleeptime
    MouseMove gameWidth/2, gameHeight/3
    sleep moveInputDelay
    send "{LButton}"
    sleep sleeptime
    MouseMove gameWidth/2, gameHeight*7/9
    sleep moveInputDelay
    send "{LButton}"
    if returnMousePosition
    MouseMove xpos, ypos
    
}

ResetCollection()
{
    send "{esc}"
    sleep sleeptime
    MouseMove gameWidth/2, gameHeight*4/9
    sleep moveInputDelay
    send "{LButton}"
    sleep menuSleepTime
    MouseMove gameWidth*11/96, gameHeight*8/9
    sleep moveInputDelay
    send "{LButton}"
    sleep sleeptime
    MouseMove gameWidth*61/96, gameHeight*31/54
    sleep moveInputDelay
    send "{LButton}"
    sleep resetSleepTime
    send "{LButton}"
    if not startNewRun
    return
    sleep reloadSleepTime
    MouseMove gameWidth*7/24, gameHeight*8/9
    sleep moveInputDelay
    send "{LButton}"
    sleep sleeptime
    MouseMove gameWidth/2, gameHeight*7/9
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