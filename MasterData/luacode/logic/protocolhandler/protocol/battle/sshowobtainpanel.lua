local function p1(protocol)
  LuaNotificationCenter.PostNotification(Common.n_OnSShowObtainPanel, nil, protocol)
  
  NekoData.DataManager.DM_Game:OnSShowObtainPanel(protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
