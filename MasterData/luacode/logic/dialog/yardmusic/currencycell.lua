local Item = require("logic.manager.experimental.types.item")
local CurrencyCell = class("CurrencyCell", Dialog)
CurrencyCell.AssetBundleName = "ui/layouts.yard"
CurrencyCell.AssetName = "TopGroupCell"

function CurrencyCell:Ctor(...)
  CurrencyCell.super.Ctor(self, ...)
end

function CurrencyCell:OnCreate()
  self._cell = self:GetChild("Num0")
  self._addBtn = self:GetChild("Num0/Add")
  self._icon = self:GetChild("Num0/Icon")
  self._text = self:GetChild("Num0/Text")
  self._icon:Subscribe_PointerClickEvent(self.OnCellClick, self)
  self._addBtn:Subscribe_PointerClickEvent(self.OnAddBtnClick, self)
end

function CurrencyCell:OnDestroy()
end

function CurrencyCell:RefreshCell(data)
  self._item = Item.Create(data)
  local imageRecord = self._item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._text:SetText(NumberManager.GetShowNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(data)))
end

function CurrencyCell:OnCellClick()
  local width, height = self._cell:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
    tipsDialog:SetTipsPosition(width, height, self._cell:GetLocalPointInUiRootPanel())
  end
end

function CurrencyCell:OnAddBtnClick()
  self:OnCellClick()
end

return CurrencyCell
