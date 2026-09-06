local function p1(protocol)
  NekoData.DataManager.DM_Gacha:OnSRefreshCardui(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_RefreshDrawCardPool, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
