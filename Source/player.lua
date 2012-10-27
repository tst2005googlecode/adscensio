player = {}

function player.load()
	player.pic = love.graphics.newImage("images/wizzard.png")
	player.x = 200
	player.y = 300
	player.dt = 250
	player.dir = "down"
	player.collide = "none"
	player.arrow = {}
	player.arrow.x = -15
	player.arrow.y = -15
	player.arrow.dir = "up"
end

function player_movement(dt)
	local offset = false
	if love.keyboard.isDown("down") or love.joystick.getHat(1, 1) == "d" or love.joystick.getHat(1, 1) == "ld" or love.joystick.getHat(1, 1) == "rd" then 
		if get_character_y_pos() < (Levels.map_h - 1) * 40 and player.collide ~= "down" then
			player.dir = "down"
			if player.y < 400 then
				player.y = player.y + player.dt * dt
			else
				offset = true
			end
		end
	elseif love.keyboard.isDown("up") or love.joystick.getHat(1, 1) == "u" or love.joystick.getHat(1, 1) == "lu" or love.joystick.getHat(1, 1) == "ru" then 
		if get_character_y_pos() > 0 and player.collide ~= "up" then
			player.dir = "up"
			if player.y > 200 then
				player.y = player.y - player.dt * dt
			else
				offset = true
			end
		end
	elseif love.keyboard.isDown("right") or love.joystick.getHat(1, 1) == "r" or love.joystick.getHat(1, 1) == "ru" or love.joystick.getHat(1, 1) == "rd" then
		if get_character_x_pos() < (Levels.map_w - 1) * 40 and player.collide ~= "right" then
			player.dir = "right"
			if player.x < 600 then
				player.x = player.x + player.dt * dt
			else
				offset = true
			end
		end
	elseif love.keyboard.isDown("left") or love.joystick.getHat(1, 1) == "l" or love.joystick.getHat(1, 1) == "lu" or love.joystick.getHat(1, 1) == "ld" then 
		if get_character_x_pos() > 0 and player.collide ~= "left" then
			player.dir = "left"
			if player.x > 200 then
				player.x = player.x - player.dt * dt
			else
				offset = true
			end
		end
	else
		player.dir = "none"
	end
	--collision for entities
	for i,item in pairs(a) do
		if item:check_collision("circle", player.x, player.y) then
			resolve_collision((player.dt * dt), player.dir, item.x, item.y)
			player.collide = "none"
		end
	end
	--collision for map
	for y=1, Levels.map_display_h do
        for x=1, Levels.map_display_w do
			if Levels.map[y+Levels.map_y][x+Levels.map_x] == 0 or Levels.map[y+Levels.map_y][x+Levels.map_x] == 2 then
				if player.x < (x*Levels.tile_w)+Levels.map_offset_x + 40 and player.x + 40 > (x*Levels.tile_w)+Levels.map_offset_x and player.y < (y*Levels.tile_h)+Levels.map_offset_y + 40 and player.y + 40 > (y*Levels.tile_h)+Levels.map_offset_y then
					resolve_collision((player.dt * dt), player.dir, (x*Levels.tile_w)+Levels.map_offset_x, (y*Levels.tile_h)+Levels.map_offset_y)
					player.collide = "none"
				end
			end
		end
	end


	if col == false then
		player.collide = "none"
	end
	if offset == true then
		Levels.changeOffset(player.dir, player.dt * dt)
		for i,item in pairs(a) do
			item:update(player.dir, player.dt * dt)
		end
	end
	offset = false
end