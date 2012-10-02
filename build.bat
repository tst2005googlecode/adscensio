-- This batch script makes it easier to build the game
PATH=%~dp0
cd %PATH%Source
-- If you do not have 7-Zip then change the command for your preference
-- or just get it at www.7-zip.org
"C:\Program Files\7-Zip\7z.exe" a -tzip "%PATH%game.love" *
PAUSE