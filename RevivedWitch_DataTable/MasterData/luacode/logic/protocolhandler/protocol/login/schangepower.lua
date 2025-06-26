-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/login/schangepower.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_AllRoles):OnSRefreshPower(protocol.role)
  for k,v in pairs(protocol.role) do
    local userInfo = {}
    userInfo.key = k
    userInfo.name = "schangepower"
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_RoleInfoChange, nil, userInfo)
  end
  ;
  ((NekoData.DataManager).DM_Team):OnSRefreshPower(protocol.lineup)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

