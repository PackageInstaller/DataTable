-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/login/srolelist.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_AllRoles):OnSRoleList(protocol)
  ;
  ((NekoData.BehaviorManager).BM_AllRoles):PostRoleEvolutionRedDataNotification()
  if ((NekoData.DataManager).DM_AllRoles):CheckNewRoleRed() then
    (LuaNotificationCenter.PostNotification)(Common.n_RefreshNewRole, nil)
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RoleInfoChange, DM_AllRoles, nil)
  ;
  ((NekoData.BehaviorManager).BM_RedPoint):OnItemChanged()
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

