mega={}            --the animation class to help cleaning stuff
mega.list={}      --the list that contains all the animation separated by name and state


--frames is a table containing multiple tables each with img and dur
--if for whatever reason something else is required for animation, add it here first.
function mega.newAnimation(name,state,frames)
   if type(mega.list[name]) ~= "table" then      --if this is the first time receiving a particular name, initiate it first.
      mega.list[name]={}
   end


   local count=0
   mega.list[name][state]={}
   for i,v in ipairs(frames) do
      mega.list[name][state][i]={}
      mega.list[name][state][i].img=v.img
      mega.list[name][state][i].dur=v.dur
      count=count+1
   end
   mega.list[name][state].count=count            --the number of frames this animation contains.
   mega.list[name][state].current=1            --the current frame.
   mega.list[name][state].totaltime=0            --total time since last frame was changed.

end

--Forces the animation system to display the next frame, setting the total time to -1 has a special meaning.
function mega.pushanimation(name,state)
   mega.list[name][state].totaltime=-1
end

--The heart of the thing, call this function from your update function.
function mega.animate(name,state,dt)
   local index = mega.list[name][state].current         --not sure if this makes stuff faster, but it certainly makes reading the code easier.
   local totaltime = mega.list[name][state].totaltime


   if totaltime < 0 then            --skips all the ugly stuff below
      nextframe(index,name,state)

   else

      totaltime=totaltime+dt
      mega.list[name][state].totaltime = totaltime

      if not (totaltime < mega.list[name][state][index].dur) then
         nextframe(index,name,state)
      end
   end
   return mega.list[name][state][index].img
end


--A secret function to make reading the code easier, forces the next frame
function nextframe(index,name,state)
   index=index+1
   if index>mega.list[name][state].count then
      index=1
   end
   mega.list[name][state].current = index
   mega.list[name][state].totaltime=0
end
