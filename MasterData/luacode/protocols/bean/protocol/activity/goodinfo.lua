local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local GoodInfo = dataclass("GoodInfo")
GoodInfo.goodId = 0
GoodInfo.chargeId = 0
GoodInfo.moneyType = 0
GoodInfo.price = 0
GoodInfo.goodStatus = 0
GoodInfo.correspondGift = 0

function GoodInfo:Ctor()
  self.itemId = {}
  self.itemNum = {}
end

function GoodInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.goodId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.chargeId) then
    return false
  end
  local length = table.slen(self.itemId)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemId[i]) then
      return false
    end
  end
  local length = table.slen(self.itemNum)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemNum[i]) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.moneyType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.price) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.goodStatus) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.correspondGift) then
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
  ret, self.chargeId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.itemId[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.itemNum[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  ret, self.moneyType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.price = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.goodStatus = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.correspondGift = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return GoodInfo
