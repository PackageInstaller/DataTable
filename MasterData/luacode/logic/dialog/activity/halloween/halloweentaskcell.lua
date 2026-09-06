local TaskStatus = LuaNetManager.CreateBean("protocol.task.taskstatus")
local TasksProtocolDef = LuaNetManager.GetProtocolDef("protocol.task.cactivitytasks")
local HalloweenTaskCell = class("HalloweenTaskCell", Dialog)
HalloweenTaskCell.AssetBundleName = "ui/layouts.activityhalloween"
HalloweenTaskCell.AssetName = "ActivityHalloweenTaskCell"

function HalloweenTaskCell:Ctor(...)
  HalloweenTaskCell.super.Ctor(self, ...)
  self._item = nil
  self._task = nil
end

function HalloweenTaskCell:OnCreate()
  self._taskBackFinish = self:GetChild("TaskBackFinish")
  self._taskBackNormal = self:GetChild("TaskBack")
  self._titleFinish = self:GetChild("TaskBackFinish/Text")
  self._titleNormal = self:GetChild("TaskBack/Text")
  self._progressNum = self:GetChild("TaskNum1")
  self._progressNumMax = self:GetChild("TaskNum2")
  self._progress = self:GetChild("Taskline")
  self._goBtn = self:GetChild("GoBtn")
  self._getBtn = self:GetChild("GetBtn")
  self._itemIcon = self:GetChild("Item")
  self._itemCount = self:GetChild("ItemNum")
  self._itemIcon:Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
  self._getBtn:Subscribe_PointerClickEvent(self.OnGetBtnClick, self)
end

function HalloweenTaskCell:OnDestroy()
end

function HalloweenTaskCell:RefreshCell(data)
  self._task = data
  self._titleNormal:SetText(self._task:GetDesc())
  self._titleFinish:SetText(self._task:GetDesc())
  self._progress:SetFillAmount(self._task:GetProgress()[1].current / self._task:GetProgress()[1].total)
  self._progressNum:SetText(self._task:GetProgress()[1].current)
  self._progressNumMax:SetText(self._task:GetProgress()[1].total)
  self._item = self._task:GetAwards()[1]
  self._itemCount:SetText(NumberManager.GetShowNumber(self._task:GetAwards()[1]:GetCount()))
  self._itemIcon:SetSprite(self._item:GetIcon().assetBundle, self._item:GetIcon().assetName)
  if self._task:GetStatus() == TaskStatus.PROCESSING then
    self._goBtn:SetActive(true)
    self._getBtn:SetActive(false)
    self._taskBackNormal:SetActive(true)
    self._taskBackFinish:SetActive(false)
    self._titleNormal:SetActive(true)
    self._titleFinish:SetActive(false)
  elseif self._task:GetStatus() == TaskStatus.FINISHED then
    self._goBtn:SetActive(false)
    self._getBtn:SetActive(true)
    self._taskBackNormal:SetActive(false)
    self._taskBackFinish:SetActive(true)
    self._titleNormal:SetActive(false)
    self._titleFinish:SetActive(true)
  elseif self._task:GetStatus() == TaskStatus.COMMITED then
    self._goBtn:SetActive(false)
    self._getBtn:SetActive(false)
    self._taskBackNormal:SetActive(true)
    self._taskBackFinish:SetActive(false)
    self._titleNormal:SetActive(true)
    self._titleFinish:SetActive(false)
  else
    self._goBtn:SetActive(false)
    self._getBtn:SetActive(false)
    self._taskBackNormal:SetActive(true)
    self._taskBackFinish:SetActive(false)
    self._titleNormal:SetActive(true)
    self._titleFinish:SetActive(false)
  end
end

function HalloweenTaskCell:OnItemCellClicked()
  local dialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if dialog then
    dialog:Init({
      item = self._item
    })
  end
end

function HalloweenTaskCell:OnGoBtnClick()
  NekoData.BehaviorManager.BM_ActivityTasks:HandleTask(self._task)
end

function HalloweenTaskCell:OnGetBtnClick()
  local protocol = LuaNetManager.CreateProtocol("protocol.task.ccommitactivitytask")
  if protocol then
    protocol.activityID = TasksProtocolDef.HALLOWEEN
    protocol.taskID = self._task:GetID()
    protocol:Send()
  end
end

return HalloweenTaskCell
