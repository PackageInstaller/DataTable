local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local DailyGiftBigCell = class("DailyGiftBigCell", Dialog)
DailyGiftBigCell.AssetBundleName = "ui/layouts.baseshop"
DailyGiftBigCell.AssetName = "RecommendShopGiftCell"

function DailyGiftBigCell:Ctor(...)
  DailyGiftBigCell.super.Ctor(self, ...)
end

function DailyGiftBigCell:OnCreate()
  self._name = self:GetChild("Gift/ItemName")
  self._icon = self:GetChild("Gift/Item")
  self._count = self:GetChild("Gift/Num/Num")
  self._pricePanel_Normal = self:GetChild("Gift/Price")
  self._priceNum_Normal = self:GetChild("Gift/Price/Text")
  self._priceIcon_Normal = self:GetChild("Gift/Price/Image")
  self._pricePanel_Discount = self:GetChild("Gift/Price")
  self._priceNum_Discount = self:GetChild("Gift/Price2/Text")
  self._priceIcon_Discount = self:GetChild("Gift/Price2/Image")
  self._priceDelete_Discount = self:GetChild("Gift/Price2/TextDelete")
  self._saleInfoIcon = self:GetChild("Gift/Sale")
  self._soldOutIcon = self:GetChild("Gift/SoldOut")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function DailyGiftBigCell:OnDestroy()
end

function DailyGiftBigCell:RefreshCell(data)
  self._celldata = data
  local item = Item.Create(data.goodName)
  local str = item:GetName()
  self._name:SetText(str)
  local imageRecord = item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if data.goodRemain == 0 then
    self._soldOutIcon:SetActive(true)
    self._count:SetText(0)
  else
    self._soldOutIcon:SetActive(false)
    if data.goodRemain == -1 then
      self._count:SetText(tostring(99 .. "+"))
    else
      self._count:SetText(tostring(data.goodRemain))
    end
  end
  if data.discount == 0 then
    self._pricePanel_Discount:SetActive(false)
    self._pricePanel_Normal:SetActive(true)
    self._saleInfoIcon:SetActive(false)
  elseif data.discount == -1 then
    self._pricePanel_Discount:SetActive(false)
    self._pricePanel_Normal:SetActive(true)
    self._saleInfoIcon:SetActive(false)
  else
    self._pricePanel_Discount:SetActive(true)
    self._pricePanel_Normal:SetActive(false)
    self._saleInfoIcon:SetActive(true)
    imageRecord = CImagePathTable:GetRecorder(10 - data.discount + 11392)
    self._saleInfoIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  if data.discount == 0 or data.discount == -1 then
    self._priceNum_Normal:SetText(tostring(data.discountPrice))
  else
    self._priceNum_Discount:SetText(tostring(data.discountPrice))
    self._priceDelete_Discount:SetText(tostring(data.price))
  end
end

function DailyGiftBigCell:OnCellClicked()
  local dialog = DialogManager.CreateSingletonDialog("shop.daygiftbuydialog")
  if dialog then
    self._celldata.endTime = self._delegate._delTime
    dialog:SetData(self._celldata)
  end
end

return DailyGiftBigCell
