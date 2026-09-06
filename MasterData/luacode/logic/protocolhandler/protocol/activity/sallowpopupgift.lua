local function p1(protocol)
  LogInfoFormat("sallowpopupgift", "--- activityID = %s ---", protocol.activityID)
  
  NekoData.DataManager.DM_Activity:OnSAllowPopUpGift(protocol)
  LuaNotificationCenter.PostNotification(Common.n_RefreshPopUpGift, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
