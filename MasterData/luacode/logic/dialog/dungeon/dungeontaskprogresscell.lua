local DungeonTaskProgressCell = class("DungeonTaskProgressCell", Dialog)
DungeonTaskProgressCell.AssetBundleName = "ui/layouts.dungeon"
DungeonTaskProgressCell.AssetName = "DungeonMenuTask1Cell2"
local TableFrame = require("framework.ui.frame.table.tableframe")

function DungeonTaskProgressCell:Ctor(...)
  DungeonTaskProgressCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function DungeonTaskProgressCell:OnCreate()
  self._dots = {}
  for i = 1, 3 do
    self._dots[i] = self:GetChild("Dot" .. i)
  end
  self._name = self:GetChild("Task")
  self._progress = self:GetChild("Num")
end

function DungeonTaskProgressCell:OnDestroy()
end

function DungeonTaskProgressCell:RefreshCell()
  self._name:SetText(self._cellData.desc)
  local text = BeanManager.GetTableByName("message.cstringres"):GetRecorder(1058).msgTextID
  text = TextManager.GetText(text)
  text = text:gsub("%$parameter(%d)", {
    ["1"] = self._cellData.current,
    ["2"] = self._cellData.total
  })
  self._progress:SetText(text)
  for i, v in ipairs(self._dots) do
    v:SetActive((self._cellData.index - 1) % #self._dots == i - 1)
  end
end

return DungeonTaskProgressCell
