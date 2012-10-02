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
function love.draw()
  Levels:draw_map()
  draw_character()
end
function love.update( dt )
    -- get input
    if love.keyboard.isDown( "down" ) then
        --map_offset_y = map_offset_y - move_speed * dt
		if hero.y < 400 then
		   hero.y = hero.y + hero.dt * dt
		else
		   Levels.map_offset_y = Levels.map_offset_y - hero.dt * dt
		end
    end
    if love.keyboard.isDown( "up" ) then
        --map_offset_y = map_offset_y + move_speed * dt
		if hero.y > 150 then
		   hero.y = hero.y - hero.dt * dt
		else
		   Levels.map_offset_y = Levels.map_offset_y + hero.dt * dt
		end
    end
    if love.keyboard.isDown( "right" ) then
        --map_offset_x = map_offset_x - move_speed * dt
		if hero.x < 600 then
		   hero.x = hero.x + hero.dt * dt
		else
	       Levels.map_offset_x = Levels.map_offset_x - hero.dt * dt
		end
    end
    if love.keyboard.isDown( "left" ) then
        --map_offset_x = map_offset_x + move_speed * dt
		if hero.x > 150 then
		   hero.x = hero.x - hero.dt * dt
		else
		   Levels.map_offset_x = Levels.map_offset_x + hero.dt * dt
		end
    end
	if Levels.map_offset_x > -40 and Levels.map_x > 0 then
	   Levels.map_offset_x = Levels.map_offset_x - 40
	   Levels.map_x = Levels.map_x - 1
	elseif Levels.map_offset_x < -80 and Levels.map_x < Levels.map_w - Levels.map_display_w then
	   Levels.map_offset_x = Levels.map_offset_x + 40
	   Levels.map_x = Levels.map_x + 1
	end
	if Levels.map_offset_y > -40 and Levels.map_y > 0 then
	   Levels.map_offset_y = Levels.map_offset_y - 40
	   Levels.map_y = Levels.map_y - 1
	elseif Levels.map_offset_y < -80 and Levels.map_y < Levels.map_h - Levels.map_display_h then
	   Levels.map_offset_y = Levels.map_offset_y + 40
	   Levels.map_y = Levels.map_y + 1
	end
	if love.keyboard.isDown( "escape" ) then
        love.event.push( "q" )
    end
end 
