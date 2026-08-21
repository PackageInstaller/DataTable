-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/dailygiftcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local DailyGiftCell = class("DailyGiftCell", Dialog)
DailyGiftCell.AssetBundleName = "ui/layouts.baseshop"
DailyGiftCell.AssetName = "RecommendShopItemCell"
DailyGiftCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DailyGiftCell
  ((DailyGiftCell.super).Ctor)(self, ...)
end

DailyGiftCell.OnCreate = function(self)
  -- function num : 0_1
  self._back1 = self:GetChild("Cell/Back1")
  self._back2 = self:GetChild("Cell/Back2")
  self._item = self:GetChild("Cell/Item")
  self._itemName = self:GetChild("Cell/ItemName")
  self._priceBoard = self:GetChild("Cell/Price")
  self._priceImg = self:GetChild("Cell/Price/Image")
  self._priceNum = self:GetChild("Cell/Price/Text")
  self._priceDelete = self:GetChild("Cell/Price/TextDelete")
  self._price2Board = self:GetChild("Cell/Price2")
  self._price2Num = self:GetChild("Cell/Price2/Text")
  self._price2Img = self:GetChild("Cell/Price2/Image")
  self._priceFree = self:GetChild("Cell/PriceFree")
  self._num = self:GetChild("Cell/Num")
  self._numT = self:GetChild("Cell/Num/Num")
  self._sale = self:GetChild("Cell/Sale")
  self._soldOut = self:GetChild("Cell/SoldOut")
  self._redDot = self:GetChild("Cell/RedDot")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

DailyGiftCell.OnDestroy = function(self)
  -- function num : 0_2
end

DailyGiftCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, Item
  self._data = data
  ;
  (self._back2):SetActive((self._data).pictureId == 1)
  ;
  (self._back1):SetActive((self._data).pictureId ~= 1)
  if (self._data).moneyType ~= DataCommon.DiamodID then
    LogErrorFormat("DailyGiftCell", "礼包现在只可用钻石购买，发现其它的货币类型！[goodId=%d, moneyType=%d]", (self._data).goodId, (self._data).moneyType)
  end
  ;
  (self._soldOut):SetActive((self._data).goodRemain == 0)
  local noDiscount = (self._data).discount == -1 or (self._data).discount == 10
  if noDiscount and (self._data).discountPrice > 0 then
    (self._priceBoard):SetActive(false)
    ;
    (self._price2Board):SetActive(true)
    ;
    (self._priceFree):SetActive(false)
    ;
    (self._sale):SetActive(false)
    ;
    (self._price2Num):SetText((self._data).discountPrice)
    local imageRecord = ((Item.Create)(data.moneyType)):GetIcon()
    ;
    (self._price2Img):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  elseif noDiscount and (self._data).discountPrice == 0 then
    (self._priceBoard):SetActive(false)
    ;
    (self._price2Board):SetActive(false)
    ;
    (self._priceFree):SetActive(true)
    ;
    (self._sale):SetActive(false)
  elseif not noDiscount then
    (self._priceBoard):SetActive(true)
    ;
    (self._price2Board):SetActive(false)
    ;
    (self._priceFree):SetActive(false)
    ;
    (self._sale):SetActive(true)
    ;
    (self._priceNum):SetText((self._data).discountPrice)
    ;
    (self._priceDelete):SetText((self._data).price)
    local imageRecord = ((Item.Create)(data.moneyType)):GetIcon()
    ;
    (self._priceImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = ((NekoData.BehaviorManager).BM_Shop):GetDiscountAsset((self._data).discount)
    ;
    (self._sale):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("DailyGiftCell", "The discount and discountPrice data error! [discount=%d, discountPrice=%d]", (self._data).discount, (self._data).discountPrice)
  end
  ;
  (self._num):SetActive((self._data).goodRemain ~= -1)
  ;
  (self._numT):SetText((self._data).goodRemain)
  local item = (Item.Create)((self._data).goodName)
  local imageRecord = item:GetIcon()
  ;
  (self._item):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._itemName):SetText(item:GetName())
  ;
  (self._redDot):SetActive((self._data).discountPrice == 0 and (self._data).goodRemain ~= 0)
  -- DECOMPILER ERROR: 12 unprocessed JMP targets
end

DailyGiftCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("shop.daygiftbuydialog")
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  if dialog then
    (self._data).endTime = (self._delegate)._delTime
    dialog:SetData(self._data)
  end
end

return DailyGiftCell

