local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local IsRoleInOtherSkill = class("IsRoleInOtherSkill", Task)

function IsRoleInOtherSkill:Ctor(context)
  IsRoleInOtherSkill.super.Ctor(self)
  self._entity = nil
  for i, e in ipairs(context._battleworld._entitys) do
    if e._entityId == context._entityId then
      self._entity = e
      break
    end
  end
end

function IsRoleInOtherSkill:OnStart()
end

function IsRoleInOtherSkill:OnUpdate(deltaTime)
  if self._entity then
    local AnimationEventComponent = BattleECS.Components.AnimationEventComponent
    if self._entity:GetComponent(AnimationEventComponent)._roleIsInSkill then
      return TaskStatus.Failure
    else
      return TaskStatus.Success
    end
  else
    return TaskStatus.Failure
  end
end

function IsRoleInOtherSkill:OnEnd()
end

return IsRoleInOtherSkill
