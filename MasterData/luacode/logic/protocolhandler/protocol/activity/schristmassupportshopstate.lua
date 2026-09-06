local function p1(protocol)
  local dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.ChristmasCallActivityManagerID)
  
  local bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasCallActivityManagerID)
  dm:OnSChristmasSupportShopState(protocol)
  LuaNotificationCenter.PostNotification(Common.n_OnSChristmasSupportShopState, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
