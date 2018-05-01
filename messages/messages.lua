local class = require 'lib/middleclass'

local Messages = class("Messages")

function Messages:initialize()
    self.messages = {
        "HELLO FROM MARS!",
        "ANOTHER SUCCESSFUL LANDING BY MFSA",
        "SHUTTLE CAM EXT-4 (REMOTE)"
    }

    self.time_message = "CURRENT MARTIAN TIME "
    self.timezone = " MST"

    self.time_per_msg = 5
    self.msg_timer = 0
    self.msg_index = 1

    love.graphics.setNewFont(20)
end

function Messages:update(dt)
    self.msg_timer = self.msg_timer + dt
    
    if self.msg_timer > self.time_per_msg then
        self.msg_timer = 0

        self:increment_index()
    end
end

function Messages:draw()
    self:draw_msg(self.messages[self.msg_index], 10)

    self:draw_msg(self.time_message .. os.time() .. self.timezone, SCREEN_HEIGHT - 30)
end

function Messages:increment_index()
    self.msg_index = self.msg_index + 1
        
    if self.msg_index > #self.messages then
        self.msg_index = 1
    end
end

function Messages:draw_msg(string, y)
    love.graphics.setColor(255, 255, 255, 255)

    local font = love.graphics.getFont()
    local msg_width = font:getWidth(string)
    local x = (SCREEN_WIDTH - 10) - msg_width
    
    love.graphics.print(string, x, y)
end

return Messages