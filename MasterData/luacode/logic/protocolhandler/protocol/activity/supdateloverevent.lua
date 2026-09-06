local function p1(protocol)
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.LoverActivityManagerID):OnSUpdateConstructionEvent(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_OnSUpdateLoverConstructionEvent, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
