local CharacterTaskDetailFrame = class("CharacterTaskDetailFrame", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
CharacterTaskDetailFrame.AssetBundleName = "ui/layouts.basetasklist"
CharacterTaskDetailFrame.AssetName = "TaskDetail"

function CharacterTaskDetailFrame:Ctor(...)
  CharacterTaskDetailFrame.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function CharacterTaskDetailFrame:OnCreate()
  self._name = self:GetChild("Title")
  self._desc = self:GetChild("Detail")
  self._commit = self:GetChild("GetBtn")
  self._tip = self:GetChild("Tip")
  self._board = self:GetChild("ItemFrame")
  self._progress = {
    back = self:GetChild("ProgressBack"),
    current = self:GetChild("ProgressBack/Num/Num"),
    total = self:GetChild("ProgressBack/Num/NumMax"),
    bar = self:GetChild("ProgressBack/Progress"),
    text = self:GetChild("ProgressName")
  }
  self._goButton = self:GetChild("GoBtn")
  self._helper = TableFrame.Create(self._board, self, false, false)
  self._commit:Subscribe_PointerClickEvent(self.OnCommitClick, self)
  self._goButton:Subscribe_PointerClickEvent(self.OnGoButtonClick, self)
end

function CharacterTaskDetailFrame:OnDestroy()
  if self._helper then
    self._helper:Destroy()
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function CharacterTaskDetailFrame:RefreshCell(data, delegate)
  self._cellData = data
  self._delegate = delegate
  self._helper:ReloadAllCell()
  self._name:SetText(self._cellData:GetName())
  self._desc:SetText(self._cellData:GetDesc())
  self._tip:SetText(self._cellData:GetHintLocation())
  self:RefreshProgress()
  self._goButton:SetActive(self._cellData:CanJump() and self._cellData:GetStatus() ~= 3)
  self._commit:SetActive(self._cellData:GetStatus() == 3)
end

function CharacterTaskDetailFrame:RefreshProgress()
  local progress = self._cellData:GetProgress()
  local current = 0
  local total = 0
  self._progress.back:SetActive(#progress ~= 0)
  if #progress == 1 then
    current = progress[1].current
    total = progress[1].total
  else
    for i, v in ipairs(progress) do
      total = total + 1
      if v.current >= v.total then
        current = current + 1
      end
    end
  end
  self._progress.current:SetText(current)
  self._progress.total:SetText(total)
  self._progress.bar:SetFillAmount(current / total)
  self._progress.text:SetText(self._cellData:GetShortDesc())
end

function CharacterTaskDetailFrame:OnCommitClick()
  self._delegate:OnCommitClick(self._cellData:GetID())
end

function CharacterTaskDetailFrame:OnGoButtonClick()
  NekoData.BehaviorManager.BM_Task:HandleTask(self._cellData:GetID())
end

function CharacterTaskDetailFrame:NumberOfCell(helper)
  return #self._cellData:GetAwards()
end

function CharacterTaskDetailFrame:CellAtIndex(helper, index)
  return "task.taskawardcell"
end

function CharacterTaskDetailFrame:DataAtIndex(helper, index)
  return self._cellData:GetAwards()[index]
end

return CharacterTaskDetailFrame
