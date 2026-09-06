local function p1(protocol)
  LogErrorFormat("srefreshpointstasks", "--- activityId = %s ---", protocol.activityID)
  
  if protocol.activityID == DataCommon.Activities.StarMirage then
    NekoData.DataManager.DM_Activity:GetManager(DataCommon.StarMirageManagerID):OnSRefreshPointsTasks(protocol)
  else
    NekoData.DataManager.DM_Activity:OnSRefreshPointsTasks(protocol)
  end
  LuaNotificationCenter.PostNotification(Common.n_RefreshActivityRewards, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
