backgroundMusic = nil
backgroundMusicIsPlaying = false
function playSound(location,volume,loop)

  love.audio.setVolume(volume)
  --Plays audio only once
  if(loop) then
    audio = love.audio.newSource(location)
    audio:setLooping(true)
  else
    audio = love.audio.newSource(location,"stream") -- Stream argument pre-loads sounds in the memory, good only for small sound files
  end
  audio.play(audio)
  return audio
end

function playBackgroundMusic()
  backgroundMusicIsPlaying = true
  backgroundMusic = playSound("media/audio/stellarartwars_-_Floating_Through_Time_(SAW_mix).mp3",0.5,true)
end

function stopBackgroundMusic()
  backgroundMusic:setLooping(false)
  love.audio.stop(backgroundMusic)
  backgroundMusicIsPlaying = false
end

function checkAndStopOrPlayBackgroundMusic()
  if love.keyboard.isDown('m')  then
    if(backgroundMusicIsPlaying) then
      stopBackgroundMusic()
    else
      playBackgroundMusic()
    end
  end
end
function playBlastSound()
  playSound("media/audio/blast.mp3",0.5,false)
end

function playLaserSound()
  playSound("media/audio/laser.mp3",0.5,false)
end
