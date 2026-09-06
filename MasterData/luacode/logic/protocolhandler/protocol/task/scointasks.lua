local function p1(protocol)
  local actType = DataCommon.AgCoinActivityID
  
  NekoData.DataManager.DM_Activity:GetManager(actType):OnSCoinTasks(protocol)
  LuaNotificationCenter.PostNotification(Common.n_DreamSpiralTaskRefresh, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
