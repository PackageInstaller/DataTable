local TaskAwardCell = require("logic.dialog.task.taskawardcell")
local DailyTaskAwardCell = class("DailyTaskAwardCell", TaskAwardCell)
DailyTaskAwardCell.AssetBundleName = "ui/layouts.basetasklist"
DailyTaskAwardCell.AssetName = "TaskStoryItemCellSmall"

function DailyTaskAwardCell:Ctor(...)
  DailyTaskAwardCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

return DailyTaskAwardCell
