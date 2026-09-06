local function p1(protocol)
  NekoData.DataManager.DM_Shop:OnSShopDisplay(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_LoverRefreshShopDisplay, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
