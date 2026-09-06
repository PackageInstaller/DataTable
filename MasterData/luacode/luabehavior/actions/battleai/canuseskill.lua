local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local CanUseSkill = class("CanUseSkill", Task)

function CanUseSkill:Ctor(context)
  CanUseSkill.super.Ctor(self)
  self._context = context
  self._entity = nil
  for i, e in ipairs(self._context._battleworld._entitys) do
    if e._entityId == self._context._entityId then
      self._entity = e
      break
    end
  end
  self._utility = BattleECS.Utility.Utility
  self._buffUtility = BattleECS.Utility.BuffUtility
end

function CanUseSkill:OnStart()
end

function CanUseSkill:OnUpdate(deltaTime)
  if self._context._battleworld:GetCampWinState() ~= "" then
    return
  end
  if self._entity then
    local TypeComponent = BattleECS.Components.TypeComponent
    local AnimationEventComponent = BattleECS.Components.AnimationEventComponent
    if self._entity:GetComponent(TypeComponent)._summonName == "partner" then
      return TaskStatus.Success
    end
    if self._entity:GetComponent(TypeComponent)._isImaged then
      return TaskStatus.Success
    elseif not self._utility.IsRoleDead(self._entity) then
      if self._utility.IsToTargetXPoint(self._entity) then
        if not self._entity:GetComponent(AnimationEventComponent)._roleIsInSkill then
          local effectType = {
            AttackSkill = 1,
            UseSkill = 2,
            Both = 3
          }
          if not self._buffUtility.IsRoleHasCanNotUseSkillBuff(self._entity, effectType.AttackSkill) then
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
  end
  return TaskStatus.Failure
end

function CanUseSkill:OnEnd()
end

return CanUseSkill
