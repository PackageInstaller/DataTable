-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/shopmonthcell2.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local DM_RedDot = (NekoData.DataManager).DM_RedDot
local ShopMonthCell2 = class("ShopMonthCell2", Dialog)
ShopMonthCell2.AssetBundleName = "ui/layouts.baseshop"
ShopMonthCell2.AssetName = "RechargeShopMonthCell"
ShopMonthCell2.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopMonthCell2
  ((ShopMonthCell2.super).Ctor)(self, ...)
end

ShopMonthCell2.OnCreate = function(self)
  -- function num : 0_1
  self._img = self:GetChild("CellBack/MonthCardImg")
  self._name = self:GetChild("CellBack/ItemName")
  self._isBuyText = self:GetChild("CellBack/Buy/Text")
  self._priceBorder = self:GetChild("CellBack/Price")
  self._priceType = self:GetChild("CellBack/Price/RMB")
  self._priceNum = self:GetChild("CellBack/Price/Text")
  self._priceSaleBorder = self:GetChild("CellBack/PriceSale")
  self._priceSaleType = self:GetChild("CellBack/PriceSale/RMB")
  self._priceSaleNum = self:GetChild("CellBack/PriceSale/Text")
  self._priceSaleTextDelete = self:GetChild("CellBack/PriceSale/TextDelete")
  self._diamondImage = self:GetChild("CellBack/Show/Image")
  self._diamondNum = self:GetChild("CellBack/Show/Text")
  self._sale = self:GetChild("CellBack/Sale")
  self._saleImage = self:GetChild("CellBack/Sale/Sale")
  self._saleText = self:GetChild("CellBack/Sale/Time/Time")
  self._redDot = self:GetChild("CellBack/RedDot")
  ;
  (self._redDot):SetActive(false)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

ShopMonthCell2.OnDestroy = function(self)
  -- function num : 0_2
end

ShopMonthCell2.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CImagePathTable, _ENV
  self._data = data
  local imageRecord = CImagePathTable:GetRecorder(((self._data).iteminfo).pictureId)
  ;
  (self._img):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._name):SetText((TextManager.GetText)(((self._data).iteminfo).goodName))
  if ((self._data).iteminfo).discount ~= -1 and ((self._data).iteminfo).discount ~= 10 then
    (self._priceBorder):SetActive(false)
    ;
    (self._priceSaleBorder):SetActive(true)
    ;
    (self._priceSaleNum):SetText((SdkManager.GetPrice)(((self._data).iteminfo).discountPrice))
    ;
    (self._priceSaleTextDelete):SetText((SdkManager.GetPrice)(((self._data).iteminfo).price))
    ;
    (self._sale):SetActive(true)
    imageRecord = ((NekoData.BehaviorManager).BM_Shop):GetDiscountAsset(((self._data).iteminfo).discount)
    ;
    (self._saleImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._saleText):SetText(((NekoData.BehaviorManager).BM_Shop):GetRemainTimeStrForMonthCard(((self._data).iteminfo).endTime))
  else
    ;
    (self._priceBorder):SetActive(true)
    ;
    (self._priceSaleBorder):SetActive(false)
    ;
    (self._priceNum):SetText((SdkManager.GetPrice)(((self._data).iteminfo).discountPrice))
    ;
    (self._sale):SetActive(false)
  end
  ;
  (self._diamondNum):SetText(((self._data).iteminfo).diamondSum)
  self:RefreshTime()
  if ((self._delegate)._delegate):GetJumpMonthCardFlag() == 2 then
    self:OnCellClicked()
    ;
    ((self._delegate)._delegate):SetJumpMonthCardFlag(false)
  end
end

ShopMonthCell2.RefreshTime = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self._remainTime = ((NekoData.BehaviorManager).BM_Shop):GetMonthCardRemainTime(3)
  ;
  (self._isBuyText):SetText(((NekoData.BehaviorManager).BM_Shop):GetSpriteEvidenceRemainTimeStr(self._remainTime))
end

ShopMonthCell2.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if eventName == "RefreshMonthCard" then
    self:RefreshTime()
  end
end

ShopMonthCell2.OnCellClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("shop.monthcardbuydialog")
  if dialog then
    dialog:SetData((self._data).iteminfo, ((NekoData.BehaviorManager).BM_Shop):GetMonthCardEndShowTime(3))
  end
end

return ShopMonthCell2

