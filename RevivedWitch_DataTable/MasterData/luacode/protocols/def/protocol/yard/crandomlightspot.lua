-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/crandomlightspot.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRandomLightSpot = dataclass("CRandomLightSpot", require("framework.net.protocol"))
CRandomLightSpot.ProtocolType = 2342
CRandomLightSpot.MaxSize = 65535
CRandomLightSpot.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRandomLightSpot
  ((CRandomLightSpot.super).Ctor)(self, client)
end

CRandomLightSpot.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CRandomLightSpot.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CRandomLightSpot

