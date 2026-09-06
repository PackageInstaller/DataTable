local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local GoodInfo = dataclass("GoodInfo")
GoodInfo.goodId = 0
GoodInfo.sortId = 0
GoodInfo.itemId = 0
GoodInfo.itemSum = 0
GoodInfo.goodRemain = 0
GoodInfo.maxRemain = 0
GoodInfo.moneyType = 0
GoodInfo.price = 0
GoodInfo.discount = 0
GoodInfo.discountPrice = 0
GoodInfo.beginTime = 0
GoodInfo.endTime = 0
GoodInfo.status = 0
GoodInfo.NORMAL = 0
GoodInfo.OVER_LIMIT = 1

function GoodInfo:Ctor()
end

function GoodInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.goodId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.sortId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemSum) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.goodRemain) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.maxRemain) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.moneyType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.price) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.discount) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.discountPrice) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.beginTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.endTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.status) then
    return false
  end
  return true
end

function GoodInfo:Unmarshal(buffer)
  local ret = true
  ret, self.goodId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.sortId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.itemId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.itemSum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.goodRemain = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.maxRemain = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.moneyType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.price = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.discount = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.discountPrice = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.beginTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.endTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.status = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return GoodInfo
