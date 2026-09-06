local function p1(protocol)
  NekoData.DataManager.DM_Tower:OnSRenewRolesHPinTower(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_TowerRoleHPRefresh, {}, protocol.status)
end

local function p2(protocol, client)
end

return {p1, p2}
