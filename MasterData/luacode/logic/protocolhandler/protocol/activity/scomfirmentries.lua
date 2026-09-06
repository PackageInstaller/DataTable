local function p1(protocol)
  NekoData.DataManager.DM_Activity:OnSShareActivity(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_RefreshShareActivity, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
