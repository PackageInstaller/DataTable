local function p1(protocol)
  local dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.DoubleElevenActivityID)
  
  local bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.DoubleElevenActivityID)
  dm:OnSSendDoubleElevenActivity(protocol)
  if protocol.state == 0 then
    LuaNotificationCenter.PostNotification(Common.n_OnDoubleElevenActivityEnd, nil, protocol)
  else
    bm:SendGetTasksProtocol()
    LuaNotificationCenter.PostNotification(Common.n_OnSSendDoubleElevenActivity, nil, protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
