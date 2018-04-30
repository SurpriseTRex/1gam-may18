local StarField = require 'stars/starfield'

function love.load()
    love.window.setMode(640, 360)

    starfield = StarField:new(500)
end

function love.update(dt)
    starfield:update(dt)
end

function love.draw()
    starfield:draw()
end