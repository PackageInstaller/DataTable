local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local flowerProgress = dataclass("flowerProgress")
flowerProgress.flowerScore = 0
flowerProgress.allFlower = 0

function flowerProgress:Ctor()
  self.rewardIds = {}
end

function flowerProgress:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.flowerScore) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.allFlower) then
    return false
  end
  local length = table.slen(self.rewardIds)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardIds[i]) then
      return false
    end
  end
  return true
end

function flowerProgress:Unmarshal(buffer)
  local ret = true
  ret, self.flowerScore = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.allFlower = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.rewardIds[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return flowerProgress
