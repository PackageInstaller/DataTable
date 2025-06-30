-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/login/sroleupdateproperties.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_AllRoles):OnSRoleUpdateProperties(protocol)
  local userInfo = {}
  userInfo.name = "sroleupdateproperties"
  userInfo.key = protocol.roleId
  userInfo.properties = protocol.properties
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RoleInfoChange, nil, userInfo)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_UpdateProperties, nil, protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

