local function p1(protocol)
  local str = "["
  
  for i, v in ipairs(protocol.receives) do
    if i ~= 1 then
      str = str .. ", "
    end
    str = str .. v
  end
  str = str .. "]"
  LogInfoFormat("smonthsigninfo", "signTotalNum = %s, receives = %s", protocol.signTotalNum, str)
  local dialog = DialogManager.GetDialog("welfare.monthsign.monthsignbuydialog")
  if dialog then
    dialog:Destroy()
  end
  NekoData.DataManager.DM_Welfare:OnSMonthSignInfo(protocol)
  LuaNotificationCenter.PostNotification(Common.n_RefreshMonthSign, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
