local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local ShatteredZone = dataclass("ShatteredZone")
ShatteredZone.zoneIndex = 0
ShatteredZone.thisWeekState = 0

function ShatteredZone:Ctor()
  self.normalRewards = {}
  self.firstPassRewards = {}
  self.LineupsRecords = {}
end

function ShatteredZone:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.zoneIndex) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.normalRewards)) then
    return false
  end
  for key, value in pairs(self.normalRewards) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.firstPassRewards)) then
    return false
  end
  for key, value in pairs(self.firstPassRewards) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  local length = table.slen(self.LineupsRecords)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.LineupsRecords[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.thisWeekState) then
    return false
  end
  return true
end

function ShatteredZone:Unmarshal(buffer)
  local ret = true
  ret, self.zoneIndex = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    self.normalRewards[key] = value
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
    self.firstPassRewards[key] = value
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.LineupsRecords[i] = require("protocols.bean.protocol.activity.lineuprecord").Create()
    if not self.LineupsRecords[i]:Unmarshal(buffer) then
      return false
    end
  end
  ret, self.thisWeekState = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return ShatteredZone
