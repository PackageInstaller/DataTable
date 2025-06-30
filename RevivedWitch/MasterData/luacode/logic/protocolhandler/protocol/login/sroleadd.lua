-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/login/sroleadd.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_AllRoles):OnSRoleAdd(protocol)
  if ((NekoData.BehaviorManager).BM_AllRoles):IsShowRoleEvolutionRed() then
    ((NekoData.BehaviorManager).BM_AllRoles):PostRoleEvolutionRedDataNotification()
  end
  if ((NekoData.DataManager).DM_AllRoles):CheckNewRoleRed() then
    (LuaNotificationCenter.PostNotification)(Common.n_RefreshNewRole, nil)
  end
  local userInfo = {}
  userInfo.name = "sroleadd"
  userInfo.roleId = (protocol.role).id
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RoleInfoChange, DM_AllRoles, userInfo)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

