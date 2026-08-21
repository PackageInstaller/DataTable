-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cclienttimer.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CCLientTimer = dataclass("CCLientTimer", require("framework.net.protocol"))
CCLientTimer.ProtocolType = 2713
CCLientTimer.MaxSize = 65536
CCLientTimer.timeId = 0
CCLientTimer.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CCLientTimer
  ((CCLientTimer.super).Ctor)(self, client)
end

CCLientTimer.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.timeId) then
    return false
  end
  return true
end

CCLientTimer.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCLientTimer

