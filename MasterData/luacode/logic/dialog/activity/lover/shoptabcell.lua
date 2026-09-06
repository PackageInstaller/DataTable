local GridFrame = require("framework.ui.frame.grid.gridframe")
local BottomToTop = 3
local ColumnNum = 5
local ShopTabCell = class("ShopTabCell", Dialog)
ShopTabCell.AssetBundleName = "ui/layouts.activityvalentines"
ShopTabCell.AssetName = "ActivityValentinesShopFrame"

function ShopTabCell:Ctor(...)
  ShopTabCell.super.Ctor(self, ...)
end

function ShopTabCell:OnCreate()
  self._scrollBar = self:GetChild("Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._panel = self:GetChild("CellFrame")
  self._frame = GridFrame.Create(self._panel, self, true, ColumnNum)
  self._width, self._height = self._panel:GetRectSize()
end

function ShopTabCell:OnDestroy()
  self._frame:Destroy()
end

function ShopTabCell:RefreshTabCell(data, notChangePos)
  self._cellInfo = data
  local lastPos = self._frame:GetCurrentPosition()
  self._frame:ReloadAllCell()
  if notChangePos and lastPos then
    self._frame:MoveToAssignedPos(lastPos)
  end
end

function ShopTabCell:OnCurPosChange(frame, proportion)
  local total = self._frame:GetTotalLength()
  if total > self._height then
    self._scrollBar:SetScrollSize(self._height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetScrollSize(1)
    self._scrollBar:SetScrollValue(proportion)
  end
end

function ShopTabCell:NumberOfCell(frame)
  return #self._cellInfo
end

function ShopTabCell:CellAtIndex(frame, index)
  return "activity.lover.shopitemcell"
end

function ShopTabCell:DataAtIndex(frame, index)
  return self._cellInfo[index]
end

return ShopTabCell
