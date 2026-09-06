local function p1(protocol)
  local str
  
  for k, v in pairs(protocol.money) do
    if not str then
      str = "{"
    else
      str = str .. ", "
    end
    str = str .. "[" .. k .. "] = " .. v
  end
  str = str and str .. "}"
  LogInfoFormat("sreqcoinnum", "--- money = %s ---", str)
  NekoData.DataManager.DM_Currency:OnSReqcoinnum(protocol)
  LuaNotificationCenter.PostNotification(Common.n_RefreshCurrency, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
