local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local DungeonType = dataclass("DungeonType")
DungeonType.NONE = 0
DungeonType.SPECIAL = 1
DungeonType.MAIN = 2
DungeonType.RESOURCE = 3
DungeonType.BOSS = 4
DungeonType.AUTO = 5
DungeonType.TOWER = 6
DungeonType.SIDE_QUEST = 7
DungeonType.ACTIVITY = 8

function DungeonType:Ctor()
end

function DungeonType:Marshal(buffer)
  return true
end

function DungeonType:Unmarshal(buffer)
  local ret = true
  return ret
end

return DungeonType
