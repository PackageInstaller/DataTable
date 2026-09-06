local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local IfHasEnoughConditionsUseSkill = class("IfHasEnoughConditionsUseSkill", Task)

function IfHasEnoughConditionsUseSkill:Ctor(context)
  IfHasEnoughConditionsUseSkill.super.Ctor(self)
  self._battleworld = context._battleworld
  self._entity = nil
  for i, e in ipairs(self._battleworld._entitys) do
    if e._entityId == context._entityId then
      self._entity = e
      break
    end
  end
  self._buffUtility = BattleECS.Utility.BuffUtility
  self._utility = BattleECS.Utility.Utility
end

function IfHasEnoughConditionsUseSkill:OnStart()
end

function IfHasEnoughConditionsUseSkill:OnUpdate(deltaTime)
  if self._entity then
    local effectType = {
      AttackSkill = 1,
      UseSkill = 2,
      Both = 3
    }
    if self._buffUtility.IsRoleHasCanNotUseSkillBuff(self._entity, effectType.Both, 0) then
      return TaskStatus.Failure
    end
    local AnimationEventComponent = BattleECS.Components.AnimationEventComponent
    if self._battleworld:GetCampWinState() == "" then
      if not self._utility.IsRoleDead(self._entity) then
        if not self._entity:GetComponent(AnimationEventComponent)._roleIsInSkill then
          if self._utility.IsToTargetXPoint(self._entity) then
            return TaskStatus.Success
          else
            return TaskStatus.Failure
          end
        else
          return TaskStatus.Failure
        end
      else
        return TaskStatus.Failure
      end
    else
      return TaskStatus.Failure
    end
  else
    return TaskStatus.Failure
  end
end

function IfHasEnoughConditionsUseSkill:OnEnd()
end

return IfHasEnoughConditionsUseSkill
