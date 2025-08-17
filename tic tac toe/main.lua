


function love.load()
    -- Create a 1x1 white pixel (we’ll tint it gray later)
    local imageData = love.image.newImageData(1, 1)
    imageData:setPixel(0, 0, 1, 1, 1, 1)
    particleImage = love.graphics.newImage(imageData)

    ps = love.graphics.newParticleSystem(particleImage, 500)

    -- Smoke settings
    ps:setParticleLifetime(2, 4)               -- smoke lasts longer
    ps:setEmissionRate(50)                     -- particles per second
    ps:setSizes(10, 20)                      -- grows as it rises
    ps:setSizeVariation(1)                     -- random sizes
    ps:setLinearAcceleration(-10, -50, 10, -100) -- drift upward (negative y)
    ps:setColors(0.5, 0.5, 0.5, 0.8,   -- start gray, semi-opaque
                 0.5, 0.5, 0.5, 0.0) 

end


function love.update(dt)
	ps:update(dt)
end

function love.draw()
	love.graphics.draw(ps, 400, 300)
end