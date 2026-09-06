local GridFrame = require("framework.ui.frame.grid.gridframe")
local BattleReportFrameCell = class("BattleReportFrameCell", Dialog)
BattleReportFrameCell.AssetBundleName = "ui/layouts.battlewin"
BattleReportFrameCell.AssetName = "BattleReportFrame"
local CampType = {Left = 1, Right = 2}
local colNum = 3

function BattleReportFrameCell:Ctor(...)
  BattleReportFrameCell.super.Ctor(self, ...)
end

function BattleReportFrameCell:OnCreate()
  self._frame = GridFrame.Create(self:GetRootWindow(), self, true, colNum, false)
end

function BattleReportFrameCell:OnDestroy()
  if self._frame then
    self._frame:Destroy()
    self._frame = nil
  end
end

function BattleReportFrameCell:RefreshCell(data)
  self._data = data
  self._canCheckRoleDetail = self._delegate._canCheckRoleDetail
  self._frame:ReloadAllCell()
end

function BattleReportFrameCell:NumberOfCell(frame)
  return #self._data
end

function BattleReportFrameCell:CellAtIndex(frame, index)
  if self._data[index].isPartner then
    return "battle.battleaccount.battlereportsupportcell"
  elseif self._data[index].isRole then
    return "battle.battleaccount.battlereportcharcell"
  else
    return "battle.battleaccount.battlereportbosscell"
  end
end

function BattleReportFrameCell:DataAtIndex(frame, index)
  return self._data[index]
end

return BattleReportFrameCell
