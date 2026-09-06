local Item = require("logic.manager.experimental.types.item")
local ChristmasBattleItemCell = class("ChristmasBattleItemCell", Dialog)
ChristmasBattleItemCell.AssetBundleName = "ui/layouts.activitychristmas"
ChristmasBattleItemCell.AssetName = "ActivityChristmasCellItem"

function ChristmasBattleItemCell:Ctor(...)
  ChristmasBattleItemCell.super.Ctor(self, ...)
end

function ChristmasBattleItemCell:OnCreate()
  self._text = self:GetChild("text")
  self._count = self:GetChild("Panel/ItemCell/_Count")
  self._icon = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._select = self:GetChild("Panel/ItemCell/_BackGround/Select")
  self._select:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function ChristmasBattleItemCell:OnDestroy()
end

function ChristmasBattleItemCell:RefreshCell(data)
  self._text:SetActive(data.tag == "first" or data.tag == "may")
  self._count:SetActive(false)
  self._count:SetText(data.count)
  if data.tag == "first" then
    self._text:SetText(TextManager.GetText(701418))
  elseif data.tag == "may" then
    self._text:SetText(TextManager.GetText(701419))
  elseif data.tag == "item" then
    self._count:SetActive(true)
  end
  self._item = Item.Create(data.itemID)
  local imageRecord = self._item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = self._item:GetPinJiImage()
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function ChristmasBattleItemCell:OnCellClicked()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
    local width, height = self:GetRootWindow():GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

return ChristmasBattleItemCell
