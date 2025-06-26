-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/ccheckshopredpoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CCheckShopRedpoint = dataclass("CCheckShopRedpoint", require("framework.net.protocol"))
CCheckShopRedpoint.ProtocolType = 3639
CCheckShopRedpoint.MaxSize = 65535
CCheckShopRedpoint.shoptype = 0
CCheckShopRedpoint.goodId = 0
CCheckShopRedpoint.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CCheckShopRedpoint
  ((CCheckShopRedpoint.super).Ctor)(self, client)
end

CCheckShopRedpoint.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.shoptype) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.goodId) then
    return false
  end
  return true
end

CCheckShopRedpoint.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCheckShopRedpoint

