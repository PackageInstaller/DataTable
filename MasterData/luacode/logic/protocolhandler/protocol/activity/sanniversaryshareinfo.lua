local function p1(protocol)
  local dm = NekoData.DataManager.DM_AnniversaryShare
  
  local bm = NekoData.BehaviorManager.BM_AnniversaryShare
  dm:OnSAnniversaryShareInfo(protocol)
  LuaNotificationCenter.PostNotification(Common.n_OnSAnniversaryShareInfo, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
