local DungeonTaskCell = class("DungeonTaskCell", Dialog)
DungeonTaskCell.AssetBundleName = "ui/layouts.dungeon"
DungeonTaskCell.AssetName = "DungeonMenuTask1Cell"
local TableFrame = require("framework.ui.frame.table.tableframe")

function DungeonTaskCell:Ctor(...)
  DungeonTaskCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function DungeonTaskCell:OnCreate()
  self._name = self:GetChild("Task")
  self._progress = {
    [1] = self:GetChild("NumGreen"),
    [3] = self:GetChild("NumOrange"),
    [8] = self:GetChild("NumOrange")
  }
  self._marks = {
    [1] = self:GetChild("MainImg"),
    [2] = self:GetChild("BranchImg"),
    [3] = self:GetChild("QiYuanImg"),
    [8] = self:GetChild("QiYuanImg")
  }
  self._finishImg = self:GetChild("FinishImage")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnClick, self)
end

function DungeonTaskCell:OnDestroy()
end

function DungeonTaskCell:RefreshCell()
  for i, v in pairs(self._marks) do
    v:SetActive(false)
  end
  for i, v in pairs(self._progress) do
    v:SetActive(false)
  end
  self._name:SetText(self._cellData:GetName())
  for i, v in pairs(self._marks) do
    if self._cellData:GetType() == i then
      v:SetActive(true)
      break
    end
  end
  self._finishImg:SetActive(self._cellData:GetStatus() == 3)
  local progress = self._cellData:GetProgress()
  if #progress <= 1 then
    self._data = {}
    if #progress == 0 or not self._delegate:ShouldShowProgress() then
      for _, v in pairs(self._progress) do
        v:SetActive(false)
      end
    elseif #progress == 1 then
      local text = BeanManager.GetTableByName("message.cstringres"):GetRecorder(1058).msgTextID
      text = TextManager.GetText(text)
      text = text:gsub("%$parameter(%d)", {
        ["1"] = progress[1].current,
        ["2"] = progress[1].total
      })
      for i, v in pairs(self._progress) do
        if self._cellData:GetType() == i then
          v:SetActive(i == self._cellData:GetType())
          v:SetText(text)
          if self._cellData:GetStatus() == 3 then
            v:SetActive(false)
          end
          break
        end
      end
    end
  else
    self._data = progress
    self._helper:ReloadAllCell()
    local length = self._helper:GetTotalLength()
    self._helper:ReloadAllCell()
  end
end

function DungeonTaskCell:OnClick()
  DialogManager.CreateSingletonDialog("task.tasktipdialog"):SetData(self._cellData)
end

function DungeonTaskCell:NumberOfCell()
  if self._delegate:ShouldShowProgress() then
    return #self._tasks
  end
  return 0
end

function DungeonTaskCell:CellAtIndex()
  return "dungeon.dungeontaskprogresscell"
end

function DungeonTaskCell:DataAtIndex(helper, index)
  local data = clone(self._data[index])
  data.type = self._cellData:GetType()
  data.index = index
  return data
end

return DungeonTaskCell
