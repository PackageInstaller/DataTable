local function p1(protocol)
  NekoData.DataManager.DM_Tower:OnSMove2BattleIsland(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_TowerMove, {}, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
