local Item = require("logic.manager.experimental.types.item")
local AccumulateRewardItemCell = class("AccumulateRewardItemCell", Dialog)
AccumulateRewardItemCell.AssetBundleName = "ui/layouts.activitystar"
AccumulateRewardItemCell.AssetName = "ActivityStarAccountItemCell"

function AccumulateRewardItemCell:Ctor(...)
  AccumulateRewardItemCell.super.Ctor(self, ...)
end

function AccumulateRewardItemCell:OnCreate()
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._num = self:GetChild("ItemCell/_Count")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function AccumulateRewardItemCell:OnDestroy()
end

function AccumulateRewardItemCell:RefreshCell(data)
  self._item = Item.Create(data.id)
  local imageRecord = self._item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = self._item:GetPinJiImage()
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._num:SetText(NumberManager.GetShowNumber(data.num))
end

function AccumulateRewardItemCell:OnCellClicked()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
    local width, height = self:GetRootWindow():GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

return AccumulateRewardItemCell
