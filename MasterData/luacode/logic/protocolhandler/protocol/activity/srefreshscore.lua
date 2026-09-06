local function p1(protocol)
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.ChristmasActivityManagerID):OnSRefreshScore(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_RefreshChristmasScore, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
