-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/shopmonthcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local DM_RedDot = (NekoData.DataManager).DM_RedDot
local ShopMonthCell = class("ShopMonthCell", Dialog)
ShopMonthCell.AssetBundleName = "ui/layouts.baseshop"
ShopMonthCell.AssetName = "RechargeShopMonthCell"
ShopMonthCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopMonthCell
  ((ShopMonthCell.super).Ctor)(self, ...)
end

ShopMonthCell.OnCreate = function(self)
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
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

ShopMonthCell.OnDestroy = function(self)
  -- function num : 0_2
end

ShopMonthCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CImagePathTable, _ENV, DM_RedDot
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
    (self._priceSaleNum):SetText(((self._data).iteminfo).discountPrice)
    ;
    (self._priceSaleTextDelete):SetText(((self._data).iteminfo).price)
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
    (self._priceNum):SetText(((self._data).iteminfo).discountPrice)
    ;
    (self._sale):SetActive(false)
  end
  ;
  (self._diamondNum):SetText(((self._data).iteminfo).diamondSum)
  self:RefreshTime()
  if ((self._delegate)._delegate):GetJumpMonthCardFlag() == 1 and (((self._data).iteminfo).goodType == 13 or ((self._data).iteminfo).goodType == 15) then
    self:OnCellClicked()
    ;
    ((self._delegate)._delegate):SetJumpMonthCardFlag(false)
  end
  self._redDotNode = (((((DM_RedDot.nodeChildShop)[50]).childNode).ItemData).childNode).FirstDiscountShopCardReddot
  self:ShowRedDot()
end

ShopMonthCell.RefreshTime = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if ((self._data).iteminfo).goodType == 13 or ((self._data).iteminfo).goodType == 15 then
    self._remainTime = ((NekoData.BehaviorManager).BM_Shop):GetMonthCardRemainTime(1)
    if not self._remainTime then
      self._remainTime = ((NekoData.BehaviorManager).BM_Shop):GetMonthCardRemainTime(2)
    end
  else
    if ((self._data).iteminfo).goodType == 17 then
      self._remainTime = ((NekoData.BehaviorManager).BM_Shop):GetMonthCardRemainTime(4)
    end
  end
  ;
  (self._isBuyText):SetText(((NekoData.BehaviorManager).BM_Shop):GetMonthCardRemainTimeStr(self._remainTime))
end

ShopMonthCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if eventName == "RefreshMonthCard" then
    self:RefreshTime()
  else
    if eventName == "RedPointInfo" then
      self:ShowRedDot()
    end
  end
end

ShopMonthCell.OnCellClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV, DM_RedDot
  local dialog = (DialogManager.CreateSingletonDialog)("shop.monthcardbuydialog")
  if dialog then
    local tempData = nil
    if ((self._data).iteminfo).goodType == 13 or ((self._data).iteminfo).goodType == 15 then
      tempData = ((NekoData.BehaviorManager).BM_Shop):GetMonthCardEndShowTime(1)
      if not tempData then
        tempData = ((NekoData.BehaviorManager).BM_Shop):GetMonthCardEndShowTime(2)
      end
    else
      if ((self._data).iteminfo).goodType == 17 then
        tempData = ((NekoData.BehaviorManager).BM_Shop):GetMonthCardEndShowTime(4)
      end
    end
    dialog:SetData((self._data).iteminfo, tempData)
    if self._redDotResult and self._redDotNode then
      (DM_RedDot.SetNodeRead)(self._redDotNode)
      if self._redDotResult ~= (DM_RedDot.GetNodeResult)(self._redDotNode) then
        (LuaNotificationCenter.PostNotification)(Common.n_ShopRedPoint, nil, nil)
      end
    end
  end
end

ShopMonthCell.ShowRedDot = function(self)
  -- function num : 0_7 , upvalues : DM_RedDot
  if self._redDotNode then
    self._redDotResult = (DM_RedDot.GetNodeResult)(self._redDotNode)
    ;
    (self._redDot):SetActive(self._redDotResult)
  else
    ;
    (self._redDot):SetActive(false)
  end
end

return ShopMonthCell

