-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/returnwelfare/returnwelfaretasktabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CReturnLoginActivity = (BeanManager.GetTableByName)("welfare.creturnloginactivity")
local TaskStatus = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local CActivityTasks = (LuaNetManager.GetProtocolDef)("protocol.task.cactivitytasks")
local sortHelper = {[TaskStatus.FINISHED] = 1, [TaskStatus.PROCESSING] = 2, [TaskStatus.ACCEPTED] = 3, [TaskStatus.COMMITED] = 4}
local ReturnWelfareTaskTabCell = class("ReturnWelfareTaskTabCell", Dialog)
ReturnWelfareTaskTabCell.AssetBundleName = "ui/layouts.welfare"
ReturnWelfareTaskTabCell.AssetName = "ReturnWelfareTask"
ReturnWelfareTaskTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ReturnWelfareTaskTabCell
  ((ReturnWelfareTaskTabCell.super).Ctor)(self, ...)
  self._leftTime = nil
  self._taskData = {}
end

ReturnWelfareTaskTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._getTotalTaskAward = self:GetChild("BackImage/Image")
  self._backImg = self:GetChild("BackImage")
  self._title = self:GetChild("BackImage/Title")
  self._timeTxt = self:GetChild("BackImage/Time")
  self._taskPanel = self:GetChild("BackImage/Frame")
  self._taskProgress = self:GetChild("ProgressBack/Progress")
  self._taskFinishNum = self:GetChild("ProgressBack/Num/Num")
  self._taskNum = self:GetChild("ProgressBack/Num/NumMax")
  self._taskFrame = (TableFrame.Create)(self._taskPanel, self, true, true, true)
  ;
  (self._getTotalTaskAward):Subscribe_PointerClickEvent(self.OnTotalTaskAwardClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshTaskAwards, Common.n_ReturnPlayerRewardRefresh, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, function(_, notification)
    -- function num : 0_1_0 , upvalues : self
    self:RefreshTaskData(notification, false)
  end
, Common.n_OnSActivityTasks, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, function(_, notification)
    -- function num : 0_1_1 , upvalues : self
    self:RefreshTaskData(notification, true)
  end
, Common.n_OnSRefreshActivityTask, nil)
end

ReturnWelfareTaskTabCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._taskFrame):Destroy()
  if self._activityTask then
    (GameTimer.RemoveTask)(self._activityTask)
    self._activityTask = nil
  end
end

ReturnWelfareTaskTabCell.RefreshTabCell = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local protocol = ((NekoData.BehaviorManager).BM_ReturnWelfare):GetBackTaskRewardProtocolData()
  if protocol then
    self:RefreshTaskAwards(protocol)
  end
  self:RefreshTaskData(nil, nil, true)
end

ReturnWelfareTaskTabCell.RefreshTaskData = function(self, notification, refresh, forceRefresh)
  -- function num : 0_4 , upvalues : CActivityTasks, _ENV, TaskStatus, sortHelper
  if not forceRefresh and (notification.userInfo).activityID ~= CActivityTasks.BACK_PLAYER then
    return 
  end
  for key,_ in pairs(self._taskData) do
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R9 in 'UnsetPending'

    (self._taskData)[key] = nil
  end
  local allTasks = ((NekoData.BehaviorManager).BM_ActivityTasks):GetReturnBackPlayerTasks()
  if allTasks then
    local finishTaskCount = 0
    local totalTaskCount = 0
    for _,value in pairs(allTasks) do
      totalTaskCount = totalTaskCount + 1
      if value:GetStatus() == TaskStatus.FINISHED or value:GetStatus() == TaskStatus.COMMITED then
        finishTaskCount = finishTaskCount + 1
      end
      ;
      (table.insert)(self._taskData, value)
    end
    ;
    (table.sort)(self._taskData, function(taskA, taskB)
    -- function num : 0_4_0 , upvalues : sortHelper
    local sortIdA1 = sortHelper[taskA:GetStatus()]
    local sortIdB1 = sortHelper[taskB:GetStatus()]
    if sortIdA1 == nil then
      sortIdA1 = 99
    end
    if sortIdB1 == nil then
      sortIdB1 = 99
    end
    local sortIdA2 = taskA:GetID()
    local sortIdB2 = taskB:GetID()
    if sortIdA2 >= sortIdB2 then
      do return sortIdA1 ~= sortIdB1 end
      do return sortIdA1 < sortIdB1 end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
    ;
    (self._taskProgress):SetFillAmount((finishTaskCount) / (totalTaskCount))
    ;
    (self._taskFinishNum):SetText(finishTaskCount)
    ;
    (self._taskNum):SetText(totalTaskCount)
  end
  do
    ;
    (self._taskFrame):ReloadAllCell()
    ;
    (self._taskFrame):MoveToTop()
  end
end

ReturnWelfareTaskTabCell.RefreshTaskAwards = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV, Item
  self._leftTime = (notification.userInfo).leftTime
  self:RefreshTime()
  if self._activityTask then
    (GameTimer.RemoveTask)(self._activityTask)
    self._activityTask = nil
  end
  if not self._activityTask then
    self._activityTask = (GameTimer.AddTask)(0, 60, function()
    -- function num : 0_5_0 , upvalues : self
    self:RefreshTime()
  end
)
  end
  self._rewardStatus = ((notification.userInfo).goodInfo).goodStatus
  self._itemInfo = {giftPackId = ((notification.userInfo).goodInfo).goodId, itemId = ((notification.userInfo).goodInfo).itemId, itemNum = ((notification.userInfo).goodInfo).itemNum}
  local giftPackItem = (Item.Create)(((notification.userInfo).goodInfo).goodId)
  local imageRecord = giftPackItem:GetIcon()
  ;
  (self._getTotalTaskAward):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local RewardStatusType = {CannotGet = 0, CanGet = 1, GetOver = 2}
  if self._rewardStatus == RewardStatusType.CanGet then
    ((NekoData.BehaviorManager).BM_Activity):SetBackTaskRedPoint(true)
  else
    ;
    ((NekoData.BehaviorManager).BM_Activity):SetBackTaskRedPoint(false)
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshReturnWelfareRedDot, nil, nil)
end

ReturnWelfareTaskTabCell.NumberOfCell = function(self, frame)
  -- function num : 0_6
  return #self._taskData
end

ReturnWelfareTaskTabCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  return "welfare.returnwelfare.returnwelfaretaskcell"
end

ReturnWelfareTaskTabCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  return (self._taskData)[index]
end

ReturnWelfareTaskTabCell.RefreshTime = function(self)
  -- function num : 0_9 , upvalues : _ENV, CStringRes
  if self._leftTime then
    local time = self._leftTime / 1000
    local day = (math.floor)(time / 86400)
    local hour = (math.floor)((time - day * 24 * 60 * 60) / 3600)
    local min = (math.floor)((time - day * 24 * 60 * 60 - hour * 60 * 60) / 60)
    local sec = (math.floor)(time - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60)
    local str = (TextManager.GetText)((CStringRes:GetRecorder(1042)).msgTextID)
    if day > 0 then
      local str1 = (TextManager.GetText)((CStringRes:GetRecorder(1043)).msgTextID)
      ;
      (self._timeTxt):SetText(str .. day .. str1)
    else
      do
        if hour > 0 then
          local str2 = (TextManager.GetText)((CStringRes:GetRecorder(1044)).msgTextID)
          ;
          (self._timeTxt):SetText(str .. hour .. str2)
        else
          do
            local str3 = (TextManager.GetText)((CStringRes:GetRecorder(1045)).msgTextID)
            ;
            (self._timeTxt):SetText(str .. min .. str3)
          end
        end
      end
    end
  end
end

ReturnWelfareTaskTabCell.OnTotalTaskAwardClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("welfare.returnwelfare.giftpackageitemshowdialog")
  if dialog then
    dialog:SetData(self._itemInfo, self._rewardStatus)
  end
end

return ReturnWelfareTaskTabCell

