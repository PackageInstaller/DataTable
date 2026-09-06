local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local DungeonSkill = dataclass("DungeonSkill")
DungeonSkill.id = 0
DungeonSkill.lefttimes = 0
DungeonSkill.lefttime = 0

function DungeonSkill:Ctor()
end

function DungeonSkill:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.lefttimes) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.lefttime) then
    return false
  end
  return true
end

function DungeonSkill:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.lefttimes = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.lefttime = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return DungeonSkill
