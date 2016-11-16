--Module for creating new elements in game
require "classes/element"
require "classes/misc"

function love.load ()


  --Window title
  love.window.setTitle("Pomba Invaders")
  --Our tables where we will place our elements
  particles = {}
  enemies = {}
  --My a list of objets that will work like Enum objects
  type = {
    player = {value = "player"},
    obstacle = {value = "obstacle"},
    enemy1 = {value = "enemy", warp = true },
    enemy2 = {value = "enemy", warp = false }
  }

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
  DetectBulletCollisions(player.bullets,particles)

  CheckAndUpdateParticles(particles,dt)
end

function love.keypressed(key, u)
   --Debug
end

function love.draw ()
  --Draws shots
  for _, bullet in pairs(player.bullets) do
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle('fill', bullet.x, bullet.y, bullet.width, bullet.height)
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
  --Draw effect particles
  for index, particle in ipairs(particles) do
    love.graphics.draw(particle.ps, particle.x, particle.y)
    print("hi")
  end


end
