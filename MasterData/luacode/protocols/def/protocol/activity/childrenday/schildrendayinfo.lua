local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SChildrenDayInfo = dataclass("SChildrenDayInfo", require("framework.net.protocol"))
SChildrenDayInfo.ProtocolType = 2650
SChildrenDayInfo.MaxSize = 65535
SChildrenDayInfo.score = 0
SChildrenDayInfo.taskFinishLeft = 0
SChildrenDayInfo.LOCKED = 0
SChildrenDayInfo.FETCHED = 1
SChildrenDayInfo.TO_FETCH = 2

function SChildrenDayInfo:Ctor(client)
  SChildrenDayInfo.super.Ctor(self, client)
  self.awards = {}
  self.leftTimes = {}
end

function SChildrenDayInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.awards)) then
    return false
  end
  for key, value in pairs(self.awards) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.score) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.leftTimes)) then
    return false
  end
  for key, value in pairs(self.leftTimes) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.taskFinishLeft) then
    return false
  end
  return true
end

function SChildrenDayInfo:Unmarshal(buffer)
  local ret = true
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
    self.awards[key] = value
  end
  ret, self.score = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    self.leftTimes[key] = value
  end
  ret, self.taskFinishLeft = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChildrenDayInfo
