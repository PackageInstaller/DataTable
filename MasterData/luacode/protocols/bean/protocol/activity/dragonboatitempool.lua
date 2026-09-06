local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local DragonBoatItemPool = dataclass("DragonBoatItemPool")
DragonBoatItemPool.poolId = 0

function DragonBoatItemPool:Ctor()
  self.itemId = {}
  self.itemNum = {}
end

function DragonBoatItemPool:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.poolId) then
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
  return true
end

function DragonBoatItemPool:Unmarshal(buffer)
  local ret = true
  ret, self.poolId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
  return ret
end

return DragonBoatItemPool
