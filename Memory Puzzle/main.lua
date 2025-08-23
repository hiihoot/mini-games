
local card = require "card"

local test = {
	card.new(230, 200, 1, 1),
	card.new(338, 200, 2, 1),
	card.new(446, 200, 3, 1)
}

function love.load()
end

function love.update(dt)
	for i = 1, #test do
		test[i]:update(dt)
	end
end

function love.mousepressed(x, y, button, istouch, presses)
	if button == 1 then
		for _,v in ipairs(test) do
			if v:inSide(x, y) then
				v:flip()
			end
		end
	end
end

function love.draw(dt)
	for i = 1, #test do
		test[i]:draw()
	end
	love.graphics.setBackgroundColor(1.0, 0.80, 0.796)
end