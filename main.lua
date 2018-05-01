local StarField = require 'stars/starfield'
local Player = require 'player/player'
local moonshine = require 'moonshine'

function love.load()
    love.window.setMode(640, 360)

    love.graphics.setBackgroundColor(5, 10, 0)

    effect = moonshine(moonshine.effects.chromasep)
        .chain(moonshine.effects.scanlines)
        .chain(moonshine.effects.crt)
        .chain(moonshine.effects.desaturate)

    effect.scanlines.color = {255, 255, 255}
    effect.scanlines.opacity = 0.3
    effect.scanlines.frequency = 200
    effect.scanlines.phase = 1

    effect.desaturate.tint = {255, 255, 200}

    effect.chromasep.radius = 1

    starfield = StarField:new(500)
    player = Player:new()
end

function love.update(dt)
    starfield:update(dt)
    player:update(dt)
end

function love.draw()
    effect(function()
        starfield:draw()
        player:draw()

        love.graphics.print("GREETINGS FROM MARS", 600, 10)
    end)
end