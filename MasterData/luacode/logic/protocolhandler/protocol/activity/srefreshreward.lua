local function p1(protocol)
  LuaNotificationCenter.PostNotification(Common.n_ReturnPlayerRewardRefresh, nil, protocol)
  
  NekoData.DataManager.DM_ReturnWelfare:OnSRefreshReward(protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
