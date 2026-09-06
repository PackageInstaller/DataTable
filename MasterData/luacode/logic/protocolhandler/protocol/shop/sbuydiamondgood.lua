local function p1(protocol)
  local dialog = DialogManager.GetDialog("shop.itemgiftbuydialog")
  
  if dialog then
    dialog:Destroy()
  end
  dialog = DialogManager.GetDialog("activity.halloween.shopbuydialogskin")
  if dialog then
    dialog:Destroy()
  end
  dialog = DialogManager.GetDialog("activity.halloween.shopbuydialog6")
  if dialog then
    dialog:Destroy()
  end
  if protocol.result == 1 then
    NekoData.DataManager.DM_Shop:OnSBuyDiamondGood(protocol)
    LuaNotificationCenter.PostNotification(Common.n_RefreshShopInfo, nil, protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
