#A description of the overall design of the game code

# Design #

Currently the project is split into five files.

# Files #

## main.lua ##
This file is the main loop for the game that contains all the Love2D callbacks. This file should manage the overall state of the game and coordinate the interactions of the other files. Currently this file is in need of clean up. One area being the player code that needs to be moved to player.lua.

## levels.lua ##
The overall goal of this file will be to load all the levels of the game. At the moment only one area is made, however in time more areas will be created that can be transitioned between each other. It may be possible that so many areas would exist that another layer of code will be needed called zones that would organize the all of the worlds maps into smaller sections.

Right now the maps are tilemaps and hard coded. A more suitable option will be needed in the future whether that be storing the map data into a custom file or creating a map editor to auto-generate the maps into Lua.

## enitities.lua ##
Contains the data for NPCs and creatures (or at least will). This file contains the Entities object that is used for instances.

## player.lua ##
Code in this file is used to manage the actions of the player controlled character. This file is very sparse and needs to have some code from main.lua moved into it.

## menu.lua ##
The game menus and splash screen are coded here.

---
### Considerations ###
  * A utility library to handle common functions such as collisions and game state