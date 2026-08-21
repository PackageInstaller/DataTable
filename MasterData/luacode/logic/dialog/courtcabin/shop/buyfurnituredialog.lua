-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/shop/buyfurnituredialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local FurnitureItem = require("logic.manager.experimental.types.furnitureitem")
local UIManager = ((CS.PixelNeko).UI).UIManager
local BuyFurnitureDialog = class("BuyFurnitureDialog", Dialog)
BuyFurnitureDialog.AssetBundleName = "ui/layouts.yard"
BuyFurnitureDialog.AssetName = "FurnitureThemeBuy"
BuyFurnitureDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BuyFurnitureDialog
  ((BuyFurnitureDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._buyNum = 1
  self._stock = 0
end

BuyFurnitureDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._back = self:GetChild("Back")
  self._icon = self:GetChild("Back/Theme/Item")
  self._name = self:GetChild("Back/Theme/NameBack/Name")
  self._comfortIcon = self:GetChild("Back/Theme/Comfortable/ComfortableImg")
  self._comfortNum = self:GetChild("Back/Theme/Comfortable/ComfortableNum")
  self._num = self:GetChild("Back/Theme/Num/Num")
  self._themeNumPanel = self:GetChild("Back/TxtBack")
  ;
  (self._themeNumPanel):SetActive(false)
  self._themeScrollbar = self:GetChild("Back/Scrollbar")
  ;
  (self._themeScrollbar):SetActive(false)
  self._description = self:GetChild("Back/Detail")
  self._frame = self:GetChild("Back/Frame")
  self._detail = ((((CS.PixelNeko).UI).UIManager).CreateLuaWindow)("ui/layouts.yard.assetbundle", "FurnitureThemeBuyFrameCell", (self._frame)._uiObject)
  self._detail_name = self:GetChild("Back/Frame/FurnitureThemeBuyFrameCell(Clone)/Name")
  self._detail_num = self:GetChild("Back/Frame/FurnitureThemeBuyFrameCell(Clone)/Num")
  self._detail_costCurrencyIcon = self:GetChild("Back/Frame/FurnitureThemeBuyFrameCell(Clone)/Icon")
  self._detail_costCurrencyPrice = self:GetChild("Back/Frame/FurnitureThemeBuyFrameCell(Clone)/Price")
  self._buyNumText = self:GetChild("Back/Num/Num")
  self._reduceBtn = self:GetChild("Back/Num/MinusBtn")
  self._addBtn = self:GetChild("Back/Num/AddBtn")
  self._minBtn = self:GetChild("Back/Num/MinBtn")
  self._maxBtn = self:GetChild("Back/Num/MaxBtn")
  self._costCurrencyIcon = self:GetChild("Back/PriceAll/Image")
  self._costCurrencyNum = self:GetChild("Back/PriceAll/Num")
  self._buyBtn = self:GetChild("Back/BuyBtn")
  ;
  (self._reduceBtn):Subscribe_PointerClickEvent(self.OnReduceBtnClicked, self)
  ;
  (self._addBtn):Subscribe_PointerClickEvent(self.OnAddBtnClicked, self)
  ;
  (self._minBtn):Subscribe_PointerClickEvent(self.OnMinBtnClicked, self)
  ;
  (self._maxBtn):Subscribe_PointerClickEvent(self.OnMaxBtnClicked, self)
  ;
  (self._buyBtn):Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  ;
  (self._rootWindow):Subscribe_PointerClickEvent(self.OnRootWindowClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
end

BuyFurnitureDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

BuyFurnitureDialog.SetData = function(self, furnitureGoodId)
  -- function num : 0_3 , upvalues : _ENV, FurnitureItem, Item
  self._furnitureInfo = ((NekoData.BehaviorManager).BM_Shop):GetFurnitureInfo(furnitureGoodId)
  local furnitureItem = (FurnitureItem.Create)(((self._furnitureInfo).serverData).itemId)
  local imageRecord = furnitureItem:GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._name):SetText(furnitureItem:GetName())
  imageRecord = ((NekoData.BehaviorManager).BM_Cabin):GetComfortImageRecord()
  ;
  (self._comfortIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._comfortNum):SetText(furnitureItem:GetComfort())
  ;
  (self._num):SetText(((self._furnitureInfo).serverData).goodRemain)
  ;
  (self._description):SetText(furnitureItem:GetDestribe())
  ;
  (self._detail_name):SetText(furnitureItem:GetName())
  ;
  (self._detail_num):SetText(1)
  ;
  (self._detail_costCurrencyPrice):SetText(((self._furnitureInfo).serverData).discountPrice)
  local costCurrencyItem = (Item.Create)(((self._furnitureInfo).serverData).moneyType)
  imageRecord = costCurrencyItem:GetIcon()
  ;
  (self._detail_costCurrencyIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._costCurrencyIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._stock = ((self._furnitureInfo).serverData).goodRemain
  self:RefreshRightBuyPanel()
  ;
  ((NekoData.BehaviorManager).BM_Shop):SetChecked((DataCommon.CabinGoodsType).Furniture, furnitureGoodId)
end

BuyFurnitureDialog.RefreshRightBuyPanel = function(self)
  -- function num : 0_4
  (self._buyNumText):SetText(self._buyNum)
  local cost = ((self._furnitureInfo).serverData).discountPrice * self._buyNum
  ;
  (self._costCurrencyNum):SetText(cost)
  self._trueCost = cost
end

BuyFurnitureDialog.OnReduceBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self._buyNum > 1 then
    self._buyNum = self._buyNum - 1
    self:RefreshRightBuyPanel()
  else
    ;
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100235)
  end
end

BuyFurnitureDialog.OnAddBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self._buyNum < self._stock then
    self._buyNum = self._buyNum + 1
    self:RefreshRightBuyPanel()
  else
    ;
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100236)
  end
end

BuyFurnitureDialog.OnMinBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self._buyNum ~= 1 then
    self._buyNum = 1
    self:RefreshRightBuyPanel()
  else
    ;
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100235)
  end
end

BuyFurnitureDialog.OnMaxBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self._buyNum ~= self._stock then
    self._buyNum = self._stock
    self:RefreshRightBuyPanel()
  else
    ;
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100236)
  end
end

BuyFurnitureDialog.OnRootWindowClicked = function(self)
  -- function num : 0_9
end

BuyFurnitureDialog.OnGlobalPointerDown = function(self, args)
  -- function num : 0_10 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._back)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

BuyFurnitureDialog.OnBackBtnClicked = function(self)
  -- function num : 0_11
  self:Destroy()
end

BuyFurnitureDialog.OnBuyBtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local haveNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.FurnitureCion)
  if self._trueCost <= haveNum then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cbuyshopgood")
    if protocol then
      protocol.shopId = DataCommon.FurnitureShopId
      local map = {}
      map[((self._furnitureInfo).serverData).goodId] = self._buyNum
      protocol.goods = map
      protocol:Send()
    end
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):OpenCurrencyExchangeBuyDialog(1, self._trueCost - haveNum)
    end
  end
end

return BuyFurnitureDialog

