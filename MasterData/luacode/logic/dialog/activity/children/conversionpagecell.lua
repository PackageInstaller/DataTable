local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local ConversionPageCell = class("ConversionPageCell", Dialog)
ConversionPageCell.AssetBundleName = "ui/layouts.activitychildrensday"
ConversionPageCell.AssetName = "ActivityChildrensDayItemShopCell"

function ConversionPageCell:Ctor(...)
  ConversionPageCell.super.Ctor(self, ...)
end

function ConversionPageCell:OnCreate()
  self._name = self:GetChild("CellBack/Name")
  self._itemFrame = self:GetChild("CellItem/Panel/ItemCell/_BackGround/Frame")
  self._itemCount = self:GetChild("CellItem/Panel/ItemCell/_Count")
  self._itemIcon = self:GetChild("CellItem/Panel/ItemCell/_BackGround/Icon")
  self._itemIcon:Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  self._limit = self:GetChild("CellBack/Limit")
  self._soldOut = self:GetChild("SoldOut")
  self._item = self:GetChild("Item")
  self._num = self:GetChild("Num")
  self._getBtn = self:GetChild("GetBtn")
  self._getBtn_text = self:GetChild("GetBtn/_Text2")
  self._getBtn_text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1809))
  self._getBtn:Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function ConversionPageCell:OnDestroy()
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
end

function ConversionPageCell:RefreshCell(data)
  if data.leftTimes == 0 then
    self._soldOut:SetActive(true)
    self._getBtn:SetActive(false)
  else
    self._soldOut:SetActive(false)
    self._getBtn:SetActive(true)
  end
  self._name:SetText(data.item:GetName())
  self._itemFrame:SetSprite(data.item:GetPinJiImageAB())
  self._itemIcon:SetSprite(data.item:GetIconAB())
  self._itemCount:SetText(data.num)
  self._item:SetSprite(data.coinItem:GetIconAB())
  self._limit:SetText(NekoData.BehaviorManager.BM_Message:GetString(1806, {
    data.leftTimes
  }))
  self._num:SetText(data.price)
end

function ConversionPageCell:OnCellClicked()
  if NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.Cicada) < self._cellData.price then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100465)
  else
    NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChildrenActivityManagerID):SendAwardExchange(self._cellData.id)
  end
end

function ConversionPageCell:OnItemCellClicked()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._cellData.item
    })
  end
end

return ConversionPageCell
