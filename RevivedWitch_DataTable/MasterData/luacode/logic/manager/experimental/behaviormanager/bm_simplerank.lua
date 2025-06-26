-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_simplerank.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local RankType = (LuaNetManager.GetBeanDef)("protocol.ranking.ranktype")
local SimpleRank = (LuaNetManager.GetBeanDef)("protocol.ranking.simplerank")
local BM_SimpleRank = class("BM_SimpleRank")
BM_SimpleRank.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._simpleRank = (NekoData.Data).simpleRank
end

BM_SimpleRank.GetSimpleRankData = function(self, rankType)
  -- function num : 0_1
  return ((self._simpleRank).rankData)[rankType]
end

BM_SimpleRank.GetRankTypeDef = function(self, rankType)
  -- function num : 0_2 , upvalues : RankType
  return RankType
end

BM_SimpleRank.GetSimpleRankDef = function(self, rankType)
  -- function num : 0_3 , upvalues : SimpleRank
  return SimpleRank
end

BM_SimpleRank.GetChristmasCallRankData = function(self)
  -- function num : 0_4 , upvalues : RankType
  return ((self._simpleRank).rankData)[RankType.CHRISTMAS_SUPPORT]
end

BM_SimpleRank.GetSpringFestivalRankData = function(self)
  -- function num : 0_5 , upvalues : RankType
  return ((self._simpleRank).rankData)[RankType.SPRING_FESTIVAL]
end

return BM_SimpleRank

