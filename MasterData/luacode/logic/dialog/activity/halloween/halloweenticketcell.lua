local Item = require("logic.manager.experimental.types.item")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CItemPinJiTable = BeanManager.GetTableByName("item.citempinji")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local HalloweenTicketCell = class("HalloweenTicketCell", Dialog)
HalloweenTicketCell.AssetBundleName = "ui/layouts.activityhalloween"
HalloweenTicketCell.AssetName = "ActivityHalloweenTicketCellItem"

function HalloweenTicketCell:Ctor(...)
  HalloweenTicketCell.super.Ctor(self, ...)
end

function HalloweenTicketCell:OnCreate()
  self._num1 = self:GetChild("Num1")
  self._num2 = self:GetChild("Num2")
  self._itemCell = self:GetChild("Panel/ItemCell")
  self._itemIcon = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._itemFrame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._itemCount = self:GetChild("Panel/ItemCell/_Count")
  self._itemCell:Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
end

function HalloweenTicketCell:RefreshCell(data)
  self._data = data.data
  self._index = data.index
  self._item = self._data.item
  self._itemNum = self._data.itemNum
  self._itemNowNum = self._data.itemNowNum
  self._itemTotalNum = self._data.itemTotalNum
  if self._itemNowNum == 0 then
    self._num1:SetText(TextManager.GetText(CStringRes:GetRecorder(1631).msgTextID, 0))
  else
    self._num1:SetText(self._itemNowNum)
  end
  self._num2:SetText(self._itemTotalNum)
  self._itemCount:SetText(self._itemNum)
  self._itemIcon:SetSprite(self._item:GetIcon().assetBundle, self._item:GetIcon().assetName)
  if self._index == 1 then
    local maxPinJiRecord = CItemPinJiTable:GetRecorder(6)
    local maxPinjiImage = CImagePathTable:GetRecorder(maxPinJiRecord.imageDir) or DataCommon.DefaultImageAsset
    self._itemFrame:SetSprite(maxPinjiImage.assetBundle, maxPinjiImage.assetName)
  else
    self._itemFrame:SetSprite(self._item:GetPinJiImage().assetBundle, self._item:GetPinJiImage().assetName)
  end
end

function HalloweenTicketCell:OnItemCellClicked()
  local width, height = self._itemCell:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
    tipsDialog:SetTipsPosition(width, height, self._itemCell:GetLocalPointInUiRootPanel())
  end
end

return HalloweenTicketCell
