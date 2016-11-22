--Reads keyboard input and updates player position
bulletsTimer = 0
bulletTimerLimiter = 0
pigeon = love.graphics.newImage("media/images/pigeonSprite.gif")
playerTimer = 0
FRAMES = 0
playerIsMovingRight = false -- Work around sprite scaling bug
function resetBulletsTimer()
  bulletsTimer = love.timer.getTime()
end

function checkKeyInputAndMovePlayer(player)
  if love.keyboard.isDown('right') and player.x < love.graphics.getWidth() - player.width then
    player.x = player.x + 1
    if(playerIsMovingRight == false) then
      player.x = player.x + player.width
      playerIsMovingRight = true
    end
    player.xScale = -1
  elseif love.keyboard.isDown('left') and player.x > 1 then
    player.x = player.x - 1
    if(playerIsMovingRight == true) then
      player.x = player.x - player.width
      playerIsMovingRight = false
    end
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
--Checks if the user pressed space and fires bullet
function checkKeyDownAndFireBullet()
  if love.keyboard.isDown(' ')  then
    --Draws only 1 bullet each 1000 miliseconds
    if (love.timer.getTime() - bulletsTimer) * 1000 > bulletTimerLimiter then
      resetBulletsTimer()
      player.fire()
    end
  end
end

function loadPlayerSprite()
  pigeon = love.graphics.newImage("media/images/pigeonSprite2.png")
  quads = {}
  local imgWidth, imgHeight = pigeon:getWidth(), pigeon:getHeight()
  FRAMES = 3
  playerTimer = 0
   local spriteWidth = imgWidth / FRAMES
   for i=0,FRAMES-1 do
      table.insert(quads, love.graphics.newQuad(i * spriteWidth, 0, spriteWidth, imgHeight, pigeon:getDimensions()))
   end
end

function updatePlayerSpriteTimer(dt)
  playerTimer = playerTimer + dt * 4
end

function drawPlayer()
  love.graphics.setColor(255,255,255,255)
  love.graphics.draw(pigeon, quads[(math.floor(playerTimer) % FRAMES) + 1], player.x, player.y, player.xrotation,player.xScale,1)
end
--Returns default player object
function getDefaultPlayer(_bulletTimerLimiter)
  player = {
    width = pigeon:getWidth()/FRAMES,
    height = pigeon:getHeight(),
    x = love.graphics.getWidth( )/2,
    y = love.graphics.getHeight()-pigeon:getHeight(),
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
      --Plays laser sound FX
      playLaserSound()

    end
  }
  bulletTimerLimiter = _bulletTimerLimiter
  return player
end
