-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/shop/sgetshopinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  LogInfoFormat("sgetshopinfo", "--- shopId = %s ---", protocol.shopId)
  if not (DialogManager.GetDialog)("shop.uniqueequipbuydialog") then
    local dialog = (DialogManager.GetDialog)("shop.itembuydialog")
  end
  if dialog and protocol.shopId == protocol.shopId then
    dialog:Destroy()
  end
  ;
  ((NekoData.DataManager).DM_Shop):OnSGetShopInfo(protocol)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshShopInfo, nil, protocol)
  do
    if GlobalGameFSM:GetCurrentState() == "CourtYard" and protocol.shopId == 13 then
      local yardController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
      if yardController and (yardController._yardFSM):GetCurrentState() == "Cabin" then
        (DialogManager.CreateSingletonDialog)("courtcabin.shop.furniturestoredialog")
      end
    end
    for _,v in pairs((DataCommon.StarMirage).Shop) do
      if v == protocol.shopId then
        ((DialogManager.CreateSingletonDialog)("activity.starmirage.shopmaindialog")):SetShopId(protocol.shopId)
        break
      end
    end
    do
      local dialogName = "activity.swimsuit.shopmaindialog"
      do
        if ((DataCommon.SwimSuitActivity).Shop).ShopID == protocol.shopId then
          local dialog = (DialogManager.GetDialog)(dialogName)
          if not dialog then
            dialog = (DialogManager.CreateSingletonDialog)(dialogName)
          end
          dialog:SetData(protocol.shopId)
        end
        dialogName = "activity.halloween.halloweenmaindialog"
        if ((DataCommon.HalloweenActivity).Shop).ShopID == protocol.shopId then
          dialog = (DialogManager.GetDialog)(dialogName)
          if not dialog then
            dialog = (DialogManager.CreateSingletonDialog)(dialogName)
          end
          dialog:OpenShop()
        end
        for _,v in pairs((DataCommon.Christmas).Shop) do
          if v == protocol.shopId then
            ((DialogManager.CreateSingletonDialog)("activity.christmas.shopmaindialog")):SetShopId(protocol.shopId)
            break
          end
        end
        do
          dialogName = "activity.birthday.maindialog"
          if DataCommon.BirtDayShopID == protocol.shopId then
            dialog = (DialogManager.GetDialog)(dialogName)
            if not dialog then
              dialog = (DialogManager.CreateSingletonDialog)(dialogName)
            end
            dialog:OpenShop(protocol.shopId)
          end
          dialogName = "activity.chrismascall.maindialog"
          if DataCommon.ChristmasCallShopID == protocol.shopId then
            dialog = (DialogManager.GetDialog)(dialogName)
            if not dialog then
              dialog = (DialogManager.CreateSingletonDialog)(dialogName)
            end
            dialog:OpenShop(protocol.shopId)
          end
          for _,v in pairs((DataCommon.Lover).Shop) do
            if v == protocol.shopId then
              ((DialogManager.CreateSingletonDialog)("activity.lover.shopmaindialog")):SetShopId(protocol.shopId)
              break
            end
          end
          do
            dialogName = "activity.dragonboatfestival.maindialog"
            if DataCommon.DragonBoatFestivalShopID == protocol.shopId then
              dialog = (DialogManager.GetDialog)(dialogName)
              if not dialog then
                dialog = (DialogManager.CreateSingletonDialog)(dialogName)
              end
              dialog:OpenShop(protocol.shopId)
            end
            for _,v in pairs((DataCommon.Anniversary).Shop) do
              if v == protocol.shopId then
                ((DialogManager.CreateSingletonDialog)("activity.anniversary.shopmaindialog")):SetShopId(protocol.shopId)
                break
              end
            end
            do
              for _,v in pairs(((DataCommon.StarMirage1)[(DataCommon.Activities).StarMirageCopy]).Shop) do
                if v == protocol.shopId then
                  ((DialogManager.CreateSingletonDialog)("activity.starmirage1.shopmaindialog")):SetShopId(protocol.shopId)
                  break
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

