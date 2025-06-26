-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/halloween/halloweensheet1.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local TaskStatus = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local CHalloweenAward = (BeanManager.GetTableByName)("mission.challoweenaward")
local sortHelper = {[TaskStatus.FINISHED] = 1, [TaskStatus.PROCESSING] = 2, [TaskStatus.COMMITED] = 3}
local HalloweenSheet1 = class("HalloweenSheet1", Dialog)
HalloweenSheet1.AssetBundleName = "ui/layouts.activityhalloween"
HalloweenSheet1.AssetName = "ActivityHalloweenTask"
HalloweenSheet1.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : HalloweenSheet1
  ((HalloweenSheet1.super).Ctor)(self, ...)
  self._taskData = {}
  self._rewardData = {}
end

HalloweenSheet1.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
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
  ;
  (self._tipsBtn):Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  ;
  (self._currencyIcon):Subscribe_PointerClickEvent(self.OnCurrencyIconClicked, self)
  self._taskFrame = (TableFrame.Create)(self._taskPanel, self, true, true, true)
  self._rewardFrame = (TableFrame.Create)(self._rewardPanel, self, false, true)
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
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRewardData, Common.n_OnSOpenHalloweenInfo, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRewardData, Common.n_OnSRefreshHalloweenInfo, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRewardData, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, function()
    -- function num : 0_1_2 , upvalues : self
    (self._taskPanel):SetActive(false)
    ;
    (self._taskFinish):SetActive(true)
  end
, Common.n_OnHalloweenTaskEnd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshCurrencyData, Common.n_RefreshCurrency, nil)
  self:SetStaticRes()
  self:SetData()
end

HalloweenSheet1.SetStaticRes = function(self)
  -- function num : 0_2 , upvalues : _ENV, CStringRes, Item
  (self._staticTxt1):SetText((TextManager.GetText)((CStringRes:GetRecorder(1632)).msgTextID))
  ;
  (self._activeTime):SetText((TextManager.GetText)((CStringRes:GetRecorder(1626)).msgTextID))
  ;
  (self._changeTime):SetText((TextManager.GetText)((CStringRes:GetRecorder(1628)).msgTextID))
  ;
  (self._taskFinishTxt):SetText((TextManager.GetText)((CStringRes:GetRecorder(1633)).msgTextID))
  self._currencyItem = (Item.Create)(DataCommon.Pumpkin)
  ;
  (self._currencyIcon):SetSprite(((self._currencyItem):GetIcon()).assetBundle, ((self._currencyItem):GetIcon()).assetName)
end

HalloweenSheet1.OnDestroy = function(self)
  -- function num : 0_3
  if self._taskFrame then
    (self._taskFrame):Destroy()
  end
  if self._rewardFrame then
    (self._rewardFrame):Destroy()
  end
end

HalloweenSheet1.SetData = function(self, data)
  -- function num : 0_4 , upvalues : _ENV
  (self._taskPanel):SetActive((((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.HalloweenActivityID)):GetIsOpenTask())
  ;
  (self._taskFinish):SetActive(not (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.HalloweenActivityID)):GetIsOpenTask())
  self:RefreshCurrencyData()
  self:GetTaskData()
  self:RefreshRewardData()
end

HalloweenSheet1.RefreshCurrencyData = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local havePumpkinNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.Pumpkin)
  ;
  (self._currencyNum):SetText((NumberManager.GetShowNumber)(havePumpkinNum))
end

HalloweenSheet1.GetTaskData = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.task.cactivitytasks")
  self._activityID = protocol.HALLOWEEN
  if protocol then
    protocol.activityID = protocol.HALLOWEEN
    protocol:Send()
  end
end

HalloweenSheet1.RefreshTaskData = function(self, notification, refresh)
  -- function num : 0_7 , upvalues : _ENV, sortHelper
  if (notification.userInfo).activityID ~= self._activityID then
    return 
  end
  for key,_ in pairs(self._taskData) do
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R8 in 'UnsetPending'

    (self._taskData)[key] = nil
  end
  local allTasks = ((NekoData.BehaviorManager).BM_ActivityTasks):GetHalloweenTasks()
  if allTasks then
    for _,value in pairs(allTasks) do
      (table.insert)(self._taskData, value)
    end
    ;
    (table.sort)(self._taskData, function(taskA, taskB)
    -- function num : 0_7_0 , upvalues : sortHelper
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
  end
  ;
  (self._taskFrame):ReloadAllCell()
  ;
  (self._taskFrame):MoveToTop()
end

HalloweenSheet1.RefreshRewardData = function(self)
  -- function num : 0_8 , upvalues : _ENV
  for key,_ in pairs(self._rewardData) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R6 in 'UnsetPending'

    (self._rewardData)[key] = nil
  end
  local bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.HalloweenActivityID)
  local allRewards = bm:GetPumpkinReward()
  do
    if allRewards then
      local havePumpkinNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.Pumpkin)
      for rewardID,rewardState in pairs(allRewards) do
        local record = bm:GetHalloweenAwardRecorder(rewardID)
        ;
        (table.insert)(self._rewardData, {id = record.id, neednum = record.neednum, rewarditem = record.rewarditem, rewardquantity = record.rewardquantity, canGet = not record, isGet = (record.neednum > havePumpkinNum or rewardState ~= 0) and rewardState == 1, isMultiReward = #record.rewarditem > 1})
      end
      ;
      (table.sort)(self._rewardData, function(a, b)
    -- function num : 0_8_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    end
    ;
    (self._rewardFrame):ReloadAllCell()
    local hasPosToMove = false
    for k,v in ipairs(self._rewardData) do
      if v.canGet and not v.isGet then
        (self._rewardFrame):MoveLeftToIndex(k)
        hasPosToMove = true
        break
      end
    end
    if not hasPosToMove then
      for k,v in ipairs(self._rewardData) do
        if not v.isGet and (self._rewardData)[k - 1] then
          (self._rewardFrame):MoveLeftToIndex(k - 1)
        end
        break
      end
    end
    -- DECOMPILER ERROR: 9 unprocessed JMP targets
  end
end

HalloweenSheet1.CellAtIndex = function(self, frame, index)
  -- function num : 0_9
  if frame == self._taskFrame then
    return "activity.halloween.halloweentaskcell"
  else
    if not ((self._rewardData)[index]).isMultiReward then
      return "activity.halloween.halloweenrewardcell1"
    else
      return "activity.halloween.halloweenrewardcell2"
    end
  end
end

HalloweenSheet1.NumberOfCell = function(self, frame, index)
  -- function num : 0_10
  if frame == self._taskFrame then
    return #self._taskData
  else
    return #self._rewardData
  end
end

HalloweenSheet1.DataAtIndex = function(self, frame, index)
  -- function num : 0_11
  if frame == self._taskFrame then
    return (self._taskData)[index]
  else
    return (self._rewardData)[index]
  end
end

HalloweenSheet1.OnTipsBtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV, CStringRes
  local dialogName = "activity.halloween.halloweentipsdialog"
  local dialog = (DialogManager.CreateSingletonDialog)(dialogName)
  if dialog then
    dialog:SetData((CStringRes:GetRecorder(1630)).msgTextID)
  end
end

HalloweenSheet1.OnCurrencyIconClicked = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if dialog then
    dialog:Init({item = self._currencyItem})
  end
end

return HalloweenSheet1

