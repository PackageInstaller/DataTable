local function p1(protocol)
  NekoData.DataManager.DM_AllRoles:OnSRoleUpdateLv(protocol)
  
  local userInfo = {}
  userInfo.name = "sroleupdatelv"
  userInfo.key = protocol.roleId
  userInfo.levelandexp = {
    level = protocol.level,
    exp = protocol.exp,
    key = protocol.roleId
  }
  LuaNotificationCenter.PostNotification(Common.n_LevelUp, DM_AllRoles, userInfo)
  LuaNotificationCenter.PostNotification(Common.n_RoleInfoChange, DM_AllRoles, userInfo)
end

local function p2(protocol, client)
end

return {p1, p2}
