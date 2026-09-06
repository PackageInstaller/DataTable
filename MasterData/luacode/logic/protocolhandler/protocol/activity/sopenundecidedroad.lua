local function p1(protocol)
  NekoData.DataManager.DM_UndecidedRoad:OnSOpenUndecidedRoad(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_RefreshUndecidedRoadState, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
