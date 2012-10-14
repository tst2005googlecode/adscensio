-- require
require('levels')
require('menu')
require('entities')

function love.load()
-- tiles
tile = {}
for i=0,3 do -- change 3 to the number of tile images minus 1.
  tile[i] = love.graphics.newImage( "images/tile"..i..".png" )
end

joysticks = love.joystick.getNumJoysticks()
love.joystick.open(1)
button = love.joystick.getNumButtons(1)
axes = love.joystick.getNumAxes(1)

game_start = false
Menu.load()

hero = {}
hero.pic = love.graphics.newImage("images/actor_up.gif")
hero.x = 200
hero.y = 200
hero.dt = 250
hero.dir = "down"

end

function draw_character()
   love.graphics.draw(hero.pic, Entities.x, Entities.y)
   love.graphics.draw(hero.pic, hero.x, hero.y)
end

function draw_character_position()
	love.graphics.print(hero.x + Levels.get_map_x_pos(), 40, 35)
	love.graphics.print(hero.y + Levels.get_map_y_pos(), 40, 55)
	love.graphics.print(Menu.active_panel, 40, 75)
	love.graphics.print(joysticks, 40, 95)
	love.graphics.print(button, 40, 115)
	love.graphics.print(axes, 40, 135)
	love.graphics.print("axis: "..love.joystick.getHat(1, 1), 40, 155)
end

function get_character_x_pos()
	local x = hero.x + Levels.get_map_x_pos()
	return x
end

function get_character_y_pos()
	local y = hero.y + Levels.get_map_y_pos()
	return y
end

function resolve_collision(dir, x, y)
	if hero.x > x and dir == "left" then
		hero.x = x + 40
	elseif x > hero.x and dir == "right" then
		hero.x = x - 40
	elseif hero.y > y and dir == "up" then
		hero.y = y + 40
	elseif y > hero.y and dir == "down" then
		hero.y = y - 40
	end
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
		draw_character_position()
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
		if love.keyboard.isDown("down") or love.joystick.getHat(1, 1) == "d" or love.joystick.getHat(1, 1) == "ld" or love.joystick.getHat(1, 1) == "rd" then 
			if get_character_y_pos() < (Levels.map_h - 1) * 40 then
				hero.dir = "down"
				if hero.y < 400 then
				   hero.y = hero.y + hero.dt * dt
				else
				   Levels.changeOffset("down", dt * hero.dt)
				   Entities.y = Entities.y - hero.dt * dt
				end
				if Entities.check_collision(hero.x, hero.y) then
					resolve_collision(hero.dir, Entities.x, Entities.y)
				end
			end
		end
		if love.keyboard.isDown("up") or love.joystick.getHat(1, 1) == "u" or love.joystick.getHat(1, 1) == "lu" or love.joystick.getHat(1, 1) == "ru" then 
			if get_character_y_pos() > 0 then
				hero.dir = "up"
				if hero.y > 150 then
				   hero.y = hero.y - hero.dt * dt
				else
				   Levels.changeOffset("up", dt * hero.dt)
				   Entities.y = Entities.y + hero.dt * dt
				end
				if Entities.check_collision(hero.x, hero.y) then
					resolve_collision(hero.dir, Entities.x, Entities.y)
				end
			end
		end
		if love.keyboard.isDown("right") or love.joystick.getHat(1, 1) == "r" or love.joystick.getHat(1, 1) == "ru" or love.joystick.getHat(1, 1) == "rd" then
			if get_character_x_pos() < (Levels.map_w - 1) * 40 then
				hero.dir = "right"
				if hero.x < 600 then
				   hero.x = hero.x + hero.dt * dt
				else
				   Levels.changeOffset("right", dt * hero.dt)
				   Entities.x = Entities.x - hero.dt * dt
				end
				if Entities.check_collision(hero.x, hero.y) then
					--hero.x = hero.x - hero.dt * dt
					resolve_collision(hero.dir, Entities.x, Entities.y)
				end
			end
		end
		if love.keyboard.isDown("left") or love.joystick.getHat(1, 1) == "l" or love.joystick.getHat(1, 1) == "lu" or love.joystick.getHat(1, 1) == "ld" then 
			if get_character_x_pos() > 0 then
				hero.dir = "left"
				if hero.x > 150 then
				   hero.x = hero.x - hero.dt * dt
				else
				   Levels.changeOffset("left", dt * hero.dt)
				   Entities.x = Entities.x + hero.dt * dt
				end
				if Entities.check_collision(hero.x, hero.y) then
					--hero.x = hero.x + hero.dt * dt
					resolve_collision(hero.dir, Entities.x, Entities.y)
				end
			end
		end
		Levels.update()
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
	end
end
