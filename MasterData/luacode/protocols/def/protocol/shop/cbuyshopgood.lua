local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CBuyShopGood = dataclass("CBuyShopGood", require("framework.net.protocol"))
CBuyShopGood.ProtocolType = 3613
CBuyShopGood.MaxSize = 65535
CBuyShopGood.WaitProtocol = "protocol.notify.scancelloading"
CBuyShopGood.shopId = 0

function CBuyShopGood:Ctor(client)
  CBuyShopGood.super.Ctor(self, client)
  self.goods = {}
end

function CBuyShopGood:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.shopId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.goods)) then
    return false
  end
  for key, value in pairs(self.goods) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function CBuyShopGood:Unmarshal(buffer)
  local ret = true
  ret, self.shopId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    ret, value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    self.goods[key] = value
  end
  return ret
end

return CBuyShopGood
