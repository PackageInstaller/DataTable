-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/scollectlightspot.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SCollectLightSpot = dataclass("SCollectLightSpot", require("framework.net.protocol"))
SCollectLightSpot.ProtocolType = 2345
SCollectLightSpot.MaxSize = 65535
SCollectLightSpot.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SCollectLightSpot, _ENV
  ((SCollectLightSpot.super).Ctor)(self, client)
  self.light = ((require("protocols.bean.protocol.yard.light")).Create)()
end

SCollectLightSpot.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.light):Marshal(buffer) then
    return false
  end
  return true
end

SCollectLightSpot.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.light):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SCollectLightSpot

