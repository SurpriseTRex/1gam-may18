local StarField = require 'stars/starfield'
local Player = require 'player/player'

function love.load()
    love.window.setMode(640, 360)

    starfield = StarField:new(500)
    player = Player:new()
end

function love.update(dt)
    starfield:update(dt)
    player:update(dt)
end

function love.draw()
    starfield:draw()
    player:draw()
end