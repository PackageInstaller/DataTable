-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/task/daily/dailytaskdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DailyTaskDialog = class("DailyTaskDialog", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
DailyTaskDialog.AssetBundleName = "ui/layouts.basetasklist"
DailyTaskDialog.AssetName = "TaskActiveNew"
local Status = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local RedData = require("logic.manager.experimental.types.reddata")
local tm = (NekoData.BehaviorManager).BM_Task
DailyTaskDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DailyTaskDialog
  ((DailyTaskDialog.super).Ctor)(self, ...)
  self._groupName = "Cell"
  self._baseSceneController = nil
end

DailyTaskDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._listBoard = self:GetChild("Frame")
  self._helper = (TableFrame.Create)(self._listBoard, self, true, true, true)
  self._progress = self:GetChild("Active/ActiveLine")
  self._milestones = {}
  self._milestonesState = {}
  for i = 1, 5 do
    do
      local base = "Active/Active" .. i
      -- DECOMPILER ERROR at PC81: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self._milestones)[i] = {board = self:GetChild(base), itemCell = self:GetChild(base .. "/Award/ItemCell"), itemIcon = self:GetChild(base .. "/Award/ItemCell/_BackGround/Icon"), itemNum = self:GetChild(base .. "/Award/ItemCell/_Count"), got = self:GetChild(base .. "/Award/Get"), num = self:GetChild(base .. "/Num"), dot = self:GetChild(base .. "/Dot"), graydot = self:GetChild(base .. "/DotGrey"), effect = self:GetChild(base .. "/Award/Effect")}
      if i == 5 then
        self._other = {itemCell = self:GetChild(base .. "/Award/ItemCell2"), itemIcon = self:GetChild(base .. "/Award/ItemCell2/_BackGround/Icon"), itemNum = self:GetChild(base .. "/Award/ItemCell2/_Count"), got = self:GetChild(base .. "/Award/Get2"), effect = self:GetChild(base .. "/Award/Effect2")}
        ;
        ((self._other).itemCell):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnItemCellClick(i, 2)
  end
)
      end
      -- DECOMPILER ERROR at PC122: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self._milestonesState)[i] = false
      ;
      (((self._milestones)[i]).itemCell):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self, i
    self:OnItemCellClick(i)
  end
)
    end
  end
  self._active = self:GetChild("Active/ActiveToday")
  self._scroll = self:GetChild("Scrollbar")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._refreshTime = self:GetChild("Active/RefreshTimeText")
  self._dreamProgress = self:GetChild("BattlePassProgress/Loading/Loading/BackGround/Progress")
  self._dreamExpNum = self:GetChild("BattlePassProgress/Loading/Num/Num")
  self._dreamItem = self:GetChild("BattlePassProgress/Item")
  self._back = self:GetChild("BattlePassProgress/Back")
  ;
  (self._back):Subscribe_PointerClickEvent(self.OnDreamBoxClick, self)
  self._redDot = self:GetChild("BattlePassProgress/RedDot")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnTaskRefresh, Common.n_RefreshDailyTask, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.ShowActiveTip, Common.n_RefreshDailyTask, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_RefreshWeekTask, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_RefreshWeekActiveValue, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshMilestone, Common.n_GetActiveAward, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_DreamSpiralTaskRefresh, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_DreamSpiralRefresh, nil)
  self:SetData()
  ;
  (UIBackManager.SwitchToNext)()
end

DailyTaskDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._helper):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
end

DailyTaskDialog.Init = function(self, baseSceneController)
  -- function num : 0_3
  self._baseSceneController = baseSceneController
end

DailyTaskDialog.SetData = function(self)
  -- function num : 0_4
  self:Refresh("daily")
end

DailyTaskDialog.Refresh = function(self, state)
  -- function num : 0_5 , upvalues : _ENV
  if type(state) ~= "string" then
    self:RefreshCell(self._btnState)
    self:RefreshMilestone()
  else
    self:RefreshCell(state)
    self:RefreshMilestone()
  end
  local mgr = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.AgCoinActivityID)
  local has = mgr:HasUntakeAward()
  ;
  (self._redDot):SetActive(has)
  local baseInfo = mgr:GetBaseInfo()
  local chipInfo = baseInfo.chipInfo
  ;
  (self._dreamProgress):SetFillAmount(chipInfo.has / chipInfo.max)
  ;
  (self._dreamExpNum):SetActive(chipInfo.max > 0)
  if chipInfo.max > 0 then
    (self._dreamExpNum):SetText((string.format)("%d/%d", chipInfo.has, chipInfo.max))
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

DailyTaskDialog.RefreshMilestone = function(self)
  -- function num : 0_6 , upvalues : tm, _ENV, CStringRes
  if self._btnState == "daily" then
    self._activeInfo = tm:GetActiveInfo()
    local current = (self._activeInfo).current
    local total = (((self._activeInfo).ranks)[#(self._activeInfo).ranks]).value
    local tempCurrent = current - 10
    if tempCurrent > 0 then
      (self._progress):SetFillAmount(tempCurrent / total)
    else
      ;
      (self._progress):SetFillAmount(0)
    end
    for i,v in ipairs(self._milestones) do
      local info = ((self._activeInfo).ranks)[i]
      ;
      (v.num):SetText(info.value)
      ;
      (v.num):SetActive(current < info.value)
      ;
      (v.dot):SetActive(info.value <= current)
      ;
      (v.graydot):SetActive(current < info.value)
      ;
      (v.got):SetActive(info.got)
      if info.got then
        (v.itemCell):SetAlpha(0.5)
      else
        (v.itemCell):SetAlpha(1)
      end
      do
        if i == 5 then
          local imageRecord = ((info.award)[2]):GetIcon()
          ;
          ((self._other).itemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
          ;
          ((self._other).itemNum):SetText((NumberManager.GetShowNumber)(((info.award)[2]):GetCount()))
          ;
          ((self._other).effect):SetActive((info.value <= current and not info.got))
          ;
          ((self._other).got):SetActive(info.got)
          if info.got then
            ((self._other).itemCell):SetAlpha(0.5)
          else
            ((self._other).itemCell):SetAlpha(1)
          end
        end
        do
          local imageRecord = ((info.award)[1]):GetIcon()
          ;
          (v.itemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
          ;
          (v.itemNum):SetText((NumberManager.GetShowNumber)(((info.award)[1]):GetCount()))
          -- DECOMPILER ERROR at PC158: Confused about usage of register: R11 in 'UnsetPending'

          ;
          (self._milestonesState)[i] = info.value <= current
          ;
          (v.effect):SetActive((info.value <= current and not info.got))
          -- DECOMPILER ERROR at PC170: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
    ;
    (self._active):SetText(current)
    self._thisActiveNum = current
    ;
    (self._refreshTime):SetText((TextManager.GetText)((CStringRes:GetRecorder(1304)).msgTextID))
  elseif self._btnState == "week" then
    local current = tm:GetWeekCurrentActiveValue()
    local activeinfo = tm:GetWeekActiveValueMap()
    self._activeInfo = {}
    for k,v in pairs(activeinfo) do
      (table.insert)(self._activeInfo, {key = k, value = v})
    end
    ;
    (table.sort)(self._activeInfo, function(a, b)
    -- function num : 0_6_0
    do return a.key < b.key end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    local total = ((self._activeInfo)[#self._activeInfo]).key
    local tempCurrent = current - 10
    if tempCurrent > 0 then
      (self._progress):SetFillAmount(tempCurrent / total)
    else
      (self._progress):SetFillAmount(0)
    end
    for i,v in ipairs(self._milestones) do
      local info = (self._activeInfo)[i]
      ;
      (v.num):SetText(info.key)
      ;
      (v.num):SetActive(current < info.key)
      ;
      (v.dot):SetActive(info.key <= current)
      ;
      (v.graydot):SetActive(current < info.key)
      ;
      (v.got):SetActive(info.value == 1)
      if info.value == 1 then
        (v.itemCell):SetAlpha(0.5)
      else
        (v.itemCell):SetAlpha(1)
      end
      do
        if i == 5 then
          local imageRecord = ((info.award)[2]):GetIcon()
          ;
          ((self._other).itemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
          ;
          ((self._other).itemNum):SetText((NumberManager.GetShowNumber)(((info.award)[2]):GetCount()))
          ;
          ((self._other).got):SetActive(info.value == 1)
          if info.got then
            ((self._other).itemCell):SetAlpha(0.5)
          else
            ((self._other).itemCell):SetAlpha(1)
          end
        end
        do
          local imageRecord = ((info.award)[1]):GetIcon()
          ;
          (v.itemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
          ;
          (v.itemNum):SetText((NumberManager.GetShowNumber)(((info.award)[1]):GetCount()))
          -- DECOMPILER ERROR at PC360: Confused about usage of register: R12 in 'UnsetPending'

          ;
          (self._milestonesState)[i] = info.key <= current
          ;
          (v.effect):SetActive(info.key <= current and not info.value == 1)
          -- DECOMPILER ERROR at PC373: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
    ;
    (self._active):SetText(current)
    self._thisActiveNum = current
    ;
    (self._refreshTime):SetText((TextManager.GetText)((CStringRes:GetRecorder(1303)).msgTextID))
  end
  -- DECOMPILER ERROR: 31 unprocessed JMP targets
end

DailyTaskDialog.RefreshCell = function(self, state)
  -- function num : 0_7
  self:RefreshTaskList(state)
end

DailyTaskDialog.RefreshTaskList = function(self, state)
  -- function num : 0_8 , upvalues : tm, _ENV, Status
  self._btnState = state
  if tm:GetWeekCurrentActiveValue() < 100 then
    self._isFullTo100 = state ~= "week"
    do
      local tasks = tm:GetWeektTaskList()
      self._tasks = tasks
      ;
      (table.sort)(self._tasks, function(a, b)
    -- function num : 0_8_0 , upvalues : _ENV
    local _, x = (math.modf)(a:GetStatus() / 3)
    local _, y = (math.modf)(b:GetStatus() / 3)
    if a:GetStatus() == b:GetStatus() then
      if a:GetID() >= b:GetID() then
        do return x ~= y end
        do return b:GetStatus() < a:GetStatus() end
        do return x < y end
        -- DECOMPILER ERROR: 6 unprocessed JMP targets
      end
    end
  end
)
      if (tm:GetActiveInfo()).current < 100 then
        self._isFullTo100 = state ~= "daily"
        local tasks = tm:GetTasksByGroup(2)
        self._tasks = {}
        local pendingTasks = {}
        local finishTasks = {}
        local unFinishTasks = {}
        for _,v in pairs(tasks) do
          if v:GetType() == 3 then
            if v:GetStatus() == Status.COMMITED then
              (table.insert)(finishTasks, v)
            elseif v:GetStatus() == Status.FINISHED then
              (table.insert)(pendingTasks, v)
            else
              (table.insert)(unFinishTasks, v)
            end
          end
        end
        ;
        (table.sort)(finishTasks, function(a, b)
    -- function num : 0_8_1
    do return a:GetSortID() < b:GetSortID() end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
        ;
        (table.sort)(unFinishTasks, function(a, b)
    -- function num : 0_8_2
    do return a:GetSortID() < b:GetSortID() end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
        ;
        (table.sort)(pendingTasks, function(a, b)
    -- function num : 0_8_3
    do return a:GetSortID() < b:GetSortID() end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
        if self._isFullTo100 then
          for i,v in ipairs(unFinishTasks) do
            (table.insert)(self._tasks, v)
          end
          for i,v in ipairs(pendingTasks) do
            (table.insert)(self._tasks, v)
          end
        else
          for i,v in ipairs(pendingTasks) do
            (table.insert)(self._tasks, v)
          end
          for i,v in ipairs(unFinishTasks) do
            (table.insert)(self._tasks, v)
          end
        end
        for i,v in ipairs(finishTasks) do
          (table.insert)(self._tasks, v)
        end
        ;
        (self._helper):ReloadAllCell()
        ;
        (self._helper):MoveToTop(false)
        -- DECOMPILER ERROR: 14 unprocessed JMP targets
      end
    end
  end
end

DailyTaskDialog.OnTaskRefresh = function(self)
  -- function num : 0_9
  if self._btnState == "week" then
    return 
  end
  self:Refresh("daily")
  self._refreshed = false
end

DailyTaskDialog.OnAbandonClick = function(self, taskid)
  -- function num : 0_10 , upvalues : tm
  tm:TryAbandonTask(self._selected)
end

DailyTaskDialog.OnAcceptClick = function(self, taskid)
  -- function num : 0_11 , upvalues : tm
  tm:TryAcceptTask(self._selected)
end

DailyTaskDialog.OnRefreshClick = function(self, taskid)
  -- function num : 0_12 , upvalues : tm, _ENV
  if tm:GetDailyRefreshCount() > 0 and not self._refreshed then
    tm:RequestDailyTaskRefresh(taskid)
    self._refreshed = true
  end
  ;
  ((NekoData.BehaviorManager).BM_Message):SendMessageById(100078)
end

DailyTaskDialog.OnCommitClick = function(self, taskid)
  -- function num : 0_13 , upvalues : _ENV, tm
  if ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(6) then
    ((NekoData.BehaviorManager).BM_Guide):FinishGuide(6)
  end
  tm:TryCommitTask(taskid)
end

DailyTaskDialog.OnItemCellClick = function(self, index, cellindex)
  -- function num : 0_14 , upvalues : tm, _ENV, Item
  if not cellindex then
    cellindex = 1
  end
  if (self._milestonesState)[index] == true then
    if self._btnState == "daily" then
      local info = ((self._activeInfo).ranks)[index]
      if info.value <= (self._activeInfo).current and not info.got then
        tm:RequestActiveAward(info.value)
      else
        if not info.got then
          local width, height = (((self._milestones)[index]).box):GetRectSize()
          local tip = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
          tip:Init({item = ((((self._activeInfo).ranks)[index]).award)[cellindex]})
          tip:UpdatePosition(((self._milestones)[index]).box)
          tip:SetTipsPosition(width, height, (((self._milestones)[index]).box):GetLocalPointInUiRootPanel())
        end
      end
    else
      do
        if self._btnState == "week" then
          local current = tm:GetWeekCurrentActiveValue()
          local info = (self._activeInfo)[index]
          if info.key <= current and info.value == 0 then
            local req = (LuaNetManager.CreateProtocol)("protocol.task.creceiveweekactives")
            req.value = info.key
            req:Send()
          end
        end
        do
          local tempCfg = nil
          if self._btnState == "week" then
            tempCfg = ((BeanManager.GetTableByName)("mission.cweekmissionaward")):GetRecorder(((self._activeInfo)[index]).key)
          else
            if self._btnState == "daily" then
              tempCfg = ((BeanManager.GetTableByName)("mission.cdailymissionaward")):GetRecorder((((self._activeInfo).ranks)[index]).value)
            end
          end
          if type(tempCfg.awardid) == "table" then
            local tempAward = (Item.Create)((tempCfg.awardid)[cellindex])
            tempAward:SetCount((tempCfg.num)[cellindex])
            local tip = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
            tip:Init({item = tempAward, num = tempAward:GetCount()})
          else
            do
              local tempAward = (Item.Create)(tempCfg.awardid)
              tempAward:SetCount(tempCfg.num)
              local tip = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
              tip:Init({item = tempAward, num = tempAward:GetCount()})
            end
          end
        end
      end
    end
  end
end

DailyTaskDialog.OnDailyTaskBtnClicked = function(self)
  -- function num : 0_15
  self:Refresh("daily")
end

DailyTaskDialog.OnWeekTaskBtnClicked = function(self)
  -- function num : 0_16
  self:Refresh("week")
end

DailyTaskDialog.NumberOfCell = function(self, helper)
  -- function num : 0_17
  return #self._tasks
end

DailyTaskDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_18
  local task = (self._tasks)[index]
  if task:IsSpecialDailyTask() then
    return "task.daily.goldentaskcell"
  else
    return "task.daily.dailytaskcell"
  end
end

DailyTaskDialog.DataAtIndex = function(self, helper, index)
  -- function num : 0_19
  return (self._tasks)[index]
end

DailyTaskDialog.OnBackBtnClicked = function(self)
  -- function num : 0_20 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("task.daily.dailytaskdialog")
end

DailyTaskDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_21 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

DailyTaskDialog.OnCurPosChange = function(self, helper, ratio)
  -- function num : 0_22
  if helper == self._helper then
    (self._scroll):SetScrollValue(1 - ratio)
  end
end

DailyTaskDialog.OnDreamBoxClick = function(self)
  -- function num : 0_23 , upvalues : _ENV
  local mgr = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.AgCoinActivityID)
  if mgr:IsAgCoinActivityOpen() then
    if (DialogManager.GetDialog)("welfare.welfaremaindialog") then
      (DialogManager.DestroySingletonDialog)("welfare.welfaremaindialog")
    end
    local dialog = (DialogManager.CreateSingletonDialog)("welfare.welfaremaindialog")
    if dialog then
      dialog:SetData(true)
      dialog:SetSelectedTab((dialog.WelfareType).dreamSpiral)
    end
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100033)
    end
  end
end

DailyTaskDialog.ShowActiveTip = function(self)
  -- function num : 0_24 , upvalues : _ENV
  do
    if self._lastActiveNum and self._thisActiveNum then
      local addNum = self._thisActiveNum - self._lastActiveNum
      if addNum > 0 then
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100295, {self._thisActiveNum - self._lastActiveNum})
      end
    end
    self._lastActiveNum = self._thisActiveNum
  end
end

return DailyTaskDialog

