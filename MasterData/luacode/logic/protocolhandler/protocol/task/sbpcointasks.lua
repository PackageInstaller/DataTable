local function p1(protocol)
  local actType = DataCommon.GiftOfTimeActivityManagerID
  
  NekoData.DataManager.DM_Activity:GetManager(actType):OnSCoinTasks(protocol)
  LuaNotificationCenter.PostNotification(Common.n_NewDreamSpiralTaskRefresh, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
