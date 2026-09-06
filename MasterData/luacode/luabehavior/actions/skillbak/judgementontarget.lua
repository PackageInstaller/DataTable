local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local EJudgementType = require("luabehavior.agent.ejudgementtype")
local AttributeComponent = require("logic.battle.component.attributecomponent")
local JudgementOnTarget = class("JudgementOnTarget", Task)

function JudgementOnTarget:Ctor(context, index, judgementType)
  JudgementOnTarget.super.Ctor(self)
  self._context = context
  self._index = index
  self._judgementType = judgementType
end

function JudgementOnTarget:OnStart()
end

function JudgementOnTarget:OnUpdate(deltaTime)
  local target = self._context._skill:GetTarget(self._index)
  if target then
    local attributeComponent = target:GetComponent(AttributeComponent)
    if self._judgementType == EJudgementType.TargetDead then
      if attributeComponent._hp > 0 then
        return Behavior_Status.Failure
      else
        return Behavior_Status.Success
      end
    elseif self._judgementType == EJudgementType.TargetDisappear then
      if attributeComponent._deadtype == 2 then
        return Behavior_Status.Success
      else
        return Behavior_Status.Failure
      end
    elseif self._judgementType == EJudgementType.BattlerExist then
      return Behavior_Status.Success
    end
  else
    if self._judgementType == EJudgementType.BattlerExist then
      return Behavior_Status.Failure
    end
    return Behavior_Status.Success
  end
end

return JudgementOnTarget
