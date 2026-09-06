local function p1(protocol)
  LogInfoFormat("sactivityshopreddot", "--- activityId = %s ---", protocol.activityId)
  
  if protocol.activityId == DataCommon.Activities.SwimSuit then
    local bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityManagerID)
    local dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.SummerActivityManagerID)
    dm:OnSActivityShopRedDot(protocol)
    LuaNotificationCenter.PostNotification(Common.n_SummerShopRedPoint, nil, nil)
  else
    if protocol.activityId == DataCommon.Activities.DoubleEleven then
      local dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.DoubleElevenActivityID)
      dm:OnSActivityShopRedDot(protocol)
    end
    LuaNotificationCenter.PostNotification(Common.n_RefreshActivityShopRedDot, nil, protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
