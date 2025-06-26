-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/alchemy/formulaqualitytabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local BottomToTop = 2
local FormulaQualityTabCell = class("FormulaQualityTabCell", Dialog)
FormulaQualityTabCell.AssetBundleName = "ui/layouts.yard"
FormulaQualityTabCell.AssetName = "AlchemyChooseFrame"
FormulaQualityTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FormulaQualityTabCell
  ((FormulaQualityTabCell.super).Ctor)(self, ...)
  self._init = false
end

FormulaQualityTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, TableFrame
  self._scrollBar = self:GetChild("Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._lockTxt = self:GetChild("LockTxt")
  self._panel = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  self._width = (self._panel):GetRectSize()
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnRootWindowClicked, self)
end

FormulaQualityTabCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

FormulaQualityTabCell.RefreshTabCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  if not self._init then
    self._init = true
    if data.lock then
      (self._lockTxt):SetActive(true)
      ;
      (self._lockTxt):SetText((string.gsub)((TextManager.GetText)(800118), "%$parameter1%$", data.unlockLv))
    else
      ;
      (self._lockTxt):SetActive(false)
    end
    self._data = data.list
    ;
    (self._frame):ReloadAllCell()
    ;
    (self._frame):MoveToTop()
  end
end

FormulaQualityTabCell.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_4
  local total = (self._frame):GetTotalLength()
  if self._height < total then
    (self._scrollBar):SetActive(true)
    ;
    (self._scrollBar):SetScrollSize(self._height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetActive(false)
  end
end

FormulaQualityTabCell.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._data
end

FormulaQualityTabCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "alchemy.formulacell"
end

FormulaQualityTabCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._data)[index]
end

FormulaQualityTabCell.OnRootWindowClicked = function(self, frame, index)
  -- function num : 0_8
end

return FormulaQualityTabCell

