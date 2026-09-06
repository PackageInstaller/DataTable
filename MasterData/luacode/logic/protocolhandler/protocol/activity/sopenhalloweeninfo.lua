local function p1(protocol)
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.HalloweenActivityID):OnSOpenHalloweenInfo(protocol)
  
  local sendProtocol = LuaNetManager.CreateProtocol("protocol.task.cactivitytasks")
  if sendProtocol then
    sendProtocol.activityID = sendProtocol.HALLOWEEN
    sendProtocol:Send()
  end
  LuaNotificationCenter.PostNotification(Common.n_OnSOpenHalloweenInfo, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
