-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/aprilfoolsday/shopbuydialog6.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CCurrencySymbol = (BeanManager.GetTableByName)("topup.ccurrencysymbol")
local UIManager = ((CS.PixelNeko).UI).UIManager
local ShopBuyDialog6 = class("ShopBuyDialog6", Dialog)
ShopBuyDialog6.AssetBundleName = "ui/layouts.activityaprilfools"
ShopBuyDialog6.AssetName = "ActivityAprilFoolsShop6"
ShopBuyDialog6.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopBuyDialog6
  ((ShopBuyDialog6.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

ShopBuyDialog6.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._itemBack = self:GetChild("Back/ItemBack")
  self._itemImage = self:GetChild("Back/MonthCardImg")
  self._itemImage_Char = self:GetChild("Back/Char")
  ;
  (self._itemImage_Char):SetActive(false)
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
  self._priceImg = self:GetChild("Back/Price/Image")
  self._textRmt = self:GetChild("Back/Price/RmtText")
  self._price2 = self:GetChild("Back/Price2")
  ;
  (self._price2):SetActive(false)
  self._itemPanel = self:GetChild("Back/Frame")
  self._itemFrame = (TableFrame.Create)(self._itemPanel, self, true, true, true)
  self._desText = self:GetChild("Back/IncludeBack1/Text")
  self._buyBtn = self:GetChild("Back/BuyBtn")
  ;
  (self._buyBtn):Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogClicked, Common.n_GlobalPointerWillDown, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBuyShopGood, Common.n_RefreshShopInfo, nil)
end

ShopBuyDialog6.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._itemFrame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

ShopBuyDialog6.SetData = function(self, iteminfo, shopid)
  -- function num : 0_3 , upvalues : _ENV, Item, CCurrencySymbol
  self._itemInfo = iteminfo
  self._shopId = shopid
  ;
  (self._saleImage):SetActive(false)
  self._itemData = {}
  for id,_ in ipairs(iteminfo.itemId) do
    (table.insert)(self._itemData, {id = (iteminfo.itemId)[id], count = (iteminfo.itemSum)[id]})
  end
  ;
  (self._itemFrame):ReloadAllCell()
  ;
  (self._itemFrame):MoveToTop()
  local item = (Item.Create)(iteminfo.giftId)
  ;
  (self._desText):SetText(item:GetDestribe())
  local imageRecord = item:GetIcon()
  ;
  (self._itemImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetShopBuyBackGroudImg()
  ;
  (self._itemBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._itemName):SetText(item:GetName())
  ;
  (self._priceNum):SetText((SdkManager.GetPrice)(iteminfo.discountPrice))
  if SdkManager.IsOverseas then
    (self._priceImg):SetActive(false)
    ;
    (self._textRmt):SetActive(true)
    ;
    (self._textRmt):SetText((CCurrencySymbol:GetRecorder(iteminfo.moneyType)).symbol)
  else
    ;
    (self._priceImg):SetActive(true)
    ;
    (self._textRmt):SetActive(false)
  end
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

ShopBuyDialog6.OnBuyBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local cmd = (LuaNetManager.CreateProtocol)("protocol.charge.cbuydiamond")
  cmd.goodId = (self._itemInfo).goodId
  cmd:Send()
end

ShopBuyDialog6.OnDialogClicked = function(self, args)
  -- function num : 0_5 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

ShopBuyDialog6.OnBuyShopGood = function(self, notification)
  -- function num : 0_6
  if (notification.userInfo).shopId == self._shopId then
    self:Destroy()
  end
end

ShopBuyDialog6.OnBackBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if (DialogManager.GetDialog)("bag.itemtipsdialog") or (DialogManager.GetDialog)("equip.equiptipspreviewdialog") then
    return 
  end
  self:Destroy()
end

ShopBuyDialog6.NumberOfCell = function(self, frame)
  -- function num : 0_8
  return #self._itemData
end

ShopBuyDialog6.CellAtIndex = function(self, frame, index)
  -- function num : 0_9
  return "activity.aprilfoolsday.shopitembuycell"
end

ShopBuyDialog6.DataAtIndex = function(self, frame, index)
  -- function num : 0_10
  return (self._itemData)[index]
end

return ShopBuyDialog6

