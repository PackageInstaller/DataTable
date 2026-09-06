local function p1(protocol)
  NekoData.DataManager.DM_AllRoles:OnSRoleAdd(protocol)
  
  if NekoData.BehaviorManager.BM_AllRoles:IsShowRoleEvolutionRed() then
    NekoData.BehaviorManager.BM_AllRoles:PostRoleEvolutionRedDataNotification()
  end
  if NekoData.DataManager.DM_AllRoles:CheckNewRoleRed() then
    LuaNotificationCenter.PostNotification(Common.n_RefreshNewRole, nil)
  end
  local userInfo = {}
  userInfo.name = "sroleadd"
  userInfo.roleId = protocol.role.id
  LuaNotificationCenter.PostNotification(Common.n_RoleInfoChange, DM_AllRoles, userInfo)
end

local function p2(protocol, client)
end

return {p1, p2}
