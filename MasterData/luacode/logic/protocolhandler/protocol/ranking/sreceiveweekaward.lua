local function p1(protocol)
  NekoData.DataManager.DM_WeekBoss:OnSReceiveWeekAward(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_SReceiveWeekAward, nil, protocol)
  if protocol.items and #protocol.items > 0 then
    local dialog = DialogManager.CreateSingletonDialog("bag.itemaccountdialog")
    if dialog then
      dialog:LoadData(protocol)
    end
  end
end

local function p2(protocol, client)
end

return {p1, p2}
