local background = {
  image = nil,
  quads = {
      generated = {},
      base = {}
  }
}


-- Creates a new element with quad info using one of the quads previously created
function newBGQuad(_quad, _x, _y, _type)
  local quad = {
    quad = _quad,
    type = _type,
    x = _x,
    y = _y
  }
  return quad
end


function loadBackgroundImage()
  background.image = love.graphics.newImage("media/images/backgroundGame.jpg")
end


-- Divides background into images
function loadBackgroundQuads()
    table.insert(background.quads.base, love.graphics.newQuad(0, 0, background.image:getWidth()/2, background.image:getHeight(), background.image:getDimensions()))
    table.insert(background.quads.base, love.graphics.newQuad(background.image:getWidth()/2, 0, background.image:getWidth()/2, background.image:getHeight(), background.image:getDimensions()))
end


function loadInitializeBackgroundVariables()
  loadBackgroundImage()
  loadBackgroundQuads()
  table.insert(background.quads.generated, newBGQuad(background.quads.base[1],0,0,1))
end


-- Returns a background quad different than the one being currently used
function getAlternateType(type)
  if(type == 1) then
    return 2
  else
    return 1
  end
end


-- This will make a endless scrolling background, which will place one quad
-- On top of the other and remove after it moves out of the screen
function updateBackgroundPosition()
  for index, quad in ipairs(background.quads.generated) do
    if(quad.y==0) then
      local type = getAlternateType(quad.type)
      table.insert(background.quads.generated, newBGQuad(background.quads.base[type],0,background.image:getHeight()*-1,type))
    -- Removes background quad if it has gone out of the screen
    elseif(quad.y > love.graphics.getHeight()) then
      table.remove(background.quads.generated, index)
    end
    quad.y = quad.y + 0.01
  end
end


function drawBackground()
  love.graphics.setColor(255,255,255)
  for index, quad in ipairs(background.quads.generated) do
    love.graphics.draw(background.image ,quad.quad,quad.x ,quad.y)
  end
end
