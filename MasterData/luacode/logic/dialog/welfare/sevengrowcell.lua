local TaskStatus = LuaNetManager.CreateBean("protocol.task.taskstatus")
local TasksProtocolDef = LuaNetManager.GetProtocolDef("protocol.task.cactivitytasks")
local SevenGrowCell = class("SevenGrowCell", Dialog)
SevenGrowCell.AssetBundleName = "ui/layouts.welfare"
SevenGrowCell.AssetName = "SevenGrowCell"

function SevenGrowCell:Ctor(...)
  SevenGrowCell.super.Ctor(self, ...)
  self._item = nil
  self._task = nil
end

function SevenGrowCell:OnCreate()
  self._lightBack = self:GetChild("Light")
  self._backBack = self:GetChild("Back")
  self._title = self:GetChild("Title")
  self._progress = self:GetChild("ProgressBack/Progress")
  self._progressNum = self:GetChild("ProgressBack/Num/Num")
  self._progressNumMax = self:GetChild("ProgressBack/Num/NumMax")
  self._itemCell = self:GetChild("ItemCell")
  self._itemIcon = self:GetChild("ItemCell/_BackGround/Icon")
  self._itemFrame = self:GetChild("ItemCell/_BackGround/Frame")
  self._itemCount = self:GetChild("ItemCell/_Count")
  self._tips = self:GetChild("Tips")
  self._tipsText = self:GetChild("Tips/Text")
  self._lockBtn = self:GetChild("LockBtn")
  self._goBtn = self:GetChild("GoBtn")
  self._getBtn = self:GetChild("GetBtn")
  self._doneBtn = self:GetChild("DoneBtn")
  self._ongoingBtn = self:GetChild("OngoingBtn")
  self._itemCell:Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
  self._getBtn:Subscribe_PointerClickEvent(self.OnGetBtnClick, self)
end

function SevenGrowCell:OnDestroy()
  if self._timer then
    ServerGameTimer.RemoveTask(self._timer)
    self._timer = nil
  end
end

function SevenGrowCell:RefreshCell(data)
  self._task = data.data
  self._isFirst = data.isFirst
  self._lightBack:SetActive(self._isFirst)
  self._backBack:SetActive(not self._isFirst)
  self._title:SetText(self._task:GetDesc())
  self._progress:SetFillAmount(self._task:GetProgress()[1].current / self._task:GetProgress()[1].total)
  self._progressNum:SetText(self._task:GetProgress()[1].current)
  self._progressNumMax:SetText(self._task:GetProgress()[1].total)
  self._item = self._task:GetAwards()[1]
  self._itemCount:SetText(NumberManager.GetShowNumber(self._task:GetAwards()[1]:GetCount()))
  self._itemIcon:SetSprite(self._item:GetIcon().assetBundle, self._item:GetIcon().assetName)
  self._itemFrame:SetSprite(self._item:GetPinJiImage().assetBundle, self._item:GetPinJiImage().assetName)
  if self._delegate._nowTaskDay > self._delegate._lastTaskDay then
    self._lockBtn:SetActive(true)
    self._goBtn:SetActive(false)
    self._ongoingBtn:SetActive(false)
    self._getBtn:SetActive(false)
    self._doneBtn:SetActive(false)
  elseif self._task:GetStatus() == TaskStatus.PROCESSING or self._task:IsLock() then
    self._lockBtn:SetActive(false)
    self._goBtn:SetActive(self._task:CanJump())
    self._ongoingBtn:SetActive(not self._task:CanJump())
    self._getBtn:SetActive(false)
    self._doneBtn:SetActive(false)
  elseif self._task:GetStatus() == TaskStatus.FINISHED then
    self._lockBtn:SetActive(false)
    self._goBtn:SetActive(false)
    self._ongoingBtn:SetActive(false)
    self._getBtn:SetActive(true)
    self._doneBtn:SetActive(false)
  elseif self._task:GetStatus() == TaskStatus.COMMITED then
    self._lockBtn:SetActive(false)
    self._goBtn:SetActive(false)
    self._ongoingBtn:SetActive(false)
    self._getBtn:SetActive(false)
    self._doneBtn:SetActive(true)
  else
    self._lockBtn:SetActive(false)
    self._goBtn:SetActive(false)
    self._ongoingBtn:SetActive(false)
    self._getBtn:SetActive(false)
    self._doneBtn:SetActive(false)
  end
  local tipsTextID = self._task:GetUnlockTextId()
  if tipsTextID then
    self._tipsText:SetText(TextManager.GetText(tipsTextID))
  end
  self._tips:SetActive(false)
end

function SevenGrowCell:OnItemCellClicked()
  local dialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if dialog then
    dialog:Init({
      item = self._item
    })
  end
end

function SevenGrowCell:OnGoBtnClick()
  if self._task:IsLock() then
    self._tips:SetActive(true)
    if self._timer then
      ServerGameTimer.RemoveTask(self._timer)
      self._timer = nil
    end
    self._timer = GameTimer.AddTask(2, 0, function()
      self._tips:SetActive(false)
    end, nil)
    return
  end
  NekoData.BehaviorManager.BM_ActivityTasks:HandleTask(self._task)
end

function SevenGrowCell:OnGetBtnClick()
  local protocol = LuaNetManager.CreateProtocol("protocol.task.ccommitactivitytask")
  if protocol then
    protocol.activityID = TasksProtocolDef.SEVEN_DAYS
    protocol.taskID = self._task:GetID()
    protocol:Send()
  end
end

return SevenGrowCell
