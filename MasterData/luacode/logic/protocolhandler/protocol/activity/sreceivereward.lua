local function p1(protocol)
  NekoData.DataManager.DM_UndecidedRoad:OnSreceiveReward(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_RefreshUndecidedRoadAward, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
