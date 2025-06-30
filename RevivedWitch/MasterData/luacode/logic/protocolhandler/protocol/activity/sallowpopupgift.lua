-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/sallowpopupgift.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  LogInfoFormat("sallowpopupgift", "--- activityID = %s ---", protocol.activityID)
  ;
  ((NekoData.DataManager).DM_Activity):OnSAllowPopUpGift(protocol)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshPopUpGift, nil, protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

