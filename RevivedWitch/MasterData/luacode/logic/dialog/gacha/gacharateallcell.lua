-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/gacharateallcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local GachaRateAllCell = class("GachaRateAllCell", Dialog)
GachaRateAllCell.AssetBundleName = "ui/layouts.gacha"
GachaRateAllCell.AssetName = "GachaRateAllTitle"
GachaRateAllCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GachaRateAllCell
  ((GachaRateAllCell.super).Ctor)(self, ...)
end

GachaRateAllCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._field = self:GetChild("CellFrame")
  self._frame = (TableFrame.Create)(self._field, self, true, false, true)
  local _ = nil
  _ = (self._field):GetRectSize()
  self._field_x = (self._field):GetPosition()
  _ = (self:GetRootWindow()):GetRectSize()
  self._x = (self:GetRootWindow()):GetSize()
end

GachaRateAllCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

GachaRateAllCell.RefreshCell = function(self, data)
  -- function num : 0_3
  self._data = data
  ;
  (self._frame):ReloadAllCell()
  local totalLength = (self._frame):GetTotalLength()
  local delta = totalLength - self._fHeight
  ;
  (self._field):SetHeight(0, totalLength)
  ;
  (self._field):SetPosition(self._field_x, self._field_ox, self._field_y, self._field_oy - delta)
  ;
  (self:GetRootWindow()):SetSize(self._x, self._ox, 0, self._height + delta)
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
end

GachaRateAllCell.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._data
end

GachaRateAllCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "gacha.gacharateallcellcell"
end

GachaRateAllCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._data)[index]
end

GachaRateAllCell.ShouldLengthChange = function(self)
  -- function num : 0_7
  return true
end

return GachaRateAllCell

