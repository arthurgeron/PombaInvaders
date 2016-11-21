function playSound(location,volume,loop)

  love.audio.setVolume(volume)
  --Plays audio only once
  if(loop) then
    audio = love.audio.newSource(location)
    audio:setLooping(true)
  else
    audio = love.audio.newSource(location,"stream") -- Stream argument pre-loads sounds in the memory, good only for small sound files
  end
  love.audio.play(audio)
end


function playBlastSound()
  playSound("media/audio/blast.mp3",0.5,false)
end

function playLaserSound()
  playSound("media/audio/laser.mp3",0.5,false)
end
