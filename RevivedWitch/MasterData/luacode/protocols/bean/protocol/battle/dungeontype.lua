-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/battle/dungeontype.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
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
DungeonType.Ctor = function(self)
  -- function num : 0_0
end

DungeonType.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

DungeonType.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return DungeonType

