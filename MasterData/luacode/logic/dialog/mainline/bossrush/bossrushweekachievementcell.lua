local CWeeklyBossAchieveMissionConfig = BeanManager.GetTableByName("dungeonselect.cweeklybossachievemissionconfig")
local Status = LuaNetManager.CreateBean("protocol.task.taskstatus")
local TableFrame = require("framework.ui.frame.table.tableframe")
local BossRushWeekAchievementCell = class("BossRushWeekAchievementCell", Dialog)
BossRushWeekAchievementCell.AssetBundleName = "ui/layouts.mainline"
BossRushWeekAchievementCell.AssetName = "BossRushWeekAchievementCell"

function BossRushWeekAchievementCell:Ctor(...)
  BossRushWeekAchievementCell.super.Ctor(self, ...)
end

function BossRushWeekAchievementCell:OnCreate()
  self._title = self:GetChild("Back/Title1")
  self._detailTxt = self:GetChild("Back/Detail")
  self._progress = self:GetChild("Back/ProgressBack/Progress")
  self._num = self:GetChild("Back/ProgressBack/Num/Num")
  self._maxNum = self:GetChild("Back/ProgressBack/Num/NumMax")
  self._getBtn = self:GetChild("Back/GetBtn")
  self._goBtn = self:GetChild("Back/GoBtn")
  self._detailBtn = self:GetChild("Back/DetailBtn")
  self._goBtn:SetActive(false)
  self._detailBtn:SetActive(false)
  self._doneImage = self:GetChild("Back/BackDone")
  self._getBtn:Subscribe_PointerClickEvent(self.OnGetBtnClicked, self)
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._detailBtn:Subscribe_PointerClickEvent(self.OnDetailtnClicked, self)
  self._itemArea = self:GetChild("Back/ItemFrame")
  self._itemFrame = TableFrame.Create(self._itemArea, self, false, false, false)
end

function BossRushWeekAchievementCell:OnDestroy()
  self._itemFrame:Destroy()
end

function BossRushWeekAchievementCell:RefreshCell(data)
  self._task = data
  local record = CWeeklyBossAchieveMissionConfig:GetRecorder(self._task:GetID())
  if record then
    self._title:SetText(TextManager.GetText(record.missionnameTextID))
    self._detailTxt:SetText(TextManager.GetText(record.descriptionTextID))
    local taskStatus = self._task:GetStatus()
    local btn = taskStatus == Status.PROCESSING or self._task:IsLock()
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
end

function BossRushWeekAchievementCell:NumberOfCell(frame)
  return table.nums(self._itemList)
end

function BossRushWeekAchievementCell:CellAtIndex(frame, index)
  return "achievement.roleachievementdetailcellitemcell"
end

function BossRushWeekAchievementCell:DataAtIndex(frame, index)
  local temp = {}
  temp.itemid = self._itemList[index]
  temp.itemnum = self._itemNumList[index]
  return temp
end

function BossRushWeekAchievementCell:OnDetailtnClicked()
end

function BossRushWeekAchievementCell:OnGoBtnClicked()
end

function BossRushWeekAchievementCell:OnGetBtnClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.task.ccommittask")
  if protocol then
    protocol.taskid = self._task:GetID()
    protocol:Send()
    return
  end
end

return BossRushWeekAchievementCell
