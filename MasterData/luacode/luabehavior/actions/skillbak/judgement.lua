local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local EJudgementType = require("luabehavior.agent.ejudgementtype")
local AttributeComponent = require("logic.battle.component.attributecomponent")
local Judgement = class("Judgement", Task)

function Judgement:Ctor(context, judgementType)
  Judgement.super.Ctor(self)
  self._context = context
  self._judgementType = judgementType
end

function Judgement:OnStart()
end

function Judgement:OnUpdate(deltaTime)
  local attacker = self._context._skill:GetAttacker()
  local attributeComponent = attacker:GetComponent(AttributeComponent)
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
    if attacker then
      return Behavior_Status.Success
    else
      return Behavior_Status.Failure
    end
  end
end

return Judgement
