local function p1(protocol)
  LogInfoFormat("SSevenPopGiftStatus", "--- leftTime = %s ---", protocol.leftTime)
  
  NekoData.DataManager.DM_Activity:SSevenPopGiftStatus(protocol)
  LuaNotificationCenter.PostNotification(Common.n_RefreshPopUpGift7Day, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
