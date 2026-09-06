local function p1(protocol)
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.SummerActivityManagerID):OnSUpdateConstructionEvent(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_SUpdateConstructionEvent, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
