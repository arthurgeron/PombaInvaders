
--Calculates and update enemies positions
function CalculateNewEnemiesPositions(enemiesList)
  --Updates enemies positions
  for index, enemy in ipairs(enemiesList) do
    enemy.calculateNewPosition(enemy)
  end
end
--Calculates quantity of enemies that will be placed in the screen
function calculateAndInsertEnemies(enemiesTable,startingY,Yspacing,width,height)
  currentPosition = startingY
  while true do
      enemy = createElement(width,height, 0, 0, currentPosition, type.enemy2)
      if enemy.baseMovementSpeedX > 0 then
        enemy.x = 0
      else
        enemy.x =  love.graphics.getWidth()
        enemy.initialX = love.graphics.getWidth()
      end
      table.insert(enemiesTable, enemy)
      if currentPosition + Yspacing + height + 10 >= love.graphics.getHeight() - player.height then
            return
      else
            currentPosition = currentPosition + Yspacing
      end
  end
end
