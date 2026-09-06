local GridFrame = require("framework.ui.frame.grid.gridframe")
local EquipBookAttrFrameCell = class("EquipBookAttrFrameCell", Dialog)
EquipBookAttrFrameCell.AssetBundleName = "ui/layouts.tujian"
EquipBookAttrFrameCell.AssetName = "EquipBookPropertyFrame"

function EquipBookAttrFrameCell:Ctor(...)
  EquipBookAttrFrameCell.super.Ctor(self, ...)
end

function EquipBookAttrFrameCell:OnCreate()
  self._cellPanel = self:GetChild("Frame")
  self._frame = GridFrame.Create(self._cellPanel, self, true, 2, false)
end

function EquipBookAttrFrameCell:OnDestroy()
  self._frame:Destroy()
end

function EquipBookAttrFrameCell:RefreshCell(data)
  self._frame:ReloadAllCell()
  local tw, th = self._cellPanel:GetRectSize()
  local totalLength = self._frame:GetTotalLength()
  self._cellPanel:SetSize(0, tw, 0, totalLength)
  self._anchorY, self._offsetY = self._cellPanel:GetYPosition()
  self._cellPanel:SetYPosition(self._anchorY, self._offsetY - (totalLength - th))
  local rw, rh = self:GetRootWindow():GetRectSize()
  self:GetRootWindow():SetSize(0, rw, 0, rh + totalLength - th)
end

function EquipBookAttrFrameCell:ShouldLengthChange()
  return true
end

function EquipBookAttrFrameCell:NumberOfCell(frame)
  return #self._cellData.value
end

function EquipBookAttrFrameCell:CellAtIndex(frame)
  return "handbook.equipbookattrcell"
end

function EquipBookAttrFrameCell:DataAtIndex(frame, index)
  return self._cellData.value[index]
end

return EquipBookAttrFrameCell
