-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/sopenchristmasdinner.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  LogInfoFormat("sopenchristmasdinner", "isOpen:%s leftTime:%s waiter:%s snack:%s used:%s", protocol.isOpen, protocol.leftTime, protocol.waiter, protocol.snack, protocol.used)
  ;
  (((NekoData.DataManager).DM_Activity):GetManager(DataCommon.ChristmasActivityManagerID)):OnRefreshFoodStallsStatus(protocol)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_OnRefreshChristmasFoodStallsStatus, nil, nil)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

