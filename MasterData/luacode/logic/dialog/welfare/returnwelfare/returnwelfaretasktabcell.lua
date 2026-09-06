local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CReturnLoginActivity = BeanManager.GetTableByName("welfare.creturnloginactivity")
local TaskStatus = LuaNetManager.CreateBean("protocol.task.taskstatus")
local CActivityTasks = LuaNetManager.GetProtocolDef("protocol.task.cactivitytasks")
local sortHelper = {
  [TaskStatus.FINISHED] = 1,
  [TaskStatus.PROCESSING] = 2,
  [TaskStatus.ACCEPTED] = 3,
  [TaskStatus.COMMITED] = 4
}
local ReturnWelfareTaskTabCell = class("ReturnWelfareTaskTabCell", Dialog)
ReturnWelfareTaskTabCell.AssetBundleName = "ui/layouts.welfare"
ReturnWelfareTaskTabCell.AssetName = "ReturnWelfareTask"

function ReturnWelfareTaskTabCell:Ctor(...)
  ReturnWelfareTaskTabCell.super.Ctor(self, ...)
  self._leftTime = nil
  self._taskData = {}
end

function ReturnWelfareTaskTabCell:OnCreate()
  self._getTotalTaskAward = self:GetChild("BackImage/Image")
  self._backImg = self:GetChild("BackImage")
  self._title = self:GetChild("BackImage/Title")
  self._timeTxt = self:GetChild("BackImage/Time")
  self._taskPanel = self:GetChild("BackImage/Frame")
  self._taskProgress = self:GetChild("ProgressBack/Progress")
  self._taskFinishNum = self:GetChild("ProgressBack/Num/Num")
  self._taskNum = self:GetChild("ProgressBack/Num/NumMax")
  self._taskFrame = TableFrame.Create(self._taskPanel, self, true, true, true)
  self._getTotalTaskAward:Subscribe_PointerClickEvent(self.OnTotalTaskAwardClicked, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshTaskAwards, Common.n_ReturnPlayerRewardRefresh, nil)
  LuaNotificationCenter.AddObserver(self, function(_, notification)
    self:RefreshTaskData(notification, false)
  end, Common.n_OnSActivityTasks, nil)
  LuaNotificationCenter.AddObserver(self, function(_, notification)
    self:RefreshTaskData(notification, true)
  end, Common.n_OnSRefreshActivityTask, nil)
end

function ReturnWelfareTaskTabCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._taskFrame:Destroy()
  if self._activityTask then
    GameTimer.RemoveTask(self._activityTask)
    self._activityTask = nil
  end
end

function ReturnWelfareTaskTabCell:RefreshTabCell()
  local protocol = NekoData.BehaviorManager.BM_ReturnWelfare:GetBackTaskRewardProtocolData()
  if protocol then
    self:RefreshTaskAwards(protocol)
  end
  self:RefreshTaskData(nil, nil, true)
end

function ReturnWelfareTaskTabCell:RefreshTaskData(notification, refresh, forceRefresh)
  if not forceRefresh and notification.userInfo.activityID ~= CActivityTasks.BACK_PLAYER then
    return
  end
  for key, _ in pairs(self._taskData) do
    self._taskData[key] = nil
  end
  local allTasks = NekoData.BehaviorManager.BM_ActivityTasks:GetReturnBackPlayerTasks()
  if allTasks then
    local finishTaskCount = 0
    local totalTaskCount = 0
    for _, value in pairs(allTasks) do
      totalTaskCount = totalTaskCount + 1
      if value:GetStatus() == TaskStatus.FINISHED or value:GetStatus() == TaskStatus.COMMITED then
        finishTaskCount = finishTaskCount + 1
      end
      table.insert(self._taskData, value)
    end
    table.sort(self._taskData, function(taskA, taskB)
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
      if sortIdA1 == sortIdB1 then
        return sortIdA2 < sortIdB2
      else
        return sortIdA1 < sortIdB1
      end
    end)
    self._taskProgress:SetFillAmount(finishTaskCount / totalTaskCount)
    self._taskFinishNum:SetText(finishTaskCount)
    self._taskNum:SetText(totalTaskCount)
  end
  self._taskFrame:ReloadAllCell()
  self._taskFrame:MoveToTop()
end

function ReturnWelfareTaskTabCell:RefreshTaskAwards(notification)
  self._leftTime = notification.userInfo.leftTime
  self:RefreshTime()
  if self._activityTask then
    GameTimer.RemoveTask(self._activityTask)
    self._activityTask = nil
  end
  if not self._activityTask then
    self._activityTask = GameTimer.AddTask(0, 60, function()
      self:RefreshTime()
    end)
  end
  self._rewardStatus = notification.userInfo.goodInfo.goodStatus
  self._itemInfo = {
    giftPackId = notification.userInfo.goodInfo.goodId,
    itemId = notification.userInfo.goodInfo.itemId,
    itemNum = notification.userInfo.goodInfo.itemNum
  }
  local giftPackItem = Item.Create(notification.userInfo.goodInfo.goodId)
  local imageRecord = giftPackItem:GetIcon()
  self._getTotalTaskAward:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local RewardStatusType = {
    CannotGet = 0,
    CanGet = 1,
    GetOver = 2
  }
  if self._rewardStatus == RewardStatusType.CanGet then
    NekoData.BehaviorManager.BM_Activity:SetBackTaskRedPoint(true)
  else
    NekoData.BehaviorManager.BM_Activity:SetBackTaskRedPoint(false)
  end
  LuaNotificationCenter.PostNotification(Common.n_RefreshReturnWelfareRedDot, nil, nil)
end

function ReturnWelfareTaskTabCell:NumberOfCell(frame)
  return #self._taskData
end

function ReturnWelfareTaskTabCell:CellAtIndex(frame, index)
  return "welfare.returnwelfare.returnwelfaretaskcell"
end

function ReturnWelfareTaskTabCell:DataAtIndex(frame, index)
  return self._taskData[index]
end

function ReturnWelfareTaskTabCell:RefreshTime()
  if self._leftTime then
    local time = self._leftTime / 1000
    local day = math.floor(time / 86400)
    local hour = math.floor((time - day * 24 * 60 * 60) / 3600)
    local min = math.floor((time - day * 24 * 60 * 60 - hour * 60 * 60) / 60)
    local sec = math.floor(time - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60)
    local str = TextManager.GetText(CStringRes:GetRecorder(1042).msgTextID)
    if 0 < day then
      local str1 = TextManager.GetText(CStringRes:GetRecorder(1043).msgTextID)
      self._timeTxt:SetText(str .. day .. str1)
    elseif 0 < hour then
      local str2 = TextManager.GetText(CStringRes:GetRecorder(1044).msgTextID)
      self._timeTxt:SetText(str .. hour .. str2)
    else
      local str3 = TextManager.GetText(CStringRes:GetRecorder(1045).msgTextID)
      self._timeTxt:SetText(str .. min .. str3)
    end
  end
end

function ReturnWelfareTaskTabCell:OnTotalTaskAwardClicked()
  local dialog = DialogManager.CreateSingletonDialog("welfare.returnwelfare.giftpackageitemshowdialog")
  if dialog then
    dialog:SetData(self._itemInfo, self._rewardStatus)
  end
end

return ReturnWelfareTaskTabCell
