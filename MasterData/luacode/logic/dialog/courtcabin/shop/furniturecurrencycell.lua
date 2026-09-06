local Item = require("logic.manager.experimental.types.item")
local FurnitureCurrencyCell = class("FurnitureCurrencyCell", Dialog)
FurnitureCurrencyCell.AssetBundleName = "ui/layouts.yard"
FurnitureCurrencyCell.AssetName = "TopGroupCell"

function FurnitureCurrencyCell:Ctor(...)
  FurnitureCurrencyCell.super.Ctor(self, ...)
end

function FurnitureCurrencyCell:OnCreate()
  self._cell = self:GetChild("Num0")
  self._addBtn = self:GetChild("Num0/Add")
  self._icon = self:GetChild("Num0/Icon")
  self._text = self:GetChild("Num0/Text")
  self._icon:Subscribe_PointerClickEvent(self.OnCellClick, self)
  self._addBtn:Subscribe_PointerClickEvent(self.OnAddBtnClick, self)
end

function FurnitureCurrencyCell:OnDestroy()
end

function FurnitureCurrencyCell:RefreshCell(data)
  self._item = Item.Create(data)
  local imageRecord = self._item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._text:SetText(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(data))
end

function FurnitureCurrencyCell:OnCellClick()
  local width, height = self._cell:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
    tipsDialog:SetTipsPosition(width, height, self._cell:GetLocalPointInUiRootPanel())
  end
end

function FurnitureCurrencyCell:OnAddBtnClick()
  if self._cellData == DataCommon.DiamodID then
    NekoData.BehaviorManager.BM_Shop:JumpToShopBuyDiamonds()
  elseif self._cellData == DataCommon.FurnitureCion then
    NekoData.BehaviorManager.BM_Message:OpenCurrencyExchangeDialog(1)
  end
end

return FurnitureCurrencyCell
