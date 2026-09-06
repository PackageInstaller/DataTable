local function p1(protocol)
  NekoData.DataManager.DM_Game:OnSOpenBossPanel(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_RefreshBossPanelRed, nil)
  LuaNotificationCenter.PostNotification(Common.n_ReceiveBossRushInfo, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
