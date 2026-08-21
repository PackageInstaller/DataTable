-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/newbattle/battlepausebuffdetailcellcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local BattlePauseBuffDetailCellCell = class("BattlePauseBuffDetailCellCell", Dialog)
BattlePauseBuffDetailCellCell.AssetBundleName = "ui/layouts.battlenew"
BattlePauseBuffDetailCellCell.AssetName = "BattlePauseCellBuffFrame"
BattlePauseBuffDetailCellCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattlePauseBuffDetailCellCell
  ((BattlePauseBuffDetailCellCell.super).Ctor)(self, ...)
end

BattlePauseBuffDetailCellCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._panel = self:GetRootWindow()
  self._frame = (TableFrame.Create)(self._panel, self, false, false)
end

BattlePauseBuffDetailCellCell.OnDestroy = function(self)
  -- function num : 0_2
  if self._frame then
    (self._frame):Destroy()
    self._frame = nil
  end
end

BattlePauseBuffDetailCellCell.RefreshCell = function(self, data)
  -- function num : 0_3
  self._data = data
  ;
  (self._frame):ReloadAllCell()
end

BattlePauseBuffDetailCellCell.NumberOfCell = function(self, frame)
  -- function num : 0_4
  if frame == self._frame then
    return #self._data
  end
end

BattlePauseBuffDetailCellCell.CellAtIndex = function(self, frame)
  -- function num : 0_5
  if frame == self._frame then
    return "newbattle.battlepausebuffdetailcellcellbuffcell"
  end
end

BattlePauseBuffDetailCellCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  if frame == self._frame then
    return (self._data)[index]
  end
end

BattlePauseBuffDetailCellCell.ShouldLengthChange = function(self, frame, index)
  -- function num : 0_7
  return true
end

return BattlePauseBuffDetailCellCell

