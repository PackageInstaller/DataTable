local function p1(protocol)
  NekoData.DataManager.DM_TowerV2:OnSRougeTowerUpdateUnreceivedReward(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_TowerV2UpdateUnreceivedReward, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
