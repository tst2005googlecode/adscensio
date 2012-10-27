function love.conf(t)
    t.modules.joystick = true 
    t.modules.audio = true 
    t.modules.keyboard = true 
    t.modules.event = true 
    t.modules.image = true 
    t.modules.graphics = true 
    t.modules.timer = true 
    t.modules.mouse = true 
    t.modules.sound = true 
	t.modules.thread = false
    t.modules.physics = false
    t.console = false           -- Attach a console (boolean, Windows only)
    t.title = "Adscensio"       -- The title of the window the game is in (string) 
    t.author = "Joel"           -- The author of the game (string)
	t.identity = "Adscensio"    -- The name of the save directory (string)
    t.screen.fullscreen = false -- Enable fullscreen (boolean)
    t.screen.vsync = true      -- Enable vertical sync (boolean)
    t.screen.fsaa = 0           -- The number of FSAA-buffers (number)
    t.screen.height = 600       -- The window height (number)
    t.screen.width = 800        -- The window width (number)
end