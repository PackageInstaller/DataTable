-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/achievement/roleachievementdetailcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAchievementMissionConfig = (BeanManager.GetTableByName)("mission.cachievemissionconfig")
local Status = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local TableFrame = require("framework.ui.frame.table.tableframe")
local RoleAchievementDetailCell = class("RoleAchievementDetailCell", Dialog)
RoleAchievementDetailCell.AssetBundleName = "ui/layouts.basetasklist"
RoleAchievementDetailCell.AssetName = "AchievementCell"
RoleAchievementDetailCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RoleAchievementDetailCell
  ((RoleAchievementDetailCell.super).Ctor)(self, ...)
end

RoleAchievementDetailCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
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
  ;
  (self._getBtn):Subscribe_PointerClickEvent(self.OnGetBtnClicked, self)
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  ;
  (self._detailBtn):Subscribe_PointerClickEvent(self.OnDetailtnClicked, self)
  self._itemArea = self:GetChild("Back/ItemFrame")
  self._itemFrame = (TableFrame.Create)(self._itemArea, self, false, false, false)
end

RoleAchievementDetailCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._itemFrame):Destroy()
  if self._timer then
    (ServerGameTimer.RemoveTask)(self._timer)
    self._timer = nil
  end
end

RoleAchievementDetailCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CAchievementMissionConfig, _ENV, Status
  self._task = data.task
  local record = CAchievementMissionConfig:GetRecorder((self._task):GetID())
  if record then
    (self._title):SetText((TextManager.GetText)(record.missionnameTextID))
    ;
    (self._detailTxt):SetText((TextManager.GetText)(record.descriptionTextID))
    local taskStatus = (self._task):GetStatus()
    local btn = taskStatus ~= Status.PROCESSING and (self._task):IsLock()
    ;
    (self._goBtn):SetActive(not btn or record.jumptype ~= 0)
    ;
    (self._detailBtn):SetActive(not btn or record.jumptype == 0)
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
  ;
  (self._tips):SetActive(false)
  -- DECOMPILER ERROR: 15 unprocessed JMP targets
end

RoleAchievementDetailCell.NumberOfCell = function(self, frame)
  -- function num : 0_4 , upvalues : _ENV
  return (table.nums)(self._itemList)
end

RoleAchievementDetailCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "achievement.roleachievementdetailcellitemcell"
end

RoleAchievementDetailCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  local temp = {}
  temp.itemid = (self._itemList)[index]
  temp.itemnum = (self._itemNumList)[index]
  return temp
end

RoleAchievementDetailCell.OnDetailtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("achievement.roleachievementdetailtip")):SetData((self._task):GetID())
end

RoleAchievementDetailCell.OnGoBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if (self._task):IsLock() then
    (self._tips):SetActive(true)
    if self._timer then
      (ServerGameTimer.RemoveTask)(self._timer)
      self._timer = nil
    end
    self._timer = (GameTimer.AddTask)(2, 0, function()
    -- function num : 0_8_0 , upvalues : self
    (self._tips):SetActive(false)
  end
, nil)
    return 
  end
  ;
  ((NekoData.BehaviorManager).BM_Task):HandleTask((self._task):GetID())
end

RoleAchievementDetailCell.OnGetBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.task.ccommittask")
  if protocol then
    protocol.taskid = (self._task):GetID()
    protocol:Send()
    return 
  end
end

return RoleAchievementDetailCell

