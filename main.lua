local StarField = require 'stars/starfield'
local DebrisField = require 'debris/debrisfield'
local Player = require 'player/player'
local Messages = require 'messages/messages'
local moonshine = require 'moonshine'

function love.load()
    SCREEN_WIDTH = 640
    SCREEN_HEIGHT = 360

    love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setBackgroundColor(5, 10, 0)

    effect = moonshine(moonshine.effects.scanlines)
        .chain(moonshine.effects.crt)
        .chain(moonshine.effects.desaturate)
        .chain(moonshine.effects.chromasep)

    effect.scanlines.color = {255, 255, 255}
    effect.scanlines.opacity = 0.3
    effect.scanlines.frequency = 200
    effect.scanlines.phase = 1

    effect.desaturate.tint = {125, 125, 0}
    effect.desaturate.strength = 0.1

    effect.chromasep.radius = 1

    starfield = StarField:new(500)
    player = Player:new()
    messages = Messages:new()
    debris = DebrisField:new(7)
    explosions = {}
    screenshake = { active = false, duration = 0.5, timer = 0.5, magnitude = 1}
    normal_x = 0
    normal_y = 0
end

function love.update(dt)
    starfield:update(dt)
    player:update(dt)
    debris:update(dt)

    for i, explosion in ipairs(explosions) do
        explosion:update(dt)
    end

    messages:update(dt)

    if screenshake.active then
        screenshake.timer = screenshake.timer - dt

        normal_x = normal_x + screenshake.magnitude
        normal_y = normal_y + screenshake.magnitude

        if screenshake.timer <= 0 then
            screenshake.active = false
        end
    end
end

function love.draw()
    if screenshake.active then
        local dx = love.math.random(-screenshake.magnitude, screenshake.magnitude)
        local dy = love.math.random(-screenshake.magnitude, screenshake.magnitude)
        love.graphics.translate(dx, dy)
    end

    effect(function()
        starfield:draw()
        player:draw()
        debris:draw()

        for i, explosion in ipairs(explosions) do
            explosion:draw()
        end

        messages:draw()
    end)
end