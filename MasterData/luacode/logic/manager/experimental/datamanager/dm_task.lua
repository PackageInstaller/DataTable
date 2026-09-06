local DM_Task = class("DM_Task")
local Task = require("logic.manager.experimental.types.task")
local RedData = require("logic.manager.experimental.types.reddata")
local Status = LuaNetManager.CreateBean("protocol.task.taskstatus")
local Item = require("logic.manager.experimental.types.item")
local MainLineTaskStatus = LuaNetManager.CreateBean("protocol.task.mainlinerewardstatus")
local cmissiontypeconfig = BeanManager.GetTableByName("mission.cmissiontypeconfig")
local CAchievementMissionConfig = BeanManager.GetTableByName("mission.cachievemissionconfig")
local CWeeklyBossAchieveMissionConfig = BeanManager.GetTableByName("dungeonselect.cweeklybossachievemissionconfig")

function DM_Task:Ctor()
  self._tasks = NekoData.Data.tasks
  self._redData = NekoData.Data.tasks.redData
  for _, i in ipairs(cmissiontypeconfig:GetAllIds()) do
    self._tasks.typed[i] = {}
    local record = cmissiontypeconfig:GetRecorder(i)
    self._tasks.sorted[record.tab] = self._tasks.sorted[record.tab] or {}
  end
  self._tasks.week = {}
  self._tasks.skinCollect = {}
  self._tasks.mainLine = {}
end

function DM_Task:Clear()
  for _, i in ipairs(cmissiontypeconfig:GetAllIds()) do
    self._tasks.typed[i] = {}
    local record = cmissiontypeconfig:GetRecorder(i)
    self._tasks.sorted[record.tab] = {}
  end
  self._tasks.list = {}
  self._tasks.daily = {}
  self._tasks.choice = {}
  self._tasks.params = {}
  self._tasks.achievement = {}
  if self._tasks.week.activevalues then
    for k, v in pairs(self._tasks.week.activevalues) do
      self._tasks.week.activevalues[k] = nil
    end
  end
  self._tasks.week.activevalues = nil
  self._tasks.week.currentactivevalue = nil
  self._tasks.week = {}
  for k, v in pairs(self._tasks.skinCollect) do
    self._tasks.skinCollect[k] = nil
  end
  for k, v in pairs(self._tasks.mainLine) do
    self._tasks.mainLine[k] = nil
  end
  self._redData:Clear()
end

local function try_add_task(self, id)
  if not self._tasks.list[id] then
    local task = Task.Create()
    task:SetID(id)
    self._tasks.list[id] = task
    table.insert(self._tasks.typed[task:GetType()], task:GetID())
    self._tasks.sorted[task:GetGroupID()] = self._tasks.sorted[task:GetGroupID()] or {}
    table.insert(self._tasks.sorted[task:GetGroupID()], task:GetID())
    return true
  end
  return false
end

local type_sort_ids = {}

local function get_type_sort_id(typeid)
  if not type_sort_ids[typeid] then
    type_sort_ids[typeid] = cmissiontypeconfig:GetRecorder(typeid).sortid
  end
  return type_sort_ids[typeid]
end

local function simple_sort(ltask, rtask)
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
  if lsortid ~= rsortid then
    return lsortid < rsortid
  else
    return ltask:GetAcceptTime() < rtask:GetAcceptTime()
  end
end

local sort_status = {
  [Status.COMMITED] = 1,
  [Status.UNACCEPT] = 2,
  [Status.PROCESSING] = 3,
  [Status.FINISHED] = 4,
  [Status.ACCEPTED] = 5
}

function DM_Task:OnSAllTasks(protocol)
  for _, tbl in ipairs({
    protocol.majorTasks,
    protocol.branchTasks,
    protocol.dailyTasks,
    protocol.characterTasks,
    protocol.achieveTasks,
    protocol.weekBossTasks
  }) do
    for _, v in ipairs(tbl) do
      try_add_task(self, v.taskid)
      self._tasks.list[v.taskid]:InitFromProtocol(v)
    end
  end
  for i, _ in pairs(self._tasks.sorted) do
    self:SortTasks(i)
  end
  self._tasks.choice = protocol.taskChoices
  self:RefreshMainStoryTaskRedData()
  self:RefreshDailyTaskRedData()
  self:RefreshCharacterTaskRedData()
  self:RefreshAchievementTaskRedData()
  self:RefreshWeekBossAchievementTaskRedData()
end

function DM_Task:OnSAllWeekTasks(protocol)
  for _, v in ipairs(protocol.weekTasks) do
    try_add_task(self, v.taskid)
    self._tasks.list[v.taskid]:InitFromProtocol(v)
  end
  self._tasks.week.activevalues = protocol.activeValues
  self._tasks.week.currentactivevalue = protocol.currentActiveValue
  self:RefreshDailyTaskRedData()
end

function DM_Task:OnSWeekActiveAward(protocol)
  for k, v in pairs(self._tasks.week.activevalues) do
    if protocol.value == k then
      self._tasks.week.activevalues[k] = 1
    end
  end
end

function DM_Task:OnSAcceptTask(protocol)
  local id = protocol.taskinfo.taskid
  try_add_task(self, id)
  self._tasks.list[id]:InitFromProtocol(protocol.taskinfo)
  self:SortTasks(self._tasks.list[id]:GetGroupID())
  LuaNotificationCenter.PostNotification(NekoData.Events.Task.n_RefreshTask, self, id)
  if self._tasks.list[id]:GetType() == 1 then
    self:RefreshMainStoryTaskRedData()
  elseif self._tasks.list[id]:GetType() == 3 then
    self:RefreshDailyTaskRedData()
  elseif self._tasks.list[id]:GetType() == 7 then
    self:RefreshCharacterTaskRedData()
  elseif self._tasks.list[id]:GetType() == 4 then
    self:RefreshAchievementTaskRedData()
  elseif self._tasks.list[id]:GetType() == 16 then
    self:RefreshWeekBossAchievementTaskRedData()
  end
end

local function seq_remove_if(tbl, func)
  local index
  for i, v in pairs(tbl) do
    if func(i, v) then
      index = i
      break
    end
  end
  table.remove(tbl, index)
end

function DM_Task:OnSDailyTaskForAccept(protocol)
  local ranks = {}
  local recorder = BeanManager.GetTableByName("mission.cdailymissionaward")
  for value, got in pairs(protocol.activeValues) do
    local record = recorder:GetRecorder(value)
    local awardList = {}
    for i = 1, #record.awardid do
      local award = Item.Create(record.awardid[i])
      award:SetCount(record.num[i])
      table.insert(awardList, award)
    end
    ranks[#ranks + 1] = {
      value = value,
      got = got == 1,
      award = awardList
    }
  end
  table.sort(ranks, function(lhs, rhs)
    return lhs.value < rhs.value
  end)
  self._tasks.active = {
    current = protocol.currentActiveValue,
    ranks = ranks
  }
  self._tasks.dailyLimits = {
    refresh = protocol.dailyRefreshTime
  }
  for _, id in pairs(clone(self._tasks.sorted[2])) do
    if id < 80000 then
      self:RemoveTask(id)
    end
  end
  local groupid
  for _, info in ipairs(protocol.dailyTasks) do
    try_add_task(self, info.taskid)
    self._tasks.list[info.taskid]:InitFromProtocol(info)
    groupid = groupid or self._tasks.list[info.taskid]:GetGroupID()
  end
  self._tasks.params.dailyaccepttime = protocol.dailyAcceptTime
  if groupid ~= nil then
    self:SortTasks(groupid)
  end
  self:RefreshDailyTaskRedData()
  LuaNotificationCenter.PostNotification(NekoData.Events.Task.n_GetDailyTask, self, nil, nil)
end

function DM_Task:RemoveTask(id)
  local task = self._tasks.list[id]
  if not task then
    return false
  end
  
  local function t(k, v)
    return v == id
  end
  
  seq_remove_if(self._tasks.typed[task:GetType()], t)
  seq_remove_if(self._tasks.sorted[task:GetGroupID()], t)
  self._tasks.list[id] = nil
  return true
end

function DM_Task:SortTasks(groupid)
  table.sort(self._tasks.sorted[groupid], function(lhs, rhs)
    local ltask = self._tasks.list[lhs]
    local rtask = self._tasks.list[rhs]
    local lstatus = sort_status[ltask:GetStatus()]
    local rstatus = sort_status[rtask:GetStatus()]
    if lstatus ~= rstatus then
      return lstatus > rstatus
    else
      return simple_sort(ltask, rtask)
    end
  end)
end

function DM_Task:UpdateTask(id, info)
  local current = self._tasks.list[id]
  if not current then
    return
  end
  local task = Task.Create()
  task:InitFromProtocol(info)
  if id == info.taskid then
    self._tasks.list[id] = task
  else
    if current:GetType() == task:GetType() and current:GetGroupID() == task:GetGroupID() then
      seq_remove_if(self._tasks.typed[current:GetType()], function(i)
        return i == current:GetID()
      end)
      table.insert(self._tasks.typed[current:GetType()], task:GetID())
      self._tasks.list[id] = nil
      self._tasks.list[info.taskid] = task
      local group = self._tasks.sorted[task:GetGroupID()]
      for i, v in pairs(group) do
        if v == id then
          group[i] = info.taskid
          break
        end
      end
    else
      assert(false, "replace irrevalent tasks " .. id .. " with " .. info.taskid)
    end
    assert(not self:RemoveTask(id))
  end
  if task:GetType() == 1 then
    self:RefreshMainStoryTaskRedData()
  elseif task:GetType() == 3 then
    self:RefreshDailyTaskRedData()
  elseif task:GetType() == 7 then
    self:RefreshCharacterTaskRedData()
  elseif task:GetType() == 4 then
    self:RefreshAchievementTaskRedData()
  elseif task:GetType() == 16 then
    self:RefreshWeekBossAchievementTaskRedData()
  end
end

function DM_Task:OnSTaskAward(protocol)
end

function DM_Task:OnSActiveAward(protocol)
  for i, v in pairs(self._tasks.active.ranks) do
    if v.value == protocol.activeValue then
      v.got = true
      break
    end
  end
  self:RefreshDailyTaskRedData()
  LuaNotificationCenter.PostNotification(NekoData.Events.Task.n_GetActiveAward, self, protocol.activeValue)
end

function DM_Task:OnSRefreshTask(protocol)
  local task = self._tasks.list[protocol.taskinfo.taskid]
  if not task then
    LogError("task", "srefreshtask id not found: " .. protocol.taskinfo.taskid)
    return
  end
  task:InitFromProtocol(protocol.taskinfo)
  LuaNotificationCenter.PostNotification(NekoData.Events.Task.n_RefreshTaskOfGuide, self, nil)
  self:SortTasks(task:GetGroupID())
  LuaNotificationCenter.PostNotification(NekoData.Events.Task.n_RefreshTask, self, task:GetID())
  if task:GetStatus() == 1 and task:GetType() ~= 4 and task:GetType() ~= 8 and task:GetType() ~= 14 and task:GetType() ~= 16 then
    self:RemoveTask(task:GetID())
  end
  if task:GetType() == 1 then
    self:RefreshMainStoryTaskRedData()
  elseif task:GetType() == 3 then
    self:RefreshDailyTaskRedData()
  elseif task:GetType() == 7 then
    self:RefreshCharacterTaskRedData()
  elseif task:GetType() == 4 then
    self:RefreshAchievementTaskRedData()
  elseif task:GetType() == 16 then
    self:RefreshWeekBossAchievementTaskRedData()
  end
end

function DM_Task:RemoveFinishedTasks()
  local remove = {}
  for id, task in pairs(self._tasks.list) do
    if task:GetType() ~= 3 and task:GetType() ~= 4 and task:GetType() ~= 8 and task:GetType() ~= 16 and task:GetStatus() == 1 then
      remove[#remove + 1] = id
    end
  end
  for _, id in pairs(remove) do
    self:RemoveTask(id)
  end
  for groupid, _ in pairs(self._tasks.sorted) do
    if groupid ~= 2 then
      self:SortTasks(groupid)
    end
  end
end

function DM_Task:RefreshMainStoryTaskRedData()
  local bHasMainTaskFinish = false
  local taskIds = self._tasks.typed[1]
  for _, id in pairs(taskIds) do
    local task = self._tasks.list[id]
    if task:GetStatus() == Status.FINISHED then
      bHasMainTaskFinish = true
      break
    end
  end
  self._redData:SetIndexRedValue(RedData.FirstPage, bHasMainTaskFinish)
end

function DM_Task:RefreshDailyTaskRedData()
  local dailyTaskHasRed = false
  local weeklyTaskHasRed = false
  local bothTaskHasRed = false
  if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Task_Every) then
    if self._tasks.active and self._tasks.active.current and self._tasks.active.current >= 100 then
      dailyTaskHasRed = false
    else
      local taskIds = self._tasks.typed[3]
      for _, id in pairs(taskIds) do
        local task = self._tasks.list[id]
        if task:GetStatus() == Status.FINISHED then
          dailyTaskHasRed = true
          break
        end
      end
    end
    if self._tasks.week and self._tasks.week.currentactivevalue and 100 <= self._tasks.week.currentactivevalue then
      weeklyTaskHasRed = false
    else
      local taskIds = self._tasks.typed[8]
      for _, id in pairs(taskIds) do
        local task = self._tasks.list[id]
        if task:GetStatus() == Status.FINISHED then
          weeklyTaskHasRed = true
          break
        end
      end
    end
    bothTaskHasRed = dailyTaskHasRed or weeklyTaskHasRed
    if not bothTaskHasRed and self._tasks.active then
      for _, v in pairs(self._tasks.active.ranks) do
        if self._tasks.active.current >= v.value and not v.got then
          bothTaskHasRed = true
          break
        end
      end
    end
  end
  self._redData:SetIndexRedValue(RedData.SecondPage, bothTaskHasRed)
  self._redData:SetIndexRedValue(RedData.SecondPage_Weekly, weeklyTaskHasRed)
  self._redData:SetIndexRedValue(RedData.SecondPage_Daily, dailyTaskHasRed)
end

function DM_Task:RefreshCharacterTaskRedData()
  local finished = false
  local taskIds = self._tasks.typed[7]
  for _, id in pairs(taskIds) do
    local task = self._tasks.list[id]
    if task:GetStatus() == Status.FINISHED then
      finished = true
      break
    end
  end
  self._redData:SetIndexRedValue(RedData.ThirdPage, finished)
end

function DM_Task:RefreshAchievementTaskRedData()
  local finished = false
  local taskIds = self._tasks.typed[4]
  for _, id in pairs(taskIds) do
    local task = self._tasks.list[id]
    local record = CAchievementMissionConfig:GetRecorder(id)
    if record then
      if task:GetStatus() == Status.FINISHED then
        finished = true
        break
      end
    else
      LogErrorFormat("DM_Task", "record with id %s is not exist in cachievemissionconfig", id)
    end
  end
  if not finished and self._tasks.achievement and table.nums(self._tasks.achievement.unReceiveLevels) > 0 then
    finished = true
  end
  if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Task_Every) then
    finished = false
  end
  self._redData:SetIndexRedValue(RedData.FourPage, finished)
end

function DM_Task:RefreshWeekBossAchievementTaskRedData()
  local finished = false
  local taskIds = self._tasks.typed[16]
  for _, id in pairs(taskIds) do
    local task = self._tasks.list[id]
    local record = CWeeklyBossAchieveMissionConfig:GetRecorder(id)
    if record then
      if task:GetStatus() == Status.FINISHED then
        finished = true
        break
      end
    else
      LogErrorFormat("DM_Task", "record with id %s is not exist in cweeklybossachievemissionconfig", id)
    end
  end
  NekoData.BehaviorManager.BM_WeekBoss:SetRedDotWithType(NekoData.BehaviorManager.BM_WeekBoss.RedDotType.Achievement, finished)
  LuaNotificationCenter.PostNotification(Common.n_WeekBossTaskRedPoint, self, nil)
end

function DM_Task:OnSRefreshAchievementInfo(protocol)
  self._tasks.achievement = protocol.achievement
  self:RefreshAchievementTaskRedData()
end

function DM_Task:OnSReceiveAchieveLevelAward(protocol)
  for k, v in pairs(self._tasks.achievement.unReceiveLevels) do
    if v == protocol.level then
      self._tasks.achievement.unReceiveLevels[k] = nil
    end
  end
  self:RefreshAchievementTaskRedData()
end

function DM_Task:SetIndexRedValue(index, value)
  self._redData:SetIndexRedValue(index, value)
end

function DM_Task:OnSAddBadges(protocol)
  self._tasks.achievement.showBadges = protocol.badges
end

function DM_Task:OnSRefreshSkinCollectTask(protocol)
  for k, v in ipairs(protocol.tasks) do
    self._tasks.skinCollect[k] = v
  end
end

function DM_Task:OnSMainLineReward(protocol)
  for k, v in pairs(self._tasks.mainLine) do
    self._tasks.mainLine[k] = nil
  end
  for i, v in ipairs(protocol.mainLineRewardStates) do
    self._tasks.mainLine[v.mainLineId] = v.mainLineState
  end
  self:RefreshMainLineTaskRedDot()
end

function DM_Task:OnSMainLineRewardRefreshed(protocol)
  for i, v in ipairs(protocol.mainLineRewardStates) do
    self._tasks.mainLine[v.mainLineId] = v.mainLineState
  end
  self:RefreshMainLineTaskRedDot()
end

function DM_Task:RefreshMainLineTaskRedDot()
  local showRedDot = false
  for k, v in pairs(self._tasks.mainLine) do
    if v == MainLineTaskStatus.AVAILABLE then
      showRedDot = true
      break
    end
  end
  self._redData:SetIndexRedValue(RedData.MainLineTask, showRedDot)
end

return DM_Task
