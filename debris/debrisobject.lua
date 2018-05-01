local class = require 'lib/middleclass'
local Explosion = require 'debris/explosion'

local DebrisObject = class("DebrisObject")

function DebrisObject:initialize()
    self.isActive = true

    self.x = math.random(640)
    self.y = self:random_height()

    self.speed = math.random(20, 200)
    self.size = math.random(4, 40)

    self.color = { r = math.random(255), g = math.random(255), b = math.random(255) }
end

function DebrisObject:random_height() return math.random(360) end

function DebrisObject:update(dt)
    self:move(dt)

    if self:is_colliding().colliding then
        self.isActive = false
        table.insert(explosions, Explosion:new(10 * self.size, self.x, self.y))
    end
end

function DebrisObject:draw()
    if self.isActive then
        love.graphics.setColor(self.color.r, self.color.g, self.color.b, 255)
        love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
    end
end

function DebrisObject:move(dt)
    if self.x <= -30 then
        self.x = 650
        self.y = self:random_height()
        self.isActive = true
        self.size = math.random(4, 40)
        self.color = { r = math.random(255), g = math.random(255), b = math.random(255) }
    end

    if self.y <= -20 then
        self.y = self:random_height()
    elseif self.y >= 360 then
        self.y = self:random_height()
    end

    self.x = self.x - (self.speed * dt)
end

function DebrisObject:is_colliding()
    if self.isActive then
        local radius = (player.sprite:getWidth() * 0.07) / 2

        local dist = ((player.x - radius / 2) - self.x)^2 + ((player.y - radius / 2) - self.y)^2
        local colliding = dist <= (radius + (self.size / 2))^2

        love.graphics.setColor(0, 255, 0, 255)
        love.graphics.circle("fill", player.x, player.y, radius)
        love.graphics.setColor(255, 255, 255, 255)

        if colliding then
            collPointX = ((player.x * self.size) + (self.x * radius))/(radius + self.size)
            collPointY = ((player.y * self.size) + (self.y * radius))/(radius + self.size)
            
            return {colliding = true, collX = collPointX, collY = collPointY}
        end

    end

    return {colliding = false}
end

return DebrisObject