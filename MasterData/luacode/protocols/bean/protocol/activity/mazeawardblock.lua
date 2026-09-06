local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local MazeAwardBlock = dataclass("MazeAwardBlock")
MazeAwardBlock.blockType = 0
MazeAwardBlock.status = 0
MazeAwardBlock.itemId = 0
MazeAwardBlock.itemNum = 0
MazeAwardBlock.TO_FETCH = 0
MazeAwardBlock.FETCHED = 1

function MazeAwardBlock:Ctor()
end

function MazeAwardBlock:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.blockType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.status) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemNum) then
    return false
  end
  return true
end

function MazeAwardBlock:Unmarshal(buffer)
  local ret = true
  ret, self.blockType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.status = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.itemId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.itemNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return MazeAwardBlock
