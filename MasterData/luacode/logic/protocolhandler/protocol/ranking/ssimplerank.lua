local function p1(protocol)
  local RankType = NekoData.BehaviorManager.BM_SimpleRank:GetRankTypeDef()
  
  if protocol.rankType == RankType.FLOWER_SEND or protocol.rankType == RankType.FLOWER_RECEIVE then
  else
    local dm = NekoData.DataManager.DM_SimpleRank
    dm:OnSSimpleRank(protocol)
  end
  LuaNotificationCenter.PostNotification(Common.n_OnSSimpleRank, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
