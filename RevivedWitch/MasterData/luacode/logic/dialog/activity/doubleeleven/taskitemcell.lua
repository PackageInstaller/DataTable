-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/doubleeleven/taskitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskItemCell = class("TaskItemCell", Dialog)
TaskItemCell.AssetBundleName = "ui/layouts.activityeleven"
TaskItemCell.AssetName = "TaskCellItem"
TaskItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TaskItemCell
  ((TaskItemCell.super).Ctor)(self, ...)
  self._item = nil
end

TaskItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._itemCount = self:GetChild("Panel/ItemCell/_Count")
  self._itemFrame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._itemIcon = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
end

TaskItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

TaskItemCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  self._item = data
  ;
  (self._itemCount):SetText((NumberManager.GetShowNumber)((self._item):GetCount()))
  ;
  (self._itemIcon):SetSprite(((self._item):GetIcon()).assetBundle, ((self._item):GetIcon()).assetName)
  ;
  (self._itemFrame):SetSprite(((self._item):GetPinJiImage()).assetBundle, ((self._item):GetPinJiImage()).assetName)
end

TaskItemCell.OnItemCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if dialog then
    dialog:Init({item = self._item})
  end
end

return TaskItemCell

