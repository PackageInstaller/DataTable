local function p1(protocol)
  NekoData.DataManager.DM_Explore:OnSSySynchronizationRefreshNums(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_RefreshTimesChanged, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
