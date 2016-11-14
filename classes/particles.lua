particles = {}
--Creating particles
function NewParticle(xpos,ypos)
  particle = {
    ps = love.graphics.newParticleSystem( love.graphics.newImage('media/images/square.png'), 32),
    timer = love.timer.getTime(),
    x = xpos,
    y = ypos
  }
  particle.ps:setParticleLifetime(0,1)
  particle.ps:setEmissionRate(100)
  particle.ps:setSizeVariation(1)
  particle.ps:setLinearAcceleration(-2000, -2000, 2000, 2000)
  particle.ps:setColors(255, 255, 255, 255, 255, 255, 255, 0)
  particle.ps:setSizes(0.05)
  particle.ps:setLinearAcceleration(-200,-200,400,400)
  return particle
end
function CheckAndRemoveParticles(particlesTable)
  --Removes square particles after 400 miliseconds
  for index, particle in ipairs(particlesTable) do
    if (love.timer.getTime() - particle.timer) * 1000 >= 400 then
      table.remove(particlesTable, index)
    end
    particle.ps:update(dt)
  end
end

function CreateExplosionEffect(bullet,particlesTable)
  table.insert(particlesTable,NewParticle(bullet.x + (bullet.width/2),bullet.y+(bullet.height/2)))--Inserts a new particle
end
