local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local MixGoodInfo = dataclass("MixGoodInfo")
MixGoodInfo.goodId = 0
MixGoodInfo.sortId = 0
MixGoodInfo.goodType = 0
MixGoodInfo.diamondSum = 0
MixGoodInfo.freeDiamondSum = 0
MixGoodInfo.giftId = 0
MixGoodInfo.goodRemain = 0
MixGoodInfo.moneyType = 0
MixGoodInfo.price = 0
MixGoodInfo.discount = 0
MixGoodInfo.discountPrice = 0
MixGoodInfo.pictureId = 0
MixGoodInfo.goodName = 0
MixGoodInfo.visiualEffect = 0
MixGoodInfo.condition = 0
MixGoodInfo.beginTime = 0
MixGoodInfo.endTime = 0
MixGoodInfo.optionId = 0

function MixGoodInfo:Ctor()
  self.itemId = {}
  self.itemSum = {}
end

function MixGoodInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.goodId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.sortId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.goodType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.diamondSum) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.freeDiamondSum) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.giftId) then
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
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.goodRemain) then
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
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.pictureId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.goodName) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.visiualEffect) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.condition) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.beginTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.endTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.optionId) then
    return false
  end
  return true
end

function MixGoodInfo:Unmarshal(buffer)
  local ret = true
  ret, self.goodId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.sortId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.goodType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.diamondSum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.freeDiamondSum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.giftId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
  ret, self.goodRemain = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
  ret, self.pictureId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.goodName = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.visiualEffect = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.condition = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
  ret, self.optionId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return MixGoodInfo
