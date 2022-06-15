local f19Down = 0
local f18Down = 0
local f17Down = 0

function showAlert(text, time)
  hs.alert.closeAll(0.0)

  for _, screen in ipairs(hs.screen.allScreens()) do
    hs.alert.show(text, {}, screen, time)
  end
end

function showCurrentSongAlert()
  hs.timer.doAfter(0.1, function() showAlert("Playing: " .. hs.spotify.getCurrentTrack(), 0.75) end)
end

function changeVolume(diff)
    local current = hs.audiodevice.defaultOutputDevice():volume()
    local new = math.min(100, math.max(0, math.floor(current + diff)))
    if new > 0 then
      hs.audiodevice.defaultOutputDevice():setMuted(false)
    else
      hs.audiodevice.defaultOutputDevice():setMuted(true)
    end
    showAlert("Volume: " .. generateProgressBar(new) .. " (" .. new .. "%)", 0.75)
    hs.audiodevice.defaultOutputDevice():setVolume(new)
end

function changeSpotifyVolume(diff)
  hs.spotify.setVolume(vol)
end


function generateProgressBar(val)
  function genPos(val, pos)
      local a = val - ((pos)*10)
      
      if a < 0 and a > -10 then
          return val - (10*(pos-1))
      elseif a <= -10 then
          return "-"
      else
          return "="
      end
      return "-"
  end
  
  local s = "|" 
     
  for i=1,10 do
    s = s..genPos(val, i)
  end
     
  s = s.."|"
  return s
end

z = hs.eventtap.new({hs.eventtap.event.types.scrollWheel}, function(e)
  local scroll = e:getProperty(hs.eventtap.event.properties.scrollWheelEventDeltaAxis1)

  if f19Down == 1 then
    if scroll < 0 then
      changeVolume(4)
      
      return true
    elseif scroll > 0 then
      changeVolume(-4)
      
      return true
    end
  elseif f18Down == 1 then
    -- Adjust spotify volume
    if scroll < 0 then
      hs.spotify.volumeUp()
      showAlert("Spotify: " .. generateProgressBar(hs.spotify.getVolume()) .. " (" .. hs.spotify.getVolume() .. "%)", 0.75)
      
      return true
    elseif scroll > 0 then
      hs.spotify.volumeDown()
      showAlert("Spotify: " .. generateProgressBar(hs.spotify.getVolume()) .. " (" .. hs.spotify.getVolume() .. "%)", 0.75)
      
      return true
    end
  end
end):start()

leftMouse = hs.eventtap.new({hs.eventtap.event.types.leftMouseDown}, function (e)
  if f19Down == 1 then
    hs.spotify.next()
    showCurrentSongAlert()
    
    return true -- stop propagation
  elseif f18Down == 1 then
    hs.spotify.ff()
    
    return true -- stop propagation
  end

end):start()

rightMouse = hs.eventtap.new({hs.eventtap.event.types.rightMouseDown}, function (e)
  if f19Down == 1 then
    hs.spotify.previous()
    showCurrentSongAlert()
    
    return true -- stop propagation
  elseif f18Down == 1 then
    hs.spotify.rw()
    
    return true -- stop propagation
  end

end):start()

-- Bind keys
hs.hotkey.bind({}, "f19", function() f19Down = 1 end, function() f19Down = 0 end)
hs.hotkey.bind({}, "f18", function() f18Down = 1 end, function() f18Down = 0 end)
--hs.hotkey.bind({}, "f17", function() f17Down = 1 end, function() f17Down = 0 end)

-- Bind middle mouse
mouseButtons = hs.eventtap.new({ hs.eventtap.event.types.otherMouseDown }, function(e)
  local mouseButton = e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber'])
  if mouseButton == 2 then
    if f19Down == 1 then
      hs.spotify.playpause()
      showCurrentSongAlert()
      --print("Pause spotify")
      return true
    end
  elseif mouseButton == 3 then
    if f18Down == 1 then
      --print("deafen")
      return true -- drop propagation, discord handles binding at input level
    end
  elseif mouseButton == 4 then
    if f18Down == 1 then
      -- print("mute")
      return true -- drop propagation, discord handles binding at input level
    end
  end
end):start()