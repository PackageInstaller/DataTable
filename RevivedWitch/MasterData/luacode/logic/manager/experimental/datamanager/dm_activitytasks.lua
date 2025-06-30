-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_activitytasks.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("logic.manager.experimental.types.task")
local TaskStatus = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local TasksProtocolDef = (LuaNetManager.GetProtocolDef)("protocol.task.cactivitytasks")
local DM_ActivityTasks = class("DM_ActivityTasks")
DM_ActivityTasks.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._allTaskList = ((NekoData.Data).activityTasks).allTaskList
  self._finishedTaskList = ((NekoData.Data).activityTasks).finishedTaskList
end

DM_ActivityTasks.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  for key,_ in pairs(self._allTaskList) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R6 in 'UnsetPending'

    (self._allTaskList)[key] = nil
  end
  for key,_ in pairs(self._finishedTaskList) do
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R6 in 'UnsetPending'

    (self._finishedTaskList)[key] = nil
  end
end

DM_ActivityTasks.OnSActivityTasks = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  (self._allTaskList)[protocol.activityID] = {}
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._finishedTaskList)[protocol.activityID] = {}
  for _,activityTask in pairs(protocol.activityTasks) do
    self:_HandleTask(protocol.activityID, activityTask)
  end
end

DM_ActivityTasks.OnSRefreshActivityTask = function(self, protocol)
  -- function num : 0_3
  self:_HandleTask(protocol.activityID, protocol.taskinfo)
end

DM_ActivityTasks._HandleTask = function(self, activityID, taskinfo)
  -- function num : 0_4 , upvalues : Task, _ENV, TaskStatus, TasksProtocolDef
  local task = (Task.Create)()
  task:InitFromProtocol(taskinfo)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

  if (self._allTaskList)[activityID] == nil then
    (self._allTaskList)[activityID] = {}
    LogInfoFormat("DM_ActivityTasks", "AllTaskList No Exist ActivityTaskID", activityID)
  end
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R4 in 'UnsetPending'

  if (self._finishedTaskList)[activityID] == nil then
    (self._finishedTaskList)[activityID] = {}
    LogInfoFormat("DM_ActivityTasks", "FinishedTaskList No Exist ActivityTaskID", activityID)
  end
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self._allTaskList)[activityID])[task:GetID()] = task
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R4 in 'UnsetPending'

  if task:GetStatus() == TaskStatus.FINISHED then
    ((self._finishedTaskList)[activityID])[task:GetID()] = task
    if activityID == TasksProtocolDef.JIGSAW_PUZZLE or activityID == TasksProtocolDef.HALLOWEEN then
      (LuaNotificationCenter.PostNotification)(Common.n_RefreshActivityRewards, nil, nil)
    end
  else
    -- DECOMPILER ERROR at PC61: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self._finishedTaskList)[activityID])[task:GetID()] = nil
  end
end

return DM_ActivityTasks

