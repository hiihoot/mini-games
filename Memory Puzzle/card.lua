local flux = require "lib/Flux"

Card = {}
Card.__index = Card


function Card:new(x, y, row, col)
	local self = setmetatable({}, Card)
	self.x = x or 0
    self.y = y or 0
    self.sx = -1
    self.w = 100
    self.h = 144
    self.col = col or 1
    self.row = row or 1
    self.flipped = false
    self.state = nil
    self.cards = love.graphics.newImage("assets/cards.png")
    self.quad = love.graphics.newQuad((self.row - 1) * self.w, (self.col - 1) * self.h, 
    	self.w, self.h, 
    	self.cards:getDimensions())
    return self
end

function Card:inSide(x, y)
	return (x >= self.x and x <= self.x + self.w and 
	y >= self.y and y <= self.y + self.h)
end

function Card:flip()
	if self.state == "flipping" then return end

	self.state = "flipping"
	flux.to(self, 0.6, {sx = 0})
		:ease("quadout")
		:oncomplete(function()
				self.fliped = not self.fliped
			end)
		:after(self, 0.6, {sx = 1})
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
		self.quad = love.graphics.newQuad((self.row - 1) * self.w, 
			(self.col - 1) * self.h, 
			self.w, self.h, 
			self.cards:getDimensions())
	else
		self.quad = love.graphics.newQuad((15-1) * self.w, (3-1) * self.h, self.w, self.h, self.cards:getDimensions())
	end

	love.graphics.draw(self.cards, self.quad, -self.w/2, -self.h/2)
	love.graphics.setColor(1, 1, 1)
	love.graphics.pop()
end

return Card