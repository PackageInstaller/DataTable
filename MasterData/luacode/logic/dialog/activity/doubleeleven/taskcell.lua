local TaskCellHelper = require("logic.dialog.activity.doubleeleven.taskcellhelper")
local TaskItemCell = class("TaskItemCell", Dialog)
TaskItemCell.AssetBundleName = "ui/layouts.activityeleven"
TaskItemCell.AssetName = "ActivityElevenTaskCell"

function TaskItemCell:Ctor(...)
  TaskItemCell.super.Ctor(self, ...)
end

function TaskItemCell:OnCreate()
  self._rootElement = self:GetRootWindow()
  self._taskCellhelper = TaskCellHelper.Create(self._rootElement)
end

function TaskItemCell:OnDestroy()
  if self._taskCellhelper then
    self._taskCellhelper:OnDestroy()
  end
end

function TaskItemCell:RefreshCell(data)
  if self._taskCellhelper then
    self._taskCellhelper:RefreshCell(data)
  end
end

return TaskItemCell
