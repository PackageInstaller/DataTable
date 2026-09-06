local function p1(protocol)
  local dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.BirthDayActivityManagerID)
  
  local bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.BirthDayActivityManagerID)
  dm:OnSChangeWish(protocol)
  LuaNotificationCenter.PostNotification(Common.n_OnSChangeWish, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
