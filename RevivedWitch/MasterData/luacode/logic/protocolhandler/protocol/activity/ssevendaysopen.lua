-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/ssevendaysopen.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_SevenGrow):OnSSevenDaysOpen(protocol)
  local sendProtocol = (LuaNetManager.CreateProtocol)("protocol.task.cactivitytasks")
  if sendProtocol then
    sendProtocol.activityID = sendProtocol.SEVEN_DAYS
    sendProtocol:Send()
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_OnSSevenDaysOpen, nil, protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

