-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/timer/sservertime.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SServerTime = dataclass("SServerTime", require("framework.net.protocol"))
SServerTime.ProtocolType = 1701
SServerTime.MaxSize = 65535
SServerTime.time = 0
SServerTime.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SServerTime
  ((SServerTime.super).Ctor)(self, client)
end

SServerTime.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.time) then
    return false
  end
  return true
end

SServerTime.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SServerTime

