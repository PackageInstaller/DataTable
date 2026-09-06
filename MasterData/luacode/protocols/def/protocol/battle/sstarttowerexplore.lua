local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SStartTowerExplore = dataclass("SStartTowerExplore", require("framework.net.protocol"))
SStartTowerExplore.ProtocolType = 1982
SStartTowerExplore.MaxSize = 65535
SStartTowerExplore.mapShowType = 0
SStartTowerExplore.playerPos = 0
SStartTowerExplore.currentTowerFloor = 0
SStartTowerExplore.totalFloors = 0
SStartTowerExplore.towerFloorId = 0
SStartTowerExplore.towerID = 0

function SStartTowerExplore:Ctor(client)
  SStartTowerExplore.super.Ctor(self, client)
  self.mapList = {}
  self.linueupStatue = {}
end

function SStartTowerExplore:Marshal(buffer)
  local length = table.slen(self.mapList)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.mapList[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.mapShowType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.playerPos) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.linueupStatue)) then
    return false
  end
  for key, value in pairs(self.linueupStatue) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.currentTowerFloor) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.totalFloors) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.towerFloorId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.towerID) then
    return false
  end
  return true
end

function SStartTowerExplore:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.mapList[i] = require("protocols.bean.protocol.battle.squreinfo").Create()
    if not self.mapList[i]:Unmarshal(buffer) then
      return false
    end
  end
  ret, self.mapShowType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.playerPos = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    self.linueupStatue[key] = value
  end
  ret, self.currentTowerFloor = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.totalFloors = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.towerFloorId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.towerID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SStartTowerExplore
