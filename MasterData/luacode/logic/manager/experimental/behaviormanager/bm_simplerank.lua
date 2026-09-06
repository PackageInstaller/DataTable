local RankType = LuaNetManager.GetBeanDef("protocol.ranking.ranktype")
local SimpleRank = LuaNetManager.GetBeanDef("protocol.ranking.simplerank")
local BM_SimpleRank = class("BM_SimpleRank")

function BM_SimpleRank:Ctor()
  self._simpleRank = NekoData.Data.simpleRank
end

function BM_SimpleRank:GetSimpleRankData(rankType)
  return self._simpleRank.rankData[rankType]
end

function BM_SimpleRank:GetRankTypeDef(rankType)
  return RankType
end

function BM_SimpleRank:GetSimpleRankDef(rankType)
  return SimpleRank
end

function BM_SimpleRank:GetChristmasCallRankData()
  return self._simpleRank.rankData[RankType.CHRISTMAS_SUPPORT]
end

function BM_SimpleRank:GetSpringFestivalRankData()
  return self._simpleRank.rankData[RankType.SPRING_FESTIVAL]
end

function BM_SimpleRank:GetTowerV2RankData()
  return self._simpleRank.rankData[RankType.ROUGE_TOWER]
end

return BM_SimpleRank
