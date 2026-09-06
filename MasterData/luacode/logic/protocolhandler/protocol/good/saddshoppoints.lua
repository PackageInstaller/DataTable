local function p1(protocol)
  NekoData.DataManager.DM_Shop:OnSAddShopPoints(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_OnRefreshOldPlayerBenefits, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
