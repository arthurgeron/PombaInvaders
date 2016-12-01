particles = {}


-- Creating particles
function NewExplosionParticle(xpos,ypos)
  particle = NewParticle('media/images/square.png',xpos,ypos)
  particle.ps:setParticleLifetime(0,1)
  particle.ps:setEmissionRate(100)
  particle.ps:setSizeVariation(1)
  particle.ps:setLinearAcceleration(-2000, -2000, 2000, 2000)
  particle.ps:setColors(255, 255, 255, 255, 255, 255, 255, 0)
  particle.ps:setSizes(0.05)
  particle.ps:setLinearAcceleration(-200,-200,400,400)
  return particle
end


-- Draws particles
function drawParticles()
  for index, particle in ipairs(particles) do
    love.graphics.draw(particle.ps, particle.x, particle.y)
  end
end


-- Update's particles(necessary for them to be drawn every frame)
function CheckAndUpdateParticles(particlesTable,dt)
  -- Removes square particles after 400 miliseconds
  for index, particle in ipairs(particlesTable) do
    -- If particle isn't dead
    if(CheckAndRemoveOldParticle(particle,particlesTable) == false) then
    -- Update necessary for the particle to be drawn
    particle.ps:update(dt)
  end
  end
end


-- Removes particles after they limit the timer limit
function CheckAndRemoveOldParticle(particle,particlesTable)
  if (love.timer.getTime() - particle.timer) * 1000 >= 400 then
    table.remove(particlesTable, index)
    return true
  else
    return false
  end
end


-- Creates a new particle emitter
function NewParticle(location,xpos,ypos)
  particle = {
    ps = love.graphics.newParticleSystem( love.graphics.newImage('media/images/square.png'), 32),
    timer = love.timer.getTime(),
    x = xpos,
    y = ypos
  }
  return particle
end


-- Creates explosion effect
function CreateExplosionEffect(_bullet)
   table.insert(particles,NewExplosionParticle(_bullet.x + (_bullet.width/2),_bullet.y+(_bullet.height/2)))--Inserts a new particle
end
