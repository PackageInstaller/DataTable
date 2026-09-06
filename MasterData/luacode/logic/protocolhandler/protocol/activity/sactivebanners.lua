local function p1(protocol)
  NekoData.DataManager.DM_Activity:OnSActiveBanners(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_RefreshActivities, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
