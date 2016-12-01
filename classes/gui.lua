local score = 0
local highScore = 0
local messageTimer = -1
local message = nil


function drawGUI()
  drawScore()
end



function getFont()
  return love.graphics.newImageFont("media/fonts/Resource-Imagefont.png",
    " abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
    "123456789.,!?-+/():;%&`'*#=[]\"")
end


function drawScore()
  love.graphics.setColor(255, 255, 0)
  font = getFont()
  love.graphics.setFont(font)
  love.graphics.print("Score:" .. score, 0, 0)
  love.graphics.print("High Score:" ..highScore,0, 30)
end


function drawPausedGameMessage()
  displayMessageInMiddleOfScreen("Game Paused!","255,255,0")
end


function setAndPrintMessage(_message)
  messageTimer = love.timer.getTime()
  message = _message
end


function drawLevelMessage()
    if((love.timer.getTime()- messageTimer) * 1000 < 2000 ) then
      displayMessageInMiddleOfScreen(message, "255,255,0")
    end
end


function displayMessageInMiddleOfScreen(_message, color)
  font = getFont()
  love.graphics.setFont(font)
  love.graphics.setColor(0, 255, 0)
  love.graphics.print(_message, love.graphics.getWidth()*0.40, love.graphics.getHeight()*0.40)
end


function addScore(points)
  score = score + points
  if(score > highScore) then
    highScore = score
  end
end


function resetScore()
  score = 0
end
