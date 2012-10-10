-- This file handles all game menus including the main menu and in game menu
Menu = {}

Menu.active_panel = "none"

function Menu.load()
	Menu.title_font = love.graphics.newFont(36)
	Menu.menu_font = love.graphics.newFont(20)
end

function Menu.draw_main()
	love.graphics.setFont(Menu.title_font)
	love.graphics.print("Title", 350, 100)
	love.graphics.setFont(Menu.menu_font)
	love.graphics.print("Start", 350, 275)
	love.graphics.print("Options", 350, 300)
end

function Menu.draw_game()
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", 50, 50, 700, 500)
	love.graphics.setColor(255, 255, 255)
	love.graphics.print("Menu", 350, 75)
end

function Menu.toggle()
	if Menu.active_panel == "none" then
		Menu.active_panel = "main"
	else
		Menu.active_panel = "none"
	end
end