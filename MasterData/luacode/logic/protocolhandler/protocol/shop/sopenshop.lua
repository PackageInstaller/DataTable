local function p1(protocol)
  NekoData.DataManager.DM_Shop:OnSOpenShop(protocol)
  
  local list = NekoData.BehaviorManager.BM_Shop:GetShopIDList()
  local dialog = DialogManager.GetDialog("shop.shopmaindialog")
  if dialog then
    dialog:SetData(list)
  else
    dialog = DialogManager.CreateSingletonDialog("shop.shopmaindialog")
    dialog:SetData(list)
  end
  LuaNotificationCenter.PostNotification(Common.n_SOpenShop, nil, dialog)
end

local function p2(protocol, client)
end

return {p1, p2}
