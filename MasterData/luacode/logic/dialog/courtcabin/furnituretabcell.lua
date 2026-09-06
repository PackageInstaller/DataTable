local TableFrame = require("framework.ui.frame.table.tableframe")
local ColumnNums = 9
local DressUpCabinDialog = require("logic.dialog.courtcabin.dressupcabindialog")
local FurnitureTabCell = class("FurnitureTabCell", Dialog)
FurnitureTabCell.AssetBundleName = "ui/layouts.yard"
FurnitureTabCell.AssetName = "HouseDecorateItemFrame"

function FurnitureTabCell:Ctor(...)
  FurnitureTabCell.super.Ctor(self, ...)
  self._init = false
end

function FurnitureTabCell:OnCreate()
  self._leftArrow = self:GetChild("Left")
  self._rightArrow = self:GetChild("Right")
  self._panel = self:GetChild("Frame")
  self._width, self._height = self._panel:GetRectSize()
  self._frame = TableFrame.Create(self._panel, self, false, true)
end

function FurnitureTabCell:OnDestroy()
  self._frame:Destroy()
end

function FurnitureTabCell:RefreshTabCell(data, isRefresh, isChangePos)
  local lastPos = self._frame:GetCurrentPosition()
  if not self._init or isRefresh then
    self._init = true
    self._data = data.data
    self._tabId = data.tabId
    if #self._data <= ColumnNums then
      self._leftArrow:SetActive(false)
      self._rightArrow:SetActive(false)
      self._frame:SetSlide(false)
    else
      self._leftArrow:SetActive(true)
      self._rightArrow:SetActive(true)
      self._frame:SetSlide(true)
    end
    self._frame:ReloadAllCell()
  end
  if not isChangePos then
    if lastPos then
      self._frame:MoveToAssignedPos(lastPos)
    end
  else
    self._frame:MoveToLeft()
  end
end

function FurnitureTabCell:OnCurPosChange(frame, tag)
  if frame == self._frame and #self._data > ColumnNums then
    self._leftArrow:SetActive(tag ~= 0)
    self._rightArrow:SetActive(tag ~= 1)
    if self._frame:GetTotalLength() <= self._width then
      self._leftArrow:SetActive(false)
      self._rightArrow:SetActive(false)
    end
  end
end

function FurnitureTabCell:NumberOfCell(frame)
  return #self._data
end

function FurnitureTabCell:CellAtIndex(frame, index)
  if self._tabId == DressUpCabinDialog.SpecialTabType.Theme then
    return "courtcabin.themecell"
  else
    return "courtcabin.furniturecell"
  end
end

function FurnitureTabCell:DataAtIndex(frame, index)
  return self._data[index]
end

return FurnitureTabCell
