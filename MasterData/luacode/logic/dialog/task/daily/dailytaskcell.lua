local DailyTaskCell = class("DailyTaskCell", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
DailyTaskCell.AssetBundleName = "ui/layouts.basetasklist"
DailyTaskCell.AssetName = "TaskStoryCell3"
local Status = LuaNetManager.CreateBean("protocol.task.taskstatus")

function DailyTaskCell:Ctor(...)
  DailyTaskCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function DailyTaskCell:OnCreate()
  self._back = self:GetChild("Back/Back")
  self._done = self:GetChild("Back/BackDone")
  self._name = self:GetChild("Back/Title1")
  self._commit = self:GetChild("Back/GetBtn")
  self._progress = {
    current = self:GetChild("Back/ProgressBack/Num/Num"),
    total = self:GetChild("Back/ProgressBack/Num/NumMax"),
    bar = self:GetChild("Back/ProgressBack/Progress")
  }
  self._desc = self:GetChild("Back/Detail")
  self._goto = self:GetChild("Back/GoBtn")
  self._activeValue = self:GetChild("Back/ActiveNum")
  self._tips = self:GetChild("Back/Tips")
  self._tipsText = self:GetChild("Back/Tips/Text")
  self._commit:Subscribe_PointerClickEvent(self.OnCommitClick, self)
  self._goto:Subscribe_PointerClickEvent(self.OnGoToClick, self)
end

function DailyTaskCell:OnDestroy()
  if self._task then
    ServerGameTimer.RemoveTask(self._task)
    self._task = nil
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function DailyTaskCell:RefreshCell()
  self._name:SetText(self._cellData:GetName())
  self._desc:SetText(self._cellData:GetDesc())
  self._activeValue:SetText(self._cellData:GetActiveValue())
  local progress = self._cellData:GetProgress()
  self._progress.current:SetText(progress[1].current)
  self._progress.total:SetText(progress[1].total)
  self._progress.bar:SetFillAmount(progress[1].current / progress[1].total)
  local status = self._cellData:GetStatus()
  if self._delegate._isFullTo100 then
    self._commit:SetActive(false)
    self._done:SetActive(status == Status.COMMITED or status == Status.FINISHED)
    self._back:SetActive(status ~= Status.COMMITED and status ~= Status.FINISHED)
  else
    self._commit:SetActive(status == Status.FINISHED)
    self._done:SetActive(status == Status.COMMITED)
    self._back:SetActive(status ~= Status.COMMITED)
  end
  self._goto:SetActive(self._cellData:CanJump() and (status == Status.PROCESSING or status == Status.ACCEPTED))
  self._tips:SetActive(false)
end

function DailyTaskCell:OnCommitClick()
  self._delegate:OnCommitClick(self._cellData:GetID())
end

function DailyTaskCell:OnGoToClick()
  if self._cellData:IsLock() then
    local tipsTextID = self._cellData:GetUnlockTextId()
    if tipsTextID then
      self._tipsText:SetText(TextManager.GetText(tipsTextID))
    end
    self._tips:SetActive(true)
    if self._task then
      ServerGameTimer.RemoveTask(self._task)
      self._task = nil
    end
    self._task = GameTimer.AddTask(2, 0, function()
      self._tips:SetActive(false)
    end, nil)
    return
  end
  NekoData.BehaviorManager.BM_Task:HandleTask(self._cellData:GetID())
end

function DailyTaskCell:OnEvent(name, args)
  if name == "reload" then
    for _, i in pairs(args) do
      if i == self._cellData:GetID() then
        self:GetRootWindow():SetAnimatorTrigger("onRefresh")
      end
    end
  end
end

return DailyTaskCell
