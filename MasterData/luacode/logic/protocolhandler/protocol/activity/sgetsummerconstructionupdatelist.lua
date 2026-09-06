local function p1(protocol)
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.SummerActivityManagerID):OnSGetSummerConstructionUpdateList(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_SGetSummerConstructionUpdateList, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
