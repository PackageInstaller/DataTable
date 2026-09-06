local function p1(protocol)
  local str = "["
  
  for i, v in ipairs(protocol.channel) do
    if i ~= 1 then
      str = str .. ", "
    end
    str = str .. v
  end
  str = str .. "]"
  LogInfoFormat("srefreshinvestactinfo", "close = %s, actId = %s, channelList = %s, currentChannel = %s, leftTimes = %s, actLeftTime = %s, todayFetched = %s", protocol.close, protocol.actId, str, protocol.currentChannel, protocol.leftTimes, protocol.actLeftTime, protocol.todayFetched)
  NekoData.DataManager.DM_Welfare:OnSRefreshInvestActInfo(protocol)
  LuaNotificationCenter.PostNotification(Common.n_RefreshLimitedInvestment, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
