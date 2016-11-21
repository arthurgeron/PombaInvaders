
percentageOfShootingEnemies = 0
numberOfEnemies = 0
currentLevel = 0

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
  print('won level')
  addScore(100)
  loadNextScene()
end

function loseLevel()

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
  cleanScene()
  percentageOfShootingEnemies = 10
  numberOfEnemies = 2
  currentLevel = 1
  sceneLoad()
end

function cleanScene()
  resetEnemiesTable()
  player = getDefaultPlayer()
  resetBulletsTimer()
end

function sceneLoad()
  calculateAndInsertEnemies(enemies,getLevelNumberOfEnemies(),60,20,40,10)
end

function loadNextScene()
  increaseNumberOfEnemies()
  increaseLevelNumber()
  increasePercentageOfShootingEnemies()
  cleanScene()
  sceneLoad()
  love.window.setTitle("Pomba Invaders - Level ", getCurrentLevel())
end
