-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/sbuyshopgood.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SBuyShopGood = dataclass("SBuyShopGood", require("framework.net.protocol"))
SBuyShopGood.ProtocolType = 3614
SBuyShopGood.MaxSize = 65535
SBuyShopGood.result = 0
SBuyShopGood.shopId = 0
SBuyShopGood.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SBuyShopGood
  ((SBuyShopGood.super).Ctor)(self, client)
  self.refresh = {}
end

SBuyShopGood.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.result) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.shopId) then
    return false
  end
  local length = (table.slen)(self.refresh)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.refresh)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SBuyShopGood.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R8 in 'UnsetPending'

    (self.refresh)[i] = ((require("protocols.bean.protocol.shop.goodinfo")).Create)()
    if not ((self.refresh)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SBuyShopGood

