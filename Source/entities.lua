
Entities = {}
Entities.x = 1
Entities.y = 1
Entities.pic = love.graphics.newImage("images/circle.png")

function Entities:new(x, y)
	newEntity = {}
	setmetatable(newEntity, self)
	self.__index = self
	newEntity.x = x
	newEntity.y = y
	return newEntity
end

function Entities:draw()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(self.pic, self.x, self.y)
end

function Entities:update(dir, del)
	if dir == "up" then
		self.y = self.y + del
	elseif dir == "down" then
		self.y = self.y - del
	elseif dir == "left" then
		self.x = self.x + del
	elseif dir == "right" then
		self.x = self.x - del
	end
end

function Entities:check_collision(x, y)
	result = false
	if x < self.x + 40 and x + 40 > self.x and y < self.y + 40 and y + 40 > self.y then
		result = true
	end
	return result
end
