local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenDiamondShop = dataclass("SOpenDiamondShop", require("framework.net.protocol"))
SOpenDiamondShop.ProtocolType = 3617
SOpenDiamondShop.MaxSize = 65535
SOpenDiamondShop.shopId = 0

function SOpenDiamondShop:Ctor(client)
  SOpenDiamondShop.super.Ctor(self, client)
  self.goods = {}
end

function SOpenDiamondShop:Marshal(buffer)
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
  return true
end

function SOpenDiamondShop:Unmarshal(buffer)
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
    self.goods[i] = require("protocols.bean.protocol.shop.mixgoodinfo").Create()
    if not self.goods[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SOpenDiamondShop
