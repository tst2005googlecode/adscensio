-- require
require('levels')

function love.load()
-- tiles
tile = {}
for i=0,3 do -- change 3 to the number of tile images minus 1.
  tile[i] = love.graphics.newImage( "images/tile"..i..".png" )
end
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
   love.graphics.print(hero.x + Levels.get_map_x_pos(), 40, 40)
   love.graphics.print(hero.y + Levels.get_map_y_pos(), 40, 55)
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
  Levels.draw_map()
  draw_character()
  draw_character_position()
end

function love.update( dt )
    -- get input
    if love.keyboard.isDown( "down" ) and get_character_y_pos() < (Levels.map_h - 1) * 40 then
        --map_offset_y = map_offset_y - move_speed * dt
		if hero.y < 400 then
		   hero.y = hero.y + hero.dt * dt
		else
		   Levels.map_offset_y = Levels.map_offset_y - hero.dt * dt
		end
    end
    if love.keyboard.isDown( "up" ) and get_character_y_pos() > 0 then
        --map_offset_y = map_offset_y + move_speed * dt
		if hero.y > 150 then
		   hero.y = hero.y - hero.dt * dt
		else
		   Levels.map_offset_y = Levels.map_offset_y + hero.dt * dt
		end
    end
    if love.keyboard.isDown( "right" ) and get_character_x_pos() < (Levels.map_w - 1) * 40 then
        --map_offset_x = map_offset_x - move_speed * dt
		if hero.x < 600 then
		   hero.x = hero.x + hero.dt * dt
		else
	       Levels.changeOffset("right", dt * hero.dt)
		end
    end
    if love.keyboard.isDown( "left" ) and get_character_x_pos() > 0 then
        --map_offset_x = map_offset_x + move_speed * dt
		if hero.x > 150 then
		   hero.x = hero.x - hero.dt * dt
		else
		   Levels.changeOffset("left", dt * hero.dt)
		end
    end
	Levels.update()
	if love.keyboard.isDown( "escape" ) then
        love.event.push( "q" )
    end
end 
