--Loops trough current existing bullets table
function DetectBulletCollisions(bulletsTable,particlesTable)
    for index, bullet in ipairs(bulletsTable) do
      if bullet.y < (0 - bullet.height) then--If out of limits then remove
        table.remove(bulletsTable, index)
      end
      --Bullet speed movement
      bullet.y = bullet.y - 1
      for index2, enemy in ipairs(enemies) do--Checks collision with enemies
        if(CheckCollision(bullet,enemy)) then
          CreateExplosionEffect(bullet,particlesTable) -- Creates explosion effect at the bullet's position
          table.remove(bulletsTable, index )--Removes bullet
          table.remove(enemies,index2)--Removes/kills enemy
          love.audio.play(love.audio.newSource("media/audio/blast.mp3","static"))--Blast sound
        end
      end
    end
end
