local function p1(protocol)
  NekoData.DataManager.DM_WeekBoss:OnSWeekBossRedPoint(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_SWeekBossRedPoint, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
