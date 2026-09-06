local Item = require("logic.manager.experimental.types.item")
local LoverMoneyNumCell = class("LoverMoneyNumCell", Dialog)
LoverMoneyNumCell.AssetBundleName = "ui/layouts.activityvalentines"
LoverMoneyNumCell.AssetName = "ActivityValentinesNumCell"

function LoverMoneyNumCell:Ctor(...)
  LoverMoneyNumCell.super.Ctor(self, ...)
  self._item = nil
end

function LoverMoneyNumCell:OnCreate()
  self._moneyBoard = self:GetChild("Back")
  self._addBtn = self:GetChild("Add")
  self._moneyIcon = self:GetChild("Icon")
  self._moneyText = self:GetChild("Text")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnMoneyBoardClick, self)
end

function LoverMoneyNumCell:OnDestroy()
end

function LoverMoneyNumCell:RefreshCell(data)
  self._item = Item.Create(data)
  local image = self._item:GetIcon()
  self._moneyIcon:SetSprite(image.assetBundle, image.assetName)
  if NekoData.BehaviorManager.BM_Currency:IsCurrency(data) then
    self._moneyText:SetNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(data))
  else
    self._moneyText:SetNumber(NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(data))
  end
  self._addBtn:SetActive(false)
end

function LoverMoneyNumCell:OnMoneyBoardClick()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
    local width, height = self._moneyBoard:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self._moneyBoard:GetLocalPointInUiRootPanel())
  end
end

return LoverMoneyNumCell
