score = 0
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
  font = getFont()
  love.graphics.setFont(font)
  love.graphics.print(score, 0, 0)
end

function setAndPrintMessage(_message)
  messageTimer = love.timer.getTime()
  message = _message
end

function drawMessage()
    if((love.timer.getTime()- messageTimer) * 1000 < 2000 ) then
      font = getFont()
      love.graphics.setFont(font)
      love.graphics.print(message, love.graphics.getWidth()/2, love.graphics.getHeight()/2)
    end
end

function addScore(points)
  score = score + points
end

function resetScore()
  score = 0
end
