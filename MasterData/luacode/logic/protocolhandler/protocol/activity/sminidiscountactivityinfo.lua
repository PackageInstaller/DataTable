local function p1(protocol)
  NekoData.DataManager.DM_Welfare:OnMinDiscountInfo(protocol)
  
  LogInfoFormat("sminidiscountactivityinfo", "activityId %s leftTime %s", DataCommon.Activities.MinDiscount, protocol.leftTime)
  NekoData.DataManager.DM_Activity:OnSRefreshActTime({
    activityId = DataCommon.Activities.MinDiscount,
    leftTime = protocol.leftTime
  })
  LuaNotificationCenter.PostNotification(Common.n_OnRefreshMinDiscount, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
