local function p1(protocol)
  local dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.ChristmasCallActivityManagerID)
  
  local bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasCallActivityManagerID)
  dm:OnSCheckGainNumber(protocol)
  LuaNotificationCenter.PostNotification(Common.n_OnSCheckGainNumber, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
