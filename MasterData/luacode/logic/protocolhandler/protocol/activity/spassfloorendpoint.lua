local function p1(protocol)
  NekoData.DataManager.DM_TowerV2:OnSPassFloorEndPoint(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_TowerV2Reward, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
