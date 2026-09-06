local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenUndecidedRoad = dataclass("SOpenUndecidedRoad", require("framework.net.protocol"))
SOpenUndecidedRoad.ProtocolType = 2480
SOpenUndecidedRoad.MaxSize = 65535
SOpenUndecidedRoad.seasonId = 0
SOpenUndecidedRoad.totalScore = 0
SOpenUndecidedRoad.leftTime = 0
SOpenUndecidedRoad.day = 0

function SOpenUndecidedRoad:Ctor(client)
  SOpenUndecidedRoad.super.Ctor(self, client)
  self.battleIds = {}
  self.challenge = {}
end

function SOpenUndecidedRoad:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.seasonId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.totalScore) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.battleIds)) then
    return false
  end
  for key, value in pairs(self.battleIds) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.day) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.challenge)) then
    return false
  end
  for key, value in pairs(self.challenge) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SOpenUndecidedRoad:Unmarshal(buffer)
  local ret = true
  ret, self.seasonId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.totalScore = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
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
    self.battleIds[key] = value
  end
  ret, self.day = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    value = require("protocols.bean.protocol.activity.battleinfo").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.challenge[key] = value
  end
  return ret
end

return SOpenUndecidedRoad
