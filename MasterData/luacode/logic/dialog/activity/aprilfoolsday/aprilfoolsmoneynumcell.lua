local Item = require("logic.manager.experimental.types.item")
local AprilFoolsMoneyNumCell = class("AprilFoolsMoneyNumCell", Dialog)
AprilFoolsMoneyNumCell.AssetBundleName = "ui/layouts.activityaprilfools"
AprilFoolsMoneyNumCell.AssetName = "MoneyCell"

function AprilFoolsMoneyNumCell:Ctor(...)
  AprilFoolsMoneyNumCell.super.Ctor(self, ...)
  self._item = nil
end

function AprilFoolsMoneyNumCell:OnCreate()
  self._addBtn = self:GetChild("Add")
  self._moneyIcon = self:GetChild("Icon")
  self._moneyText = self:GetChild("Text")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnMoneyBoardClick, self)
end

function AprilFoolsMoneyNumCell:OnDestroy()
end

function AprilFoolsMoneyNumCell:RefreshCell(data)
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

function AprilFoolsMoneyNumCell:OnMoneyBoardClick()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
    local width, height = self._moneyIcon:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self._moneyIcon:GetLocalPointInUiRootPanel())
  end
end

return AprilFoolsMoneyNumCell
