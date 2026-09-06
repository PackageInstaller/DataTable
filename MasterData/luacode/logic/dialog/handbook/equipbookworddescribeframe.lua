local TableFrame = require("framework.ui.frame.table.tableframe")
local EquipBookWordDescribeFrame = class("EquipBookWordDescribeFrame", Dialog)
EquipBookWordDescribeFrame.AssetBundleName = "ui/layouts.tujian"
EquipBookWordDescribeFrame.AssetName = "EquipBookRandomPropertyFrame"

function EquipBookWordDescribeFrame:Ctor(...)
  EquipBookWordDescribeFrame.super.Ctor(self, ...)
  self._data = {}
end

function EquipBookWordDescribeFrame:OnCreate()
  self._panel = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._panel, self, true, false)
end

function EquipBookWordDescribeFrame:OnDestroy()
  self._frame:Destroy()
end

function EquipBookWordDescribeFrame:RefreshCell(data)
  self._data = data.value
  self._frame:ReloadAllCell()
end

function EquipBookWordDescribeFrame:NumberOfCell(frame, index)
  return #self._data
end

function EquipBookWordDescribeFrame:CellAtIndex(frame, index)
  return "handbook.equipbookworddescribecell"
end

function EquipBookWordDescribeFrame:DataAtIndex(frame, index)
  return self._data[index]
end

return EquipBookWordDescribeFrame
