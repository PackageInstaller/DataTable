local function p1(protocol)
  local dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.BirthDayActivityManagerID)
  
  local bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.BirthDayActivityManagerID)
  dm:OnSBirthdayActivity(protocol)
  if protocol.state == 0 then
    LuaNotificationCenter.PostNotification(Common.n_OnSBirthdayActivityEnd, nil, protocol)
  else
    bm:SendCActivityTasks()
    LuaNotificationCenter.PostNotification(Common.n_OnSBirthdayActivity, nil, protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
