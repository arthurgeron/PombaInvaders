
--General function for creating dynamic elements in the game
function createElement(largura, altura, cor, x, y, _tipoDeComponente)
  _baseMovementSpeedX = (math.floor((math.random() * 1) + 0) + 1 - 1.15) *  ((math.random(1,2)*2)-3) --Numero negativo ou positivo para definir a direcao do veiculo aleatoriamente. Random speed between 10 and 20
    if(_tipoDeComponente.tipo == "inimigo") then
      _warp = _tipoDeComponente.warp
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
      tipoDeComponente = _tipoDeComponente,
      warp = _warp,
      maxX = _maxX,
      minX = _minX,
      baseMovementSpeedX = _baseMovementSpeedX,
      speedX = _baseMovementSpeedX,
      speedY = 0,
      y = y,
      initialX = x,
      initialY = y,

      calcularNovaPos = function (this)
          if (this.tipoDeComponente.tipo == "obstaculo") then
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

          elseif (this.tipoDeComponente.tipo == "inimigo") then
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
  obstaculos = {}
  tipoDeComponente = {
    player = {tipo = "player"},
    obstaculo = {tipo = "obstaculo"},
    inimigo1 = {tipo = "inimigo", warp = true },
    inimigo2 = {tipo = "inimigo", warp = false }
  }
  player = {
    x = love.graphics.getWidth( )/2,
    y = love.graphics.getHeight()-40,
    width = 40,
    height = 40,
    bullets={},
    tipo = tipoDeComponente.player,
    fire=function()
      table.insert(player.bullets, { x=player.x + (player.width/2) , y=player.y, width = 8, height = 20})
      --Plays audio only once
      love.audio.play(love.audio.newSource("laser.mp3","stream"))

    end
  }


  --Calcula a quantidade de obstaculos a serem alocados
  posicionador = 60
  espacamento = 20
  while true do
      larguraObstaculo = 40
      alturaObstaculo = 10
      obstaculo = createElement(larguraObstaculo,alturaObstaculo, 0, 0, posicionador, tipoDeComponente.inimigo2)
      if obstaculo.baseMovementSpeedX > 0 then
        obstaculo.x = 0
      else
        obstaculo.x =  love.graphics.getWidth()
        obstaculo.initialX = love.graphics.getWidth()
      end
      table.insert(obstaculos, obstaculo)
      if posicionador + espacamento + alturaObstaculo + 10 >= love.graphics.getHeight() - 40 then
            return
      else
            posicionador = posicionador + espacamento
      end
  end
end

function lost()

end

function love.update (dt)
  --Atualiza a posicao dos obstaculos
  for index, obstaculo in ipairs(obstaculos) do
    obstaculo.calcularNovaPos(obstaculo)
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
    for index2, obstacle in ipairs(obstaculos) do
      if(CheckCollision(bullet,obstacle)) then
        table.insert(particles,NewParticle(bullet.x + (bullet.width/2),bullet.y+(bullet.height/2)))
        table.remove(player.bullets, index )
        table.remove(obstaculos,index2)
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
  for index, obstaculo in ipairs(obstaculos) do
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle('fill', obstaculo.x, obstaculo.y, obstaculo.width, obstaculo.height)
  end


end
