-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/furnituretabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local ColumnNums = 9
local DressUpCabinDialog = require("logic.dialog.courtcabin.dressupcabindialog")
local FurnitureTabCell = class("FurnitureTabCell", Dialog)
FurnitureTabCell.AssetBundleName = "ui/layouts.yard"
FurnitureTabCell.AssetName = "HouseDecorateItemFrame"
FurnitureTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FurnitureTabCell
  ((FurnitureTabCell.super).Ctor)(self, ...)
  self._init = false
end

FurnitureTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._leftArrow = self:GetChild("Left")
  self._rightArrow = self:GetChild("Right")
  self._panel = self:GetChild("Frame")
  self._width = (self._panel):GetRectSize()
  self._frame = (TableFrame.Create)(self._panel, self, false, true)
end

FurnitureTabCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

FurnitureTabCell.RefreshTabCell = function(self, data, isRefresh, isChangePos)
  -- function num : 0_3 , upvalues : ColumnNums
  local lastPos = (self._frame):GetCurrentPosition()
  if not self._init or isRefresh then
    self._init = true
    self._data = data.data
    self._tabId = data.tabId
    if #self._data <= ColumnNums then
      (self._leftArrow):SetActive(false)
      ;
      (self._rightArrow):SetActive(false)
      ;
      (self._frame):SetSlide(false)
    else
      ;
      (self._leftArrow):SetActive(true)
      ;
      (self._rightArrow):SetActive(true)
      ;
      (self._frame):SetSlide(true)
    end
    ;
    (self._frame):ReloadAllCell()
  end
  if not isChangePos and lastPos then
    (self._frame):MoveToAssignedPos(lastPos)
  end
  ;
  (self._frame):MoveToLeft()
end

FurnitureTabCell.OnCurPosChange = function(self, frame, tag)
  -- function num : 0_4 , upvalues : ColumnNums
  if tag == 0 then
    (self._leftArrow):SetActive(frame ~= self._frame or ColumnNums >= #self._data)
    ;
    (self._rightArrow):SetActive(tag ~= 1)
    if (self._frame):GetTotalLength() <= self._width then
      (self._leftArrow):SetActive(false)
      ;
      (self._rightArrow):SetActive(false)
    end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

FurnitureTabCell.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._data
end

FurnitureTabCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_6 , upvalues : DressUpCabinDialog
  if self._tabId == (DressUpCabinDialog.SpecialTabType).Theme then
    return "courtcabin.themecell"
  else
    return "courtcabin.furniturecell"
  end
end

FurnitureTabCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._data)[index]
end

return FurnitureTabCell

