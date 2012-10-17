-- This file handles all game menus including the main menu and in game menu
Menu = {}

Menu.active_panel = "main"
Menu.state = 0
Menu.count = 0.75

function Menu.load()
	Menu.title_font = love.graphics.newFont(36)
	Menu.menu_font = love.graphics.newFont(20)
end

function Menu.update_main(dt)
	Menu.count = Menu.count + dt
	if Menu.count > 1.2 then
		Menu.count = 0
	end
end
-- Game Menu
function Menu.draw()
	if Menu.active_panel == "main" then
		love.graphics.setFont(Menu.title_font)
		love.graphics.print("Title", 350, 100)
		love.graphics.setFont(Menu.menu_font)
		if Menu.count > 0.6 then
			love.graphics.print("Press Enter!", 330, 300)
		end
	elseif Menu.active_panel == "default" then
		love.graphics.setFont(Menu.menu_font)
		love.graphics.setColor(0, 0, 0, 140)
		love.graphics.rectangle("fill", 0, 0, 800, 600)
		love.graphics.setColor(0, 0, 0)
		love.graphics.rectangle("fill", 50, 50, 700, 500)
		love.graphics.setColor(255, 255, 255)
		love.graphics.print("Menu", 350, 75)
	elseif Menu.active_panel == "controls" then
		love.graphics.setFont(Menu.menu_font)
		love.graphics.setColor(0, 0, 0, 140)
		love.graphics.rectangle("fill", 0, 0, 800, 600)
		love.graphics.setColor(0, 0, 0)
		love.graphics.rectangle("fill", 50, 50, 700, 500)
		love.graphics.setColor(255, 255, 255)
		love.graphics.print("Controls", 350, 75)
		love.graphics.print("Arrow Keys to move", 200, 150)
	elseif Menu.active_panel == "exit" then
		love.graphics.setFont(Menu.menu_font)
		love.graphics.setColor(0, 0, 0, 140)
		love.graphics.rectangle("fill", 0, 0, 800, 600)
		love.graphics.setColor(0, 0, 0)
		love.graphics.rectangle("fill", 275, 200, 250, 150)
		love.graphics.setColor(255, 255, 255)
		love.graphics.print("Are you sure?", 325, 230)
		if Menu.state == 0 then
			love.graphics.setColor(100, 255, 100)
			love.graphics.print("Yes", 350, 270)
			love.graphics.setColor(255, 255, 255)
			love.graphics.print("No", 425, 270)
		else
			love.graphics.setColor(255, 255, 255)
			love.graphics.print("Yes", 350, 270)
			love.graphics.setColor(100, 255, 100)
			love.graphics.print("No", 425, 270)
			love.graphics.setColor(255, 255, 255)
		end
	end
end

function Menu.toggle()
	if Menu.active_panel == "none" then
		Menu.active_panel = "default"
	else
		Menu.active_panel = "none"
		Menu.state = 0
	end
end

function Menu.keys(key)
	if key == "escape" then
		if Menu.active_panel == "exit" then
			Menu.active_panel = "none"
		elseif Menu.active_panel == "main" then
			love.event.push("quit")
		else
			Menu.toggle()
		end
	elseif key == "left" then
		if Menu.active_panel == "exit" then
			if Menu.state == 0 then
				Menu.state = 1
			else
				Menu.state = 0
			end
		elseif Menu.active_panel == "default" then
			Menu.active_panel = "controls"
		end
	elseif key == "right" then
		if Menu.active_panel == "exit" then
			if Menu.state == 0 then
				Menu.state = 1
			else
				Menu.state = 0
			end
		elseif Menu.active_panel == "controls" then
			Menu.active_panel = "default"
		end
	elseif key == "return" then
		if Menu.active_panel == "exit" and Menu.state == 0 then
			love.event.push("quit")
		else 
			Menu.toggle()
		end
	end
end