local class = require 'lib/middleclass'
local DebrisObject = require 'debris/debrisobject'

local DebrisField = class("DebrisField")

function DebrisField:initialize(num_objects)
    self.objects = {}
    for i = 0, num_objects do
        self.objects[i] = DebrisObject:new()
    end
end

function DebrisField:update(dt)
    for i, object in ipairs(self.objects) do
        object:update(dt)
    end
end

function DebrisField:draw()
    for i, object in ipairs(self.objects) do
        object:draw()
    end
end

return DebrisField