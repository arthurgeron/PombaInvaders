
require "classes/player"
require "classes/particles"
require "classes/enemy"
require "classes/bullet"
require "classes/collision"

--Type of elements, works like Enum objects
type = {
  player = {value = "player"},
  bullet = {value = "bullet"},
  obstacle = {value = "obstacle"},
  enemy1 = {value = "enemy", warp = true },
  enemy2 = {value = "enemy", warp = false }
}

--General function for creating dynamic elements in the game
function createElement(initialWidth, initialHeight, initialColor, x, y, _type)
  _baseMovementSpeedX = (math.floor((math.random() * 1) + 0) + 1 - 1.15) *  ((math.random(1,2)*2)-3) --Numero negativo ou positivo para definir a direcao do veiculo aleatoriamente. Random speed between 10 and 20
    if(_type.value == "enemy") then
      _warp = _type.warp
      if(_warp == false) then -- If it's not a warping object
        if(_baseMovementSpeedX>0) then
          _maxX = x + 200 --Max movement speed
          _minX = x --Min movement speed
        else
          _maxX = love.graphics.getWidth() - 40
          _minX = love.graphics.getWidth() - 200
        end
      else
        warp = false
        _minX = -1
        _maxX = -1
      end
    else
      warp = false
      _minX = -1
      _maxX = -1
    end

    element = {
      width = initialWidth,
      height = initialHeight,
      type = _type,
      warp = _warp,
      maxX = _maxX,
      minX = _minX,
      baseMovementSpeedX = _baseMovementSpeedX,
      speedX = _baseMovementSpeedX,
      speedY = 0,
      y = y,
      initialX = x,
      initialY = y,
      timer = -1,

      calculateNewPosition = function (this)
          if (this.type.value == "obstacle") then
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
              if(CheckCollision(this, player)) then
                lost()
              end

          elseif (this.type.value == "enemy") then
            if (this.warp == true) then
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
            else
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
          else -- Default
            this.x  =  this.x  +  this.speedX
            this.y = this.y + this.speedY
          end

      end
    }
    return element
end
