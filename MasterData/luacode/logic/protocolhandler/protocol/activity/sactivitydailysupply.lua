local function p1(protocol)
  local str
  
  for k, v in pairs(protocol.supply) do
    if not str then
      str = "{"
    else
      str = str .. ", "
    end
    str = str .. "[" .. k .. "] = " .. v
  end
  str = str and str .. "}"
  LogInfoFormat("sactivitydailysupply", "--- activityId = %s, supply = %s ---", protocol.activityId, str)
  NekoData.DataManager.DM_Activity:OnSActivityDailySupply(protocol)
  LuaNotificationCenter.PostNotification(Common.n_RefreshActivityDailySupply, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
