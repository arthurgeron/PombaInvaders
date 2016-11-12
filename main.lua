
--General function for creating dynamic elements in the game
function createElement(largura, altura, cor, x, y, _type)
  _baseMovementSpeedX = (math.floor((math.random() * 1) + 0) + 1 - 1.15) *  ((math.random(1,2)*2)-3) --Numero negativo ou positivo para definir a direcao do veiculo aleatoriamente. Random speed between 10 and 20
    if(_type.value == "enemy") then
      _warp = _type.warp
      if(_warp == false) then
        if(_baseMovementSpeedX>0) then
          _maxX = x + 200
          _minX = x
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

    elemento = {
      width = largura,
      height = altura,
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
    return elemento
end

--Returns the length of a table
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

--Check for collision between two objects
function CheckCollision(object1, object2)
  return object1.x < object2.x+object2.width and
         object2.x < object1.x+object1.width and
         object1.y < object2.y+object2.height and
         object2.y < object1.y+object1.height
end
--Creating particles
function NewParticle(xpos,ypos)
  particle = {
    ps = love.graphics.newParticleSystem( love.graphics.newImage('square.png'), 32),
    timer = love.timer.getTime(),
    x = xpos,
    y = ypos
  }
  particle.ps:setParticleLifetime(0,1)
  particle.ps:setEmissionRate(100)
  particle.ps:setSizeVariation(1)
  particle.ps:setLinearAcceleration(-2000, -2000, 2000, 2000)
  particle.ps:setColors(255, 255, 255, 255, 255, 255, 255, 0)
  particle.ps:setSizes(0.05)
  particle.ps:setLinearAcceleration(-200,-200,400,400)
  return particle
end
function love.load ()
  --Shots timer
  bulletsTimer =love.timer.getTime()
  --Background
  love.graphics.setBackgroundColor(176,224,230)
  particles = {}
  enemies = {}
  type = {
    player = {value = "player"},
    obstacle = {value = "obstacle"},
    enemy1 = {value = "enemy", warp = true },
    enemy2 = {value = "enemy", warp = false }
  }
  player = {
    x = love.graphics.getWidth( )/2,
    y = love.graphics.getHeight()-40,
    width = 40,
    height = 40,
    bullets={},
    value = type.player,
    fire=function()
      table.insert(player.bullets, { x=player.x + (player.width/2) , y=player.y, width = 8, height = 20})
      --Plays audio only once
      love.audio.play(love.audio.newSource("laser.mp3","stream"))

    end
  }


  --Calcula a quantidade de enemies a serem alocados
  positioner = 60
  spacing = 20
  while true do
      width = 40
      height = 10
      enemy = createElement(width,height, 0, 0, positioner, type.enemy2)
      if enemy.baseMovementSpeedX > 0 then
        enemy.x = 0
      else
        enemy.x =  love.graphics.getWidth()
        enemy.initialX = love.graphics.getWidth()
      end
      table.insert(enemies, enemy)
      if positioner + spacing + height + 10 >= love.graphics.getHeight() - 40 then
            return
      else
            positioner = positioner + spacing
      end
  end
end

function lost()

end

function love.update (dt)
  --Atualiza a posicao dos enemies
  for index, enemy in ipairs(enemies) do
    enemy.calculateNewPosition(enemy)
  end

  if love.keyboard.isDown('right') then
    player.x = player.x + 1
  end
  if love.keyboard.isDown('left') then
    player.x = player.x - 1
  end
  if love.keyboard.isDown('up') then
    player.y = player.y - 1
  end
  if love.keyboard.isDown('down') then
    player.y = player.y + 1
  end

  if love.keyboard.isDown(' ')  then
    if (love.timer.getTime() - bulletsTimer) * 1000 > 1000 then
      bulletsTimer = love.timer.getTime()
      player.fire()
    end
  end

  for index, bullet in ipairs(player.bullets) do
    if bullet.y < (0 - bullet.height) then
      table.remove(player.bullets, index)
    end
    --Bullet speed movement
    bullet.y = bullet.y - 1
    for index2, obstacle in ipairs(enemies) do
      if(CheckCollision(bullet,obstacle)) then
        table.insert(particles,NewParticle(bullet.x + (bullet.width/2),bullet.y+(bullet.height/2)))
        table.remove(player.bullets, index )
        table.remove(enemies,index2)
        love.audio.play(love.audio.newSource("blast.mp3","static"))
      end
    end
  end
  for index, particle in ipairs(particles) do
    if (love.timer.getTime() - particle.timer) * 1000 >= 400 then
      table.remove(particles, index)
    end
    particle.ps:update(dt)
  end

end

function love.keypressed(key, u)
   --Debug
   if key == "lctrl" then --set to whatever key you want to use
      debug.debug()
   end
end

function love.draw ()
  --Draws shots
  for _, bullet in pairs(player.bullets) do
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle('fill', bullet.x, bullet.y, bullet.width, bullet.height)
  end
  --Draw effect particles
  for index, particle in ipairs(particles) do
    love.graphics.draw(particle.ps, particle.x, particle.y)
  end
  --Draws Player
  love.graphics.setColor(255, 255, 0)
  love.graphics.rectangle('fill', player.x, player.y, player.width, player.height)
  love.graphics.setColor(255, 255, 255)

  --Draws enemies
  for index, enemy in ipairs(enemies) do
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle('fill', enemy.x, enemy.y, enemy.width, enemy.height)
  end


end
