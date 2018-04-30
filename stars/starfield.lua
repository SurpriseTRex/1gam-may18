local class = require 'lib/middleclass'
local Star = require 'stars/star'

local StarField = class("StarField")

function StarField:initialize(num_stars)
    self.stars = {}
    for i = 0, num_stars do
        self.stars[i] = Star:new()
    end
end

function StarField:update(dt)
    for i, star in ipairs(self.stars) do
        star:update(dt)
    end
end

function StarField:draw()
    for i, star in ipairs(self.stars) do
        star:draw()
    end
end

return StarField