local TableFrame = require("framework.ui.frame.table.tableframe")
local GachaRateAllCell = class("GachaRateAllCell", Dialog)
GachaRateAllCell.AssetBundleName = "ui/layouts.gacha"
GachaRateAllCell.AssetName = "GachaRateAllTitle"

function GachaRateAllCell:Ctor(...)
  GachaRateAllCell.super.Ctor(self, ...)
end

function GachaRateAllCell:OnCreate()
  self._field = self:GetChild("CellFrame")
  self._frame = TableFrame.Create(self._field, self, true, false, true)
  local _
  _, self._fHeight = self._field:GetRectSize()
  self._field_x, self._field_ox, self._field_y, self._field_oy = self._field:GetPosition()
  _, self._height = self:GetRootWindow():GetRectSize()
  self._x, self._ox = self:GetRootWindow():GetSize()
end

function GachaRateAllCell:OnDestroy()
  self._frame:Destroy()
end

function GachaRateAllCell:RefreshCell(data)
  self._data = data
  self._frame:ReloadAllCell()
  local totalLength = self._frame:GetTotalLength()
  local delta = totalLength - self._fHeight
  self._field:SetHeight(0, totalLength)
  self._field:SetPosition(self._field_x, self._field_ox, self._field_y, self._field_oy - delta)
  self:GetRootWindow():SetSize(self._x, self._ox, 0, self._height + delta)
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function GachaRateAllCell:NumberOfCell(frame)
  return #self._data
end

function GachaRateAllCell:CellAtIndex(frame, index)
  return "gacha.gacharateallcellcell"
end

function GachaRateAllCell:DataAtIndex(frame, index)
  return self._data[index]
end

function GachaRateAllCell:ShouldLengthChange()
  return true
end

return GachaRateAllCell
