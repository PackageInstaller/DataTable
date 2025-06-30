-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/skill/playattackeraction.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local AnimaitonUtility = require("logic.battle.utility.animaitonutility")
local PlayAttackerAction = class("PlayAttackerAction", Task)
PlayAttackerAction.Ctor = function(self, context, actionName)
  -- function num : 0_0 , upvalues : PlayAttackerAction
  ((PlayAttackerAction.super).Ctor)(self)
  self._context = context
  self._actionName = actionName
  self._time = 0
  self._totalTime = 200
end

PlayAttackerAction.OnStart = function(self)
  -- function num : 0_1 , upvalues : AnimaitonUtility
  self._time = 0
  ;
  (AnimaitonUtility.PlayAnimaiton)((self._context)._world, ((self._context)._attacker)._entityId, self._actionName)
end

PlayAttackerAction.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : TaskStatus
  self._time = self._time + deltaTime
  if self._totalTime <= self._time then
    self._time = self._totalTime
    return TaskStatus.Success
  end
  return TaskStatus.Running
end

PlayAttackerAction.GetCheckPoints = function(self)
  -- function num : 0_3
  return self._totalTime - self._time
end

return PlayAttackerAction

