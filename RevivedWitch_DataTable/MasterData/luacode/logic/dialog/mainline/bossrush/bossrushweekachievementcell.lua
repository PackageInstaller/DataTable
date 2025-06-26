-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/bossrush/bossrushweekachievementcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CWeeklyBossAchieveMissionConfig = (BeanManager.GetTableByName)("dungeonselect.cweeklybossachievemissionconfig")
local Status = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local TableFrame = require("framework.ui.frame.table.tableframe")
local BossRushWeekAchievementCell = class("BossRushWeekAchievementCell", Dialog)
BossRushWeekAchievementCell.AssetBundleName = "ui/layouts.mainline"
BossRushWeekAchievementCell.AssetName = "BossRushWeekAchievementCell"
BossRushWeekAchievementCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BossRushWeekAchievementCell
  ((BossRushWeekAchievementCell.super).Ctor)(self, ...)
end

BossRushWeekAchievementCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._title = self:GetChild("Back/Title1")
  self._detailTxt = self:GetChild("Back/Detail")
  self._progress = self:GetChild("Back/ProgressBack/Progress")
  self._num = self:GetChild("Back/ProgressBack/Num/Num")
  self._maxNum = self:GetChild("Back/ProgressBack/Num/NumMax")
  self._getBtn = self:GetChild("Back/GetBtn")
  self._goBtn = self:GetChild("Back/GoBtn")
  self._detailBtn = self:GetChild("Back/DetailBtn")
  ;
  (self._goBtn):SetActive(false)
  ;
  (self._detailBtn):SetActive(false)
  self._doneImage = self:GetChild("Back/BackDone")
  ;
  (self._getBtn):Subscribe_PointerClickEvent(self.OnGetBtnClicked, self)
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  ;
  (self._detailBtn):Subscribe_PointerClickEvent(self.OnDetailtnClicked, self)
  self._itemArea = self:GetChild("Back/ItemFrame")
  self._itemFrame = (TableFrame.Create)(self._itemArea, self, false, false, false)
end

BossRushWeekAchievementCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._itemFrame):Destroy()
end

BossRushWeekAchievementCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CWeeklyBossAchieveMissionConfig, _ENV, Status
  self._task = data
  local record = CWeeklyBossAchieveMissionConfig:GetRecorder((self._task):GetID())
  if record then
    (self._title):SetText((TextManager.GetText)(record.missionnameTextID))
    ;
    (self._detailTxt):SetText((TextManager.GetText)(record.descriptionTextID))
    local taskStatus = (self._task):GetStatus()
    local btn = taskStatus ~= Status.PROCESSING and (self._task):IsLock()
    ;
    (self._doneImage):SetActive(taskStatus == Status.COMMITED)
    ;
    (self._getBtn):SetActive(taskStatus == Status.FINISHED)
    local taskDone = taskStatus == Status.COMMITED or taskStatus == Status.FINISHED
    if (self._task):IsMultiProgress() then
      if not taskDone then
        (self._num):SetText(0)
        ;
        (self._maxNum):SetText(1)
        ;
        (self._progress):SetFillAmount(0)
      else
        (self._num):SetText(1)
        ;
        (self._maxNum):SetText(1)
        ;
        (self._progress):SetFillAmount(1)
      end
    else
      local progress = ((self._task):GetProgress())[1]
      if not taskDone then
        (self._num):SetText((math.min)(progress.current, progress.total))
        ;
        (self._maxNum):SetText(progress.total)
        ;
        (self._progress):SetFillAmount(progress.current / progress.total)
      else
        (self._num):SetText(progress.total)
        ;
        (self._maxNum):SetText(progress.total)
        ;
        (self._progress):SetFillAmount(1)
      end
    end
    self._itemList = record.rewarditem
    self._itemNumList = record.rewardquantity
    ;
    (self._itemFrame):ReloadAllCell()
  end
  local tipsTextID = (self._task):GetUnlockTextId()
  if tipsTextID then
    (self._tipsText):SetText((TextManager.GetText)(tipsTextID))
  end
  -- DECOMPILER ERROR: 11 unprocessed JMP targets
end

BossRushWeekAchievementCell.NumberOfCell = function(self, frame)
  -- function num : 0_4 , upvalues : _ENV
  return (table.nums)(self._itemList)
end

BossRushWeekAchievementCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "achievement.roleachievementdetailcellitemcell"
end

BossRushWeekAchievementCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  local temp = {}
  temp.itemid = (self._itemList)[index]
  temp.itemnum = (self._itemNumList)[index]
  return temp
end

BossRushWeekAchievementCell.OnDetailtnClicked = function(self)
  -- function num : 0_7
end

BossRushWeekAchievementCell.OnGoBtnClicked = function(self)
  -- function num : 0_8
end

BossRushWeekAchievementCell.OnGetBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.task.ccommittask")
  if protocol then
    protocol.taskid = (self._task):GetID()
    protocol:Send()
    return 
  end
end

return BossRushWeekAchievementCell

