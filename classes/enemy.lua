enemies = {}
--Calculates and update enemies positions
function CalculateNewEnemiesPositions(enemiesList)
  --Updates enemies positions
  for index, enemy in ipairs(enemiesList) do
    enemy.calculateNewPosition(enemy)
  end
end
--Checks if the shoot trigger timer has reached its limit and randomly shoots or not
function randomShootingTrigger(percentageOfEnemyes)
  numberOfEnemiesTriggered = 0
  for index, enemy in ipairs(enemies) do
    if(( love.timer.getTime() - enemy.timer )*1000 > 3000) then --
      -- print("timer rang, random n: ",love.math.random(3))
      if(love.math.random(7) == 1) then -- 1 in 3 chances of firing each 3 seconds
        fireBullet(1,true,enemy.x + (enemy.width / 2),enemy.y + enemy.height, 4, 20)
        numberOfEnemiesTriggered = numberOfEnemiesTriggered + 1
      end
      enemy.timer = love.timer.getTime() -- Resets timer
      if((numberOfEnemiesTriggered * 100) / tableLength(enemies) > percentageOfEnemyes ) then
        break
      end
    end
  end
end
--Create enemy
function createEnemy(enemiesTable,x,y,width,height, direction, maxXDistanceToMove)
  enemy = createElement(width,height, 0, x, y, type.enemy2)
  enemy.x = x
  enemy.y = y
  enemy.initialX = x
  if(direction>0) then--Makes sure the enemy will move in the right direction
    if(enemy.baseMovementSpeedX<0) then
      enemy.baseMovementSpeedX = enemy.baseMovementSpeedX * -1
    end
  else
    if(enemy.baseMovementSpeedX>0) then
      enemy.baseMovementSpeedX = enemy.baseMovementSpeedX * -1
    end
  end
  --Limits the horizontal movement
  if enemy.baseMovementSpeedX > 0 then
    enemy.maxX = enemy.x + maxXDistanceToMove
    enemy.minX = enemy.x
  else
    enemy.minX = enemy.x - maxXDistanceToMove
    enemy.maxX = enemy.x
  end
  --Defines enemy timer which will be used for random shooting
  enemy.timer = love.timer.getTime()
  return enemy
end
--Calculates quantity of enemies that will be placed in the screen
function calculateAndInsertEnemies(enemiesTable,startingY,Yspacing,width,height)
  startingX = 0+width+10
  Xspacing = 60
  currentYPosition = startingY
  currentXPosition = startingX
  xDistanceToMove = 200
  currentEnemyBlock = 1
  while true do
    if(currentEnemyBlock==1) then --For now we will only work with 2 enemies blocks, one moving to the right and the other to the left
      enemy = createEnemy(enemiesTable,currentXPosition,currentYPosition,width,height,1,xDistanceToMove)
      table.insert(enemiesTable, enemy)
      if enemy.x + enemy.width + xDistanceToMove > love.graphics.getWidth()/2 then--Calculates if there's enough space for another enemy to be alocated move
        currentYPosition = currentYPosition + Yspacing--If theres no space left he moves to the next line
        currentXPosition = startingX --Resets X positioner
      else
        currentXPosition = currentXPosition + Xspacing
      end
      if currentYPosition + Yspacing + height + 10 >= love.graphics.getHeight() - player.height  then--Checks if there are any lines left to fill, if not it will prepare the variables for the next block
            currentEnemyBlock = currentEnemyBlock + 1
            startingX = love.graphics.getWidth() - 10 - width
            currentYPosition = startingY
            currentXPosition = startingX
      end
    else if (currentEnemyBlock==2) then--Same thing as first block but working with a minus X movement
      enemy = createEnemy(enemiesTable,currentXPosition,currentYPosition,width,height,-1,xDistanceToMove)
      table.insert(enemiesTable, enemy)
      if enemy.x - enemy.width - xDistanceToMove < love.graphics.getWidth()/2 then
        currentYPosition = currentYPosition + Yspacing
        currentXPosition = startingX
      else
        currentXPosition = currentXPosition - Xspacing
      end
      if currentYPosition + Yspacing + height + 10 >= love.graphics.getHeight() - player.height  then
            currentEnemyBlock = currentEnemyBlock + 1
      end
    else
      return
    end
  end
end
end
