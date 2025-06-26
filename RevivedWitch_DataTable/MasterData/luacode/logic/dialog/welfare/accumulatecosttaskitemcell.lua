-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/accumulatecosttaskitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CommonAwardsSatus = (LuaNetManager.GetBeanDef)("protocol.common.commonawardstatus")
local AccumulateCostTaskItemCell = class("AccumulateCostTaskItemCell", Dialog)
AccumulateCostTaskItemCell.AssetBundleName = "ui/layouts.welfare"
AccumulateCostTaskItemCell.AssetName = "ActivityConsumptionCellItem"
AccumulateCostTaskItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AccumulateCostTaskItemCell
  ((AccumulateCostTaskItemCell.super).Ctor)(self, ...)
end

AccumulateCostTaskItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._num = self:GetChild("ItemCell/_Count")
  self._grey = self:GetChild("Gray")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

AccumulateCostTaskItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

AccumulateCostTaskItemCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item, _ENV, CommonAwardsSatus
  self._item = (Item.Create)(data.itemId)
  local imageRecord = (self._item):GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (self._item):GetPinJiImage()
  ;
  (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._num):SetText((NumberManager.GetShowNumber)(data.itemNum))
  ;
  (self._grey):SetActive(((self._delegate)._cellData).status == CommonAwardsSatus.FETCHED)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

AccumulateCostTaskItemCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._item})
    local width, height = (self:GetRootWindow()):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

return AccumulateCostTaskItemCell

