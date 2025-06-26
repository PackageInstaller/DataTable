-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/shalloweenshopredpoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SHalloweenShopRedPoint = dataclass("SHalloweenShopRedPoint", require("framework.net.protocol"))
SHalloweenShopRedPoint.ProtocolType = 3645
SHalloweenShopRedPoint.MaxSize = 65535
SHalloweenShopRedPoint.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SHalloweenShopRedPoint
  ((SHalloweenShopRedPoint.super).Ctor)(self, client)
end

SHalloweenShopRedPoint.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

SHalloweenShopRedPoint.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return SHalloweenShopRedPoint

