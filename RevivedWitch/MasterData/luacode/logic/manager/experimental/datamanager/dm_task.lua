-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_task.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_Task = class("DM_Task")
local Task = require("logic.manager.experimental.types.task")
local RedData = require("logic.manager.experimental.types.reddata")
local Status = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local Item = require("logic.manager.experimental.types.item")
local MainLineTaskStatus = (LuaNetManager.CreateBean)("protocol.task.mainlinerewardstatus")
local cmissiontypeconfig = (BeanManager.GetTableByName)("mission.cmissiontypeconfig")
local CAchievementMissionConfig = (BeanManager.GetTableByName)("mission.cachievemissionconfig")
local CWeeklyBossAchieveMissionConfig = (BeanManager.GetTableByName)("dungeonselect.cweeklybossachievemissionconfig")
DM_Task.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV, cmissiontypeconfig
  self._tasks = (NekoData.Data).tasks
  self._redData = ((NekoData.Data).tasks).redData
  for _,i in ipairs(cmissiontypeconfig:GetAllIds()) do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R6 in 'UnsetPending'

    ((self._tasks).typed)[i] = {}
    local record = cmissiontypeconfig:GetRecorder(i)
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R7 in 'UnsetPending'

    if not ((self._tasks).sorted)[record.tab] then
      do
        ((self._tasks).sorted)[record.tab] = {}
        -- DECOMPILER ERROR at PC34: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC34: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._tasks).week = {}
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._tasks).skinCollect = {}
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._tasks).mainLine = {}
end

DM_Task.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV, cmissiontypeconfig
  for _,i in ipairs(cmissiontypeconfig:GetAllIds()) do
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R6 in 'UnsetPending'

    ((self._tasks).typed)[i] = {}
    local record = cmissiontypeconfig:GetRecorder(i)
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self._tasks).sorted)[record.tab] = {}
  end
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._tasks).list = {}
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._tasks).daily = {}
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._tasks).choice = {}
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._tasks).params = {}
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._tasks).achievement = {}
  if ((self._tasks).week).activevalues then
    for k,v in pairs(((self._tasks).week).activevalues) do
      -- DECOMPILER ERROR at PC50: Confused about usage of register: R6 in 'UnsetPending'

      (((self._tasks).week).activevalues)[k] = nil
    end
  end
  do
    -- DECOMPILER ERROR at PC55: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self._tasks).week).activevalues = nil
    -- DECOMPILER ERROR at PC58: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self._tasks).week).currentactivevalue = nil
    -- DECOMPILER ERROR at PC61: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._tasks).week = {}
    for k,v in pairs((self._tasks).skinCollect) do
      -- DECOMPILER ERROR at PC69: Confused about usage of register: R6 in 'UnsetPending'

      ((self._tasks).skinCollect)[k] = nil
    end
    for k,v in pairs((self._tasks).mainLine) do
      -- DECOMPILER ERROR at PC79: Confused about usage of register: R6 in 'UnsetPending'

      ((self._tasks).mainLine)[k] = nil
    end
    ;
    (self._redData):Clear()
  end
end

local try_add_task = function(self, id)
  -- function num : 0_2 , upvalues : Task, _ENV
  if not ((self._tasks).list)[id] then
    local task = (Task.Create)()
    task:SetID(id)
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self._tasks).list)[id] = task
    ;
    (table.insert)(((self._tasks).typed)[task:GetType()], task:GetID())
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R3 in 'UnsetPending'

    if not ((self._tasks).sorted)[task:GetGroupID()] then
      do
        ((self._tasks).sorted)[task:GetGroupID()] = {}
        ;
        (table.insert)(((self._tasks).sorted)[task:GetGroupID()], task:GetID())
        do return true end
        return false
      end
    end
  end
end

local type_sort_ids = {}
local get_type_sort_id = function(typeid)
  -- function num : 0_3 , upvalues : type_sort_ids, cmissiontypeconfig
  if not type_sort_ids[typeid] then
    type_sort_ids[typeid] = (cmissiontypeconfig:GetRecorder(typeid)).sortid
  end
  return type_sort_ids[typeid]
end

local simple_sort = function(ltask, rtask)
  -- function num : 0_4 , upvalues : get_type_sort_id
  local lstat = ltask:IsNewTask()
  local rstat = rtask:IsNewTask()
  if lstat ~= rstat then
    return lstat
  end
  local lsp = ltask:IsSpecialDailyTask()
  local rsp = rtask:IsSpecialDailyTask()
  if lsp ~= rsp then
    return lsp
  end
  local lsortid = get_type_sort_id(ltask:GetType())
  local rsortid = get_type_sort_id(rtask:GetType())
  if lsortid >= rsortid then
    do return lsortid == rsortid end
    do return ltask:GetAcceptTime() < rtask:GetAcceptTime() end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end

local sort_status = {[Status.COMMITED] = 1, [Status.UNACCEPT] = 2, [Status.PROCESSING] = 3, [Status.FINISHED] = 4, [Status.ACCEPTED] = 5}
DM_Task.OnSAllTasks = function(self, protocol)
  -- function num : 0_5 , upvalues : _ENV, try_add_task
  for _,tbl in ipairs({protocol.majorTasks, protocol.branchTasks, protocol.dailyTasks, protocol.characterTasks, protocol.achieveTasks, protocol.weekBossTasks}) do
    for _,v in ipairs(tbl) do
      try_add_task(self, v.taskid)
      ;
      (((self._tasks).list)[v.taskid]):InitFromProtocol(v)
    end
  end
  for i,_ in pairs((self._tasks).sorted) do
    self:SortTasks(i)
  end
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._tasks).choice = protocol.taskChoices
  self:RefreshMainStoryTaskRedData()
  self:RefreshDailyTaskRedData()
  self:RefreshCharacterTaskRedData()
  self:RefreshAchievementTaskRedData()
  self:RefreshWeekBossAchievementTaskRedData()
end

DM_Task.OnSAllWeekTasks = function(self, protocol)
  -- function num : 0_6 , upvalues : _ENV, try_add_task
  for _,v in ipairs(protocol.weekTasks) do
    try_add_task(self, v.taskid)
    ;
    (((self._tasks).list)[v.taskid]):InitFromProtocol(v)
  end
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._tasks).week).activevalues = protocol.activeValues
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._tasks).week).currentactivevalue = protocol.currentActiveValue
  self:RefreshDailyTaskRedData()
end

DM_Task.OnSWeekActiveAward = function(self, protocol)
  -- function num : 0_7 , upvalues : _ENV
  for k,v in pairs(((self._tasks).week).activevalues) do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R7 in 'UnsetPending'

    if protocol.value == k then
      (((self._tasks).week).activevalues)[k] = 1
    end
  end
end

DM_Task.OnSAcceptTask = function(self, protocol)
  -- function num : 0_8 , upvalues : try_add_task, _ENV
  local id = (protocol.taskinfo).taskid
  try_add_task(self, id)
  ;
  (((self._tasks).list)[id]):InitFromProtocol(protocol.taskinfo)
  self:SortTasks((((self._tasks).list)[id]):GetGroupID())
  ;
  (LuaNotificationCenter.PostNotification)(((NekoData.Events).Task).n_RefreshTask, self, id)
  if (((self._tasks).list)[id]):GetType() == 1 then
    self:RefreshMainStoryTaskRedData()
  else
    if (((self._tasks).list)[id]):GetType() == 3 then
      self:RefreshDailyTaskRedData()
    else
      if (((self._tasks).list)[id]):GetType() == 7 then
        self:RefreshCharacterTaskRedData()
      else
        if (((self._tasks).list)[id]):GetType() == 4 then
          self:RefreshAchievementTaskRedData()
        else
          if (((self._tasks).list)[id]):GetType() == 16 then
            self:RefreshWeekBossAchievementTaskRedData()
          end
        end
      end
    end
  end
end

local seq_remove_if = function(tbl, func)
  -- function num : 0_9 , upvalues : _ENV
  local index = nil
  for i,v in pairs(tbl) do
    if func(i, v) then
      index = i
      break
    end
  end
  do
    ;
    (table.remove)(tbl, index)
  end
end

DM_Task.OnSDailyTaskForAccept = function(self, protocol)
  -- function num : 0_10 , upvalues : _ENV, Item, try_add_task
  local ranks = {}
  local recorder = (BeanManager.GetTableByName)("mission.cdailymissionaward")
  for value,got in pairs(protocol.activeValues) do
    local record = recorder:GetRecorder(value)
    local awardList = {}
    for i = 1, #record.awardid do
      local award = (Item.Create)((record.awardid)[i])
      award:SetCount((record.num)[i])
      ;
      (table.insert)(awardList, award)
    end
    ranks[#ranks + 1] = {value = value, got = got == 1, award = awardList}
  end
  ;
  (table.sort)(ranks, function(lhs, rhs)
    -- function num : 0_10_0
    do return lhs.value < rhs.value end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  -- DECOMPILER ERROR at PC55: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._tasks).active = {current = protocol.currentActiveValue, ranks = ranks}
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._tasks).dailyLimits = {refresh = protocol.dailyRefreshTime}
  for _,id in pairs(clone(((self._tasks).sorted)[2])) do
    if id < 80000 then
      self:RemoveTask(id)
    end
  end
  local groupid = nil
  for _,info in ipairs(protocol.dailyTasks) do
    try_add_task(self, info.taskid)
    ;
    (((self._tasks).list)[info.taskid]):InitFromProtocol(info)
    if not groupid then
      groupid = (((self._tasks).list)[info.taskid]):GetGroupID()
    end
  end
  -- DECOMPILER ERROR at PC106: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self._tasks).params).dailyaccepttime = protocol.dailyAcceptTime
  if groupid ~= nil then
    self:SortTasks(groupid)
  end
  self:RefreshDailyTaskRedData()
  ;
  (LuaNotificationCenter.PostNotification)(((NekoData.Events).Task).n_GetDailyTask, self, nil, nil)
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

DM_Task.RemoveTask = function(self, id)
  -- function num : 0_11 , upvalues : seq_remove_if
  local task = ((self._tasks).list)[id]
  if not task then
    return false
  end
  local t = function(k, v)
    -- function num : 0_11_0 , upvalues : id
    do return v == id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end

  seq_remove_if(((self._tasks).typed)[task:GetType()], t)
  seq_remove_if(((self._tasks).sorted)[task:GetGroupID()], t)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self._tasks).list)[id] = nil
  return true
end

DM_Task.SortTasks = function(self, groupid)
  -- function num : 0_12 , upvalues : _ENV, sort_status, simple_sort
  (table.sort)(((self._tasks).sorted)[groupid], function(lhs, rhs)
    -- function num : 0_12_0 , upvalues : self, sort_status, simple_sort
    local ltask = ((self._tasks).list)[lhs]
    local rtask = ((self._tasks).list)[rhs]
    local lstatus = sort_status[ltask:GetStatus()]
    local rstatus = sort_status[rtask:GetStatus()]
    if rstatus >= lstatus then
      do return lstatus == rstatus end
      do return simple_sort(ltask, rtask) end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
)
end

DM_Task.UpdateTask = function(self, id, info)
  -- function num : 0_13 , upvalues : Task, seq_remove_if, _ENV
  local current = ((self._tasks).list)[id]
  if not current then
    return 
  end
  local task = (Task.Create)()
  task:InitFromProtocol(info)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R5 in 'UnsetPending'

  if id == info.taskid then
    ((self._tasks).list)[id] = task
  else
    if current:GetType() == task:GetType() and current:GetGroupID() == task:GetGroupID() then
      seq_remove_if(((self._tasks).typed)[current:GetType()], function(i)
    -- function num : 0_13_0 , upvalues : current
    do return i == current:GetID() end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
      ;
      (table.insert)(((self._tasks).typed)[current:GetType()], task:GetID())
      -- DECOMPILER ERROR at PC50: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._tasks).list)[id] = nil
      -- DECOMPILER ERROR at PC54: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._tasks).list)[info.taskid] = task
      local group = ((self._tasks).sorted)[task:GetGroupID()]
      for i,v in pairs(group) do
        if v == id then
          group[i] = info.taskid
          break
        end
      end
    else
      do
        assert(false, "replace irrevalent tasks " .. id .. " with " .. info.taskid)
        assert(not self:RemoveTask(id))
        if task:GetType() == 1 then
          self:RefreshMainStoryTaskRedData()
        else
          if task:GetType() == 3 then
            self:RefreshDailyTaskRedData()
          else
            if task:GetType() == 7 then
              self:RefreshCharacterTaskRedData()
            else
              if task:GetType() == 4 then
                self:RefreshAchievementTaskRedData()
              else
                if task:GetType() == 16 then
                  self:RefreshWeekBossAchievementTaskRedData()
                end
              end
            end
          end
        end
      end
    end
  end
end

DM_Task.OnSTaskAward = function(self, protocol)
  -- function num : 0_14
end

DM_Task.OnSActiveAward = function(self, protocol)
  -- function num : 0_15 , upvalues : _ENV
  for i,v in pairs(((self._tasks).active).ranks) do
    if v.value == protocol.activeValue then
      v.got = true
      break
    end
  end
  do
    self:RefreshDailyTaskRedData()
    ;
    (LuaNotificationCenter.PostNotification)(((NekoData.Events).Task).n_GetActiveAward, self, protocol.activeValue)
  end
end

DM_Task.OnSRefreshTask = function(self, protocol)
  -- function num : 0_16 , upvalues : _ENV
  local task = ((self._tasks).list)[(protocol.taskinfo).taskid]
  if not task then
    LogError("task", "srefreshtask id not found: " .. (protocol.taskinfo).taskid)
    return 
  end
  task:InitFromProtocol(protocol.taskinfo)
  ;
  (LuaNotificationCenter.PostNotification)(((NekoData.Events).Task).n_RefreshTaskOfGuide, self, nil)
  self:SortTasks(task:GetGroupID())
  ;
  (LuaNotificationCenter.PostNotification)(((NekoData.Events).Task).n_RefreshTask, self, task:GetID())
  if task:GetStatus() == 1 and task:GetType() ~= 4 and task:GetType() ~= 8 and task:GetType() ~= 14 and task:GetType() ~= 16 then
    self:RemoveTask(task:GetID())
  end
  if task:GetType() == 1 then
    self:RefreshMainStoryTaskRedData()
  else
    if task:GetType() == 3 then
      self:RefreshDailyTaskRedData()
    else
      if task:GetType() == 7 then
        self:RefreshCharacterTaskRedData()
      else
        if task:GetType() == 4 then
          self:RefreshAchievementTaskRedData()
        else
          if task:GetType() == 16 then
            self:RefreshWeekBossAchievementTaskRedData()
          end
        end
      end
    end
  end
end

DM_Task.RemoveFinishedTasks = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local remove = {}
  for id,task in pairs((self._tasks).list) do
    if task:GetType() ~= 3 and task:GetType() ~= 4 and task:GetType() ~= 8 and task:GetType() ~= 16 and task:GetStatus() == 1 then
      remove[#remove + 1] = id
    end
  end
  for _,id in pairs(remove) do
    self:RemoveTask(id)
  end
  for groupid,_ in pairs((self._tasks).sorted) do
    if groupid ~= 2 then
      self:SortTasks(groupid)
    end
  end
end

DM_Task.RefreshMainStoryTaskRedData = function(self)
  -- function num : 0_18 , upvalues : _ENV, Status, RedData
  local bHasMainTaskFinish = false
  local taskIds = ((self._tasks).typed)[1]
  for _,id in pairs(taskIds) do
    local task = ((self._tasks).list)[id]
    if task:GetStatus() == Status.FINISHED then
      bHasMainTaskFinish = true
      break
    end
  end
  do
    ;
    (self._redData):SetIndexRedValue(RedData.FirstPage, bHasMainTaskFinish)
  end
end

DM_Task.RefreshDailyTaskRedData = function(self)
  -- function num : 0_19 , upvalues : _ENV, Status, RedData
  local dailyTaskHasRed = false
  local weeklyTaskHasRed = false
  local bothTaskHasRed = false
  if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Task_Every) then
    if (self._tasks).active and ((self._tasks).active).current and ((self._tasks).active).current >= 100 then
      dailyTaskHasRed = false
    else
      local taskIds = ((self._tasks).typed)[3]
      for _,id in pairs(taskIds) do
        local task = ((self._tasks).list)[id]
        if task:GetStatus() == Status.FINISHED then
          dailyTaskHasRed = true
          break
        end
      end
    end
    do
      if (self._tasks).week and ((self._tasks).week).currentactivevalue and ((self._tasks).week).currentactivevalue >= 100 then
        weeklyTaskHasRed = false
      else
        local taskIds = ((self._tasks).typed)[8]
        for _,id in pairs(taskIds) do
          local task = ((self._tasks).list)[id]
          if task:GetStatus() == Status.FINISHED then
            weeklyTaskHasRed = true
            break
          end
        end
      end
      do
        bothTaskHasRed = dailyTaskHasRed or weeklyTaskHasRed
        if not bothTaskHasRed and (self._tasks).active then
          for _,v in pairs(((self._tasks).active).ranks) do
            if v.value <= ((self._tasks).active).current and not v.got then
              bothTaskHasRed = true
              break
            end
          end
        end
        do
          ;
          (self._redData):SetIndexRedValue(RedData.SecondPage, bothTaskHasRed)
          ;
          (self._redData):SetIndexRedValue(RedData.SecondPage_Weekly, weeklyTaskHasRed)
          ;
          (self._redData):SetIndexRedValue(RedData.SecondPage_Daily, dailyTaskHasRed)
        end
      end
    end
  end
end

DM_Task.RefreshCharacterTaskRedData = function(self)
  -- function num : 0_20 , upvalues : _ENV, Status, RedData
  local finished = false
  local taskIds = ((self._tasks).typed)[7]
  for _,id in pairs(taskIds) do
    local task = ((self._tasks).list)[id]
    if task:GetStatus() == Status.FINISHED then
      finished = true
      break
    end
  end
  do
    ;
    (self._redData):SetIndexRedValue(RedData.ThirdPage, finished)
  end
end

DM_Task.RefreshAchievementTaskRedData = function(self)
  -- function num : 0_21 , upvalues : _ENV, CAchievementMissionConfig, Status, RedData
  local finished = false
  local taskIds = ((self._tasks).typed)[4]
  for _,id in pairs(taskIds) do
    local task = ((self._tasks).list)[id]
    local record = CAchievementMissionConfig:GetRecorder(id)
    -- DECOMPILER ERROR at PC22: Unhandled construct in 'MakeBoolean' P1

    if record and task:GetStatus() == Status.FINISHED then
      finished = true
      break
    end
    LogErrorFormat("DM_Task", "record with id %s is not exist in cachievemissionconfig", id)
  end
  do
    if not finished and (self._tasks).achievement and (table.nums)(((self._tasks).achievement).unReceiveLevels) > 0 then
      finished = true
    end
    if not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Task_Every) then
      finished = false
    end
    ;
    (self._redData):SetIndexRedValue(RedData.FourPage, finished)
  end
end

DM_Task.RefreshWeekBossAchievementTaskRedData = function(self)
  -- function num : 0_22 , upvalues : _ENV, CWeeklyBossAchieveMissionConfig, Status
  local finished = false
  local taskIds = ((self._tasks).typed)[16]
  for _,id in pairs(taskIds) do
    local task = ((self._tasks).list)[id]
    local record = CWeeklyBossAchieveMissionConfig:GetRecorder(id)
    -- DECOMPILER ERROR at PC22: Unhandled construct in 'MakeBoolean' P1

    if record and task:GetStatus() == Status.FINISHED then
      finished = true
      break
    end
    LogErrorFormat("DM_Task", "record with id %s is not exist in cweeklybossachievemissionconfig", id)
  end
  do
    ;
    ((NekoData.BehaviorManager).BM_WeekBoss):SetRedDotWithType((((NekoData.BehaviorManager).BM_WeekBoss).RedDotType).Achievement, finished)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_WeekBossTaskRedPoint, self, nil)
  end
end

DM_Task.OnSRefreshAchievementInfo = function(self, protocol)
  -- function num : 0_23
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._tasks).achievement = protocol.achievement
  self:RefreshAchievementTaskRedData()
end

DM_Task.OnSReceiveAchieveLevelAward = function(self, protocol)
  -- function num : 0_24 , upvalues : _ENV
  for k,v in pairs(((self._tasks).achievement).unReceiveLevels) do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R7 in 'UnsetPending'

    if v == protocol.level then
      (((self._tasks).achievement).unReceiveLevels)[k] = nil
    end
  end
  self:RefreshAchievementTaskRedData()
end

DM_Task.SetIndexRedValue = function(self, index, value)
  -- function num : 0_25
  (self._redData):SetIndexRedValue(index, value)
end

DM_Task.OnSAddBadges = function(self, protocol)
  -- function num : 0_26
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._tasks).achievement).showBadges = protocol.badges
end

DM_Task.OnSRefreshSkinCollectTask = function(self, protocol)
  -- function num : 0_27 , upvalues : _ENV
  for k,v in ipairs(protocol.tasks) do
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R7 in 'UnsetPending'

    ((self._tasks).skinCollect)[k] = v
  end
end

DM_Task.OnSMainLineReward = function(self, protocol)
  -- function num : 0_28 , upvalues : _ENV
  for k,v in pairs((self._tasks).mainLine) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R7 in 'UnsetPending'

    ((self._tasks).mainLine)[k] = nil
  end
  for i,v in ipairs(protocol.mainLineRewardStates) do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R7 in 'UnsetPending'

    ((self._tasks).mainLine)[v.mainLineId] = v.mainLineState
  end
  self:RefreshMainLineTaskRedDot()
end

DM_Task.OnSMainLineRewardRefreshed = function(self, protocol)
  -- function num : 0_29 , upvalues : _ENV
  for i,v in ipairs(protocol.mainLineRewardStates) do
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R7 in 'UnsetPending'

    ((self._tasks).mainLine)[v.mainLineId] = v.mainLineState
  end
  self:RefreshMainLineTaskRedDot()
end

DM_Task.RefreshMainLineTaskRedDot = function(self)
  -- function num : 0_30 , upvalues : _ENV, MainLineTaskStatus, RedData
  local showRedDot = false
  for k,v in pairs((self._tasks).mainLine) do
    if v == MainLineTaskStatus.AVAILABLE then
      showRedDot = true
      break
    end
  end
  do
    ;
    (self._redData):SetIndexRedValue(RedData.MainLineTask, showRedDot)
  end
end

return DM_Task

