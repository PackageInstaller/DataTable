local TaskStatus = LuaNetManager.CreateBean("protocol.task.taskstatus")
local TasksProtocolDef = LuaNetManager.GetProtocolDef("protocol.task.cactivitytasks")
local ReturnWelfareTaskCell = class("ReturnWelfareTaskCell", Dialog)
ReturnWelfareTaskCell.AssetBundleName = "ui/layouts.welfare"
ReturnWelfareTaskCell.AssetName = "ReturnWelfareTaskCell"

function ReturnWelfareTaskCell:Ctor(...)
  ReturnWelfareTaskCell.super.Ctor(self, ...)
  self._item = nil
  self._task = nil
end

function ReturnWelfareTaskCell:OnCreate()
  self._titleNormal = self:GetChild("Title")
  self._progressNum = self:GetChild("ProgressBack/Num/Num")
  self._progressNumMax = self:GetChild("ProgressBack/Num/NumMax")
  self._progress = self:GetChild("ProgressBack/Progress")
  self._taskLockBtn = self:GetChild("LockBtn")
  self._taskLockBtn:SetActive(false)
  self._taskOnGoingBtn = self:GetChild("OngoingBtn")
  self._taskOnGoingBtn:SetActive(false)
  self._goBtn = self:GetChild("GoBtn")
  self._taskDoneBtn = self:GetChild("DoneBtn")
  self._getBtn = self:GetChild("GetBtn")
  self._itemIcon = self:GetChild("ItemCell/_BackGround/Icon")
  self._itemCount = self:GetChild("ItemCell/_Count")
  self._itemIcon:Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
  self._getBtn:Subscribe_PointerClickEvent(self.OnGetBtnClick, self)
end

function ReturnWelfareTaskCell:OnDestroy()
end

function ReturnWelfareTaskCell:RefreshCell(data)
  self._task = data
  self._titleNormal:SetText(self._task:GetDesc())
  self._progress:SetFillAmount(self._task:GetProgress()[1].current / self._task:GetProgress()[1].total)
  self._progressNum:SetText(self._task:GetProgress()[1].current)
  self._progressNumMax:SetText(self._task:GetProgress()[1].total)
  self._item = self._task:GetAwards()[1]
  self._itemCount:SetText(NumberManager.GetShowNumber(self._task:GetAwards()[1]:GetCount()))
  self._itemIcon:SetSprite(self._item:GetIcon().assetBundle, self._item:GetIcon().assetName)
  if self._task:GetStatus() == TaskStatus.PROCESSING then
    self._goBtn:SetActive(true)
    self._getBtn:SetActive(false)
    self._taskDoneBtn:SetActive(false)
  elseif self._task:GetStatus() == TaskStatus.FINISHED then
    self._goBtn:SetActive(false)
    self._getBtn:SetActive(true)
    self._taskDoneBtn:SetActive(false)
  elseif self._task:GetStatus() == TaskStatus.COMMITED then
    self._goBtn:SetActive(false)
    self._getBtn:SetActive(false)
    self._taskDoneBtn:SetActive(true)
  else
    self._goBtn:SetActive(false)
    self._getBtn:SetActive(false)
    self._taskDoneBtn:SetActive(false)
  end
end

function ReturnWelfareTaskCell:OnItemCellClicked()
  local dialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if dialog then
    dialog:Init({
      item = self._item
    })
  end
end

function ReturnWelfareTaskCell:OnGoBtnClick()
  NekoData.BehaviorManager.BM_ActivityTasks:HandleTask(self._task)
end

function ReturnWelfareTaskCell:OnGetBtnClick()
  local protocol = LuaNetManager.CreateProtocol("protocol.task.ccommitactivitytask")
  if protocol then
    protocol.activityID = TasksProtocolDef.BACK_PLAYER
    protocol.taskID = self._task:GetID()
    protocol:Send()
  end
end

return ReturnWelfareTaskCell
