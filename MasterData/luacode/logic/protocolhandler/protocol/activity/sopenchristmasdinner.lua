local function p1(protocol)
  LogInfoFormat("sopenchristmasdinner", "isOpen:%s leftTime:%s waiter:%s snack:%s used:%s", protocol.isOpen, protocol.leftTime, protocol.waiter, protocol.snack, protocol.used)
  
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.ChristmasActivityManagerID):OnRefreshFoodStallsStatus(protocol)
  LuaNotificationCenter.PostNotification(Common.n_OnRefreshChristmasFoodStallsStatus, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
