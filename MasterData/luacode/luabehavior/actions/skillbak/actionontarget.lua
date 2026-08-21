-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/skillbak/actionontarget.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local EActionType = require("luabehavior.agent.eactiontype")
local AnimaitonComponent = require("logic.battle.component.animaitoncomponent")
local ActionOnTarget = class("ActionOnTarget", Task)
ActionOnTarget.Ctor = function(self, context, index, actionType, actionName)
  -- function num : 0_0 , upvalues : ActionOnTarget, EActionType
  ((ActionOnTarget.super).Ctor)(self)
  self._context = context
  self._index = index
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

ActionOnTarget.OnStart = function(self)
  -- function num : 0_1 , upvalues : AnimaitonComponent
  self._time = 0
  local skill = (self._context)._skill
  if skill:GetTarget(self._index) then
    local animaitonComponent = (skill:GetTarget(self._index)):GetComponent(AnimaitonComponent)
    animaitonComponent._needRefresh = true
    animaitonComponent._animationName = self._actionName
  end
end

ActionOnTarget.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : Behavior_Status
  self._time = self._time + deltaTime
  if self._totalTime <= self._time then
    self._time = self._totalTime
    return Behavior_Status.Success
  end
  return Behavior_Status.Running
end

ActionOnTarget.GetCheckPoints = function(self)
  -- function num : 0_3
  return self._totalTime - self._time
end

return ActionOnTarget

