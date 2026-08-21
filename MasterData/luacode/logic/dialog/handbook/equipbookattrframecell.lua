-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/equipbookattrframecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local EquipBookAttrFrameCell = class("EquipBookAttrFrameCell", Dialog)
EquipBookAttrFrameCell.AssetBundleName = "ui/layouts.tujian"
EquipBookAttrFrameCell.AssetName = "EquipBookPropertyFrame"
EquipBookAttrFrameCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipBookAttrFrameCell
  ((EquipBookAttrFrameCell.super).Ctor)(self, ...)
end

EquipBookAttrFrameCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame
  self._cellPanel = self:GetChild("Frame")
  self._frame = (GridFrame.Create)(self._cellPanel, self, true, 2, false)
end

EquipBookAttrFrameCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

EquipBookAttrFrameCell.RefreshCell = function(self, data)
  -- function num : 0_3
  (self._frame):ReloadAllCell()
  local tw, th = (self._cellPanel):GetRectSize()
  local totalLength = (self._frame):GetTotalLength()
  ;
  (self._cellPanel):SetSize(0, tw, 0, totalLength)
  self._anchorY = (self._cellPanel):GetYPosition()
  ;
  (self._cellPanel):SetYPosition(self._anchorY, self._offsetY - (totalLength - th))
  local rw, rh = (self:GetRootWindow()):GetRectSize()
  ;
  (self:GetRootWindow()):SetSize(0, rw, 0, rh + totalLength - th)
end

EquipBookAttrFrameCell.ShouldLengthChange = function(self)
  -- function num : 0_4
  return true
end

EquipBookAttrFrameCell.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #(self._cellData).value
end

EquipBookAttrFrameCell.CellAtIndex = function(self, frame)
  -- function num : 0_6
  return "handbook.equipbookattrcell"
end

EquipBookAttrFrameCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return ((self._cellData).value)[index]
end

return EquipBookAttrFrameCell

