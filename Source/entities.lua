
Entities = {}

Entities.x = 100
Entities.y = 100

function Entities.check_collision(x, y)
	result = false
	if x < Entities.x + 40 and x + 40 > Entities.x and y < Entities.y + 40 and y + 40 > Entities.y then
		result = true
	end
	return result
end
