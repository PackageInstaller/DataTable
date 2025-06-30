-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/srefreshinvestactinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local str = "["
  for i,v in ipairs(protocol.channel) do
    if i ~= 1 then
      str = str .. ", "
    end
    str = str .. v
  end
  str = str .. "]"
  LogInfoFormat("srefreshinvestactinfo", "close = %s, actId = %s, channelList = %s, currentChannel = %s, leftTimes = %s, actLeftTime = %s, todayFetched = %s", protocol.close, protocol.actId, str, protocol.currentChannel, protocol.leftTimes, protocol.actLeftTime, protocol.todayFetched)
  ;
  ((NekoData.DataManager).DM_Welfare):OnSRefreshInvestActInfo(protocol)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshLimitedInvestment, nil, protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

