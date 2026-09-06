local function p1(protocol)
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.SummerActivityManagerID):OnRefreshFoodStallsStatus(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_RefreshFoodStallsStatus, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
