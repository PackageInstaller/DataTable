local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local ForesightGoodInfo = dataclass("ForesightGoodInfo")
ForesightGoodInfo.goodId = 0
ForesightGoodInfo.moneyType = 0
ForesightGoodInfo.price = 0
ForesightGoodInfo.pictureId = 0
ForesightGoodInfo.goodName = 0

function ForesightGoodInfo:Ctor()
  self.itemId = {}
  self.itemSum = {}
end

function ForesightGoodInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.goodId) then
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
  local length = table.slen(self.itemSum)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemSum[i]) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.moneyType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.price) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.pictureId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.goodName) then
    return false
  end
  return true
end

function ForesightGoodInfo:Unmarshal(buffer)
  local ret = true
  ret, self.goodId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    ret, self.itemSum[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
  ret, self.pictureId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.goodName = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return ForesightGoodInfo
