local BM_Task = class("BM_Task")
local Status = LuaNetManager.CreateBean("protocol.task.taskstatus")
local StaticEvent = require("logic.scene.luaevent.event.staticevent")
local CAchievementMissionConfig = BeanManager.GetTableByName("mission.cachievemissionconfig")

function BM_Task:Ctor()
  self._tasks = NekoData.Data.tasks
  self._redData = NekoData.Data.tasks.redData
  self._events = {}
  LuaNotificationCenter.AddObserver(self, self.InitTaskTriggers, NekoData.Events.Task.n_InitTasks, nil)
  LuaNotificationCenter.AddObserver(self, self.OnTaskRefresh, NekoData.Events.Task.n_RefreshTask, nil)
  LuaNotificationCenter.AddObserver(self, self.OnTaskAccept, NekoData.Events.Task.n_AcceptTask, nil)
  LuaNotificationCenter.AddObserver(self, self.OnDailyTaskRefresh, NekoData.Events.Task.n_GetDailyTask, nil)
  LuaNotificationCenter.AddObserver(self, self.OnGetActiveAward, NekoData.Events.Task.n_GetActiveAward, nil)
end

local function add_task_triggers(self, id, task)
  local acceptid = task:GetAcceptTriggerID()
  local acceptevent = StaticEvent.CreateFromConfig(acceptid)
  EventManager.AddEvent(acceptevent)
  local finishid = task:GetFinishTriggerID()
  local finishevent = StaticEvent.CreateFromConfig(finishid)
  EventManager.AddEvent(finishevent)
  local failid = task:GetFailTriggerID()
  local failevent
  if failid then
    failevent = StaticEvent.CreateFromConfig(failid)
    EventManager.AddEvent(failevent)
  end
  self._events[id] = {
    accept = acceptevent,
    finish = finishevent,
    fail = failevent
  }
end

function BM_Task:InitTaskTriggers()
  for id, task in pairs(self._tasks.list) do
    if task:GetStatus() == Status.PROCESSING then
      add_task_triggers(self, id, task)
    end
  end
end

function BM_Task:OnTaskAccept(notification)
  add_task_triggers(self, notification.userInfo, self._tasks.list[notification.userInfo])
  LuaNotificationCenter.PostNotification(Common.n_RefreshTask, self, self._tasks.list[notification.userInfo])
end

function BM_Task:OnTaskRefresh(notification)
  local task = self._tasks.list[notification.userInfo]
  LuaNotificationCenter.PostNotification(Common.n_RefreshTask, self, task)
end

function BM_Task:OnDailyTaskRefresh(notification)
  LuaNotificationCenter.PostNotification(Common.n_RefreshDailyTask, self, self._tasks.list[notification.userInfo])
end

function BM_Task:OnGetActiveAward(notification)
  LuaNotificationCenter.PostNotification(Common.n_GetActiveAward, self, notification.userInfo)
end

function BM_Task:GetTask(id)
  return self._tasks.list[id]
end

function BM_Task:GetAllTasks()
  return self._tasks.list
end

function BM_Task:GetTasksByType(type)
  return table.select(self._tasks.typed[type], function(v)
    return self._tasks.list[v]
  end)
end

function BM_Task:GetTasksByGroup(groupid)
  local result = {}
  for _, i in ipairs(self._tasks.sorted[groupid]) do
    result[#result + 1] = self._tasks.list[i]
  end
  return result
end

function BM_Task:GetTasksByTabAndGroup(tab, groupid)
  local result = {}
  for _, i in ipairs(self._tasks.sorted[tab]) do
    if self._tasks.list[i]:GetType() == groupid then
      result[#result + 1] = self._tasks.list[i]
    end
  end
  return result
end

function BM_Task:GetRemainDailyTaskCount()
  return self._tasks.params.dailyaccepttime
end

function BM_Task:TryAcceptTask(id)
  local protocol = LuaNetManager.CreateProtocol("protocol.task.caccepttask")
  protocol.taskid = id
  protocol:Send()
end

function BM_Task:TryCommitTask(id)
  local protocol = LuaNetManager.CreateProtocol("protocol.task.ccommittask")
  protocol.taskid = id
  protocol:Send()
end

function BM_Task:RequestDailyTask()
  local protocol = LuaNetManager.CreateProtocol("protocol.task.cdailytaskforaccept")
  protocol:Send()
end

function BM_Task:RequestDailyTaskRefresh(id)
  local protocol = LuaNetManager.CreateProtocol("protocol.task.crefreshdailytaskforaccept")
  protocol.taskid = id
  protocol:Send()
end

function BM_Task:GetTaskChoice()
  return self._tasks.choice
end

function BM_Task:GetDailyRefreshCount()
  return self._tasks.dailyLimits.refresh
end

function BM_Task:GetActiveInfo()
  return self._tasks.active
end

function BM_Task:HandleTask(taskID)
  local task = self._tasks.list[taskID]
  if task then
    local type = task:GetJumpType()
    if 0 < type then
      local handler = require("logic.task.taskhandlers." .. type)
      if handler then
        handler:Handle(task:GetConfig())
      end
    elseif type == -1 then
      DialogManager.CreateSingletonDialog("chat.guidecommentdialog"):SetData(3)
    end
  else
    LogErrorFormat("BM_Task", "Unknown task id " .. tostring(taskID))
  end
end

function BM_Task:Cleanup()
  NekoData.DataManager.DM_Task:RemoveFinishedTasks()
end

function BM_Task:RequestActiveAward(value)
  local req = LuaNetManager.CreateProtocol("protocol.task.cgetactiveaward")
  req.value = value
  req:Send()
end

function BM_Task:MarkShownTasks(ids)
  local req = LuaNetManager.CreateProtocol("protocol.task.cvisitmajortask")
  req.taskIds = ids
  req:Send()
  for _, i in pairs(ids) do
    local task = self._tasks.list[i]
    task:SetNewTask(false)
  end
end

function BM_Task:GetRedData()
  return self._redData
end

function BM_Task:GetAchievementTaskList()
  local list = {}
  local taskIds = self._tasks.typed[4]
  for _, id in pairs(taskIds) do
    local task = self._tasks.list[id]
    if CAchievementMissionConfig:GetRecorder(id) then
      table.insert(list, task)
    end
  end
  return list
end

function BM_Task:GetWeektTaskList()
  local list = {}
  for id, task in pairs(self._tasks.list) do
    if task:GetType() == 8 then
      table.insert(list, task)
    end
  end
  return list
end

function BM_Task:GetAchievement()
  return self._tasks.achievement
end

function BM_Task:GetShowBadges()
  local badges = {}
  for i = 1, 5 do
    local badge = self._tasks.achievement.showBadges[i]
    if badge then
      table.insert(badges, badge)
    else
      table.insert(badges, -1)
    end
  end
  return badges
end

function BM_Task:GetOtherShowBadges(otherBadges)
  local badges = {}
  for i = 1, 5 do
    local badge = otherBadges[i]
    if badge then
      table.insert(badges, badge)
    else
      table.insert(badges, -1)
    end
  end
  return badges
end

function BM_Task:GetWeekActiveValueMap()
  return self._tasks.week.activevalues
end

function BM_Task:GetWeekCurrentActiveValue()
  return self._tasks.week.currentactivevalue
end

function BM_Task:GetElementTaskList()
  local list = {}
  for id, task in pairs(self._tasks.list) do
    if task:GetType() == 14 then
      table.insert(list, task)
    end
  end
  return list
end

function BM_Task:GetMainLineTaskList()
  local list = {}
  for k, v in pairs(self._tasks.mainLine) do
    table.insert(list, {mainLineId = k, taskState = v})
  end
  table.sort(list, function(a, b)
    return a.mainLineId < b.mainLineId
  end)
  return list
end

return BM_Task
