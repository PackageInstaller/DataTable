local function p1(protocol)
  NekoData.DataManager.DM_AllRoles:OnSRoleRemove(protocol)
  
  if NekoData.DataManager.DM_AllRoles:CheckShowRoleEvolutionRed() then
    NekoData.BehaviorManager.BM_AllRoles:PostRoleEvolutionRedDataNotification()
  end
  if NekoData.DataManager.DM_AllRoles:CheckNewRoleRed() then
    LuaNotificationCenter.PostNotification(Common.n_RefreshNewRole, nil)
  end
  LuaNotificationCenter.PostNotification(Common.n_RoleRemove, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
