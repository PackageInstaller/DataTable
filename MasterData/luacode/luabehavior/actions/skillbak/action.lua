local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local EActionType = require("luabehavior.agent.eactiontype")
local AnimaitonComponent = require("logic.battle.component.animaitoncomponent")
local Action = class("Action", Task)

function Action:Ctor(context, actionType, actionName)
  Action.super.Ctor(self)
  self._context = context
  self._actionType = actionType
  self._actionName = actionName
  self._time = 0
  if actionType == EActionType.PlayAction then
    self._totalTime = 200
  elseif actionType == EActionType.PlayInstantAction then
    self._totalTime = 0
  end
end

function Action:OnStart()
  local skill = self._context._skill
  local animaitonComponent = skill:GetAttacker():GetComponent(AnimaitonComponent)
  animaitonComponent._needRefresh = true
  animaitonComponent._animationName = self._actionName
  self._time = 0
end

function Action:OnUpdate(deltaTime)
  self._time = self._time + deltaTime
  if self._time >= self._totalTime then
    self._time = self._totalTime
    return Behavior_Status.Success
  end
  return Behavior_Status.Running
end

function Action:GetCheckPoints()
  return self._totalTime - self._time
end

return Action
