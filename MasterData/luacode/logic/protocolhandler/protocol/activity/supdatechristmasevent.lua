local function p1(protocol)
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.ChristmasActivityManagerID):OnSUpdateConstructionEvent(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_OnSUpdateChristmasConstructionEvent, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
