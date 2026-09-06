local function p1(protocol)
  NekoData.DataManager.DM_AllRoles:OnSProfessionRune(protocol)
  
  local userInfo = {}
  userInfo.name = "sprofessionrune"
  userInfo.key = protocol.roleId
  userInfo.professionRune = protocol.professionRune
  LuaNotificationCenter.PostNotification(Common.n_RoleInfoChange, DM_AllRoles, userInfo)
end

local function p2(protocol, client)
end

return {p1, p2}
