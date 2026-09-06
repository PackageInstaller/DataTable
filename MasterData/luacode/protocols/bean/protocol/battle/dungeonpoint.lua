local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local DungeonPoint = dataclass("DungeonPoint")
DungeonPoint.sceneId = 0
DungeonPoint.spirit = 0
DungeonPoint.isPass = 0
DungeonPoint.openedBoxes = 0
DungeonPoint.totalBoxes = 0

function DungeonPoint:Ctor()
end

function DungeonPoint:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.sceneId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.spirit) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.isPass) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.openedBoxes) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.totalBoxes) then
    return false
  end
  return true
end

function DungeonPoint:Unmarshal(buffer)
  local ret = true
  ret, self.sceneId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.spirit = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.isPass = ProtocolBufferStaticFunctions.ReadInt16(buffer)
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
  return ret
end

return DungeonPoint
