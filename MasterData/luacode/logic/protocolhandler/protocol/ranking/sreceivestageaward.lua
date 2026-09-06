local function p1(protocol)
  NekoData.DataManager.DM_Game:OnSResiveBossPanelStageAward(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_RefreshBossPanelRed, nil)
  if protocol.items and #protocol.items > 0 then
    local dialog = DialogManager.CreateSingletonDialog("bag.itemaccountdialog")
    if dialog then
      dialog:LoadData(protocol)
    end
  end
  LuaNotificationCenter.PostNotification(Common.n_ReceiveBossPanelStageAward, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
