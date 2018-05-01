local class = require 'lib/middleclass'

local Explosion = class("Explosion")

function Explosion:initialize(num_particles, pos_x, pos_y)
    self.particles = {}

    for i = 0, num_particles do
        local s = math.random(10)

        self.particles[i] = {
            x = pos_x, 
            y = pos_y, 
            size = math.random(2),
            speed = s,
            vel_x = math.random(-s, s), 
            vel_y = math.random(-s, s),
            lifetime = math.random() / 1.5,
            timer = 0,
            alive = true
        }
    end
end

function Explosion:update(dt)
    for i, particle in ipairs(self.particles) do
        if particle.alive then
            particle.timer = particle.timer + dt

            if particle.timer >= particle.lifetime then
                particle.alive = false
            end

            particle.x = particle.x + ((particle.vel_x * particle.speed) * dt)
            particle.y = particle.y + ((particle.vel_y * particle.speed) * dt)
        end
    end
end

function Explosion:draw()
    love.graphics.setColor(255, 255, 255, 255)

    for i, particle in ipairs(self.particles) do
        if particle.alive then
            love.graphics.circle("fill", particle.x, particle.y, particle.size)
        end
    end
end

return Explosion