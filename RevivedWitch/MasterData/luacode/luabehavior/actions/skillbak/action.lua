-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/skillbak/action.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local EActionType = require("luabehavior.agent.eactiontype")
local AnimaitonComponent = require("logic.battle.component.animaitoncomponent")
local Action = class("Action", Task)
Action.Ctor = function(self, context, actionType, actionName)
  -- function num : 0_0 , upvalues : Action, EActionType
  ((Action.super).Ctor)(self)
  self._context = context
  self._actionType = actionType
  self._actionName = actionName
  self._time = 0
  if actionType == EActionType.PlayAction then
    self._totalTime = 200
  else
    if actionType == EActionType.PlayInstantAction then
      self._totalTime = 0
    end
  end
end

Action.OnStart = function(self)
  -- function num : 0_1 , upvalues : AnimaitonComponent
  local skill = (self._context)._skill
  local animaitonComponent = (skill:GetAttacker()):GetComponent(AnimaitonComponent)
  animaitonComponent._needRefresh = true
  animaitonComponent._animationName = self._actionName
  self._time = 0
end

Action.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : Behavior_Status
  self._time = self._time + deltaTime
  if self._totalTime <= self._time then
    self._time = self._totalTime
    return Behavior_Status.Success
  end
  return Behavior_Status.Running
end

Action.GetCheckPoints = function(self)
  -- function num : 0_3
  return self._totalTime - self._time
end

return Action

