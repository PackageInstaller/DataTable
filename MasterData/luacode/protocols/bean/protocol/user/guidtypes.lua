-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/user/guidtypes.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local GuidTypes = dataclass("GuidTypes")
GuidTypes.NEW_GUIDE_1 = 1
GuidTypes.TEN_DRAW = 2
GuidTypes.MAGIC_FIRST_WIN_SHITOUREN = 3
GuidTypes.FIRST_ENTER_DUNGEON = 4
GuidTypes.SPECIAL_ITEM = 5
GuidTypes.EQUIP_STRENGTHEN = 6
GuidTypes.AUTO_EXPLORE = 7
GuidTypes.COLLECT_LIGHT_SPOT = 8
GuidTypes.RUNE = 9
GuidTypes.SUPPORT_LIST = 10
GuidTypes.SUPPORT_GUIDE = 11
GuidTypes.BATTLE_RETREAT = 12
GuidTypes.DAILY_TASK = 13
GuidTypes.BOSS_RUSH = 14
GuidTypes.TOWER_RUSH = 15
GuidTypes.NEW_USER_TEN_DRAW = 16
GuidTypes.LEVEL_GIFT = 17
GuidTypes.SIDE_QUEST = 18
GuidTypes.BATTLE_2X = 19
GuidTypes.AG_COIN = 20
GuidTypes.EVERYDAY_SIGN = 21
GuidTypes.PARTY = 22
GuidTypes.ARENA = 23
GuidTypes.FOREST_BOSS_BACK = 2004
GuidTypes.mirror_1 = 2001
GuidTypes.YARD_APPEAR = 1215
GuidTypes.GUIDE_2007 = 2007
GuidTypes.GUIDE_2008 = 2008
GuidTypes.GUIDE_2009 = 2009
GuidTypes.GUIDE_2010 = 2010
GuidTypes.GUIDE_2003 = 2003
GuidTypes.FORGE_WORKER_APPEAR = 100
GuidTypes.Ctor = function(self)
  -- function num : 0_0
end

GuidTypes.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

GuidTypes.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return GuidTypes

