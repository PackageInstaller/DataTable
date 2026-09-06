local function p1(protocol)
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.SummerActivityManagerID):OnSUpdateSummerConstruction(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_SUpdateSummerConstruction, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
