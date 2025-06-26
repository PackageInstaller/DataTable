-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/doubleeleven/taskcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskCellHelper = require("logic.dialog.activity.doubleeleven.taskcellhelper")
local TaskItemCell = class("TaskItemCell", Dialog)
TaskItemCell.AssetBundleName = "ui/layouts.activityeleven"
TaskItemCell.AssetName = "ActivityElevenTaskCell"
TaskItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TaskItemCell
  ((TaskItemCell.super).Ctor)(self, ...)
end

TaskItemCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TaskCellHelper
  self._rootElement = self:GetRootWindow()
  self._taskCellhelper = (TaskCellHelper.Create)(self._rootElement)
end

TaskItemCell.OnDestroy = function(self)
  -- function num : 0_2
  if self._taskCellhelper then
    (self._taskCellhelper):OnDestroy()
  end
end

TaskItemCell.RefreshCell = function(self, data)
  -- function num : 0_3
  if self._taskCellhelper then
    (self._taskCellhelper):RefreshCell(data)
  end
end

return TaskItemCell

