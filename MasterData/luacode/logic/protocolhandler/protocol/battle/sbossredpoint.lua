local function p1(protocol)
  NekoData.DataManager.DM_Game:OnSBossRedPoint(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_RefreshBossPanelRed, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
