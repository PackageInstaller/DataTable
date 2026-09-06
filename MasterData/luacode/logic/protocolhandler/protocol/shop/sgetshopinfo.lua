local function p1(protocol)
  LogInfoFormat("sgetshopinfo", "--- shopId = %s ---", protocol.shopId)
  
  local dialog = DialogManager.GetDialog("shop.uniqueequipbuydialog") or DialogManager.GetDialog("shop.itembuydialog")
  if dialog and protocol.shopId == protocol.shopId then
    dialog:Destroy()
  end
  NekoData.DataManager.DM_Shop:OnSGetShopInfo(protocol)
  LuaNotificationCenter.PostNotification(Common.n_RefreshShopInfo, nil, protocol)
  if GlobalGameFSM:GetCurrentState() == "CourtYard" and protocol.shopId == 13 then
    local yardController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
    if yardController and yardController._yardFSM:GetCurrentState() == "Cabin" then
      DialogManager.CreateSingletonDialog("courtcabin.shop.furniturestoredialog")
    end
  end
  for _, v in pairs(DataCommon.StarMirage.Shop) do
    if v == protocol.shopId then
      DialogManager.CreateSingletonDialog("activity.starmirage.shopmaindialog"):SetShopId(protocol.shopId)
      break
    end
  end
  local dialogName = "activity.swimsuit.shopmaindialog"
  if DataCommon.SwimSuitActivity.Shop.ShopID == protocol.shopId then
    local dialog = DialogManager.GetDialog(dialogName)
    dialog = dialog or DialogManager.CreateSingletonDialog(dialogName)
    dialog:SetData(protocol.shopId)
  end
  dialogName = "activity.halloween.halloweenmaindialog"
  if DataCommon.HalloweenActivity.Shop.ShopID == protocol.shopId then
    dialog = DialogManager.GetDialog(dialogName)
    dialog = dialog or DialogManager.CreateSingletonDialog(dialogName)
    dialog:OpenShop()
  end
  for _, v in pairs(DataCommon.Christmas.Shop) do
    if v == protocol.shopId then
      DialogManager.CreateSingletonDialog("activity.christmas.shopmaindialog"):SetShopId(protocol.shopId)
      break
    end
  end
  dialogName = "activity.birthday.maindialog"
  if DataCommon.BirtDayShopID == protocol.shopId then
    dialog = DialogManager.GetDialog(dialogName)
    dialog = dialog or DialogManager.CreateSingletonDialog(dialogName)
    dialog:OpenShop(protocol.shopId)
  end
  dialogName = "activity.chrismascall.maindialog"
  if DataCommon.ChristmasCallShopID == protocol.shopId then
    dialog = DialogManager.GetDialog(dialogName)
    dialog = dialog or DialogManager.CreateSingletonDialog(dialogName)
    dialog:OpenShop(protocol.shopId)
  end
  for _, v in pairs(DataCommon.Lover.Shop) do
    if v == protocol.shopId then
      DialogManager.CreateSingletonDialog("activity.lover.shopmaindialog"):SetShopId(protocol.shopId)
      break
    end
  end
  dialogName = "activity.dragonboatfestival.maindialog"
  if DataCommon.DragonBoatFestivalShopID == protocol.shopId then
    dialog = DialogManager.GetDialog(dialogName)
    dialog = dialog or DialogManager.CreateSingletonDialog(dialogName)
    dialog:OpenShop(protocol.shopId)
  end
  for _, v in pairs(DataCommon.Anniversary.Shop) do
    if v == protocol.shopId then
      DialogManager.CreateSingletonDialog("activity.anniversary.shopmaindialog"):SetShopId(protocol.shopId)
      break
    end
  end
  for _, v in pairs(DataCommon.StarMirage1[DataCommon.Activities.StarMirageCopy].Shop) do
    if v == protocol.shopId then
      DialogManager.CreateSingletonDialog("activity.starmirage1.shopmaindialog"):SetShopId(protocol.shopId)
      break
    end
  end
end

local function p2(protocol, client)
end

return {p1, p2}
