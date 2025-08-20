local State = {}
State.current = nil

function State:switch(newState)
    self.current = newState
    if self.current.load then self.current:load() end
end

function State:update(dt)
    if self.current and self.current.update then
        self.current:update(dt)
    end
end

function State:draw()
    if self.current and self.current.draw then
        self.current:draw()
    end
end

function State:mousepressed(key)
    if self.current and self.current.mousepressed then
        self.current:mousepressed(key)
    end
end