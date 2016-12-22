enemies = {}
local enemiesSprites = {}
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
  enemyScaleFactor = 0.4
  enemyXScaleFactor = enemyScaleFactor
  enemyYScaleFactor = enemyScaleFactor
  preLoadEnemySprites()
end

-- Pre load sprite that will be used by all enemies
function preLoadEnemySprites()
  if(enemiesSprites[1] == nil) then
  -- First Eenemy
    enemy = {}
    enemy.width = 242
    enemy.height = 192
    enemy.deathAnimationWidth = 387
    enemy.deathAnimationHeight = 381
    enemy.sprite = love.graphics.newImage("media/images/monsterSprite01.png")
    enemy.frames = 9
    enemy.deathFrames = 6
    enemy.animationSpeed = 0.000001
    enemy.timer = 0
    enemy.currentQuad = 5
    enemy.quads = {}
    enemy.deathQuads = {}
    table.insert(enemy.quads, love.graphics.newQuad(119, 96, 162, 192, enemy.sprite:getDimensions()))
    table.insert(enemy.quads, love.graphics.newQuad(474, 126, 229, 159, enemy.sprite:getDimensions()))
    table.insert(enemy.quads, love.graphics.newQuad(852, 135, 224, 148, enemy.sprite:getDimensions()))
    table.insert(enemy.quads, love.graphics.newQuad(1287, 133, 148, 187, enemy.sprite:getDimensions()))
    table.insert(enemy.quads, love.graphics.newQuad(1662, 97, 167, 191, enemy.sprite:getDimensions()))
    table.insert(enemy.quads, love.graphics.newQuad(2032, 126, 228, 159, enemy.sprite:getDimensions()))
    table.insert(enemy.quads, love.graphics.newQuad(2400, 136, 242, 146, enemy.sprite:getDimensions()))
    table.insert(enemy.quads, love.graphics.newQuad(2834, 133, 151, 186, enemy.sprite:getDimensions()))
    table.insert(enemy.quads, love.graphics.newQuad(3220, 137, 152, 174, enemy.sprite:getDimensions()))
    -- Death quads
    table.insert(enemy.deathQuads, love.graphics.newQuad(3551, 126, 264, 183, enemy.sprite:getDimensions()))
    table.insert(enemy.deathQuads, love.graphics.newQuad(3936, 90, 255, 231, enemy.sprite:getDimensions()))
    table.insert(enemy.deathQuads, love.graphics.newQuad(4304, 34, 312, 323, enemy.sprite:getDimensions()))
    table.insert(enemy.deathQuads, love.graphics.newQuad(4658, 4, 360, 368, enemy.sprite:getDimensions()))
    table.insert(enemy.deathQuads, love.graphics.newQuad(5031, 0, 387, 381, enemy.sprite:getDimensions()))
    table.insert(enemy.deathQuads, love.graphics.newQuad(5466, 57, 296, 253, enemy.sprite:getDimensions()))
    table.insert(enemiesSprites, enemy)
  -- Second enemy
    enemy2 = nil
    enemy2 = {}
    enemy.width = 221
    enemy.height = 172
    enemy.deathAnimationWidth = 308
    enemy.deathAnimationHeight = 301
    enemy2.sprite = love.graphics.newImage("media/images/monsterSprite02.png")
    enemy2.frames = 5
    enemy2.deathFrames = 6
    enemy.animationSpeed = 1
    enemy2.timer = 0
    enemy2.quads = {}
    enemy2.deathQuads = {}
    table.insert(enemy2.quads, love.graphics.newQuad(91, 63, 160, 172, enemy.sprite:getDimensions()))
    table.insert(enemy2.quads, love.graphics.newQuad(367, 89, 221, 142, enemy.sprite:getDimensions()))
    table.insert(enemy2.quads, love.graphics.newQuad(671, 100, 221, 128, enemy.sprite:getDimensions()))
    table.insert(enemy2.quads, love.graphics.newQuad(1020, 102, 138, 165, enemy.sprite:getDimensions()))
    -- Death quads
    table.insert(enemy2.deathQuads, love.graphics.newQuad(1574, 102, 262, 139, enemy.sprite:getDimensions()))
    table.insert(enemy2.deathQuads, love.graphics.newQuad(1935, 73, 171, 183, enemy.sprite:getDimensions()))
    table.insert(enemy2.deathQuads, love.graphics.newQuad(2194, 27, 250, 259, enemy.sprite:getDimensions()))
    table.insert(enemy2.deathQuads, love.graphics.newQuad(2475, 4, 289, 291, enemy.sprite:getDimensions()))
    table.insert(enemy2.deathQuads, love.graphics.newQuad(2772, 0, 308, 301, enemy.sprite:getDimensions()))
    table.insert(enemy2.deathQuads, love.graphics.newQuad(3126, 46, 229, 202, enemy.sprite:getDimensions()))
    table.insert(enemiesSprites, enemy2)
  -- Third enemy
    enemy3 = nil
    enemy3 = {}
    enemy.width = 250
    enemy.height = 195
    enemy.deathAnimationWidth = 362
    enemy.deathAnimationHeight = 367
    enemy3.sprite = love.graphics.newImage("media/images/monsterSprite03.png")
    enemy3.frames = 5
    enemy3.deathFrames = 8
    enemy.animationSpeed = 1
    enemy3.timer = 0
    enemy3.quads = {}
    enemy3.deathQuads = {}
    table.insert(enemy3.quads, love.graphics.newQuad(117, 96, 170, 195 , enemy.sprite:getDimensions()))
    table.insert(enemy3.quads, love.graphics.newQuad(474, 126, 233, 162 , enemy.sprite:getDimensions()))
    table.insert(enemy3.quads, love.graphics.newQuad(849, 136, 250, 150, enemy.sprite:getDimensions()))
    table.insert(enemy3.quads, love.graphics.newQuad(1278, 133, 157, 187, enemy.sprite:getDimensions()))
    table.insert(enemy3.quads, love.graphics.newQuad(1663, 136, 158, 176, enemy.sprite:getDimensions()))
    -- Death Quads
    table.insert(enemy3.deathQuads, love.graphics.newQuad(1994, 125, 266, 182, enemy.sprite:getDimensions()))
    table.insert(enemy3.deathQuads, love.graphics.newQuad(2378, 90, 254, 229, enemy.sprite:getDimensions()))
    table.insert(enemy3.deathQuads, love.graphics.newQuad(2743, 34, 311, 322, enemy.sprite:getDimensions()))
    table.insert(enemy3.deathQuads, love.graphics.newQuad(3094, 4, 362, 367, enemy.sprite:getDimensions()))
    table.insert(enemy3.deathQuads, love.graphics.newQuad(3465, 0, 343, 313, enemy.sprite:getDimensions()))
    table.insert(enemy3.deathQuads, love.graphics.newQuad(3850, 0, 343, 313, enemy.sprite:getDimensions()))
    table.insert(enemy3.deathQuads, love.graphics.newQuad(4294, 56, 285, 257, enemy.sprite:getDimensions()))
    table.insert(enemy3.deathQuads, love.graphics.newQuad(4684, 59, 279, 246, enemy.sprite:getDimensions()))
    table.insert(enemiesSprites, enemy3)
  end
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
        enemy.fire()
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
    enemy.updateCounter = enemy.updateCounter + enemy.sprite.animationSpeed
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
    print(enemy.updateCounter)
    if (enemy.updateCounter - math.floor(enemy.updateCounter) == 0 ) then
      enemy.currentQuad = enemy.updateCounter
    end
    if (enemy.updateCounter > enemy.frames) then
      enemy.updateCounter = 1
      enemy.currentQuad = enemy.updateCounter
    end
    love.graphics.draw(enemy.sprite.sprite, enemy.sprite.quads[math.floor(dt+1)], enemy.x + enemyXPositionFix, enemy.y, 0, enemyXScaleFactor * enemyFlipScaleFactor, enemyYScaleFactor)
  end

end


-- Create enemy
function createEnemy(enemiesTable,x,y,width,height, direction, maxXDistanceToMove)
  enemy = createElement(width,height, 0, x, y, type.enemy2)
  enemy.x = x
  enemy.y = y
  enemy.initialX = x
  enemy.sprite = enemiesSprites[1]
  enemy.width = enemy.sprite.width * enemyScaleFactor
  enemy.height = enemy.sprite.height * enemyScaleFactor
  enemy.frames = enemy.sprite.frames
  enemy.deathFrames = enemy.sprite.deathFrames
  enemy.updateCounter = 0.0001
  enemy.timer = 0
  enemy.currentQuad = 1
  enemy.curentDeathQuad = 0
  enemy.isDead = false
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

  -- Overrides the calculateNewPosition function
  enemy.calculateNewPosition = function(this)
    if (this.warp == true) then -- If it's a warping object
      if this.x > love.graphics.getWidth() or this.x < 0 then
          this.x = this.initialX
      else
          this.x = this.x + this.speedX
      end
      if (this.y > love.graphics.getHeight() or this.y < 0) then
          this.y = this.initialY
       else
          this.y  = this.y  +  this.speedY
      end
    else -- If it's not a warping object
      if ((this.baseMovementSpeedX > 0 and this.x >= this.maxX) or (this.baseMovementSpeedX < 0 and this.x <= this.minX)) then
        this.y = this.y + 10
        this.baseMovementSpeedX = this.baseMovementSpeedX * -1
      else
        this.x = this.x + this.baseMovementSpeedX
      end
    end
    if(CheckCollision(this, player)) then
      lost()
    end
  end
  -- Defines enemy timer which will be used for random shooting
  enemy.timer = love.timer.getTime()
  enemy.fire=function()
      fireBullet(1,true,enemy.x + (enemy.width / 2),enemy.y + enemy.height, 4, 20)
    -- Plays laser sound FX
    playLaserSound()
  end
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
