-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/login/sevolution.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_AllRoles):OnSEvolution(protocol)
  if ((NekoData.DataManager).DM_AllRoles):CheckShowRoleEvolutionRed() then
    ((NekoData.BehaviorManager).BM_AllRoles):PostRoleEvolutionRedDataNotification()
  end
  local userInfo = {}
  userInfo.name = "sevolution"
  userInfo.key = protocol.roleId
  userInfo.evolution = protocol.evolution
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RoleInfoChange, DM_AllRoles, userInfo)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

