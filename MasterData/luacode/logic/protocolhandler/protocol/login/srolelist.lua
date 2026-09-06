local function p1(protocol)
  NekoData.DataManager.DM_AllRoles:OnSRoleList(protocol)
  
  NekoData.BehaviorManager.BM_AllRoles:PostRoleEvolutionRedDataNotification()
  if NekoData.DataManager.DM_AllRoles:CheckNewRoleRed() then
    LuaNotificationCenter.PostNotification(Common.n_RefreshNewRole, nil)
  end
  LuaNotificationCenter.PostNotification(Common.n_RoleInfoChange, DM_AllRoles, nil)
  NekoData.BehaviorManager.BM_RedPoint:OnItemChanged()
end

local function p2(protocol, client)
end

return {p1, p2}
