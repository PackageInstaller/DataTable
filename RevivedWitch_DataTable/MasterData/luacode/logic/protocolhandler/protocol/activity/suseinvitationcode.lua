-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/suseinvitationcode.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  if protocol.result == 1 then
    ((NekoData.DataManager).DM_Activity):CleanActivityById(8)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_RefreshUseInvite, nil, protocol)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_RefreshActivities, nil)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

