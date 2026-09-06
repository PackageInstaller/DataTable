local function p1(protocol)
  LogInfoFormat("ssigncrossday", "-- actId = %s ---", protocol.activityId)
  
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.SignManagerID):OnSSignCrossDay(protocol.activityId)
  NekoData.DataManager.DM_Activity:OnActivityStop(protocol.activityId)
  NekoData.BehaviorManager.BM_Activity:OnSSignCrossDay(protocol.activityId)
  LuaNotificationCenter.PostNotification(Common.n_RefreshSignActivity, nil, protocol.activityId)
end

local function p2(protocol, client)
end

return {p1, p2}
