local flux = require "lib/Flux"

Card = {}
Card.__index = Card


function Card.new(x, y)
	local self = setmetatable({}, Card)
	self.x = x or 0
    self.y = y or 0
    self.sx = 1
    self.w = 100
    self.h = 140
    self.flipped = false
    self.state = nil
    return self
end

function Card:inSide(x, y)
	return (x >= self.x and x <= self.x + self.w and 
	y >= self.y and y <= self.y + self.h)
end

function Card:flip()
	if self.state == "flipping" then return end

	self.state = "flipping"
	flux.to(self, 1, {sx = 0})
		:ease("quadout")
		:oncomplete(function()
				self.fliped = not self.fliped
			end)
		:after(self, 1, {sx = -1})
		:ease("quadin")	
		:oncomplete(function()
			self.state = nil
		end)
end

function Card:update(dt)
	flux.update(dt)
end

function Card:draw()
	love.graphics.push()
	love.graphics.translate(self.x + self.w/2, self.y + self.h/2)
	love.graphics.scale(self.sx, 1)

	if self.fliped then
		love.graphics.setColor(1, 0, 0)
	else
		love.graphics.setColor(0, 0, 1)
	end

	love.graphics.rectangle("fill", -self.w/2, -self.h/2, self.w, self.h, 20, 20)
	love.graphics.setColor(1, 1, 1)
	love.graphics.pop()
end

return Card