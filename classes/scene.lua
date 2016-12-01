local percentageOfShootingEnemies = 0
local numberOfEnemies = 0
local currentLevel = 0
local _bulletTimerLimiter = 0


-- Returns the amount of enemies that should fire
function getPercentageOfShootingEnemies()
  return percentageOfShootingEnemies
end


function getCurrentLevel()
  return currentLevel
end


function getLevelNumberOfEnemies()
  return numberOfEnemies
end


function increaseNumberOfEnemies()
  numberOfEnemies = numberOfEnemies * 2
end


function winLevel()
  addScore(100)
  loadNextScene()
  setAndPrintMessage("Level "..getCurrentLevel().."!")
end


function loseLevel()
  resetScore()
  cleanScene()
  loadFirstScene()
  setAndPrintMessage("You lost!")
end


function checkLevelProgress()
  if(getNumberOfEnemies() == 0 ) then
    winLevel()
  end
end


function increaseLevelNumber()
  currentLevel = currentLevel + 1
end


function increasePercentageOfShootingEnemies()
  if(percentageOfShootingEnemies + 10 < 100) then
    percentageOfShootingEnemies = percentageOfShootingEnemies + 10
  else
    percentageOfShootingEnemies = 100
  end
end


function loadFirstScene()
  _bulletTimerLimiter = 1000
  percentageOfShootingEnemies = 10
  numberOfEnemies = 2
  currentLevel = 0
  -- Pre-loads sprites
  loadInitializeBackgroundVariables()
  preLoadBulletSpriteElements()
  initializePlayerVariables()
  initializeEnemyVariables()
  -- Loads scene
  sceneLoad()
end


function cleanScene()
  initializeEnemyVariables()
  resetEnemiesTable()
  resetBulletsTable()
  initializePlayerVariables()
  resetBulletsTimer()
end


function sceneLoad()
  calculateAndInsertEnemies(enemies,getLevelNumberOfEnemies(),60,369*enemyXScaleFactor,288*enemyYScaleFactor)
end


function loadNextScene()
  oldPlayerXPos = player.x
  oldPlayerYPos = player.y
  if(_bulletTimerLimiter>300) then
    _bulletTimerLimiter = _bulletTimerLimiter - 100
  end
  -- Makes enemies smaller so more enemies can fit the scene
  reduceEnemyScaleFactor()
  increaseNumberOfEnemies()
  increaseLevelNumber()
  increasePercentageOfShootingEnemies()
  cleanScene()
  sceneLoad()
  player.x = oldPlayerXPos
  player.y = oldPlayerYPos
  love.window.setTitle("Pomba Invaders - Level " .. getCurrentLevel())
end
