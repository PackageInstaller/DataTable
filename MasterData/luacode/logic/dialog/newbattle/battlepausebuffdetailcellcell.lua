local TableFrame = require("framework.ui.frame.table.tableframe")
local BattlePauseBuffDetailCellCell = class("BattlePauseBuffDetailCellCell", Dialog)
BattlePauseBuffDetailCellCell.AssetBundleName = "ui/layouts.battlenew"
BattlePauseBuffDetailCellCell.AssetName = "BattlePauseCellBuffFrame"

function BattlePauseBuffDetailCellCell:Ctor(...)
  BattlePauseBuffDetailCellCell.super.Ctor(self, ...)
end

function BattlePauseBuffDetailCellCell:OnCreate()
  self._panel = self:GetRootWindow()
  self._frame = TableFrame.Create(self._panel, self, false, false)
end

function BattlePauseBuffDetailCellCell:OnDestroy()
  if self._frame then
    self._frame:Destroy()
    self._frame = nil
  end
end

function BattlePauseBuffDetailCellCell:RefreshCell(data)
  self._data = data
  self._frame:ReloadAllCell()
end

function BattlePauseBuffDetailCellCell:NumberOfCell(frame)
  if frame == self._frame then
    return #self._data
  end
end

function BattlePauseBuffDetailCellCell:CellAtIndex(frame)
  if frame == self._frame then
    return "newbattle.battlepausebuffdetailcellcellbuffcell"
  end
end

function BattlePauseBuffDetailCellCell:DataAtIndex(frame, index)
  if frame == self._frame then
    return self._data[index]
  end
end

function BattlePauseBuffDetailCellCell:ShouldLengthChange(frame, index)
  return true
end

return BattlePauseBuffDetailCellCell
