--Reads keyboard input and updates player position
local bulletsTimer = 0
local bulletTimerLimiter = 0
local pigeonSprite = nil
local playerTimer = 0
local FRAMES = 0


-- Checks and processes user input
function checkKeyInputAndMovePlayer(player)
  if love.keyboard.isDown('right') and player.x < love.graphics.getWidth() - player.width then
    player.x = player.x + 1
    player.xScale = -1
  elseif love.keyboard.isDown('left') and player.x > 1 then
    player.x = player.x - 1
    player.xScale = 1
  end
  if love.keyboard.isDown('up') and player.y > love.graphics.getHeight() * 0.6 then
    player.y = player.y - 1
    player.xrotation = -100
  elseif love.keyboard.isDown('down') and player.y <  love.graphics.getHeight() - player.height  then
    player.y = player.y + 1
    player.xrotation = 100
  else
    player.xrotation = 0
  end
end


-- Checks if the user pressed space and fires bullet
function checkKeyDownAndFireBullet()
  if love.keyboard.isDown(' ')  then
    -- Draws only 1 bullet each 1000 miliseconds
    if (love.timer.getTime() - bulletsTimer) * 1000 > bulletTimerLimiter then
      resetBulletsTimer()
      player.fire()
    end
  end
end


-- Pre loads player sprite
function preLoadPlayerSprite()
  pigeonSprite = love.graphics.newImage("media/images/pigeonSprite2.png")
  quads = {}
  FRAMES = 3
  playerTimer = 0
  table.insert(quads, love.graphics.newQuad(3, 7,32,33, pigeonSprite:getDimensions()))
  table.insert(quads, love.graphics.newQuad(54, 5, 62, 32, pigeonSprite:getDimensions()))
  table.insert(quads, love.graphics.newQuad(130, 0, 58, 36, pigeonSprite:getDimensions()))
end


function resetBulletsTimer()
  bulletsTimer = love.timer.getTime()
end


-- Updates player's sprite, necessar for the sprite to be drawn every frame
function updatePlayerSpriteTimer(dt)
  playerTimer = playerTimer + dt * 4
  currentQuad = (math.floor(playerTimer) % FRAMES) + 1
  if(currentQuad == 1) then
    player.height = 33
    player.width = 32
  elseif(currentQuad == 2) then
    player.height = 32
    player.width = 62
  elseif(currentQuad == 3) then
    player.height = 36
    player.width = 58
  end
end


--Draws player on screen
function drawPlayer()
  love.graphics.setColor(255,255,255,255)
  if(player.xScale == 1 ) then
    love.graphics.draw(pigeonSprite, quads[(math.floor(playerTimer) % FRAMES) + 1], player.x , player.y, player.xrotation,player.xScale,1)
  else
    love.graphics.draw(pigeonSprite, quads[(math.floor(playerTimer) % FRAMES) + 1], player.x + player.width, player.y, player.xrotation,player.xScale,1)
  end
end


--Returns default player object
function getDefaultPlayer(_bulletTimerLimiter)
  player = {
    width = pigeonSprite:getWidth()/FRAMES,
    height = pigeonSprite:getHeight(),
    x = love.graphics.getWidth( )/2,
    y = love.graphics.getHeight()-pigeonSprite:getHeight(),
    xrotation = 0,
    xScale = 1,
    bullets={},
    value = type.player,
    fire=function()
      if(playerIsMovingRight) then
        fireBullet(-1,false,player.x - (player.width / 2),player.y, 8, 20)
      else
        fireBullet(-1,false,player.x + (player.width / 2),player.y, 8, 20)
      end
      -- Plays laser sound FX
      playLaserSound()
    end
  }
  bulletTimerLimiter = _bulletTimerLimiter
  return player
end
