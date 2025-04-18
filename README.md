# BalatroResetHotkey
 A hotkey for quicker resetting in Balatro, supports single deck resets and full collection resets

# Installation
* Download Autohotkey v2.0 or later from this link https://www.autohotkey.com
* Download the [latest release](https://github.com/EvilPancake123/BalatroResetHotkey/releases/latest)

# Customization and settings
The AHK script has various settings that can be tweaked for the best perfomance. To see these settings right click the hotkey script and select "edit script", using notepad for this will work fine. These settings are:
* resetHotkey - the hotkey that will be used when resetting. Default value is "u". A list of all keys can be found [here](https://www.autohotkey.com/docs/v2/KeyList.htm)
* firstDeckResetHotkey - only used in mode 3, the hotkey that will be used when resetting from any deck to the desired starting deck in multi deck runs.
* sleepTime - the amount of time to wait in milliseconds before moving the mouse when resetting single deck, increase if restting is inconsistent. Default value is 150.
* moveInputDelay - the amount of time to wait in milliseconds between moving the mouse and clicking the mouse button, lower values means more inconsistent resets. Default value is 5.
* gameWidth - the width of the game window, if the game is in fullscreen this should be "A_ScreenWidth"
* gameHeight - the height of the game window, if the game is in fullscreen this should be "A_ScreenHeight"
* mode - which mode of the autoresetter to use. 1 is for single deck resetting, 2 is for full collection resetting. Be wary when using mode 2 as it can reset your main profile.
* returnMousePosition - only for single deck resets, whether the hotkey should return the mouse to it's previous position after resetting. If this is set to false the mouse will be at the "new run" position after each reset.
* countResets - whether the hotkey should create and update a text file to keep track of how many times you have reset. The textfile location will be in the same folder as the reset script.

The following settings are only for full collection resetting:
* menuSleepTime - the amount of time to wait in milliseconds before moving the mouse after hitting "main menu", increase if getting to the profile screen is inconsistent. Default value is 3800.
* resetSleepTime - the amount of time to wait in milliseconds before hitting the "Reset Profile" button for the second time, increase if the collection is getting reset inconsistently. Default value is 420.
* reloadSleepTime - the amount of time to wait in milliseconds before moving the mouse to the "new run" position after resetting the collection, increase if starting a new run is incosistent. Default value is 2300
* startNewRun - whether the hotkey should start a new run after resetting the collection. If false you will be on the main menu after resetting the collection.

The remaining settings are all for multi deck resetting:
* deckNumber - which deck number in the deck order to use first, 1 is for red deck, 2 is for blue deck etc.
* deckArrowSleepTime - the amount of time to wait in milliseconds between each click of the arrow when switching decks in the collection. Default value is 100
