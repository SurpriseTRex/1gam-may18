local class = require 'lib/middleclass'

local Player = class('Player')

function Player:initialize()
    self.sprite = love.graphics.newImage("images/ship.png")
    self.rotation = 0

    self.x = 100
    self.y = 160

    self.speed = 15
end

function Player:update(dt)
    self.rotation = self.rotation + (0.2 * dt)

    local movementDir = getMovementInput()
    self.x = self.x + movementDir.x * dt * self.speed
    self.y = self.y + movementDir.y * dt * self.speed
end

function Player:draw()
    local offset_x = self.sprite:getWidth() / 2
    local offset_y = self.sprite:getHeight() / 2

    love.graphics.draw(self.sprite, self.x, self.y, self.rotation, 0.08, 0.08, offset_x, offset_y)
end

function getMovementInput()
    local moveDir = {x = 0, y = 0}

    if love.keyboard.isDown("w") then
        moveDir.y = moveDir.y - 1
    end
    if love.keyboard.isDown("s") then
        moveDir.y = moveDir.y + 1
    end
    if love.keyboard.isDown("a") then
        moveDir.x = moveDir.x - 1
    end
    if love.keyboard.isDown("d") then
        moveDir.x = moveDir.x + 1
    end
    
    return moveDir
end

return Player