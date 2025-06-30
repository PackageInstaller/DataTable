-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/achievement/roleachievementdetailcellitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local RoleAchievementDetailCellItemCellItemCell = class("RoleAchievementDetailCellItemCellItemCell", Dialog)
RoleAchievementDetailCellItemCellItemCell.AssetBundleName = "ui/layouts.basetasklist"
RoleAchievementDetailCellItemCellItemCell.AssetName = "TaskStoryItemCellSmall"
RoleAchievementDetailCellItemCellItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RoleAchievementDetailCellItemCellItemCell
  ((RoleAchievementDetailCellItemCellItemCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

RoleAchievementDetailCellItemCellItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._itemIcon = self:GetChild("ItemCell/_BackGround/Icon")
  self._itemNum = self:GetChild("ItemCell/_Count")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

RoleAchievementDetailCellItemCellItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

RoleAchievementDetailCellItemCellItemCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item, _ENV
  self._itemID = data.itemid
  local item = (Item.Create)(self._itemID)
  local imageRecord = item:GetIcon()
  ;
  (self._itemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetPinJiImage()
  ;
  (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._itemNum):SetText((NumberManager.GetShowNumber)(data.itemnum))
end

RoleAchievementDetailCellItemCellItemCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV, Item
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (Item.Create)(self._itemID)})
    local width, height = (self:GetRootWindow()):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

return RoleAchievementDetailCellItemCellItemCell

