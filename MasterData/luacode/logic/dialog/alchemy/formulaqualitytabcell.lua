local TableFrame = require("framework.ui.frame.table.tableframe")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local BottomToTop = 2
local FormulaQualityTabCell = class("FormulaQualityTabCell", Dialog)
FormulaQualityTabCell.AssetBundleName = "ui/layouts.yard"
FormulaQualityTabCell.AssetName = "AlchemyChooseFrame"

function FormulaQualityTabCell:Ctor(...)
  FormulaQualityTabCell.super.Ctor(self, ...)
  self._init = false
end

function FormulaQualityTabCell:OnCreate()
  self._scrollBar = self:GetChild("Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._lockTxt = self:GetChild("LockTxt")
  self._panel = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._width, self._height = self._panel:GetRectSize()
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnRootWindowClicked, self)
end

function FormulaQualityTabCell:OnDestroy()
  self._frame:Destroy()
end

function FormulaQualityTabCell:RefreshTabCell(data)
  if not self._init then
    self._init = true
    if data.lock then
      self._lockTxt:SetActive(true)
      self._lockTxt:SetText(string.gsub(TextManager.GetText(800118), "%$parameter1%$", data.unlockLv))
    else
      self._lockTxt:SetActive(false)
    end
    self._data = data.list
    self._frame:ReloadAllCell()
    self._frame:MoveToTop()
  end
end

function FormulaQualityTabCell:OnCurPosChange(frame, proportion)
  local total = self._frame:GetTotalLength()
  if total > self._height then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(self._height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

function FormulaQualityTabCell:NumberOfCell(frame)
  return #self._data
end

function FormulaQualityTabCell:CellAtIndex(frame, index)
  return "alchemy.formulacell"
end

function FormulaQualityTabCell:DataAtIndex(frame, index)
  return self._data[index]
end

function FormulaQualityTabCell:OnRootWindowClicked(frame, index)
end

return FormulaQualityTabCell
