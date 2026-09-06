local function p1(protocol)
  LogInfoFormat("srefreshacttime", "activityId %s leftTime %s", protocol.activityId, protocol.leftTime)
  
  NekoData.DataManager.DM_Activity:OnSRefreshActTime(protocol)
  if protocol.activityId == NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.returnWelfareSignAwardActivityId and protocol.leftTime <= 0 then
    LogInfoFormat("srefreshacttime", "-- actId = %s ---", protocol.activityId)
    NekoData.DataManager.DM_Activity:GetManager(DataCommon.SignManagerID):OnSSignCrossDay(protocol.activityId)
    NekoData.DataManager.DM_Activity:OnActivityStop(protocol.activityId)
    NekoData.BehaviorManager.BM_Activity:OnSSignCrossDay(protocol.activityId)
    LuaNotificationCenter.PostNotification(Common.n_RefreshSignActivity, nil, protocol.activityId)
  elseif protocol.activityId == DataCommon.Activities.AccumulateCost then
    LuaNotificationCenter.PostNotification(Common.n_RefreshAccumulateCost, nil, nil)
  elseif protocol.activityId == DataCommon.Activities.OldPlayerBenefits then
    LuaNotificationCenter.PostNotification(Common.n_OnRefreshOldPlayerBenefits, nil, nil)
  elseif protocol.activityId == NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.returnBattlePass then
    if protocol.leftTime <= 0 then
      NekoData.DataManager.DM_ReturnWelfare:OnSReturnPass(nil)
    end
    LuaNotificationCenter.PostNotification(Common.n_RefreshReturnBattlePass, nil, protocol.activityId)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
