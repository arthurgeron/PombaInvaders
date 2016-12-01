--Module for creating new elements in game
require "classes/element"
require "classes/misc"
require "classes/gui"
require "classes/sound"
require "classes/scene"
require "classes/background"


function love.load ()

  paused = false

  -- Pre-loads sprites

  loadInitializeBackgroundVariables()

  preLoadPlayerSprite()

  preLoadBulletSpriteElements()

  preLoadEnemySpriteElements()

  -- Window title
  love.window.setTitle("Pomba Invaders - Level 0 ")

  -- Background
  love.graphics.setBackgroundColor(176,224,230)

  loadFirstScene()

  -- Looping background music
  playBackgroundMusic()

end


function love.update (dt)

  updateBackgroundPosition()

  updatePlayerSpriteTimer(dt)

  updatePigeoneBulletSpriteTimer(dt)

  updateEnemySpriteTimer(dt)

  -- Check if player wants to pause the game
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
    DetectBulletCollisions(bullets,particles)

  --Update particles' state so they can be drawed
    CheckAndUpdateParticles(particles,dt)

  --Randomly makes a percentage of the total number of enemies shoot bullets each three seconds
    randomShootingTrigger(getPercentageOfShootingEnemies())

    checkLevelProgress()

  end
end


function love.draw ()

  -- Draws background
  drawBackground()

  -- Draws player
  drawPlayer()

  -- Display paused message if it's the case
  if(paused) then
    drawPausedGameMessage()
  end

  -- Draws score
  drawScore()

  -- Draws message(if any)
  drawLevelMessage()

  -- Draws enemies
  drawEnemies()

  -- Draws shots
  drawBullets()

  -- Draw effect particles
  drawParticles()

end
