--Reads keyboard input and updates player position
bulletsTimer = 0
bulletTimerLimiter = 0
function resetBulletsTimer()
  bulletsTimer = love.timer.getTime()
end

function checkKeyInputAndMovePlayer(player)
  if love.keyboard.isDown('right') and player.x < love.graphics.getWidth() - player.width then
    player.x = player.x + 1
  end
  if love.keyboard.isDown('left') and player.x > 1 then
    player.x = player.x - 1
  end
  if love.keyboard.isDown('up') and player.y > love.graphics.getHeight() * 0.6 then
    player.y = player.y - 1
  end
  if love.keyboard.isDown('down') and player.y <  love.graphics.getHeight() - player.height  then
    player.y = player.y + 1
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


--Returns default player object
function getDefaultPlayer(_bulletTimerLimiter)
  player = {
    x = love.graphics.getWidth( )/2,
    y = love.graphics.getHeight()-40,
    width = 40,
    height = 40,
    bullets={},
    value = type.player,
    fire=function()
      fireBullet(-1,false,player.x + (player.width / 2),player.y, 8, 20)
      --Plays laser sound FX
      playLaserSound()

    end
  }
  bulletTimerLimiter = _bulletTimerLimiter
  return player
end
