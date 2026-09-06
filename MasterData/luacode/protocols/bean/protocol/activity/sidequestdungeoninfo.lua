local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SideQuestDungeonInfo = dataclass("SideQuestDungeonInfo")
SideQuestDungeonInfo.DungeonID = 0
SideQuestDungeonInfo.hasPassed = 0

function SideQuestDungeonInfo:Ctor()
  self.questInfo = {}
end

function SideQuestDungeonInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.DungeonID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.questInfo)) then
    return false
  end
  for key, value in pairs(self.questInfo) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.hasPassed) then
    return false
  end
  return true
end

function SideQuestDungeonInfo:Unmarshal(buffer)
  local ret = true
  ret, self.DungeonID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    self.questInfo[key] = value
  end
  ret, self.hasPassed = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SideQuestDungeonInfo
