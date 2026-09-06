local function p1(protocol)
  local dm = NekoData.DataManager.DM_ClientTimer
  
  local bm = NekoData.BehaviorManager.BM_ClientTimer
  dm:OnSCLientTimer(protocol)
  LuaNotificationCenter.PostNotification(Common.n_OnSCLientTimer, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
