local Item = require("logic.manager.experimental.types.item")
local RoleAchievementDetailCellItemCellItemCell = class("RoleAchievementDetailCellItemCellItemCell", Dialog)
RoleAchievementDetailCellItemCellItemCell.AssetBundleName = "ui/layouts.basetasklist"
RoleAchievementDetailCellItemCellItemCell.AssetName = "TaskStoryItemCellSmall"

function RoleAchievementDetailCellItemCellItemCell:Ctor(...)
  RoleAchievementDetailCellItemCellItemCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function RoleAchievementDetailCellItemCellItemCell:OnCreate()
  self._itemIcon = self:GetChild("ItemCell/_BackGround/Icon")
  self._itemNum = self:GetChild("ItemCell/_Count")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function RoleAchievementDetailCellItemCellItemCell:OnDestroy()
end

function RoleAchievementDetailCellItemCellItemCell:RefreshCell(data)
  self._itemID = data.itemid
  local item = Item.Create(self._itemID)
  local imageRecord = item:GetIcon()
  self._itemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetPinJiImage()
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._itemNum:SetText(NumberManager.GetShowNumber(data.itemnum))
end

function RoleAchievementDetailCellItemCellItemCell:OnCellClicked()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(self._itemID)
    })
    local width, height = self:GetRootWindow():GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

return RoleAchievementDetailCellItemCellItemCell
