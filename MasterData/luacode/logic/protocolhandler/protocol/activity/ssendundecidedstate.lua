local function p1(protocol)
  NekoData.DataManager.DM_UndecidedRoad:OnSSendUndecidedState(protocol)
  
  LogInfoFormat("ssendundecidedstate", "%s", protocol.state)
  if protocol.state == 1 then
    local csend = LuaNetManager.CreateProtocol("protocol.activity.copenundecidedroad")
    csend:Send()
  else
    LuaNotificationCenter.PostNotification(Common.n_RefreshUndecidedRoadState, nil, nil)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
