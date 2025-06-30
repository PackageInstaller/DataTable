-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/ranking/ranktype.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local RankType = dataclass("RankType")
RankType.BOSS_CHALLENGE = 1
RankType.ARENA_PVP = 2
RankType.PARTY_ACTIVE = 5
RankType.PARTY_LEVEL = 6
RankType.UNDECIDED_CHALLENGE = 7
RankType.WATERMELON = 8
RankType.CHRISTMAS_SUPPORT = 9
RankType.SPRING_FESTIVAL = 10
RankType.WEEK_BOSS_CHALLENGE = 11
RankType.SUMMER_ECHO = 12
RankType.Ctor = function(self)
  -- function num : 0_0
end

RankType.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

RankType.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return RankType

