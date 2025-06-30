-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/lover/shoptabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local BottomToTop = 3
local ColumnNum = 5
local ShopTabCell = class("ShopTabCell", Dialog)
ShopTabCell.AssetBundleName = "ui/layouts.activityvalentines"
ShopTabCell.AssetName = "ActivityValentinesShopFrame"
ShopTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopTabCell
  ((ShopTabCell.super).Ctor)(self, ...)
end

ShopTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, GridFrame, ColumnNum
  self._scrollBar = self:GetChild("Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._panel = self:GetChild("CellFrame")
  self._frame = (GridFrame.Create)(self._panel, self, true, ColumnNum)
  self._width = (self._panel):GetRectSize()
end

ShopTabCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

ShopTabCell.RefreshTabCell = function(self, data, notChangePos)
  -- function num : 0_3
  self._cellInfo = data
  local lastPos = (self._frame):GetCurrentPosition()
  ;
  (self._frame):ReloadAllCell()
  if notChangePos and lastPos then
    (self._frame):MoveToAssignedPos(lastPos)
  end
end

ShopTabCell.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_4
  local total = (self._frame):GetTotalLength()
  if self._height < total then
    (self._scrollBar):SetScrollSize(self._height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetScrollSize(1)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  end
end

ShopTabCell.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._cellInfo
end

ShopTabCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "activity.lover.shopitemcell"
end

ShopTabCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._cellInfo)[index]
end

return ShopTabCell

