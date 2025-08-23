
local card = require "card"

local spacing = 20
local startX = 160
local startY = 60

local cards = {}

function newCard(n, y)
	for i = 1, n do
		local x = startX + (i-1) * (100 + spacing)
		local c = card:new(x, y, i, 1)
		table.insert(cards, c)
	end
end

function love.load()
	for i = 1, 3 do
		newCard(4, startY + (i-1) * (144 + spacing))
	end
end

function love.update(dt)
	for i = 1, #cards do
		cards[i]:update(dt)
	end
end

function love.mousepressed(x, y, button, istouch, presses)
	if button == 1 then
		for _,v in ipairs(cards) do
			if v:inSide(x, y) then
				v:flip()
			end
		end
	end
end

function love.draw(dt)
	for i = 1,  #cards do
		cards[i]:draw()
	end
	love.graphics.setBackgroundColor(1.0, 0.80, 0.796)
end