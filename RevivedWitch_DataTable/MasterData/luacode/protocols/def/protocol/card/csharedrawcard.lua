-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/card/csharedrawcard.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CShareDrawCard = dataclass("CShareDrawCard", require("framework.net.protocol"))
CShareDrawCard.ProtocolType = 1530
CShareDrawCard.MaxSize = 65535
CShareDrawCard.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CShareDrawCard
  ((CShareDrawCard.super).Ctor)(self, client)
end

CShareDrawCard.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CShareDrawCard.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CShareDrawCard

