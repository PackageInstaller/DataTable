local function p1(protocol)
  NekoData.DataManager.DM_Shop:HalloweenRedPoint(1)
  
  LuaNotificationCenter.PostNotification(Common.n_OnSRefreshHalloweenShopRedPoint, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
