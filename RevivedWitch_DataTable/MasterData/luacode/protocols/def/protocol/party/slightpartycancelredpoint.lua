-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/slightpartycancelredpoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SLightPartyCancelRedpoint = dataclass("SLightPartyCancelRedpoint", require("framework.net.protocol"))
SLightPartyCancelRedpoint.ProtocolType = 5037
SLightPartyCancelRedpoint.MaxSize = 65535
SLightPartyCancelRedpoint.redpointType = 0
SLightPartyCancelRedpoint.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SLightPartyCancelRedpoint
  ((SLightPartyCancelRedpoint.super).Ctor)(self, client)
end

SLightPartyCancelRedpoint.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.redpointType) then
    return false
  end
  return true
end

SLightPartyCancelRedpoint.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SLightPartyCancelRedpoint

