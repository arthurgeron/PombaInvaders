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
function createEnemy(enemiesTable,x,y,width,height)
  enemy = createElement(width,height, 0, x, y, type.enemy2)
  if enemy.baseMovementSpeedX > 0 then
    enemy.x = 0
  else
    enemy.x =  love.graphics.getWidth()
    enemy.initialX = love.graphics.getWidth()
  end
  --Defines enemy timer which will be used for random shooting
  enemy.timer = love.timer.getTime()
  return enemy
end
--Calculates quantity of enemies that will be placed in the screen
function calculateAndInsertEnemies(enemiesTable,startingY,Yspacing,width,height)
  currentPosition = startingY
  while true do
      enemy = createEnemy(enemiesTable,0,currentPosition,width,height)
      table.insert(enemiesTable, enemy)
      if currentPosition + Yspacing + height + 10 >= love.graphics.getHeight() - player.height then
            return
      else
            currentPosition = currentPosition + Yspacing
      end
  end
end
