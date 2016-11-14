--Loops trough current existing bullets table
function DetectBulletCollisions()
    for index, bullet in ipairs(player.bullets) do
      if bullet.y < (0 - bullet.height) then--If out of limits then remove
        table.remove(player.bullets, index)
      end
      --Bullet speed movement
      bullet.y = bullet.y - 1
      for index2, obstacle in ipairs(enemies) do--Checks collision with enemies
        if(CheckCollision(bullet,obstacle)) then
          CreateExplosionEffect(bullet,particles) -- Creates explosion effect at the bullet's position
          table.remove(player.bullets, index )--Removes bullet
          table.remove(enemies,index2)--Removes/kills enemy
          love.audio.play(love.audio.newSource("media/audio/blast.mp3","static"))--Blast sound
        end
      end
    end
end
