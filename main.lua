--Module for creating new elements in game
require "classes/element"
require "classes/misc"
require "classes/gui"
require "classes/sound"
require "classes/scene"
function love.load ()

  paused = false

  --Window title
  love.window.setTitle("Pomba Invaders - Level 0 ")
  --Our tables where we will place our elements

  --Background
  love.graphics.setBackgroundColor(176,224,230)

  loadFirstScene()

  --Looping background music
  playBackgroundMusic()
end

function lost()

end

function love.update (dt)

  --Check if player wants to pause the game
  if love.keyboard.isDown('p')  then
    if(paused) then
      paused = false
    else
      paused = true
    end
  end

  --Checks if user wants to stop or play background music
  checkAndStopOrPlayBackgroundMusic()

  if(paused~=true) then
    --Updates enemies positions
    CalculateNewEnemiesPositions(enemies)


    --Reads keyboard input and updates player position
    checkKeyInputAndMovePlayer(player)

    --Checks if the user pressed space and fires bullet
    checkKeyDownAndFireBullet()

  --Loops trough current existing bullets table
    DetectBulletCollisions(player.bullets,particles)

  --Update particles' state so they can be drawed
    CheckAndUpdateParticles(particles,dt)

  --Randomly makes a percentage of the total number of enemies shoot bullets each three seconds
    randomShootingTrigger(getPercentageOfShootingEnemies())

    checkLevelProgress()

  end


end

function love.keypressed(key, u)
   --Debug
end

function love.draw ()

  if(paused) then
    drawPausedGameMessage()
  end
  --Draws score
  drawScore()

  --Draws message(if any)
  drawLevelMessage()

  --Draws Player
  love.graphics.setColor(255, 0, 0)
  love.graphics.rectangle('fill', player.x, player.y, player.width, player.height)
  love.graphics.setColor(255, 0, 255)

  --Draws enemies
  for index, enemy in ipairs(enemies) do
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle('fill', enemy.x, enemy.y, enemy.width, enemy.height)
  end

  --Draws shots
  for _, bullet in pairs(player.bullets) do
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle('fill', bullet.x, bullet.y, bullet.width, bullet.height)
  end
  --Draw effect particles
  for index, particle in ipairs(particles) do
    love.graphics.draw(particle.ps, particle.x, particle.y)
  end


end
