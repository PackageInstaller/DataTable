local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local ShopInfo = dataclass("ShopInfo")
ShopInfo.shopId = 0
ShopInfo.shopType = 0
ShopInfo.moneyType = ""
ShopInfo.openType = 0
ShopInfo.openTime = 0
ShopInfo.closeTime = 0
ShopInfo.closeTimeShow = 0

function ShopInfo:Ctor()
end

function ShopInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.shopId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.shopType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.moneyType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.openType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.openTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.closeTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.closeTimeShow) then
    return false
  end
  return true
end

function ShopInfo:Unmarshal(buffer)
  local ret = true
  ret, self.shopId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.shopType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.moneyType = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.openType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.openTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.closeTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.closeTimeShow = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return ShopInfo
