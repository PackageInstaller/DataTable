local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local Item = require("logic.manager.experimental.types.item")
local stageToText = {
  [-1] = 701680,
  [1] = 701664,
  [2] = 701665,
  [3] = 701666,
  [4] = 701667,
  [5] = 701668,
  [6] = 701669
}
local RewardCell = class("RewardCell", Dialog)
RewardCell.AssetBundleName = "ui/layouts.activitynewyear"
RewardCell.AssetName = "ActivityNewYearCellItem"

function RewardCell:Ctor(...)
  RewardCell.super.Ctor(self, ...)
end

function RewardCell:OnCreate()
  self._image = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._select = self:GetChild("Panel/ItemCell/_BackGround/Select")
  self._select:SetActive(false)
  self._count = self:GetChild("Panel/ItemCell/_Count")
  self._text = self:GetChild("Text")
  self._textBack = self:GetChild("Image")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function RewardCell:OnDestroy()
end

function RewardCell:RefreshCell(data)
  self._item = Item.Create(data.id)
  local image = self._item:GetIcon()
  self._image:SetSprite(image.assetBundle, image.assetName)
  image = self._item:GetPinJiImage()
  self._frame:SetSprite(image.assetBundle, image.assetName)
  self._count:SetText(NumberManager.GetShowNumber(data.num))
  self._text:SetActive(data.stage ~= -1)
  self._textBack:SetActive(data.stage ~= -1)
  self._text:SetText(TextManager.GetText(stageToText[data.stage]))
end

function RewardCell:OnCellClick()
  local width, height = self:GetRootWindow():GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

return RewardCell
