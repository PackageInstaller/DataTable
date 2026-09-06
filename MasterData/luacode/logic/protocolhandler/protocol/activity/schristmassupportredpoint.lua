local function p1(protocol)
  local dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.ChristmasCallActivityManagerID)
  
  local bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasCallActivityManagerID)
  dm:OnSChristmasSupportRedpoint(protocol)
  LuaNotificationCenter.PostNotification(Common.n_OnSChristmasSupportRedpoint, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
