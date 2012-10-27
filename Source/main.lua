-- require
require('levels')
require('menu')
require('entities')
require('player')

function love.load()
-- tiles
Levels.load_tiles()

joysticks = love.joystick.getNumJoysticks()
love.joystick.open(1)
button = love.joystick.getNumButtons(1)
axes = love.joystick.getNumAxes(1)

game_start = false
show_debug = false
Menu.load()

-- TODO: hero needs to be removed and replaced with a player object
player.load()
pic = love.graphics.newImage("images/circle.png")
arrow = love.graphics.newImage("images/arrow.png")

a = {}
a.one = Entities:new(270, 150)
a.two = Entities:new(120, 100)
a.three = Entities:new(220, 570)

end

function draw_character()
   for i,item in pairs(a) do
		item:draw()
   end
   love.graphics.draw(player.pic, player.x, player.y, 0, 1, 1, 20, 20)
   if player.arrow.x > 0 then
		love.graphics.draw(arrow, player.arrow.x, player.arrow.y)
   end
end

function draw_debug()
	love.graphics.print("X: " .. player.x + Levels.get_map_x_pos(), 40, 35)
	love.graphics.print("Y: " .. player.y + Levels.get_map_y_pos(), 40, 55)
	love.graphics.print(Menu.active_panel, 40, 75)
	love.graphics.print("FPS: " .. love.timer.getFPS( ), 40, 95)
	love.graphics.print(a.one.x, 40, 115)
	love.graphics.print(a.one.y, 40, 135)
end

function get_character_x_pos()
	local x = player.x + Levels.get_map_x_pos()
	return x
end

function get_character_y_pos()
	local y = player.y + Levels.get_map_y_pos()
	return y
end

function resolve_collision(dt, dir, x, y)
	local xc = player.x - x
	local yc = player.y - y
	if player.x > x and dir == "left" then
		player.x = player.x + dt
		player.collide = dir
	elseif x > player.x and dir == "right" then
		player.x = player.x - dt
		player.collide = dir
	elseif player.y > y and dir == "up" then
		player.y = player.y + dt
		player.collide = dir
	elseif y > player.y and dir == "down" then
		player.y = player.y - dt
		player.collide = dir
	else
		player.collide = "none"
	end
	--[[ TODO: this needs to be cleaned up
	if hero.x > x and dir == "left" and hero.y + 30 < y then
		hero.x = x + 40
		hero.y = y - 40
	elseif hero.x > x and dir == "left" and hero.y - 30 > y then
		hero.x = x + 40
		hero.y = y + 40
	elseif x > hero.x and dir == "right" and hero.y + 30 < y then
		hero.x = x - 40
		hero.y = y - 40
	elseif x > hero.x and dir == "right" and hero.y - 30 > y then
		hero.x = x - 40
		hero.y = y + 40
	elseif hero.y > y and dir == "up" and hero.x + 30 < x then
		hero.x = x - 40
	elseif hero.y > y and dir == "up" and hero.x - 30 > x then
		hero.x = x + 40
	elseif y > hero.y and dir == "down" and hero.x + 30 < x then
		hero.x = x - 40
	elseif y > hero.y and dir == "down" and hero.x - 30 > x then
		hero.x = x + 40
	end]]
end

function love.draw()
	if game_start == false then
		Menu.draw()
	elseif game_start == true then
		Levels.draw_map()
		draw_character()
		
		if Menu.active_panel ~=  "none" then
			Menu.draw()
		end
		if show_debug then
			draw_debug()
		end
	end
end

function love.update(dt)
	if game_start == false then
		if love.keyboard.isDown("return") then
			game_start = true
			Menu.active_panel = "none"
		end
		Menu.update_main(dt)
	elseif game_start == true and Menu.active_panel == "none" then
		-- get input for directional movement
		player_movement(dt)
		Levels.update()
		-- TODO: this next section needs to be moved to player.lua
		if player.arrow.x > -20 and player.arrow.y > -20 and player.arrow.x < 780 and player.arrow.y < 580 then
			if player.arrow.dir == "up" then
				player.arrow.y = player.arrow.y - 350 * dt
			elseif player.arrow.dir == "down" then
				player.arrow.y = player.arrow.y + 350 * dt
			elseif player.arrow.dir == "left" then
				player.arrow.x = player.arrow.x - 350 * dt
			elseif player.arrow.dir == "right" then
				player.arrow.x = player.arrow.x + 350 * dt
			else
				player.arrow.x = 0
				player.arrow.y = 0
			end
		else
			player.arrow.x = -15
			player.arrow.y = -15
		end
	end
end 

function love.keypressed(key)
	if key == " " then
		Menu.toggle()
	end
	if Menu.active_panel ~= "none" then
		Menu.keys(key)
	elseif key == "escape" then
		if game_start == true and Menu.active_panel == "none" then
			Menu.active_panel = "exit"
		end
	elseif key == "1" then
		if player.arrow.x < 0 and player.arrow.y < 0 then
			player.arrow.x = player.x
			player.arrow.y = player.y
			player.arrow.dir = player.dir
		end
	elseif key == "f3" then
		if show_debug == false then
			show_debug = true
		else
			show_debug = false
		end
	end
end
