local Item = require("logic.manager.experimental.types.item")
local SwimSuitBattleItemCell = class("SwimSuitBattleItemCell", Dialog)
SwimSuitBattleItemCell.AssetBundleName = "ui/layouts.activitysummer2"
SwimSuitBattleItemCell.AssetName = "ActivitySummer2CellItem"

function SwimSuitBattleItemCell:Ctor(...)
  SwimSuitBattleItemCell.super.Ctor(self, ...)
end

function SwimSuitBattleItemCell:OnCreate()
  self._text = self:GetChild("text")
  self._count = self:GetChild("Panel/ItemCell/_Count")
  self._icon = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._select = self:GetChild("Panel/ItemCell/_BackGround/Select")
  self._select:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function SwimSuitBattleItemCell:OnDestroy()
end

function SwimSuitBattleItemCell:RefreshCell(data)
  self._text:SetActive(data.tag == "first" or data.tag == "may")
  if data.tag == "first" then
    self._text:SetText(TextManager.GetText(701418))
  elseif data.tag == "may" then
    self._text:SetText(TextManager.GetText(701419))
  end
  self._count:SetActive(false)
  self._count:SetText(data.count)
  self._item = Item.Create(data.itemID)
  local imageRecord = self._item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = self._item:GetPinJiImage()
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function SwimSuitBattleItemCell:OnCellClicked()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
    local width, height = self:GetRootWindow():GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

return SwimSuitBattleItemCell
