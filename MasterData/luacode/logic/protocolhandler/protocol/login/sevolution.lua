local function p1(protocol)
  NekoData.DataManager.DM_AllRoles:OnSEvolution(protocol)
  
  if NekoData.DataManager.DM_AllRoles:CheckShowRoleEvolutionRed() then
    NekoData.BehaviorManager.BM_AllRoles:PostRoleEvolutionRedDataNotification()
  end
  local userInfo = {}
  userInfo.name = "sevolution"
  userInfo.key = protocol.roleId
  userInfo.evolution = protocol.evolution
  LuaNotificationCenter.PostNotification(Common.n_RoleInfoChange, DM_AllRoles, userInfo)
end

local function p2(protocol, client)
end

return {p1, p2}
