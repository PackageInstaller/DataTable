-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/aprilfoolsday/shopbuydialogskin.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local UIManager = ((CS.PixelNeko).UI).UIManager
local ShopBuyDialogSkin = class("ShopBuyDialogSkin", Dialog)
ShopBuyDialogSkin.AssetBundleName = "ui/layouts.activityaprilfools"
ShopBuyDialogSkin.AssetName = "ActivityAprilFoolsShopSkin"
local SkinTypeId = 91
ShopBuyDialogSkin.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopBuyDialogSkin
  ((ShopBuyDialogSkin.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

ShopBuyDialogSkin.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._itemBack = self:GetChild("Back/ItemBack")
  self._itemImage = self:GetChild("Back/MonthCardImg")
  self._itemName = self:GetChild("Back/ItemName")
  self._timeText = self:GetChild("Back/Time")
  self._timeImg = self:GetChild("Back/TimeImg")
  self._saleImage = self:GetChild("Back/Sale")
  self._priceFree = self:GetChild("Back/PriceFree")
  ;
  (self._priceFree):SetActive(false)
  self._price = self:GetChild("Back/Price")
  ;
  (self._price):SetActive(true)
  self._priceNum = self:GetChild("Back/Price/Num")
  self._price2 = self:GetChild("Back/Price2")
  ;
  (self._price2):SetActive(false)
  self._skinPanel = self:GetChild("Back/Frame")
  self._skinFrame = (TableFrame.Create)(self._skinPanel, self, true, true, true)
  self._itemPanel = self:GetChild("Back/Frame3")
  self._itemFrame = (TableFrame.Create)(self._itemPanel, self, true, true, true)
  self._buyBtn = self:GetChild("Back/BuyBtn")
  ;
  (self._buyBtn):Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogClicked, Common.n_GlobalPointerWillDown, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshShopInfo, Common.n_RefreshShopInfo, nil)
end

ShopBuyDialogSkin.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._skinFrame then
    (self._skinFrame):Destroy()
  end
  if self._itemFrame then
    (self._itemFrame):Destroy()
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

ShopBuyDialogSkin.SetData = function(self, iteminfo, shopid)
  -- function num : 0_3 , upvalues : _ENV, Item, SkinTypeId
  self._itemInfo = iteminfo
  self._shopId = shopid
  ;
  (self._saleImage):SetActive(false)
  self._itemData = {}
  self._skinData = {}
  for k,v in ipairs((self._itemInfo).itemId) do
    local item = (Item.Create)(v)
    if item:GetItemTypeId() == SkinTypeId then
      (table.insert)(self._skinData, {id = (iteminfo.itemId)[k], count = (iteminfo.itemSum)[k]})
    else
      ;
      (table.insert)(self._itemData, {id = (iteminfo.itemId)[k], count = (iteminfo.itemSum)[k]})
    end
  end
  ;
  (self._skinFrame):ReloadAllCell()
  ;
  (self._skinFrame):MoveToTop()
  ;
  (self._itemFrame):ReloadAllCell()
  ;
  (self._itemFrame):MoveToTop()
  local item = (Item.Create)(iteminfo.giftId)
  local imageRecord = item:GetIcon()
  ;
  (self._itemImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetShopBuyBackGroudImg()
  ;
  (self._itemBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._itemName):SetText(item:GetName())
  ;
  (self._priceNum):SetText(tostring(iteminfo.discountPrice))
  if not (self._itemInfo).beginTime or not (self._itemInfo).endTime or (self._itemInfo).beginTime == 0 or (self._itemInfo).endTime == 0 then
    (self._timeText):SetActive(false)
    ;
    (self._timeImg):SetActive(false)
  else
    ;
    (self._timeImg):SetActive(true)
    ;
    (self._timeText):SetActive(true)
    ;
    (self._timeText):SetText(((NekoData.BehaviorManager).BM_Shop):GetRemainTimeStr((self._itemInfo).endTime))
  end
  self._unitPrice = iteminfo.discountPrice
  self._totalMoney = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(iteminfo.moneyType)
  self._canBuyMaxNum = (math.floor)(self._totalMoney / self._unitPrice)
  if iteminfo.goodRemain ~= -1 then
    self._canBuyMaxNum = (math.min)(self._canBuyMaxNum, iteminfo.goodRemain)
  end
end

ShopBuyDialogSkin.OnBuyBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local cmd = (LuaNetManager.CreateProtocol)("protocol.charge.cbuydiamond")
  cmd.goodId = (self._itemInfo).goodId
  cmd:Send()
end

ShopBuyDialogSkin.OnDialogClicked = function(self, args)
  -- function num : 0_5 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

ShopBuyDialogSkin.OnRefreshShopInfo = function(self, notification)
  -- function num : 0_6
  if (notification.userInfo).shopId == self._shopId then
    self:Destroy()
  end
end

ShopBuyDialogSkin.OnBackBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if (DialogManager.GetDialog)("bag.itemtipsdialog") or (DialogManager.GetDialog)("equip.equiptipspreviewdialog") then
    return 
  end
  self:Destroy()
end

ShopBuyDialogSkin.NumberOfCell = function(self, frame)
  -- function num : 0_8
  if frame == self._skinFrame then
    return #self._skinData
  else
    return #self._itemData
  end
end

ShopBuyDialogSkin.CellAtIndex = function(self, frame, index)
  -- function num : 0_9
  return "activity.aprilfoolsday.shopitembuycell"
end

ShopBuyDialogSkin.DataAtIndex = function(self, frame, index)
  -- function num : 0_10
  if frame == self._skinFrame then
    return (self._skinData)[index]
  else
    return (self._itemData)[index]
  end
end

return ShopBuyDialogSkin

