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
          killPlayer()
        end
      else
        for index2, enemy in ipairs(enemies) do--Checks collision with enemies
          if(CheckCollision(bullet,enemy)) then
            addScore(10)
            CreateExplosionEffect(bullet,particlesTable) -- Creates explosion effect at the bullet's position
            table.remove(bulletsTable, index )--Removes bullet
            table.remove(enemies,index2)--Removes/kills enemy
            playBlastSound()--Blast sound
          end
        end
      end
    end
end

--Creates bullet
function createBulletObject(_direction, _hurtsPlayer, _x, _y, _width, _height)
  bullet = {
    x = _x - ( _width /2 ),
    y = _y,
    width = _width,
    height = _height,
    direction = _direction,
    hurtsPlayer = _hurtsPlayer
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
