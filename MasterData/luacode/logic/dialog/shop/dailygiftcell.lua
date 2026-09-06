local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local DailyGiftCell = class("DailyGiftCell", Dialog)
DailyGiftCell.AssetBundleName = "ui/layouts.baseshop"
DailyGiftCell.AssetName = "RecommendShopItemCell"

function DailyGiftCell:Ctor(...)
  DailyGiftCell.super.Ctor(self, ...)
end

function DailyGiftCell:OnCreate()
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
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function DailyGiftCell:OnDestroy()
end

function DailyGiftCell:RefreshCell(data)
  self._data = data
  self._back2:SetActive(self._data.pictureId == 1)
  self._back1:SetActive(self._data.pictureId ~= 1)
  self._soldOut:SetActive(self._data.goodRemain == 0)
  local noDiscount = self._data.discount == -1 or self._data.discount == 10
  if noDiscount and 0 < self._data.discountPrice then
    self._priceBoard:SetActive(false)
    self._price2Board:SetActive(true)
    self._priceFree:SetActive(false)
    self._sale:SetActive(false)
    self._price2Num:SetText(self._data.discountPrice)
    local imageRecord = Item.Create(data.moneyType):GetIcon()
    self._price2Img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  elseif noDiscount and self._data.discountPrice == 0 then
    self._priceBoard:SetActive(false)
    self._price2Board:SetActive(false)
    self._priceFree:SetActive(true)
    self._sale:SetActive(false)
  elseif not noDiscount then
    self._priceBoard:SetActive(true)
    self._price2Board:SetActive(false)
    self._priceFree:SetActive(false)
    self._sale:SetActive(true)
    self._priceNum:SetText(self._data.discountPrice)
    self._priceDelete:SetText(self._data.price)
    local imageRecord = Item.Create(data.moneyType):GetIcon()
    self._priceImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = NekoData.BehaviorManager.BM_Shop:GetDiscountAsset(self._data.discount)
    self._sale:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("DailyGiftCell", "The discount and discountPrice data error! [discount=%d, discountPrice=%d]", self._data.discount, self._data.discountPrice)
  end
  self._num:SetActive(self._data.goodRemain ~= -1)
  self._numT:SetText(self._data.goodRemain)
  local item = Item.Create(self._data.goodName)
  local imageRecord = item:GetIcon()
  self._item:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._itemName:SetText(item:GetName())
  self._redDot:SetActive(self._data.discountPrice == 0 and self._data.goodRemain ~= 0)
end

function DailyGiftCell:OnCellClicked()
  local dialog = DialogManager.CreateSingletonDialog("shop.daygiftbuydialog")
  if dialog then
    self._data.endTime = self._delegate._delTime
    dialog:SetData(self._data)
  end
end

return DailyGiftCell
