local class = require 'lib/middleclass'

local Star = class("Star")

function Star:initialize()
    self.x = math.random(640)
    self.y = self:random_height()

    self.brightness = math.random(255)

    self.speed = math.random(2, 8)
    self.size = 0.4 * self.speed
end

function Star:random_height() return math.random(360) end

function Star:update(dt)
    if self.x <= 0 then
        self.x = 650
        self.y = self:random_height()
    end

    if self.y <= 0 then
        self.y = self:random_height()
    elseif self.y >= 360 then
        self.y = self:random_height()
    end

    self.x = self.x - (self.speed * dt)
end

function Star:draw()
    love.graphics.setColor(255, 255, 255, self.brightness)
    love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
end

return Star