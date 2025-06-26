-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/crefreshshophomepage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRefreshShopHomepage = dataclass("CRefreshShopHomepage", require("framework.net.protocol"))
CRefreshShopHomepage.ProtocolType = 3628
CRefreshShopHomepage.MaxSize = 65535
CRefreshShopHomepage.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRefreshShopHomepage
  ((CRefreshShopHomepage.super).Ctor)(self, client)
end

CRefreshShopHomepage.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CRefreshShopHomepage.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CRefreshShopHomepage

