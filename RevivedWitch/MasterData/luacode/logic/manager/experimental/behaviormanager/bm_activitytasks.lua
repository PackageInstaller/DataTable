-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_activitytasks.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskStatus = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local TasksProtocolDef = (LuaNetManager.GetProtocolDef)("protocol.task.cactivitytasks")
local BM_ActivityTasks = class("BM_ActivityTasks")
BM_ActivityTasks.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._allTaskList = ((NekoData.Data).activityTasks).allTaskList
  self._finishedTaskList = ((NekoData.Data).activityTasks).finishedTaskList
end

BM_ActivityTasks.GetTasks = function(self, activityID)
  -- function num : 0_1
  return (self._allTaskList)[activityID]
end

BM_ActivityTasks.HaveFinishedTask = function(self, activityID)
  -- function num : 0_2 , upvalues : _ENV
  do return not (self._finishedTaskList)[activityID] or next((self._finishedTaskList)[activityID]) ~= nil end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

BM_ActivityTasks.HandleTask = function(self, task)
  -- function num : 0_3 , upvalues : _ENV
  local type = task:GetJumpType()
  if type > 0 then
    local handler = require("logic.task.taskhandlers." .. type)
    if handler then
      handler:Handle(task:GetConfig())
    end
  else
    do
      if type == -1 then
        ((DialogManager.CreateSingletonDialog)("chat.guidecommentdialog")):SetData(3)
      end
    end
  end
end

BM_ActivityTasks.GetSevenDaysTasks = function(self)
  -- function num : 0_4 , upvalues : TasksProtocolDef
  return self:GetTasks(TasksProtocolDef.SEVEN_DAYS)
end

BM_ActivityTasks.GetPuzzleTasks = function(self)
  -- function num : 0_5 , upvalues : TasksProtocolDef
  if not self:GetTasks(TasksProtocolDef.JIGSAW_PUZZLE) then
    return {}
  end
end

BM_ActivityTasks.GetHalloweenTasks = function(self)
  -- function num : 0_6 , upvalues : TasksProtocolDef
  return self:GetTasks(TasksProtocolDef.HALLOWEEN)
end

BM_ActivityTasks.GetChildrenTasks = function(self)
  -- function num : 0_7 , upvalues : TasksProtocolDef
  return self:GetTasks(TasksProtocolDef.CHILDREN_DAY)
end

BM_ActivityTasks.GetDoubleElevenTasks = function(self)
  -- function num : 0_8 , upvalues : TasksProtocolDef
  return self:GetTasks(TasksProtocolDef.DOUBLE_ELEVEN)
end

BM_ActivityTasks.GetBirthDayTasks = function(self)
  -- function num : 0_9 , upvalues : TasksProtocolDef
  return self:GetTasks(TasksProtocolDef.BIRTH_DAY)
end

BM_ActivityTasks.GetReturnBackPlayerTasks = function(self)
  -- function num : 0_10 , upvalues : TasksProtocolDef
  return self:GetTasks(TasksProtocolDef.BACK_PLAYER)
end

BM_ActivityTasks.GetSanniversaryDrawTasks = function(self)
  -- function num : 0_11 , upvalues : TasksProtocolDef
  return self:GetTasks(TasksProtocolDef.ANNIVERSARY_DRAW)
end

BM_ActivityTasks.SevenDaysShowRedDot = function(self)
  -- function num : 0_12 , upvalues : TasksProtocolDef
  return self:HaveFinishedTask(TasksProtocolDef.SEVEN_DAYS)
end

BM_ActivityTasks.PuzzleShowRedDot = function(self)
  -- function num : 0_13 , upvalues : TasksProtocolDef
  return self:HaveFinishedTask(TasksProtocolDef.JIGSAW_PUZZLE)
end

BM_ActivityTasks.HalloweenShowRedDot = function(self)
  -- function num : 0_14 , upvalues : TasksProtocolDef
  return self:HaveFinishedTask(TasksProtocolDef.HALLOWEEN)
end

BM_ActivityTasks.DoubleElevenRedDot = function(self)
  -- function num : 0_15 , upvalues : TasksProtocolDef
  return self:HaveFinishedTask(TasksProtocolDef.DOUBLE_ELEVEN)
end

BM_ActivityTasks.ReturnWelfareTaskRedDot = function(self)
  -- function num : 0_16 , upvalues : TasksProtocolDef
  return self:HaveFinishedTask(TasksProtocolDef.BACK_PLAYER)
end

BM_ActivityTasks.AnniversaryDrawTasksRedDot = function(self)
  -- function num : 0_17 , upvalues : TasksProtocolDef
  return self:HaveFinishedTask(TasksProtocolDef.ANNIVERSARY_DRAW)
end

BM_ActivityTasks.BirthDayShowRedDot = function(self)
  -- function num : 0_18
  return false
end

return BM_ActivityTasks

