-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sclienttimer.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SCLientTimer = dataclass("SCLientTimer", require("framework.net.protocol"))
SCLientTimer.ProtocolType = 2714
SCLientTimer.MaxSize = 65535
SCLientTimer.timeId = 0
SCLientTimer.time = 0
SCLientTimer.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SCLientTimer
  ((SCLientTimer.super).Ctor)(self, client)
end

SCLientTimer.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.timeId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.time) then
    return false
  end
  return true
end

SCLientTimer.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SCLientTimer

