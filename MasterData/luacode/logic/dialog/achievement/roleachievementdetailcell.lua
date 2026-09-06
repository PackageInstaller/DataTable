local CAchievementMissionConfig = BeanManager.GetTableByName("mission.cachievemissionconfig")
local Status = LuaNetManager.CreateBean("protocol.task.taskstatus")
local TableFrame = require("framework.ui.frame.table.tableframe")
local RoleAchievementDetailCell = class("RoleAchievementDetailCell", Dialog)
RoleAchievementDetailCell.AssetBundleName = "ui/layouts.basetasklist"
RoleAchievementDetailCell.AssetName = "AchievementCell"

function RoleAchievementDetailCell:Ctor(...)
  RoleAchievementDetailCell.super.Ctor(self, ...)
end

function RoleAchievementDetailCell:OnCreate()
  self._title = self:GetChild("Back/Title1")
  self._detailTxt = self:GetChild("Back/Detail")
  self._progress = self:GetChild("Back/ProgressBack/Progress")
  self._num = self:GetChild("Back/ProgressBack/Num/Num")
  self._maxNum = self:GetChild("Back/ProgressBack/Num/NumMax")
  self._getBtn = self:GetChild("Back/GetBtn")
  self._goBtn = self:GetChild("Back/GoBtn")
  self._detailBtn = self:GetChild("Back/DetailBtn")
  self._doneImage = self:GetChild("Back/BackDone")
  self._tips = self:GetChild("Tips")
  self._tipsText = self:GetChild("Tips/Text")
  self._getBtn:Subscribe_PointerClickEvent(self.OnGetBtnClicked, self)
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._detailBtn:Subscribe_PointerClickEvent(self.OnDetailtnClicked, self)
  self._itemArea = self:GetChild("Back/ItemFrame")
  self._itemFrame = TableFrame.Create(self._itemArea, self, false, false, false)
end

function RoleAchievementDetailCell:OnDestroy()
  self._itemFrame:Destroy()
  if self._timer then
    ServerGameTimer.RemoveTask(self._timer)
    self._timer = nil
  end
end

function RoleAchievementDetailCell:RefreshCell(data)
  self._task = data.task
  local record = CAchievementMissionConfig:GetRecorder(self._task:GetID())
  if record then
    self._title:SetText(TextManager.GetText(record.missionnameTextID))
    self._detailTxt:SetText(TextManager.GetText(record.descriptionTextID))
    local taskStatus = self._task:GetStatus()
    local btn = taskStatus == Status.PROCESSING or self._task:IsLock()
    self._goBtn:SetActive(btn and record.jumptype ~= 0)
    self._detailBtn:SetActive(btn and record.jumptype == 0)
    self._doneImage:SetActive(taskStatus == Status.COMMITED)
    self._getBtn:SetActive(taskStatus == Status.FINISHED)
    local taskDone = taskStatus == Status.COMMITED or taskStatus == Status.FINISHED
    if self._task:IsMultiProgress() then
      if not taskDone then
        self._num:SetText(0)
        self._maxNum:SetText(1)
        self._progress:SetFillAmount(0)
      else
        self._num:SetText(1)
        self._maxNum:SetText(1)
        self._progress:SetFillAmount(1)
      end
    else
      local progress = self._task:GetProgress()[1]
      if not taskDone then
        self._num:SetText(math.min(progress.current, progress.total))
        self._maxNum:SetText(progress.total)
        self._progress:SetFillAmount(progress.current / progress.total)
      else
        self._num:SetText(progress.total)
        self._maxNum:SetText(progress.total)
        self._progress:SetFillAmount(1)
      end
    end
    self._itemList = record.rewarditem
    self._itemNumList = record.rewardquantity
    self._itemFrame:ReloadAllCell()
  end
  local tipsTextID = self._task:GetUnlockTextId()
  if tipsTextID then
    self._tipsText:SetText(TextManager.GetText(tipsTextID))
  end
  self._tips:SetActive(false)
end

function RoleAchievementDetailCell:NumberOfCell(frame)
  return table.nums(self._itemList)
end

function RoleAchievementDetailCell:CellAtIndex(frame, index)
  return "achievement.roleachievementdetailcellitemcell"
end

function RoleAchievementDetailCell:DataAtIndex(frame, index)
  local temp = {}
  temp.itemid = self._itemList[index]
  temp.itemnum = self._itemNumList[index]
  return temp
end

function RoleAchievementDetailCell:OnDetailtnClicked()
  DialogManager.CreateSingletonDialog("achievement.roleachievementdetailtip"):SetData(self._task:GetID())
end

function RoleAchievementDetailCell:OnGoBtnClicked()
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
  NekoData.BehaviorManager.BM_Task:HandleTask(self._task:GetID())
end

function RoleAchievementDetailCell:OnGetBtnClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.task.ccommittask")
  if protocol then
    protocol.taskid = self._task:GetID()
    protocol:Send()
    return
  end
end

return RoleAchievementDetailCell
