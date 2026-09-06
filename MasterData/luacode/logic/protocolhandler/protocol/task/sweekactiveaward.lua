local function p1(protocol)
  NekoData.DataManager.DM_Task:OnSWeekActiveAward(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_RefreshWeekTask, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
