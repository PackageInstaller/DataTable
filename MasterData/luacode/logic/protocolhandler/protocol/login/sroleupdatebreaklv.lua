local function p1(protocol)
  NekoData.DataManager.DM_AllRoles:OnSRoleUpdateBreakLv(protocol)
  
  if protocol.breakType == 1 then
    local userInfo = {}
    userInfo.name = "sroleupdatebreaklv"
    userInfo.key = protocol.roleId
    userInfo.breakLv = protocol.breakLv
    userInfo.gainSkin = protocol.gainSkin
    LuaNotificationCenter.PostNotification(Common.n_RoleInfoChange, DM_AllRoles, userInfo)
  end
  if protocol.gainSkin ~= 0 then
    LuaNotificationCenter.PostNotification(Common.n_SkinCheckedOrGain, nil, protocol.gainSkin)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
