local TaskStatus = LuaNetManager.CreateBean("protocol.task.taskstatus")
local TasksProtocolDef = LuaNetManager.GetProtocolDef("protocol.task.cactivitytasks")
local BM_ActivityTasks = class("BM_ActivityTasks")

function BM_ActivityTasks:Ctor()
  self._allTaskList = NekoData.Data.activityTasks.allTaskList
  self._finishedTaskList = NekoData.Data.activityTasks.finishedTaskList
end

function BM_ActivityTasks:GetTasks(activityID)
  return self._allTaskList[activityID]
end

function BM_ActivityTasks:HaveFinishedTask(activityID)
  return self._finishedTaskList[activityID] and next(self._finishedTaskList[activityID]) ~= nil
end

function BM_ActivityTasks:HandleTask(task)
  local type = task:GetJumpType()
  if 0 < type then
    local handler = require("logic.task.taskhandlers." .. type)
    if handler then
      handler:Handle(task:GetConfig())
    end
  elseif type == -1 then
    DialogManager.CreateSingletonDialog("chat.guidecommentdialog"):SetData(3)
  end
end

function BM_ActivityTasks:GetSevenDaysTasks()
  return self:GetTasks(TasksProtocolDef.SEVEN_DAYS)
end

function BM_ActivityTasks:GetPuzzleTasks()
  return self:GetTasks(TasksProtocolDef.JIGSAW_PUZZLE) or {}
end

function BM_ActivityTasks:GetHalloweenTasks()
  return self:GetTasks(TasksProtocolDef.HALLOWEEN)
end

function BM_ActivityTasks:GetChildrenTasks()
  return self:GetTasks(TasksProtocolDef.CHILDREN_DAY)
end

function BM_ActivityTasks:GetDoubleElevenTasks()
  return self:GetTasks(TasksProtocolDef.DOUBLE_ELEVEN)
end

function BM_ActivityTasks:GetBirthDayTasks()
  return self:GetTasks(TasksProtocolDef.BIRTH_DAY)
end

function BM_ActivityTasks:GetReturnBackPlayerTasks()
  return self:GetTasks(TasksProtocolDef.BACK_PLAYER)
end

function BM_ActivityTasks:GetSanniversaryDrawTasks()
  return self:GetTasks(TasksProtocolDef.ANNIVERSARY_DRAW)
end

function BM_ActivityTasks:SevenDaysShowRedDot()
  return self:HaveFinishedTask(TasksProtocolDef.SEVEN_DAYS)
end

function BM_ActivityTasks:PuzzleShowRedDot()
  return self:HaveFinishedTask(TasksProtocolDef.JIGSAW_PUZZLE)
end

function BM_ActivityTasks:HalloweenShowRedDot()
  return self:HaveFinishedTask(TasksProtocolDef.HALLOWEEN)
end

function BM_ActivityTasks:DoubleElevenRedDot()
  return self:HaveFinishedTask(TasksProtocolDef.DOUBLE_ELEVEN)
end

function BM_ActivityTasks:ReturnWelfareTaskRedDot()
  return self:HaveFinishedTask(TasksProtocolDef.BACK_PLAYER)
end

function BM_ActivityTasks:AnniversaryDrawTasksRedDot()
  return self:HaveFinishedTask(TasksProtocolDef.ANNIVERSARY_DRAW)
end

function BM_ActivityTasks:BirthDayShowRedDot()
  return false
end

return BM_ActivityTasks
