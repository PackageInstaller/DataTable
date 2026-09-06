local function p1(protocol)
  local shopId = protocol.shopId
  
  if shopId == 6 or shopId == 14 then
    local dialog = DialogManager.GetDialog("shop.fashionbuydialog")
    if dialog then
      dialog:Destroy()
    end
  elseif shopId == DataCommon.UniqueEquipShopId then
    DialogManager.DestroySingletonDialog("shop.uniqueequipbuydialog")
    DialogManager.DestroySingletonDialog("shop.itembuydialog")
  elseif shopId == 24 then
    DialogManager.DestroySingletonDialog("shop.emojibuydialog")
    DialogManager.DestroySingletonDialog("shop.itembuydialog")
  elseif shopId == 27 then
    DialogManager.DestroySingletonDialog("activity.halloween.shopbuydialogfree")
    if protocol.result == 1 then
      NekoData.DataManager.DM_Shop:HalloweenRedPoint(0)
      LuaNotificationCenter.PostNotification(Common.n_OnSRefreshHalloweenShopRedPoint, nil, nil)
    end
  else
    local dialog = DialogManager.GetDialog("shop.itembuydialog")
    if dialog then
      dialog:Destroy()
    end
  end
  if GlobalGameFSM:GetCurrentState() == "CourtYard" and protocol.shopId == 13 then
    local yardController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
    if yardController and yardController._yardFSM:GetCurrentState() == "Cabin" then
      local dialog = DialogManager.GetDialog("courtcabin.shop.buyfurnituredialog")
      if dialog then
        local tag = false
        for i, v in ipairs(protocol.refresh) do
          if v.goodId == dialog._furnitureInfo.serverData.goodId then
            tag = true
            break
          end
        end
        if tag then
          dialog:Destroy()
          NekoData.BehaviorManager.BM_Message:SendMessageById(100231)
        end
      else
        dialog = DialogManager.GetDialog("courtcabin.shop.buythemedialog")
        if dialog then
          local tag = false
          for i, v in ipairs(protocol.refresh) do
            if dialog._themeInfo.furnitures[v.itemId] then
              tag = true
              break
            end
          end
          if tag then
            dialog:Destroy()
            NekoData.BehaviorManager.BM_Message:SendMessageById(100231)
          end
        end
      end
    end
  end
  if protocol.result == 1 then
    NekoData.DataManager.DM_Shop:OnSBuyShopGood(protocol)
    LuaNotificationCenter.PostNotification(Common.n_BuyShopGood, nil, protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
