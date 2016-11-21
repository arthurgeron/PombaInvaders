
percentageOfShootingEnemies = 0
numberOfEnemies = 0
currentLevel = 0
_bulletTimerLimiter = 0
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
  loadFirstScene()
  setAndPrintMessage("You lost!")
end

function checkLevelProgress()
  print(getNumberOfEnemies())
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
  cleanScene()
  percentageOfShootingEnemies = 10
  numberOfEnemies = 2
  currentLevel = 0
  sceneLoad()
end

function cleanScene()
  resetEnemiesTable()
  player = getDefaultPlayer(_bulletTimerLimiter)
  resetBulletsTimer()
end

function sceneLoad()
  calculateAndInsertEnemies(enemies,getLevelNumberOfEnemies(),60,20,40,10)
end

function loadNextScene()
  oldPlayerXPos = player.x
  oldPlayerYPos = player.y
  if(_bulletTimerLimiter>500) then
    _bulletTimerLimiter = _bulletTimerLimiter - 100
  end
  increaseNumberOfEnemies()
  increaseLevelNumber()
  increasePercentageOfShootingEnemies()
  cleanScene()
  sceneLoad()
  player.x = oldPlayerXPos
  player.y = oldPlayerYPos
  love.window.setTitle("Pomba Invaders - Level " .. getCurrentLevel())
end
