-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/login/sroleupdatebreaklv.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_AllRoles):OnSRoleUpdateBreakLv(protocol)
  do
    if protocol.breakType == 1 then
      local userInfo = {}
      userInfo.name = "sroleupdatebreaklv"
      userInfo.key = protocol.roleId
      userInfo.breakLv = protocol.breakLv
      userInfo.gainSkin = protocol.gainSkin
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_RoleInfoChange, DM_AllRoles, userInfo)
    end
    if protocol.gainSkin ~= 0 then
      (LuaNotificationCenter.PostNotification)(Common.n_SkinCheckedOrGain, nil, protocol.gainSkin)
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

