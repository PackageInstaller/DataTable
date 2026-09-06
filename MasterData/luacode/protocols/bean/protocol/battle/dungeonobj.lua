local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local DungeonObj = dataclass("DungeonObj")
DungeonObj.id = 0
DungeonObj.objType = 0
DungeonObj.objId = 0
DungeonObj.status = 0
DungeonObj.x = 0
DungeonObj.y = 0
DungeonObj.MONSTER = 1
DungeonObj.BOX = 2
DungeonObj.TASK = 3

function DungeonObj:Ctor()
end

function DungeonObj:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.objType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.objId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.status) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.x) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.y) then
    return false
  end
  return true
end

function DungeonObj:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.objType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.objId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.status = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.x = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.y = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return DungeonObj
