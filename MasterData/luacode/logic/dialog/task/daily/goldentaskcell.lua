local GoldenTaskCell = class("GoldenTaskCell", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
GoldenTaskCell.AssetBundleName = "ui/layouts.basetasklist"
GoldenTaskCell.AssetName = "TaskStoryCell2"
local Status = LuaNetManager.CreateBean("protocol.task.taskstatus")

function GoldenTaskCell:Ctor(...)
  GoldenTaskCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function GoldenTaskCell:OnCreate()
  self._back = self:GetChild("Back/Back")
  self._done = self:GetChild("Back/BackDone")
  self._name = self:GetChild("Back/Title1")
  self._refresh = self:GetChild("Back/Refresh")
  self._commit = self:GetChild("Back/GetBtn")
  self._progress = {
    current = self:GetChild("Back/ProgressBack/Num/Num"),
    total = self:GetChild("Back/ProgressBack/Num/NumMax"),
    bar = self:GetChild("Back/ProgressBack/Progress")
  }
  self._desc = self:GetChild("Back/Detail")
  self._tip = self:GetChild("Back/Ibtn")
  self._goto = self:GetChild("Back/GoBtn")
  self._activeValue = self:GetChild("Back/ActiveNum")
  self._refresh:Subscribe_PointerClickEvent(self.OnRefreshClick, self)
  self._commit:Subscribe_PointerClickEvent(self.OnCommitClick, self)
  self._tip:Subscribe_PointerClickEvent(self.OnTipClick, self)
  self._goto:Subscribe_PointerClickEvent(self.OnGoToClick, self)
  self._refreshBoard = self:GetChild("Back/RefreshTime")
  self._refreshCount = self:GetChild("Back/RefreshTime/Num")
end

function GoldenTaskCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function GoldenTaskCell:RefreshCell()
  self._name:SetText(self._cellData:GetName())
  self._desc:SetText(self._cellData:GetDesc())
  self._activeValue:SetText(self._cellData:GetActiveValue())
  self._refreshCount:SetText(NekoData.BehaviorManager.BM_Task:GetDailyRefreshCount())
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
  self._refresh:SetActive(status == Status.PROCESSING)
  self._goto:SetActive(self._cellData:CanJump() and status == Status.PROCESSING)
end

function GoldenTaskCell:OnRefreshClick()
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(32, nil, function()
    self._delegate:OnRefreshClick(self._cellData:GetID())
  end)
end

function GoldenTaskCell:OnCommitClick()
  self._delegate:OnCommitClick(self._cellData:GetID())
end

function GoldenTaskCell:OnTipClick()
  DialogManager.CreateSingletonDialog("task.tasktipdialog"):SetData(self._cellData)
end

function GoldenTaskCell:OnGoToClick()
  NekoData.BehaviorManager.BM_Task:HandleTask(self._cellData:GetID())
end

function GoldenTaskCell:OnEvent(name, args)
  if name == "reload" then
    for _, i in pairs(args) do
      if i == self._cellData:GetID() then
        self:GetRootWindow():SetAnimatorTrigger("onRefresh")
      end
    end
  end
end

return GoldenTaskCell
