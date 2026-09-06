local function p1(protocol)
  NekoData.DataManager.DM_AllRoles:OnSRefreshRole(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_RoleEnergyChanged, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
