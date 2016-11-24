
pigeonBulletSprite = nil
bulletQuads = {}

--Loops trough current existing bullets table
function DetectBulletCollisions(bulletsTable,particlesTable)
    for index, bullet in ipairs(bulletsTable) do
      if bullet.y < (0 - bullet.height) then--If out of limits then remove
        table.remove(bulletsTable, index)
      end
      --Bullet speed movement
      bullet.y = bullet.y + bullet.direction
      if(bullet.hurtsPlayer) then
        if(CheckCollision(bullet,player)) then
          playBlastSound()
          CreateExplosionEffect(player,particlesTable)
          CreateExplosionEffect(player,particlesTable)
          loseLevel()
        end
      else
        for index2, enemy in ipairs(enemies) do--Checks collision with enemies
          if(CheckCollision(bullet,enemy)) then
            addScore(10)
            CreateExplosionEffect(bullet,particlesTable) -- Creates explosion effect at the bullet's position
            killBullet(index)--Removes bullet
            killEnemy(index2)--Removes/kills enemy
            playBlastSound()--Blast sound
          end
        end
      end
    end
end

function killBullet(index)
  table.remove(player.bullets, index)--Removes bullet
end


function updatePigeoneBulletSpriteTimer(dt)
  for index, bullet in ipairs(player.bullets) do
    if(bullet.direction == -1) then
      if (bullet.bulletSpriteTimer ~= nil) then
        bullet.bulletSpriteTimer = bullet.bulletSpriteTimer + dt * 4
      end
    end
  end
end

function drawBullets()
  love.graphics.setColor(255,255,255,255)
  for index, bullet in ipairs(player.bullets) do
    if(bullet.direction == -1) then --If itś a pigeon bullet
      love.graphics.setColor(255,255,255)
      love.graphics.draw(pigeonBulletSprite, bulletQuads[(math.floor(bullet.bulletSpriteTimer) % 4) + 1], bullet.x, bullet.y)
    else
      love.graphics.setColor(255, 0, 0)
      love.graphics.rectangle('fill', bullet.x, bullet.y, bullet.width, bullet.height)
    end
  end
end

--Pre load bullet sprite elements
function preLoadBulletSpriteElements()
  pigeonBulletSprite = love.graphics.newImage("media/images/BulletSprite.png")
  table.insert(bulletQuads, love.graphics.newQuad(0, 0, pigeonBulletSprite:getWidth(),30 , pigeonBulletSprite:getDimensions()))
  table.insert(bulletQuads, love.graphics.newQuad(0, 31, pigeonBulletSprite:getWidth(), 19 , pigeonBulletSprite:getDimensions()))
  table.insert(bulletQuads, love.graphics.newQuad(0, 51, pigeonBulletSprite:getWidth(), 12, pigeonBulletSprite:getDimensions()))
  table.insert(bulletQuads, love.graphics.newQuad(0,  64, pigeonBulletSprite:getWidth(), 8, pigeonBulletSprite:getDimensions()))

end

--Creates bullet
function createBulletObject(_direction, _hurtsPlayer, _x, _y, _width, _height)
  local bullet = {
    x = _x - ( _width /2 ),
    y = _y,
    width = _width,
    height = _height,
    direction = _direction,
    hurtsPlayer = _hurtsPlayer,
    bulletSpriteTimer = 0
  }


  return bullet
end
function fireBullet(_direction, _hurtsPlayer, _x, _y, _width, _height)
  bullet = createBulletObject(_direction, _hurtsPlayer, _x, _y, _width, _height)
  addBulletToTable(bullet)
end

--Add bullet to bullet table
function addBulletToTable(bullet)
  table.insert(player.bullets,bullet)
end
