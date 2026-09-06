local function p1(protocol)
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.SpringFestivalActivityManagerID):SReceiveSpringBossReward(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_SReceiveSpringBossReward, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
