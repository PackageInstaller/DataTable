-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/task/taskawardcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskAwardCell = class("TaskAwardCell", Dialog)
TaskAwardCell.AssetBundleName = "ui/layouts.basetasklist"
TaskAwardCell.AssetName = "TaskStoryItemCell"
TaskAwardCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TaskAwardCell
  ((TaskAwardCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

TaskAwardCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._selected = self:GetChild("ItemCell/_BackGround/Select")
  self._count = self:GetChild("ItemCell/_Count")
  ;
  (self._rootWindow):Subscribe_PointerClickEvent(self.OnMouseClick, self)
end

TaskAwardCell.RefreshCell = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local icon = (self._cellData):GetIcon()
  ;
  (self._icon):SetSprite(icon.assetBundle, icon.assetName)
  local frame = (self._cellData):GetPinJiImage()
  ;
  (self._frame):SetSprite(frame.assetBundle, frame.assetName)
  ;
  (self._count):SetText((NumberManager.GetShowNumber)((self._cellData):GetCount()))
end

TaskAwardCell.OnMouseClick = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local width, height = (self._rootWindow):GetRectSize()
  local tip = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  tip:Init({item = self._cellData, num = (self._cellData):GetCount()})
  tip:UpdatePosition(self)
  tip:SetTipsPosition(width, height, (self._rootWindow):GetLocalPointInUiRootPanel())
end

return TaskAwardCell

