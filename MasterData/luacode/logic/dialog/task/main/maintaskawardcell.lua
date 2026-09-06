local TaskAwardCell = require("logic.dialog.task.taskawardcell")
local MainTaskAwardCell = class("MainTaskAwardCell", TaskAwardCell)
MainTaskAwardCell.AssetBundleName = "ui/layouts.basetasklist"
MainTaskAwardCell.AssetName = "TaskStoryItemCell"

function MainTaskAwardCell:Ctor(...)
  MainTaskAwardCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

return MainTaskAwardCell
