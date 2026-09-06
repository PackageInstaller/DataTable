local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CollectionTask = dataclass("CollectionTask")
CollectionTask.id = 0
CollectionTask.needPointsID = 0
CollectionTask.needPoints = 0
CollectionTask.status = 0

function CollectionTask:Ctor()
  self.rewards = {}
end

function CollectionTask:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.needPointsID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.needPoints) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.status) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.rewards)) then
    return false
  end
  for key, value in pairs(self.rewards) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function CollectionTask:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.needPointsID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.needPoints = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.status = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    self.rewards[key] = value
  end
  return ret
end

return CollectionTask
