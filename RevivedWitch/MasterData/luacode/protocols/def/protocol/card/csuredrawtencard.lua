-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/card/csuredrawtencard.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CSureDrawTenCard = dataclass("CSureDrawTenCard", require("framework.net.protocol"))
CSureDrawTenCard.ProtocolType = 1524
CSureDrawTenCard.MaxSize = 65535
CSureDrawTenCard.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CSureDrawTenCard
  ((CSureDrawTenCard.super).Ctor)(self, client)
end

CSureDrawTenCard.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CSureDrawTenCard.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CSureDrawTenCard

