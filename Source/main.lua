-- require
require('levels')
require('menu')

function love.load()
-- tiles
tile = {}
for i=0,3 do -- change 3 to the number of tile images minus 1.
  tile[i] = love.graphics.newImage( "images/tile"..i..".png" )
end

game_start = false
Menu.load()

hero = {}
hero.pic = love.graphics.newImage("images/actor_up.gif")
hero.x = 200
hero.y = 200
hero.dt = 250

end

function draw_character()
   love.graphics.draw(hero.pic, hero.x, hero.y)
end

function draw_character_position()
   love.graphics.print(hero.x + Levels.get_map_x_pos(), 40, 35)
   love.graphics.print(hero.y + Levels.get_map_y_pos(), 40, 55)
   love.graphics.print(Menu.active_panel, 40, 75)
end

function get_character_x_pos()
	local x = hero.x + Levels.get_map_x_pos()
	return x
end

function get_character_y_pos()
	local y = hero.y + Levels.get_map_y_pos()
	return y
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
		if love.keyboard.isDown("down") and get_character_y_pos() < (Levels.map_h - 1) * 40 then
			if hero.y < 400 then
			   hero.y = hero.y + hero.dt * dt
			else
			   Levels.map_offset_y = Levels.map_offset_y - hero.dt * dt
			end
		end
		if love.keyboard.isDown("up") and get_character_y_pos() > 0 then
			if hero.y > 150 then
			   hero.y = hero.y - hero.dt * dt
			else
			   Levels.map_offset_y = Levels.map_offset_y + hero.dt * dt
			end
		end
		if love.keyboard.isDown("right") and get_character_x_pos() < (Levels.map_w - 1) * 40 then
			if hero.x < 600 then
			   hero.x = hero.x + hero.dt * dt
			else
			   Levels.changeOffset("right", dt * hero.dt)
			end
		end
		if love.keyboard.isDown("left") and get_character_x_pos() > 0 then
			if hero.x > 150 then
			   hero.x = hero.x - hero.dt * dt
			else
			   Levels.changeOffset("left", dt * hero.dt)
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
