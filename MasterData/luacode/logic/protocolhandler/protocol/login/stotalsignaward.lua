local function p1(protocol)
  local userInfo = {
    result = protocol.success,
    
    day = protocol.day
  }
  NekoData.DataManager.DM_Welfare:OnSTotalSign(userInfo)
  LuaNotificationCenter.PostNotification(Common.n_AccumulatedSignResult, nil, userInfo)
  local pro = {
    items = protocol.awards
  }
  local dialog = DialogManager.CreateSingletonDialog("bag.itemaccountdialog")
  if dialog then
    dialog:LoadData(pro)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
