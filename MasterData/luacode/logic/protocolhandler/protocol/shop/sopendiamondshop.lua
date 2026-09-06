local function p1(protocol)
  local dialog = DialogManager.GetDialog("shop.itemgiftbuydialog")
  
  if dialog then
    dialog:Destroy()
  end
  NekoData.DataManager.DM_Shop:OnSOpenDiamondShop(protocol)
  LuaNotificationCenter.PostNotification(Common.n_RefreshShopInfo, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
