
function player_movement(dt)
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
end