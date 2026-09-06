local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local TaskStatus = LuaNetManager.CreateBean("protocol.task.taskstatus")
local CHalloweenAward = BeanManager.GetTableByName("mission.challoweenaward")
local sortHelper = {
  [TaskStatus.FINISHED] = 1,
  [TaskStatus.PROCESSING] = 2,
  [TaskStatus.COMMITED] = 3
}
local HalloweenSheet1 = class("HalloweenSheet1", Dialog)
HalloweenSheet1.AssetBundleName = "ui/layouts.activityhalloween"
HalloweenSheet1.AssetName = "ActivityHalloweenTask"

function HalloweenSheet1:Ctor(...)
  HalloweenSheet1.super.Ctor(self, ...)
  self._taskData = {}
  self._rewardData = {}
end

function HalloweenSheet1:OnCreate()
  self._staticTxt1 = self:GetChild("Txt")
  self._activeTime = self:GetChild("ActiveTime")
  self._changeTime = self:GetChild("ChangeTime")
  self._taskFinishTxt = self:GetChild("Finish/Text")
  self._taskFinish = self:GetChild("Finish")
  self._taskPanel = self:GetChild("FrameTask")
  self._rewardPanel = self:GetChild("FrameReward")
  self._currencyIcon = self:GetChild("Item")
  self._currencyNum = self:GetChild("NowNum")
  self._tipsBtn = self:GetChild("Tips")
  self._tipsBtn:Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  self._currencyIcon:Subscribe_PointerClickEvent(self.OnCurrencyIconClicked, self)
  self._taskFrame = TableFrame.Create(self._taskPanel, self, true, true, true)
  self._rewardFrame = TableFrame.Create(self._rewardPanel, self, false, true)
  LuaNotificationCenter.AddObserver(self, function(_, notification)
    self:RefreshTaskData(notification, false)
  end, Common.n_OnSActivityTasks, nil)
  LuaNotificationCenter.AddObserver(self, function(_, notification)
    self:RefreshTaskData(notification, true)
  end, Common.n_OnSRefreshActivityTask, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRewardData, Common.n_OnSOpenHalloweenInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRewardData, Common.n_OnSRefreshHalloweenInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRewardData, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, function()
    self._taskPanel:SetActive(false)
    self._taskFinish:SetActive(true)
  end, Common.n_OnHalloweenTaskEnd, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshCurrencyData, Common.n_RefreshCurrency, nil)
  self:SetStaticRes()
  self:SetData()
end

function HalloweenSheet1:SetStaticRes()
  self._staticTxt1:SetText(TextManager.GetText(CStringRes:GetRecorder(1632).msgTextID))
  self._activeTime:SetText(TextManager.GetText(CStringRes:GetRecorder(1626).msgTextID))
  self._changeTime:SetText(TextManager.GetText(CStringRes:GetRecorder(1628).msgTextID))
  self._taskFinishTxt:SetText(TextManager.GetText(CStringRes:GetRecorder(1633).msgTextID))
  self._currencyItem = Item.Create(DataCommon.Pumpkin)
  self._currencyIcon:SetSprite(self._currencyItem:GetIcon().assetBundle, self._currencyItem:GetIcon().assetName)
end

function HalloweenSheet1:OnDestroy()
  if self._taskFrame then
    self._taskFrame:Destroy()
  end
  if self._rewardFrame then
    self._rewardFrame:Destroy()
  end
end

function HalloweenSheet1:SetData(data)
  self._taskPanel:SetActive(NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.HalloweenActivityID):GetIsOpenTask())
  self._taskFinish:SetActive(not NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.HalloweenActivityID):GetIsOpenTask())
  self:RefreshCurrencyData()
  self:GetTaskData()
  self:RefreshRewardData()
end

function HalloweenSheet1:RefreshCurrencyData()
  local havePumpkinNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.Pumpkin)
  self._currencyNum:SetText(NumberManager.GetShowNumber(havePumpkinNum))
end

function HalloweenSheet1:GetTaskData()
  local protocol = LuaNetManager.CreateProtocol("protocol.task.cactivitytasks")
  self._activityID = protocol.HALLOWEEN
  if protocol then
    protocol.activityID = protocol.HALLOWEEN
    protocol:Send()
  end
end

function HalloweenSheet1:RefreshTaskData(notification, refresh)
  if notification.userInfo.activityID ~= self._activityID then
    return
  end
  for key, _ in pairs(self._taskData) do
    self._taskData[key] = nil
  end
  local allTasks = NekoData.BehaviorManager.BM_ActivityTasks:GetHalloweenTasks()
  if allTasks then
    for _, value in pairs(allTasks) do
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
  end
  self._taskFrame:ReloadAllCell()
  self._taskFrame:MoveToTop()
end

function HalloweenSheet1:RefreshRewardData()
  for key, _ in pairs(self._rewardData) do
    self._rewardData[key] = nil
  end
  local bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.HalloweenActivityID)
  local allRewards = bm:GetPumpkinReward()
  if allRewards then
    local havePumpkinNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.Pumpkin)
    for rewardID, rewardState in pairs(allRewards) do
      local record = bm:GetHalloweenAwardRecorder(rewardID)
      if record then
        table.insert(self._rewardData, {
          id = record.id,
          neednum = record.neednum,
          rewarditem = record.rewarditem,
          rewardquantity = record.rewardquantity,
          canGet = havePumpkinNum >= record.neednum and rewardState == 0,
          isGet = rewardState == 1,
          isMultiReward = #record.rewarditem > 1
        })
      end
    end
    table.sort(self._rewardData, function(a, b)
      return a.id < b.id
    end)
  end
  self._rewardFrame:ReloadAllCell()
  local hasPosToMove = false
  for k, v in ipairs(self._rewardData) do
    if v.canGet and not v.isGet then
      self._rewardFrame:MoveLeftToIndex(k)
      hasPosToMove = true
      break
    end
  end
  if not hasPosToMove then
    for k, v in ipairs(self._rewardData) do
      if not v.isGet then
        if self._rewardData[k - 1] then
          self._rewardFrame:MoveLeftToIndex(k - 1)
        end
        break
      end
    end
  end
end

function HalloweenSheet1:CellAtIndex(frame, index)
  if frame == self._taskFrame then
    return "activity.halloween.halloweentaskcell"
  elseif not self._rewardData[index].isMultiReward then
    return "activity.halloween.halloweenrewardcell1"
  else
    return "activity.halloween.halloweenrewardcell2"
  end
end

function HalloweenSheet1:NumberOfCell(frame, index)
  if frame == self._taskFrame then
    return #self._taskData
  else
    return #self._rewardData
  end
end

function HalloweenSheet1:DataAtIndex(frame, index)
  if frame == self._taskFrame then
    return self._taskData[index]
  else
    return self._rewardData[index]
  end
end

function HalloweenSheet1:OnTipsBtnClicked()
  local dialogName = "activity.halloween.halloweentipsdialog"
  local dialog = DialogManager.CreateSingletonDialog(dialogName)
  if dialog then
    dialog:SetData(CStringRes:GetRecorder(1630).msgTextID)
  end
end

function HalloweenSheet1:OnCurrencyIconClicked()
  local dialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if dialog then
    dialog:Init({
      item = self._currencyItem
    })
  end
end

return HalloweenSheet1
