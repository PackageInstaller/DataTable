-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/srandomlightspot.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRandomLightSpot = dataclass("SRandomLightSpot", require("framework.net.protocol"))
SRandomLightSpot.ProtocolType = 2343
SRandomLightSpot.MaxSize = 65535
SRandomLightSpot.leftNextRandomLightSpotTime = 0
SRandomLightSpot.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRandomLightSpot, _ENV
  ((SRandomLightSpot.super).Ctor)(self, client)
  self.light = ((require("protocols.bean.protocol.yard.light")).Create)()
end

SRandomLightSpot.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (self.light):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.leftNextRandomLightSpotTime) then
    return false
  end
  return true
end

SRandomLightSpot.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  if not (self.light):Unmarshal(buffer) then
    return false
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRandomLightSpot

