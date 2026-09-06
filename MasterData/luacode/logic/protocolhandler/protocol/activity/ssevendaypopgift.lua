local function p1(protocol)
  local commonStr = ""
  
  for k, v in pairs(protocol.rewards) do
    if commonStr ~= "" then
      commonStr = commonStr .. ", "
    end
    commonStr = commonStr .. "{key=" .. k .. ", status=" .. v .. "}"
  end
  LogInfoFormat("SSevenDayPopGIft", "--- pop = %s, hasBought = %s, leftTime = %s, goodId = %s, rewards = %s ---", protocol.pop, protocol.hasBought, protocol.leftTime, protocol.goodId, commonStr)
  NekoData.DataManager.DM_Activity:OnSSevenDayPopGIft(protocol)
  LuaNotificationCenter.PostNotification(Common.n_RefreshPopUpGift7Day, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
