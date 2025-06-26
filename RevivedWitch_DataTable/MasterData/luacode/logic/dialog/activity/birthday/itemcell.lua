-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/birthday/itemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local RewardDetailCell = class("RewardDetailCell", Dialog)
RewardDetailCell.AssetBundleName = "ui/layouts.activitylogin"
RewardDetailCell.AssetName = "TaskCellItem"
RewardDetailCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RewardDetailCell
  ((RewardDetailCell.super).Ctor)(self, ...)
end

RewardDetailCell.OnCreate = function(self)
  -- function num : 0_1
  self._itemCell = self:GetChild("Panel/ItemCell")
  self._itemCellCount = self:GetChild("Panel/ItemCell/_Count")
  self._itemCellIcon = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._itemCellFrame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

RewardDetailCell.OnDestroy = function(self)
  -- function num : 0_2
end

RewardDetailCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item
  self._data = data
  self._cellItem = (Item.Create)((self._data).item)
  local imageRecord = (self._cellItem):GetIcon()
  ;
  (self._itemCellIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (self._cellItem):GetPinJiImage()
  ;
  (self._itemCellFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._itemCellCount):SetNumber((self._data).num)
end

RewardDetailCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local width, height = (self._itemCell):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._cellItem})
    tipsDialog:SetTipsPosition(width, height, (self._itemCell):GetLocalPointInUiRootPanel())
  end
end

return RewardDetailCell

