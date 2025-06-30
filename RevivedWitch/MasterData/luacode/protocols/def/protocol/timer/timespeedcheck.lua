-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/timer/timespeedcheck.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local TimeSpeedCheck = dataclass("TimeSpeedCheck", require("framework.net.protocol"))
TimeSpeedCheck.ProtocolType = 1702
TimeSpeedCheck.MaxSize = 65535
TimeSpeedCheck.clientTime = 0
TimeSpeedCheck.serverTime = 0
TimeSpeedCheck.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : TimeSpeedCheck
  ((TimeSpeedCheck.super).Ctor)(self, client)
end

TimeSpeedCheck.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.clientTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.serverTime) then
    return false
  end
  return true
end

TimeSpeedCheck.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return TimeSpeedCheck

