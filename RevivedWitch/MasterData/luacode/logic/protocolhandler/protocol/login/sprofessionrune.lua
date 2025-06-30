-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/login/sprofessionrune.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_AllRoles):OnSProfessionRune(protocol)
  local userInfo = {}
  userInfo.name = "sprofessionrune"
  userInfo.key = protocol.roleId
  userInfo.professionRune = protocol.professionRune
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RoleInfoChange, DM_AllRoles, userInfo)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

