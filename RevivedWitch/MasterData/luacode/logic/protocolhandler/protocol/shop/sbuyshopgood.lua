-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/shop/sbuyshopgood.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local shopId = protocol.shopId
  if shopId == 6 or shopId == 14 then
    local dialog = (DialogManager.GetDialog)("shop.fashionbuydialog")
    if dialog then
      dialog:Destroy()
    end
  else
    do
      if shopId == DataCommon.UniqueEquipShopId then
        (DialogManager.DestroySingletonDialog)("shop.uniqueequipbuydialog")
        ;
        (DialogManager.DestroySingletonDialog)("shop.itembuydialog")
      else
        if shopId == 24 then
          (DialogManager.DestroySingletonDialog)("shop.emojibuydialog")
          ;
          (DialogManager.DestroySingletonDialog)("shop.itembuydialog")
        else
          if shopId == 27 then
            (DialogManager.DestroySingletonDialog)("activity.halloween.shopbuydialogfree")
            if protocol.result == 1 then
              ((NekoData.DataManager).DM_Shop):HalloweenRedPoint(0)
              ;
              (LuaNotificationCenter.PostNotification)(Common.n_OnSRefreshHalloweenShopRedPoint, nil, nil)
            end
          else
            local dialog = (DialogManager.GetDialog)("shop.itembuydialog")
            if dialog then
              dialog:Destroy()
            end
          end
        end
      end
      do
        if GlobalGameFSM:GetCurrentState() == "CourtYard" and protocol.shopId == 13 then
          local yardController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
          if yardController and (yardController._yardFSM):GetCurrentState() == "Cabin" then
            local dialog = (DialogManager.GetDialog)("courtcabin.shop.buyfurnituredialog")
            if dialog then
              local tag = false
              for i,v in ipairs(protocol.refresh) do
                if v.goodId == ((dialog._furnitureInfo).serverData).goodId then
                  tag = true
                  break
                end
              end
              do
                do
                  if tag then
                    dialog:Destroy()
                    ;
                    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100231)
                  end
                  dialog = (DialogManager.GetDialog)("courtcabin.shop.buythemedialog")
                  if dialog then
                    local tag = false
                    for i,v in ipairs(protocol.refresh) do
                      if ((dialog._themeInfo).furnitures)[v.itemId] then
                        tag = true
                        break
                      end
                    end
                    do
                      do
                        if tag then
                          dialog:Destroy()
                          ;
                          ((NekoData.BehaviorManager).BM_Message):SendMessageById(100231)
                        end
                        if protocol.result == 1 then
                          ((NekoData.DataManager).DM_Shop):OnSBuyShopGood(protocol)
                          ;
                          (LuaNotificationCenter.PostNotification)(Common.n_BuyShopGood, nil, protocol)
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

