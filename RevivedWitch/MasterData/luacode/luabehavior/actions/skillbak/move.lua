-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/skillbak/move.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local EMoveType = require("luabehavior.agent.emovetype")
local Utility = require("logic.battle.utility")
local Move = class("Move", Task)
Move.Ctor = function(self, context, moveType, distance, totalTime)
  -- function num : 0_0 , upvalues : Move
  ((Move.super).Ctor)(self)
  self._context = context
  self._moveType = moveType
  self._distance = distance / 1000
  self._time = 0
  self._totalTime = totalTime
  self._taskId = 0
end

Move.OnStart = function(self)
  -- function num : 0_1 , upvalues : EMoveType, Utility
  self._time = 0
  self._taskId = 0
  local skill = (self._context)._skill
  if self._moveType == EMoveType.MoveForward then
    self._taskId = (Utility.CreateMoveForwardTask)(skill:GetAttacker(), -self._distance)
  else
    if self._moveType == EMoveType.MoveBack then
      self._taskId = (Utility.CreateMoveBackTask)(skill:GetAttacker())
    else
      if self._moveType == EMoveType.MoveToTarget and skill:GetTarget(1) then
        self._taskId = (Utility.CreateMoveToTargetTask)(skill:GetAttacker(), skill:GetTarget(1))
      end
    end
  end
end

Move.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : Utility, Behavior_Status
  self._time = self._time + deltaTime
  if self._totalTime < self._time then
    self._time = self._totalTime
  end
  local skill = (self._context)._skill
  ;
  (Utility.UpdateMoveTask)(skill:GetAttacker(), self._taskId, self._time, self._totalTime)
  if self._time == self._totalTime then
    return Behavior_Status.Success
  else
    return Behavior_Status.Running
  end
end

Move.OnEnd = function(self)
  -- function num : 0_3 , upvalues : Utility
  if self._time ~= self._totalTime then
    (Utility.UpdateMoveTask)(((self._context)._skill):GetAttacker(), self._taskId, self._totalTime, self._totalTime)
  end
end

Move.GetCheckPoints = function(self)
  -- function num : 0_4
  return self._totalTime - self._time
end

return Move

