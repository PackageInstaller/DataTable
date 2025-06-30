-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/task/daily/dailytaskawardcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskAwardCell = require("logic.dialog.task.taskawardcell")
local DailyTaskAwardCell = class("DailyTaskAwardCell", TaskAwardCell)
DailyTaskAwardCell.AssetBundleName = "ui/layouts.basetasklist"
DailyTaskAwardCell.AssetName = "TaskStoryItemCellSmall"
DailyTaskAwardCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DailyTaskAwardCell
  ((DailyTaskAwardCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

return DailyTaskAwardCell

