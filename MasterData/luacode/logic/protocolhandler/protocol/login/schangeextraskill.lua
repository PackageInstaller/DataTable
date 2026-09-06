local function p1(protocol)
  NekoData.DataManager.DM_AllRoles:OnSChangeExtraSkill(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_RoleSkillChange, DM_AllRoles, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
