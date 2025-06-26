-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_task.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_Task = class("BM_Task")
local Status = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local StaticEvent = require("logic.scene.luaevent.event.staticevent")
local CAchievementMissionConfig = (BeanManager.GetTableByName)("mission.cachievemissionconfig")
BM_Task.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._tasks = (NekoData.Data).tasks
  self._redData = ((NekoData.Data).tasks).redData
  self._events = {}
  ;
  (LuaNotificationCenter.AddObserver)(self, self.InitTaskTriggers, ((NekoData.Events).Task).n_InitTasks, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnTaskRefresh, ((NekoData.Events).Task).n_RefreshTask, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnTaskAccept, ((NekoData.Events).Task).n_AcceptTask, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDailyTaskRefresh, ((NekoData.Events).Task).n_GetDailyTask, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGetActiveAward, ((NekoData.Events).Task).n_GetActiveAward, nil)
end

local add_task_triggers = function(self, id, task)
  -- function num : 0_1 , upvalues : StaticEvent, _ENV
  local acceptid = task:GetAcceptTriggerID()
  local acceptevent = (StaticEvent.CreateFromConfig)(acceptid)
  ;
  (EventManager.AddEvent)(acceptevent)
  local finishid = task:GetFinishTriggerID()
  local finishevent = (StaticEvent.CreateFromConfig)(finishid)
  ;
  (EventManager.AddEvent)(finishevent)
  local failid = (task:GetFailTriggerID())
  local failevent = nil
  if failid then
    failevent = (StaticEvent.CreateFromConfig)(failid)
    ;
    (EventManager.AddEvent)(failevent)
  end
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R9 in 'UnsetPending'

  ;
  (self._events)[id] = {accept = acceptevent, finish = finishevent, fail = failevent}
end

BM_Task.InitTaskTriggers = function(self)
  -- function num : 0_2 , upvalues : _ENV, Status, add_task_triggers
  for id,task in pairs((self._tasks).list) do
    if task:GetStatus() == Status.PROCESSING then
      add_task_triggers(self, id, task)
    end
  end
end

BM_Task.OnTaskAccept = function(self, notification)
  -- function num : 0_3 , upvalues : add_task_triggers, _ENV
  add_task_triggers(self, notification.userInfo, ((self._tasks).list)[notification.userInfo])
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshTask, self, ((self._tasks).list)[notification.userInfo])
end

BM_Task.OnTaskRefresh = function(self, notification)
  -- function num : 0_4 , upvalues : _ENV
  local task = ((self._tasks).list)[notification.userInfo]
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshTask, self, task)
end

BM_Task.OnDailyTaskRefresh = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshDailyTask, self, ((self._tasks).list)[notification.userInfo])
end

BM_Task.OnGetActiveAward = function(self, notification)
  -- function num : 0_6 , upvalues : _ENV
  (LuaNotificationCenter.PostNotification)(Common.n_GetActiveAward, self, notification.userInfo)
end

BM_Task.GetTask = function(self, id)
  -- function num : 0_7
  return ((self._tasks).list)[id]
end

BM_Task.GetAllTasks = function(self)
  -- function num : 0_8
  return (self._tasks).list
end

BM_Task.GetTasksByType = function(self, type)
  -- function num : 0_9 , upvalues : _ENV
  return (table.select)(((self._tasks).typed)[type], function(v)
    -- function num : 0_9_0 , upvalues : self
    return ((self._tasks).list)[v]
  end
)
end

BM_Task.GetTasksByGroup = function(self, groupid)
  -- function num : 0_10 , upvalues : _ENV
  local result = {}
  for _,i in ipairs(((self._tasks).sorted)[groupid]) do
    result[#result + 1] = ((self._tasks).list)[i]
  end
  return result
end

BM_Task.GetTasksByTabAndGroup = function(self, tab, groupid)
  -- function num : 0_11 , upvalues : _ENV
  local result = {}
  for _,i in ipairs(((self._tasks).sorted)[tab]) do
    if (((self._tasks).list)[i]):GetType() == groupid then
      result[#result + 1] = ((self._tasks).list)[i]
    end
  end
  return result
end

BM_Task.GetRemainDailyTaskCount = function(self)
  -- function num : 0_12
  return ((self._tasks).params).dailyaccepttime
end

BM_Task.TryAcceptTask = function(self, id)
  -- function num : 0_13 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.task.caccepttask")
  protocol.taskid = id
  protocol:Send()
end

BM_Task.TryCommitTask = function(self, id)
  -- function num : 0_14 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.task.ccommittask")
  protocol.taskid = id
  protocol:Send()
end

BM_Task.RequestDailyTask = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.task.cdailytaskforaccept")
  protocol:Send()
end

BM_Task.RequestDailyTaskRefresh = function(self, id)
  -- function num : 0_16 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.task.crefreshdailytaskforaccept")
  protocol.taskid = id
  protocol:Send()
end

BM_Task.GetTaskChoice = function(self)
  -- function num : 0_17
  return (self._tasks).choice
end

BM_Task.GetDailyRefreshCount = function(self)
  -- function num : 0_18
  return ((self._tasks).dailyLimits).refresh
end

BM_Task.GetActiveInfo = function(self)
  -- function num : 0_19
  return (self._tasks).active
end

BM_Task.HandleTask = function(self, taskID)
  -- function num : 0_20 , upvalues : _ENV
  local task = ((self._tasks).list)[taskID]
  if task then
    local type = task:GetJumpType()
    if type > 0 then
      local handler = require("logic.task.taskhandlers." .. type)
      if handler then
        handler:Handle(task:GetConfig())
      end
    else
      do
        do
          if type == -1 then
            ((DialogManager.CreateSingletonDialog)("chat.guidecommentdialog")):SetData(3)
          end
          LogErrorFormat("BM_Task", "Unknown task id " .. tostring(taskID))
        end
      end
    end
  end
end

BM_Task.Cleanup = function(self)
  -- function num : 0_21 , upvalues : _ENV
  ((NekoData.DataManager).DM_Task):RemoveFinishedTasks()
end

BM_Task.RequestActiveAward = function(self, value)
  -- function num : 0_22 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.task.cgetactiveaward")
  req.value = value
  req:Send()
end

BM_Task.MarkShownTasks = function(self, ids)
  -- function num : 0_23 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.task.cvisitmajortask")
  req.taskIds = ids
  req:Send()
  for _,i in pairs(ids) do
    local task = ((self._tasks).list)[i]
    task:SetNewTask(false)
  end
end

BM_Task.GetRedData = function(self)
  -- function num : 0_24
  return self._redData
end

BM_Task.GetAchievementTaskList = function(self)
  -- function num : 0_25 , upvalues : _ENV, CAchievementMissionConfig
  local list = {}
  local taskIds = ((self._tasks).typed)[4]
  for _,id in pairs(taskIds) do
    local task = ((self._tasks).list)[id]
    if CAchievementMissionConfig:GetRecorder(id) then
      (table.insert)(list, task)
    end
  end
  return list
end

BM_Task.GetWeektTaskList = function(self)
  -- function num : 0_26 , upvalues : _ENV
  local list = {}
  for id,task in pairs((self._tasks).list) do
    if task:GetType() == 8 then
      (table.insert)(list, task)
    end
  end
  return list
end

BM_Task.GetAchievement = function(self)
  -- function num : 0_27
  return (self._tasks).achievement
end

BM_Task.GetShowBadges = function(self)
  -- function num : 0_28 , upvalues : _ENV
  local badges = {}
  for i = 1, 5 do
    local badge = (((self._tasks).achievement).showBadges)[i]
    if badge then
      (table.insert)(badges, badge)
    else
      ;
      (table.insert)(badges, -1)
    end
  end
  return badges
end

BM_Task.GetOtherShowBadges = function(self, otherBadges)
  -- function num : 0_29 , upvalues : _ENV
  local badges = {}
  for i = 1, 5 do
    local badge = otherBadges[i]
    if badge then
      (table.insert)(badges, badge)
    else
      ;
      (table.insert)(badges, -1)
    end
  end
  return badges
end

BM_Task.GetWeekActiveValueMap = function(self)
  -- function num : 0_30
  return ((self._tasks).week).activevalues
end

BM_Task.GetWeekCurrentActiveValue = function(self)
  -- function num : 0_31
  return ((self._tasks).week).currentactivevalue
end

BM_Task.GetElementTaskList = function(self)
  -- function num : 0_32 , upvalues : _ENV
  local list = {}
  for id,task in pairs((self._tasks).list) do
    if task:GetType() == 14 then
      (table.insert)(list, task)
    end
  end
  return list
end

BM_Task.GetMainLineTaskList = function(self)
  -- function num : 0_33 , upvalues : _ENV
  local list = {}
  for k,v in pairs((self._tasks).mainLine) do
    (table.insert)(list, {mainLineId = k, taskState = v})
  end
  ;
  (table.sort)(list, function(a, b)
    -- function num : 0_33_0
    do return a.mainLineId < b.mainLineId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return list
end

return BM_Task

