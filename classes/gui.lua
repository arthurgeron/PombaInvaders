score = 0
function drawGUI()
  drawScore()
end

function drawScore()
  font = love.graphics.newImageFont("media/fonts/Resource-Imagefont.png",
    " abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
    "123456789.,!?-+/():;%&`'*#=[]\"")
  love.graphics.setFont(font)
  love.graphics.print(score, 0, 0)
end

function addScore(points)
  score = score + points
end

function resetScore()
  score = 0
end
