local function p1(protocol)
  local dialog = DialogManager.GetDialog("shop.monthcardbuydialog")
  
  if dialog then
    dialog:Destroy()
  end
  NekoData.DataManager.DM_Shop:OnSMonthCardState(protocol)
  LuaNotificationCenter.PostNotification(Common.n_MonthCardRefreshTime, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
