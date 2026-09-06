local function p1(protocol)
  NekoData.DataManager.DM_SevenGrow:OnSSevenDaysOpen(protocol)
  
  local sendProtocol = LuaNetManager.CreateProtocol("protocol.task.cactivitytasks")
  if sendProtocol then
    sendProtocol.activityID = sendProtocol.SEVEN_DAYS
    sendProtocol:Send()
  end
  LuaNotificationCenter.PostNotification(Common.n_OnSSevenDaysOpen, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
