enemies = {}
local enemySprite = nil
local enemyQuads = {}
local FRAMES = 0
local enemyScaleFactor = nil
enemyXScaleFactor = enemyScaleFactor
enemyYScaleFactor = enemyScaleFactor


function resetEnemiesTable()
  enemies = {}
end


-- Reduces enemy size
function reduceEnemyScaleFactor()
  if (enemyScaleFactor>0.1) then
    enemyScaleFactor = enemyScaleFactor - 0.005
  end
  enemyYScaleFactor = enemyScaleFactor
  enemyXScaleFactor = enemyYScaleFactor
end


function getNumberOfEnemies()
  return tableLength(enemies)
end


-- Removes enemy from enemy table
function killEnemy(index)
  table.remove(enemies,index)--Removes/kills enemy
end


function initializeEnemyVariables()
  enemyScaleFactor = 0.2
  enemyXScaleFactor = enemyScaleFactor
  enemyYScaleFactor = enemyScaleFactor
  if (enemySprite == nil) then
    preLoadEnemySpriteElements()
  end
end

-- Pre load sprite that will be used by all enemies
function preLoadEnemySpriteElements()
  enemySprite = love.graphics.newImage("media/images/monsterSprite.png")
  FRAMES = 4
  enemyTimer = 0
  table.insert(enemyQuads, love.graphics.newQuad(0, 0,369,288 , enemySprite:getDimensions()))
  table.insert(enemyQuads, love.graphics.newQuad(369, 0, 369, 288 , enemySprite:getDimensions()))
  table.insert(enemyQuads, love.graphics.newQuad(743, 0, 369, 288, enemySprite:getDimensions()))
  table.insert(enemyQuads, love.graphics.newQuad(1115, 0, 369, 288, enemySprite:getDimensions()))
end


-- Calculates and update enemies positions
function CalculateNewEnemiesPositions(enemiesList)
  -- Updates enemies positions
  for index, enemy in ipairs(enemiesList) do
    enemy.calculateNewPosition(enemy)
  end
end


-- Checks if the shoot trigger timer has reached its limit and randomly shoots or not
function randomShootingTrigger(percentageOfEnemyes)
  numberOfEnemiesTriggered = 0
  for index, enemy in ipairs(enemies) do
    if(( love.timer.getTime() - enemy.timer )*1000 > 3000) then
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


-- Updates Enemies Sprite's timers
function updateEnemySpriteTimer(dt)
  for index, enemy in ipairs(enemies) do
    if (enemy.spriteTimer ~= nil) then
      enemy.spriteTimer = enemy.spriteTimer + dt * FRAMES
    end
  end
end

-- Draws enemies
function drawEnemies()
  for index, enemy in ipairs(enemies) do
    enemyXPositionFix = 0
    enemyFlipScaleFactor = 1
    love.graphics.setColor(255,255,255)
    -- love.graphics.rectangle('fill', enemy.x, enemy.y, enemy.width, enemy.height)
    if(enemy.baseMovementSpeedX < 0 ) then
      enemyFlipScaleFactor =  -1
      enemyXPositionFix = enemy.width
    end
    love.graphics.draw(enemySprite, enemyQuads[(math.floor(enemy.spriteTimer) % FRAMES) + 1], enemy.x + enemyXPositionFix, enemy.y, 0, enemyXScaleFactor * enemyFlipScaleFactor, enemyYScaleFactor)
  end
end


-- Create enemy
function createEnemy(enemiesTable,x,y,width,height, direction, maxXDistanceToMove)
  enemy = createElement(width,height, 0, x, y, type.enemy2)
  enemy.x = x
  enemy.y = y
  enemy.initialX = x
  enemy.spriteTimer = 0
  -- Makes sure the enemy will move in the right direction
  if(direction>0) then
    if(enemy.baseMovementSpeedX<0) then
      enemy.baseMovementSpeedX = enemy.baseMovementSpeedX * -1
    end
  else
    if(enemy.baseMovementSpeedX>0) then
      enemy.baseMovementSpeedX = enemy.baseMovementSpeedX * -1
    end
  end
  -- Limits the horizontal movement
  if enemy.baseMovementSpeedX > 0 then
    enemy.maxX = enemy.x + maxXDistanceToMove
    enemy.minX = enemy.x
  else
    enemy.minX = enemy.x - maxXDistanceToMove
    enemy.maxX = enemy.x
  end
  -- Defines enemy timer which will be used for random shooting
  enemy.timer = love.timer.getTime()
  return enemy
end


-- Calculates quantity of enemies that will be placed in the screen
function calculateAndInsertEnemies(enemiesTable, quantity, startingY,width,height)
  startingX = 0+width+10
  Yspacing = height + 5
  Xspacing = width + 5
  counter = 0
  currentYPosition = startingY
  currentXPosition = startingX
  xDistanceToMove = 200
  currentEnemyBlock = 1
  while counter < quantity do
    counter = counter + 1
    -- We have 2 enemies blocks, one moving to the right and the other to the left
    if(currentEnemyBlock==1) then
      enemy = createEnemy(enemiesTable,currentXPosition,currentYPosition,width,height,1,xDistanceToMove)
      table.insert(enemiesTable, enemy)
      -- Calculates if there's enough space for another enemy to be alocated move
      if enemy.x + enemy.width + xDistanceToMove > love.graphics.getWidth()/2 then
        -- If theres no space left he moves to the next line
        currentYPosition = currentYPosition + Yspacing
        -- Resets X positioner
        currentXPosition = startingX
      else
        currentXPosition = currentXPosition + Xspacing
      end
      -- Checks if there are any lines left to fill, if not it will prepare the variables for the next block
      if currentYPosition + Yspacing + height + 10 >= love.graphics.getHeight() - player.height or counter >= quantity / 2  then
            currentEnemyBlock = currentEnemyBlock + 1
            startingX = love.graphics.getWidth() - 10 - width
            currentYPosition = startingY
            currentXPosition = startingX
      end
      -- Same thing as first block but working with a minus X movement (X direction -1)
      else if (currentEnemyBlock==2) then
        enemy = createEnemy(enemiesTable,currentXPosition,currentYPosition,width,height,-1,xDistanceToMove)
        table.insert(enemiesTable, enemy)
        if enemy.x - enemy.width - xDistanceToMove < love.graphics.getWidth()/2 then
          currentYPosition = currentYPosition + Yspacing
          currentXPosition = startingX
        else
          currentXPosition = currentXPosition - Xspacing
        end
        if currentYPosition + Yspacing + height + 10 >= love.graphics.getHeight() - player.height or counter >= quantity  then
              currentEnemyBlock = currentEnemyBlock + 1
        end
      else
        return
      end
    end
  end
end
