-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/good/srefreshrolegood.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(protocol.roleId)
  ;
  ((NekoData.DataManager).DM_AllRoles):OnSRefreshRoleGood(protocol)
  do
    if role then
      local data = {}
      data.id = protocol.roleId
      data.canDrawAward = role:IsShowRelationRedDot()
      ;
      ((NekoData.DataManager).DM_HandBook):OnSRefreshRoleFavorAwardStatus(data)
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_RefreshRoleFavorAwardStatus, nil, data)
    end
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_RefreshRoleGood, nil, protocol)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

