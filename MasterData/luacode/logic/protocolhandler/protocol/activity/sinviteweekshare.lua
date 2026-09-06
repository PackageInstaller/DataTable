local function p1(protocol)
  NekoData.DataManager.DM_Activity:ClearInviteRedDot(1)
  
  LuaNotificationCenter.PostNotification(Common.n_RefreshActivities, nil, nil)
  LuaNotificationCenter.PostNotification(Common.n_RefreshActivityRewards, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
