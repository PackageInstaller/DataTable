-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/alchemy/formulatabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local FormulaTabCell = class("FormulaTabCell", Dialog)
FormulaTabCell.AssetBundleName = "ui/layouts.yard"
FormulaTabCell.AssetName = "AlchemyChooseFrame1"
FormulaTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FormulaTabCell
  ((FormulaTabCell.super).Ctor)(self, ...)
  self._init = false
  self._btnDataList = {}
  self._selectLv = nil
end

FormulaTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, TabFrame
  self._rankPanel = self:GetChild("RankFrame")
  self._qualityPanel = self:GetChild("Frame")
  self._rankFrame = (TableFrame.Create)(self._rankPanel, self, false, false, false)
  self._qualityFrame = (TabFrame.Create)(self._qualityPanel, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnRootWindowClicked, self)
end

FormulaTabCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._rankFrame):Destroy()
  ;
  (self._qualityFrame):Destroy()
end

FormulaTabCell.RefreshTabCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  if not self._init then
    self._init = true
    while (self._btnDataList)[#self._btnDataList] do
      (table.remove)(self._btnDataList, #self._btnDataList)
    end
    self._data = data
    for k,v in pairs(data) do
      (table.insert)(self._btnDataList, {level = k, data = v})
    end
    ;
    (table.sort)(self._btnDataList, function(a, b)
    -- function num : 0_3_0
    do return a.level < b.level end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    ;
    (self._rankFrame):ReloadAllCell()
    if #self._btnDataList > 0 and not self._selectLv then
      self:SelectLevel(((self._btnDataList)[1]).level)
    end
  end
end

FormulaTabCell.SelectLevel = function(self, level)
  -- function num : 0_4
  if not self._selectLv or self._selectLv ~= level then
    self._selectLv = level
    ;
    (self._rankFrame):FireEvent("SetSelectTab", self._selectLv)
    local tabCell = (self._qualityFrame):ToPage(self._selectLv)
    tabCell:RefreshTabCell((self._data)[self._selectLv])
  end
end

FormulaTabCell.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._btnDataList
end

FormulaTabCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  if frame == self._rankFrame then
    return "alchemy.qualitytabbtncell"
  else
    return "alchemy.formulaqualitytabcell"
  end
end

FormulaTabCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._btnDataList)[index]
end

FormulaTabCell.OnRootWindowClicked = function(self, frame, index)
  -- function num : 0_8
end

return FormulaTabCell

