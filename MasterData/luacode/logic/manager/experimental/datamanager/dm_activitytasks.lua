local Task = require("logic.manager.experimental.types.task")
local TaskStatus = LuaNetManager.CreateBean("protocol.task.taskstatus")
local TasksProtocolDef = LuaNetManager.GetProtocolDef("protocol.task.cactivitytasks")
local DM_ActivityTasks = class("DM_ActivityTasks")

function DM_ActivityTasks:Ctor()
  self._allTaskList = NekoData.Data.activityTasks.allTaskList
  self._finishedTaskList = NekoData.Data.activityTasks.finishedTaskList
end

function DM_ActivityTasks:Clear()
  for key, _ in pairs(self._allTaskList) do
    self._allTaskList[key] = nil
  end
  for key, _ in pairs(self._finishedTaskList) do
    self._finishedTaskList[key] = nil
  end
end

function DM_ActivityTasks:OnSActivityTasks(protocol)
  self._allTaskList[protocol.activityID] = {}
  self._finishedTaskList[protocol.activityID] = {}
  for _, activityTask in pairs(protocol.activityTasks) do
    self:_HandleTask(protocol.activityID, activityTask)
  end
end

function DM_ActivityTasks:OnSRefreshActivityTask(protocol)
  self:_HandleTask(protocol.activityID, protocol.taskinfo)
end

function DM_ActivityTasks:_HandleTask(activityID, taskinfo)
  local task = Task.Create()
  task:InitFromProtocol(taskinfo)
  if self._allTaskList[activityID] == nil then
    self._allTaskList[activityID] = {}
    LogInfoFormat("DM_ActivityTasks", "AllTaskList No Exist ActivityTaskID", activityID)
  end
  if self._finishedTaskList[activityID] == nil then
    self._finishedTaskList[activityID] = {}
    LogInfoFormat("DM_ActivityTasks", "FinishedTaskList No Exist ActivityTaskID", activityID)
  end
  self._allTaskList[activityID][task:GetID()] = task
  if task:GetStatus() == TaskStatus.FINISHED then
    self._finishedTaskList[activityID][task:GetID()] = task
    if activityID == TasksProtocolDef.JIGSAW_PUZZLE or activityID == TasksProtocolDef.HALLOWEEN then
      LuaNotificationCenter.PostNotification(Common.n_RefreshActivityRewards, nil, nil)
    end
  else
    self._finishedTaskList[activityID][task:GetID()] = nil
  end
end

return DM_ActivityTasks
