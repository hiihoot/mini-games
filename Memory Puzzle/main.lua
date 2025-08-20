
local flux = require "lib/Flux"


local card = {
	x = 340,
	y = 200,
	w = 100,
	h = 140,
	sx = 1,
	fliped = false
}

function love.load()
end

function love.update(dt)
	flux.update(dt)
end

function boundingBox(rect, x, y)
	return (x >= rect.x and x <= rect.x + rect.w and 
	y >= rect.y and y <= rect.y + rect.h)
end

function love.mousepressed(x, y, button, istouch, presses)
	if button == 1 then
		if boundingBox(card, x, y) then
			flux.to(card, 0.2, {sx = 0})
				:ease("quadout")
				:oncomplete(function()
					card.fliped = not card.fliped
				end)
				:after(card, 0.3, {sx = -1})
				:ease("quadin")			
		end
	end
end

function love.draw(dt)
	love.graphics.push()
	love.graphics.translate(card.x + card.w/2, card.y + card.h/2)
	love.graphics.scale(card.sx, 1)

	if card.fliped then
		love.graphics.setColor(1, 0, 0)
	else
		love.graphics.setColor(0, 0, 1)
	end

	love.graphics.rectangle("fill", -card.w/2, -card.h/2, card.w, card.h)
	love.graphics.setColor(1, 1, 1)
	love.graphics.pop()
end