-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/task/main/maintaskawardcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskAwardCell = require("logic.dialog.task.taskawardcell")
local MainTaskAwardCell = class("MainTaskAwardCell", TaskAwardCell)
MainTaskAwardCell.AssetBundleName = "ui/layouts.basetasklist"
MainTaskAwardCell.AssetName = "TaskStoryItemCell"
MainTaskAwardCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MainTaskAwardCell
  ((MainTaskAwardCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

return MainTaskAwardCell

