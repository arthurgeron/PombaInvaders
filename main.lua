
--Module for creating new elements in game
require "classes/element"


function love.load ()
  --Shots timer
  bulletsTimer =love.timer.getTime()
  --Background
  love.graphics.setBackgroundColor(176,224,230)

  player = getDefaultPlayer()

  --Calculates quantity of enemies that will be placed in the screen
  calculateAndInsertEnemies(enemies,60,20,40,10)
end

function lost()

end

function love.update (dt)
  --Updates enemies positions
  CalculateNewEnemiesPositions(enemies)


  --Reads keyboard input and updates player position
  checkKeyInputAndMovePlayer(player)

  --Checks if the user pressed space and fires bullet
  checkKeyDownAndFireBullet()

--Loops trough current existing bullets table
  DetectBulletCollisions()

  CheckAndRemoveParticles(particles)

end

function love.keypressed(key, u)
   --Debug
   if key == "lctrl" then --set to whatever key you want to use
      debug.debug()
   end
end

function love.draw ()
  --Draws shots
  for _, bullet in pairs(player.bullets) do
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle('fill', bullet.x, bullet.y, bullet.width, bullet.height)
  end
  --Draw effect particles
  for index, particle in ipairs(particles) do
    love.graphics.draw(particle.ps, particle.x, particle.y)
  end
  --Draws Player
  love.graphics.setColor(255, 255, 0)
  love.graphics.rectangle('fill', player.x, player.y, player.width, player.height)
  love.graphics.setColor(255, 255, 255)

  --Draws enemies
  for index, enemy in ipairs(enemies) do
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle('fill', enemy.x, enemy.y, enemy.width, enemy.height)
  end


end
