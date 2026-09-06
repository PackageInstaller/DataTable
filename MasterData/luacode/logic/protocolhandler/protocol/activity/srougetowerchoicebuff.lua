local function p1(protocol)
  NekoData.DataManager.DM_TowerV2:OnSRougeTowerChoiceBuff(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_TowerV2BuffChoice, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
