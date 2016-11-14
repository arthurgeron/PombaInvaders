--Reads keyboard input and updates player position

function checkKeyInputAndMovePlayer(player)
  if love.keyboard.isDown('right') then
    player.x = player.x + 1
  end
  if love.keyboard.isDown('left') then
    player.x = player.x - 1
  end
  if love.keyboard.isDown('up') then
    player.y = player.y - 1
  end
  if love.keyboard.isDown('down') then
    player.y = player.y + 1
  end
end
--Checks if the user pressed space and fires bullet
function checkKeyDownAndFireBullet()
  if love.keyboard.isDown(' ')  then
    --Draws only 1 bullet each 1000 miliseconds
    if (love.timer.getTime() - bulletsTimer) * 1000 > 1000 then
      bulletsTimer = love.timer.getTime()
      player.fire()
    end
  end
end

--Returns default player object
function getDefaultPlayer()
  player = {
    x = love.graphics.getWidth( )/2,
    y = love.graphics.getHeight()-40,
    width = 40,
    height = 40,
    bullets={},
    value = type.player,
    fire=function()
      table.insert(player.bullets, { x=player.x + (player.width/2) , y=player.y, width = 8, height = 20})
      --Plays audio only once
      love.audio.play(love.audio.newSource("media/audio/laser.mp3","stream"))

    end
  }
  return player
end
