local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGetShopInfo = dataclass("SGetShopInfo", require("framework.net.protocol"))
SGetShopInfo.ProtocolType = 3612
SGetShopInfo.MaxSize = 65535
SGetShopInfo.shopId = 0

function SGetShopInfo:Ctor(client)
  SGetShopInfo.super.Ctor(self, client)
  self.goods = {}
  self.rmtGoods = {}
end

function SGetShopInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.shopId) then
    return false
  end
  local length = table.slen(self.goods)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.goods[i]:Marshal(buffer) then
      return false
    end
  end
  local length = table.slen(self.rmtGoods)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.rmtGoods[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SGetShopInfo:Unmarshal(buffer)
  local ret = true
  ret, self.shopId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.goods[i] = require("protocols.bean.protocol.shop.goodinfo").Create()
    if not self.goods[i]:Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.rmtGoods[i] = require("protocols.bean.protocol.shop.mixgoodinfo").Create()
    if not self.rmtGoods[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SGetShopInfo
