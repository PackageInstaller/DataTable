-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/starmirage/accumulaterewarditemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local AccumulateRewardItemCell = class("AccumulateRewardItemCell", Dialog)
AccumulateRewardItemCell.AssetBundleName = "ui/layouts.activitystar"
AccumulateRewardItemCell.AssetName = "ActivityStarAccountItemCell"
AccumulateRewardItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AccumulateRewardItemCell
  ((AccumulateRewardItemCell.super).Ctor)(self, ...)
end

AccumulateRewardItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._num = self:GetChild("ItemCell/_Count")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

AccumulateRewardItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

AccumulateRewardItemCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item, _ENV
  self._item = (Item.Create)(data.id)
  local imageRecord = (self._item):GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (self._item):GetPinJiImage()
  ;
  (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._num):SetText((NumberManager.GetShowNumber)(data.num))
end

AccumulateRewardItemCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._item})
    local width, height = (self:GetRootWindow()):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

return AccumulateRewardItemCell

