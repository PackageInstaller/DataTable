local function p1(protocol)
  LogErrorFormat("sgetmidautumninfo", "--- leftTime = %s ---", protocol.leftTime)
  
  NekoData.DataManager.DM_Activity:OnSGetMidAutumnInfo(protocol)
  LuaNotificationCenter.PostNotification(Common.n_RefreshMidAutumnLeftTime, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
