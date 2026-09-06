local Item = require("logic.manager.experimental.types.item")
local RewardDetailCell = class("RewardDetailCell", Dialog)
RewardDetailCell.AssetBundleName = "ui/layouts.activitylogin"
RewardDetailCell.AssetName = "TaskCellItem"

function RewardDetailCell:Ctor(...)
  RewardDetailCell.super.Ctor(self, ...)
end

function RewardDetailCell:OnCreate()
  self._itemCell = self:GetChild("Panel/ItemCell")
  self._itemCellCount = self:GetChild("Panel/ItemCell/_Count")
  self._itemCellIcon = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._itemCellFrame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function RewardDetailCell:OnDestroy()
end

function RewardDetailCell:RefreshCell(data)
  self._data = data
  self._cellItem = Item.Create(self._data.item)
  local imageRecord = self._cellItem:GetIcon()
  self._itemCellIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = self._cellItem:GetPinJiImage()
  self._itemCellFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._itemCellCount:SetNumber(self._data.num)
end

function RewardDetailCell:OnCellClicked()
  local width, height = self._itemCell:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._cellItem
    })
    tipsDialog:SetTipsPosition(width, height, self._itemCell:GetLocalPointInUiRootPanel())
  end
end

return RewardDetailCell
