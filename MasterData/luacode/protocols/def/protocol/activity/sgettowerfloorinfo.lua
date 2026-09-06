local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGetTowerFloorInfo = dataclass("SGetTowerFloorInfo", require("framework.net.protocol"))
SGetTowerFloorInfo.ProtocolType = 2415
SGetTowerFloorInfo.MaxSize = 65535
SGetTowerFloorInfo.enterType = 0
SGetTowerFloorInfo.passedPoints = 0
SGetTowerFloorInfo.highestPointID = 0
SGetTowerFloorInfo.time2reset = 0
SGetTowerFloorInfo.autoExploreUnlock = 0
SGetTowerFloorInfo.autoExploreState = 0
SGetTowerFloorInfo.rewardRedPoint = 0
SGetTowerFloorInfo.buffNum4Reset = 0

function SGetTowerFloorInfo:Ctor(client)
  SGetTowerFloorInfo.super.Ctor(self, client)
  self.points = {}
  self.buffList = {}
  self.rolesState = {}
  self.buff4Choice = {}
  self.unreceivedReward = {}
end

function SGetTowerFloorInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.enterType) then
    return false
  end
  local length = table.slen(self.points)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.points[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.passedPoints) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.highestPointID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.time2reset) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.buffList)) then
    return false
  end
  for key, value in pairs(self.buffList) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.rolesState)) then
    return false
  end
  for key, value in pairs(self.rolesState) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.autoExploreUnlock) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.autoExploreState) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardRedPoint) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.buffNum4Reset) then
    return false
  end
  local length = table.slen(self.buff4Choice)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.buff4Choice[i]) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.unreceivedReward)) then
    return false
  end
  for key, value in pairs(self.unreceivedReward) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SGetTowerFloorInfo:Unmarshal(buffer)
  local ret = true
  ret, self.enterType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.points[i] = require("protocols.bean.protocol.activity.pointinfo").Create()
    if not self.points[i]:Unmarshal(buffer) then
      return false
    end
  end
  ret, self.passedPoints = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.highestPointID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.time2reset = ProtocolBufferStaticFunctions.ReadInt64(buffer)
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
    self.buffList[key] = value
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
    self.rolesState[key] = value
  end
  ret, self.autoExploreUnlock = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.autoExploreState = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.rewardRedPoint = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.buffNum4Reset = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.buff4Choice[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
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
    self.unreceivedReward[key] = value
  end
  return ret
end

return SGetTowerFloorInfo
