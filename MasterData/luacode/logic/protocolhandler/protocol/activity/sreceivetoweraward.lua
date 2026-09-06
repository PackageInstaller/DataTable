local function p1(protocol)
  NekoData.DataManager.DM_TowerV2:OnSReceiveTowerAward(protocol)
  
  if #protocol.items ~= 0 then
    local dialog = DialogManager.CreateSingletonDialog("bag.itemaccountdialog")
    dialog:LoadData({
      items = protocol.items
    })
  end
  LuaNotificationCenter.PostNotification(Common.n_TowerV2Reward, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
