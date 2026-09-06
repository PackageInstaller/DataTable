local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local DungeonZone = dataclass("DungeonZone")
DungeonZone.isReceived = 0
DungeonZone.autoExplore = 0
DungeonZone.openedBoxes = 0
DungeonZone.totalBoxes = 0

function DungeonZone:Ctor()
  self.checkPoint = require("protocols.bean.protocol.battle.dungeonpoint").Create()
  self.smallPoint = {}
end

function DungeonZone:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.isReceived) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.autoExplore) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.openedBoxes) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.totalBoxes) then
    return false
  end
  if not self.checkPoint:Marshal(buffer) then
    return false
  end
  local length = table.slen(self.smallPoint)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.smallPoint[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function DungeonZone:Unmarshal(buffer)
  local ret = true
  ret, self.isReceived = ProtocolBufferStaticFunctions.ReadInt16(buffer)
  if not ret then
    return ret
  end
  ret, self.autoExplore = ProtocolBufferStaticFunctions.ReadInt16(buffer)
  if not ret then
    return ret
  end
  ret, self.openedBoxes = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.totalBoxes = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.checkPoint:Unmarshal(buffer) then
    return false
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.smallPoint[i] = require("protocols.bean.protocol.battle.dungeonpoint").Create()
    if not self.smallPoint[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return DungeonZone
