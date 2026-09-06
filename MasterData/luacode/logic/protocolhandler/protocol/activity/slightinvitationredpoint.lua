local function p1(protocol)
  warn("need to hide share red point")
  
  NekoData.DataManager.DM_Activity:UpdateInviteRedDot(protocol)
  LuaNotificationCenter.PostNotification(Common.n_RefreshActivities, nil, nil)
  LuaNotificationCenter.PostNotification(Common.n_RefreshActivityRewards, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
