
function player_movement(dt)
	local offset = false
	if love.keyboard.isDown("down") or love.joystick.getHat(1, 1) == "d" or love.joystick.getHat(1, 1) == "ld" or love.joystick.getHat(1, 1) == "rd" then 
		if get_character_y_pos() < (Levels.map_h - 1) * 40 then
			hero.dir = "down"
			if hero.y < 400 then
				hero.y = hero.y + hero.dt * dt
			else
				offset = true
			end
		end
	elseif love.keyboard.isDown("up") or love.joystick.getHat(1, 1) == "u" or love.joystick.getHat(1, 1) == "lu" or love.joystick.getHat(1, 1) == "ru" then 
		if get_character_y_pos() > 0 then
			hero.dir = "up"
			if hero.y > 150 then
				hero.y = hero.y - hero.dt * dt
			else
				offset = true
			end
		end
	elseif love.keyboard.isDown("right") or love.joystick.getHat(1, 1) == "r" or love.joystick.getHat(1, 1) == "ru" or love.joystick.getHat(1, 1) == "rd" then
		if get_character_x_pos() < (Levels.map_w - 1) * 40 then
			hero.dir = "right"
			if hero.x < 600 then
				hero.x = hero.x + hero.dt * dt
			else
				offset = true
			end
		end
	elseif love.keyboard.isDown("left") or love.joystick.getHat(1, 1) == "l" or love.joystick.getHat(1, 1) == "lu" or love.joystick.getHat(1, 1) == "ld" then 
		if get_character_x_pos() > 0 then
			hero.dir = "left"
			if hero.x > 150 then
				hero.x = hero.x - hero.dt * dt
			else
				offset = true
			end
		end
	else
		hero.dir = "none"
	end
	for i,item in pairs(a) do
		if item:check_collision(hero.x, hero.y) then
			resolve_collision(hero.dir, item.x, item.y)
		end
	end
	if offset == true then
		Levels.changeOffset(hero.dir, hero.dt * dt)
		for i,item in pairs(a) do
			item:update(hero.dir, hero.dt * dt)
		end
	end
	offset = false
end