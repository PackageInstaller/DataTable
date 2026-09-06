local function p1(protocol)
  NekoData.DataManager.DM_WeekBoss:OnSWeekBossTime(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_SWeekBossTime, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
