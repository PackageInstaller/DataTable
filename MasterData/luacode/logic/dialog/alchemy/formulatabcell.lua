local TableFrame = require("framework.ui.frame.table.tableframe")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local FormulaTabCell = class("FormulaTabCell", Dialog)
FormulaTabCell.AssetBundleName = "ui/layouts.yard"
FormulaTabCell.AssetName = "AlchemyChooseFrame1"

function FormulaTabCell:Ctor(...)
  FormulaTabCell.super.Ctor(self, ...)
  self._init = false
  self._btnDataList = {}
  self._selectLv = nil
end

function FormulaTabCell:OnCreate()
  self._rankPanel = self:GetChild("RankFrame")
  self._qualityPanel = self:GetChild("Frame")
  self._rankFrame = TableFrame.Create(self._rankPanel, self, false, false, false)
  self._qualityFrame = TabFrame.Create(self._qualityPanel, self)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnRootWindowClicked, self)
end

function FormulaTabCell:OnDestroy()
  self._rankFrame:Destroy()
  self._qualityFrame:Destroy()
end

function FormulaTabCell:RefreshTabCell(data)
  if not self._init then
    self._init = true
    while self._btnDataList[#self._btnDataList] do
      table.remove(self._btnDataList, #self._btnDataList)
    end
    self._data = data
    for k, v in pairs(data) do
      table.insert(self._btnDataList, {level = k, data = v})
    end
    table.sort(self._btnDataList, function(a, b)
      return a.level < b.level
    end)
    self._rankFrame:ReloadAllCell()
    if #self._btnDataList > 0 and not self._selectLv then
      self:SelectLevel(self._btnDataList[1].level)
    end
  end
end

function FormulaTabCell:SelectLevel(level)
  if not self._selectLv or self._selectLv ~= level then
    self._selectLv = level
    self._rankFrame:FireEvent("SetSelectTab", self._selectLv)
    local tabCell = self._qualityFrame:ToPage(self._selectLv)
    tabCell:RefreshTabCell(self._data[self._selectLv])
  end
end

function FormulaTabCell:NumberOfCell(frame)
  return #self._btnDataList
end

function FormulaTabCell:CellAtIndex(frame, index)
  if frame == self._rankFrame then
    return "alchemy.qualitytabbtncell"
  else
    return "alchemy.formulaqualitytabcell"
  end
end

function FormulaTabCell:DataAtIndex(frame, index)
  return self._btnDataList[index]
end

function FormulaTabCell:OnRootWindowClicked(frame, index)
end

return FormulaTabCell
