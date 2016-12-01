bullets={}
pigeonBulletSprite = nil
bulletQuads = {}

-- Loops trough current existing bullets table
function DetectBulletCollisions(bulletsTable,particlesTable)
    for index, bullet in ipairs(bulletsTable) do
      if bullet.y < (0 - bullet.height) then--If out of limits then remove
        table.remove(bulletsTable, index)
      end
      -- Bullet speed movement
      bullet.y = bullet.y + bullet.direction
      -- Checks if the bullet was fired by the enemy
      if(bullet.hurtsPlayer) then
        -- Check's collision with player
        if(CheckCollision(bullet,player)) then
          -- Plays blast sound
          playBlastSound()
          -- Creates explosion particles
          CreateExplosionEffect(player,particlesTable)
          CreateExplosionEffect(player,particlesTable)
          loseLevel()
        end
      else
        -- Checks collision with enemies
        for index2, enemy in ipairs(enemies) do
          if(CheckCollision(bullet,enemy)) then
            addScore(10)
            -- Creates explosion effect at the bullet's position
            CreateExplosionEffect(bullet,particlesTable)
            -- Removes bullet
            killBullet(index)
            -- Removes/kills and enemy that collided with the bullet
            killEnemy(index2)
            -- Plays blast sound
            playBlastSound()
          end
        end
      end
    end
end


-- Removes bullet
function killBullet(index)
  table.remove(bullets, index)
end


-- Updates player's bullet sprites
function updatePigeoneBulletSpriteTimer(dt)
  for index, bullet in ipairs(bullets) do
    if(bullet.direction == -1) then
      if (bullet.bulletSpriteTimer ~= nil) then
        bullet.bulletSpriteTimer = bullet.bulletSpriteTimer + dt * 4
      end
    end
  end
end


-- Draws bullet
function drawBullets()
  love.graphics.setColor(255,255,255,255)
  for index, bullet in ipairs(bullets) do
    --If the bullet was fired by the player
    if(bullet.direction == -1) then
      --Draws the bullet sprite
      love.graphics.setColor(255,255,255)
      love.graphics.draw(pigeonBulletSprite, bulletQuads[(math.floor(bullet.bulletSpriteTimer) % 4) + 1], bullet.x, bullet.y)
    else
      --Draws the bullet as a geometric element
      love.graphics.setColor(255, 0, 0)
      love.graphics.rectangle('fill', bullet.x, bullet.y, bullet.width, bullet.height)
    end
  end
end

--Pre load bullet sprite elements, which will be used for all the player's bullets
function preLoadBulletSpriteElements()
  pigeonBulletSprite = love.graphics.newImage("media/images/BulletSprite.png")
  table.insert(bulletQuads, love.graphics.newQuad(0, 0, pigeonBulletSprite:getWidth(),30 , pigeonBulletSprite:getDimensions()))
  table.insert(bulletQuads, love.graphics.newQuad(0, 30, pigeonBulletSprite:getWidth(), 19 , pigeonBulletSprite:getDimensions()))
  table.insert(bulletQuads, love.graphics.newQuad(0, 49, pigeonBulletSprite:getWidth(), 13, pigeonBulletSprite:getDimensions()))
  table.insert(bulletQuads, love.graphics.newQuad(0,  62, pigeonBulletSprite:getWidth(), 8, pigeonBulletSprite:getDimensions()))

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

--Fire creates and add bullet to bullet table
function fireBullet(_direction, _hurtsPlayer, _x, _y, _width, _height)
  bullet = createBulletObject(_direction, _hurtsPlayer, _x, _y, _width, _height)
  addBulletToTable(bullet)
end

--Add bullet to bullet table
function addBulletToTable(bullet)
  table.insert(bullets,bullet)
end
