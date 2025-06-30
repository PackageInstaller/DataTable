-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/sopendiamondshop.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SOpenDiamondShop = dataclass("SOpenDiamondShop", require("framework.net.protocol"))
SOpenDiamondShop.ProtocolType = 3617
SOpenDiamondShop.MaxSize = 65535
SOpenDiamondShop.shopId = 0
SOpenDiamondShop.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SOpenDiamondShop
  ((SOpenDiamondShop.super).Ctor)(self, client)
  self.goods = {}
end

SOpenDiamondShop.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.shopId) then
    return false
  end
  local length = (table.slen)(self.goods)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.goods)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SOpenDiamondShop.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
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
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

    (self.goods)[i] = ((require("protocols.bean.protocol.shop.mixgoodinfo")).Create)()
    if not ((self.goods)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SOpenDiamondShop

