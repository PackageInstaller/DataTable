local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local EActionType = require("luabehavior.agent.eactiontype")
local AnimaitonComponent = require("logic.battle.component.animaitoncomponent")
local ActionOnTarget = class("ActionOnTarget", Task)

function ActionOnTarget:Ctor(context, index, actionType, actionName)
  ActionOnTarget.super.Ctor(self)
  self._context = context
  self._index = index
  self._actionType = actionType
  self._actionName = actionName
  self._time = 0
  if actionType == EActionType.PlayAction then
    self._totalTime = 200
  elseif actionType == EActionType.PlayInstantAction then
    self._totalTime = 0
  end
end

function ActionOnTarget:OnStart()
  self._time = 0
  local skill = self._context._skill
  if skill:GetTarget(self._index) then
    local animaitonComponent = skill:GetTarget(self._index):GetComponent(AnimaitonComponent)
    animaitonComponent._needRefresh = true
    animaitonComponent._animationName = self._actionName
  end
end

function ActionOnTarget:OnUpdate(deltaTime)
  self._time = self._time + deltaTime
  if self._time >= self._totalTime then
    self._time = self._totalTime
    return Behavior_Status.Success
  end
  return Behavior_Status.Running
end

function ActionOnTarget:GetCheckPoints()
  return self._totalTime - self._time
end

return ActionOnTarget
