local function p1(protocol)
  LogInfoFormat("srefreshpoptips", "activityID %s status %s", protocol.activityID, protocol.status)
  
  NekoData.DataManager.DM_Activity:OnSRefreshPopTips(protocol)
  LuaNotificationCenter.PostNotification(Common.n_ReturnWelfareRefreshPopTips, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
