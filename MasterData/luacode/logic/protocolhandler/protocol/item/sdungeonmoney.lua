local function p1(protocol)
  NekoData.DataManager.DM_Dungeon:OnSDungeonMoney(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_RefreshDungeonMoney, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
