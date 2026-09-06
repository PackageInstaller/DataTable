local function p1(protocol)
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.SpringFestivalActivityManagerID):SSpringBossState(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_SSpringBossState, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
