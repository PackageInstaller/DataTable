local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SBuyShopGood = dataclass("SBuyShopGood", require("framework.net.protocol"))
SBuyShopGood.ProtocolType = 3614
SBuyShopGood.MaxSize = 65535
SBuyShopGood.result = 0
SBuyShopGood.shopId = 0

function SBuyShopGood:Ctor(client)
  SBuyShopGood.super.Ctor(self, client)
  self.refresh = {}
end

function SBuyShopGood:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.shopId) then
    return false
  end
  local length = table.slen(self.refresh)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.refresh[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SBuyShopGood:Unmarshal(buffer)
  local ret = true
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
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
    self.refresh[i] = require("protocols.bean.protocol.shop.goodinfo").Create()
    if not self.refresh[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SBuyShopGood
