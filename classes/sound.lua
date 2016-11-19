function playSound(location,volume,loop)
  --Plays audio only once
  love.audio.setVolume(volume)
  love.audio.play(love.audio.newSource(location,"stream"))
end


function playBlastSound()
  playSound("media/audio/blast.mp3",0.5,false)
end

function playLaserSound()
  playSound("media/audio/laser.mp3",0.5,false)
end
