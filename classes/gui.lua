score = 0
highScore = 0
messageTimer = -1
message = nil
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
  love.graphics.setColor(255, 0, 0)
  font = getFont()
  love.graphics.setFont(font)
  love.graphics.print("Score:" .. score, 0, 0)
  love.graphics.print("High Score:" ..highScore,0, 30)
end

function setAndPrintMessage(_message)
  messageTimer = love.timer.getTime()
  message = _message
end

function drawMessage()
    if((love.timer.getTime()- messageTimer) * 1000 < 2000 ) then
      font = getFont()
      love.graphics.setFont(font)
      love.graphics.setColor(255, 0, 0)
      love.graphics.print(message, love.graphics.getWidth()*0.40, love.graphics.getHeight()*0.40)
    end
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
