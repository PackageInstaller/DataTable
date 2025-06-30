-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/copenshop.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenShop = dataclass("COpenShop", require("framework.net.protocol"))
COpenShop.ProtocolType = 3616
COpenShop.MaxSize = 65535
COpenShop.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenShop
  ((COpenShop.super).Ctor)(self, client)
end

COpenShop.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

COpenShop.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return COpenShop

