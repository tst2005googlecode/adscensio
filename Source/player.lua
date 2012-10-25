
function player_movement(dt)
	local offset = false
	if love.keyboard.isDown("down") or love.joystick.getHat(1, 1) == "d" or love.joystick.getHat(1, 1) == "ld" or love.joystick.getHat(1, 1) == "rd" then 
		if get_character_y_pos() < (Levels.map_h - 1) * 40 and hero.collide ~= "down" then
			hero.dir = "down"
			if hero.y < 400 then
				hero.y = hero.y + hero.dt * dt
			else
				offset = true
			end
		end
	elseif love.keyboard.isDown("up") or love.joystick.getHat(1, 1) == "u" or love.joystick.getHat(1, 1) == "lu" or love.joystick.getHat(1, 1) == "ru" then 
		if get_character_y_pos() > 0 and hero.collide ~= "up" then
			hero.dir = "up"
			if hero.y > 200 then
				hero.y = hero.y - hero.dt * dt
			else
				offset = true
			end
		end
	elseif love.keyboard.isDown("right") or love.joystick.getHat(1, 1) == "r" or love.joystick.getHat(1, 1) == "ru" or love.joystick.getHat(1, 1) == "rd" then
		if get_character_x_pos() < (Levels.map_w - 1) * 40 and hero.collide ~= "right" then
			hero.dir = "right"
			if hero.x < 600 then
				hero.x = hero.x + hero.dt * dt
			else
				offset = true
			end
		end
	elseif love.keyboard.isDown("left") or love.joystick.getHat(1, 1) == "l" or love.joystick.getHat(1, 1) == "lu" or love.joystick.getHat(1, 1) == "ld" then 
		if get_character_x_pos() > 0 and hero.collide ~= "left" then
			hero.dir = "left"
			if hero.x > 200 then
				hero.x = hero.x - hero.dt * dt
			else
				offset = true
			end
		end
	else
		hero.dir = "none"
	end
	--col = false
	--collision for entities
	for i,item in pairs(a) do
		if item:check_collision("circle", hero.x, hero.y) then
			resolve_collision((hero.dt * dt), hero.dir, item.x, item.y)
			--col = true
		end
	end
	--collision for map
	for y=1, Levels.map_display_h do
        for x=1, Levels.map_display_w do
			if Levels.map[y+Levels.map_y][x+Levels.map_x] == 0 or Levels.map[y+Levels.map_y][x+Levels.map_x] == 2 then
				if hero.x < (x*Levels.tile_w)+Levels.map_offset_x + 40 and hero.x + 40 > (x*Levels.tile_w)+Levels.map_offset_x and hero.y < (y*Levels.tile_h)+Levels.map_offset_y + 40 and hero.y + 40 > (y*Levels.tile_h)+Levels.map_offset_y then
					resolve_collision((hero.dt * dt), hero.dir, (x*Levels.tile_w)+Levels.map_offset_x, (y*Levels.tile_h)+Levels.map_offset_y)
					--col = true
				end
			end
		end
	end


	if col == false then
		hero.collide = "none"
	end
	if offset == true then
		Levels.changeOffset(hero.dir, hero.dt * dt)
		for i,item in pairs(a) do
			item:update(hero.dir, hero.dt * dt)
		end
	end
	offset = false
end