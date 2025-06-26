-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/slightactivityredpoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SLightActivityRedpoint = dataclass("SLightActivityRedpoint", require("framework.net.protocol"))
SLightActivityRedpoint.ProtocolType = 2511
SLightActivityRedpoint.MaxSize = 65535
SLightActivityRedpoint.activity = 0
SLightActivityRedpoint.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SLightActivityRedpoint
  ((SLightActivityRedpoint.super).Ctor)(self, client)
end

SLightActivityRedpoint.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activity) then
    return false
  end
  return true
end

SLightActivityRedpoint.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SLightActivityRedpoint

