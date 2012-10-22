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

hero = {}
hero.pic = love.graphics.newImage("images/actor.png")
pic = love.graphics.newImage("images/circle.png")
arrow = love.graphics.newImage("images/arrow.png")
hero.x = 200
hero.y = 200
hero.dt = 250
hero.dir = "down"
hero.arrow = {}
hero.arrow.x = -15
hero.arrow.y = -15
hero.arrow.dir = "up"

a = {}
a.one = Entities:new(250, 150)
a.two = Entities:new(100, 100)
a.three = Entities:new(500, 200)

end

function draw_character()
   --love.graphics.draw(pic, a.x, a.y)
   for i,item in pairs(a) do
		item:draw()
   end
   --a:draw()
   love.graphics.draw(hero.pic, hero.x, hero.y)
   if hero.arrow.x > 0 then
		love.graphics.draw(arrow, hero.arrow.x, hero.arrow.y)
   end
end

function draw_debug()
	love.graphics.print("X: " .. hero.x + Levels.get_map_x_pos(), 40, 35)
	love.graphics.print("Y: " .. hero.y + Levels.get_map_y_pos(), 40, 55)
	love.graphics.print(Menu.active_panel, 40, 75)
	love.graphics.print("FPS: " .. love.timer.getFPS( ), 40, 95)
	--love.graphics.print(button, 40, 115)
	--love.graphics.print(axes, 40, 135)
	--love.graphics.print("axis: "..love.joystick.getHat(1, 1), 40, 155)
end

function get_character_x_pos()
	local x = hero.x + Levels.get_map_x_pos() + 20
	return x
end

function get_character_y_pos()
	local y = hero.y + Levels.get_map_y_pos() + 20
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
		if hero.arrow.x > -20 and hero.arrow.y > -20 and hero.arrow.x < 780 and hero.arrow.y < 580 then
			if hero.arrow.dir == "up" then
				hero.arrow.y = hero.arrow.y - 350 * dt
			elseif hero.arrow.dir == "down" then
				hero.arrow.y = hero.arrow.y + 350 * dt
			elseif hero.arrow.dir == "left" then
				hero.arrow.x = hero.arrow.x - 350 * dt
			elseif hero.arrow.dir == "right" then
				hero.arrow.x = hero.arrow.x + 350 * dt
			else
				hero.arrow.x = 0
				hero.arrow.y = 0
			end
		else
			hero.arrow.x = -15
			hero.arrow.y = -15
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
		if hero.arrow.x < 0 and hero.arrow.y < 0 then
			hero.arrow.x = hero.x
			hero.arrow.y = hero.y
			hero.arrow.dir = hero.dir
		end
	elseif key == "f3" then
		if show_debug == false then
			show_debug = true
		else
			show_debug = false
		end
	end
end
