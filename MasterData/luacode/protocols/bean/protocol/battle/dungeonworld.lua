local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local DungeonWorld = dataclass("DungeonWorld")
DungeonWorld.curZone = 0
DungeonWorld.clearZones = 0
DungeonWorld.totalZones = 0
DungeonWorld.isReceived = 0

function DungeonWorld:Ctor()
  self.zone = {}
end

function DungeonWorld:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.curZone) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.clearZones) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.totalZones) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.isReceived) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.zone)) then
    return false
  end
  for key, value in pairs(self.zone) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  return true
end

function DungeonWorld:Unmarshal(buffer)
  local ret = true
  ret, self.curZone = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.clearZones = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.totalZones = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.isReceived = ProtocolBufferStaticFunctions.ReadInt16(buffer)
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
    value = require("protocols.bean.protocol.battle.dungeonzone").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.zone[key] = value
  end
  return ret
end

return DungeonWorld
