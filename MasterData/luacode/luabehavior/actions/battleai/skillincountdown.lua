local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local SkillInCountDown = class("SkillInCountDown", Task)

function SkillInCountDown:Ctor(context)
  SkillInCountDown.super.Ctor(self)
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

function SkillInCountDown:OnStart()
end

function SkillInCountDown:OnUpdate(deltaTime)
  if self._entity then
    local isCd, skill = self._utility.IsInCD(self._entity, self._context._behaviorSkillList)
    if not isCd then
      local TypeComponent = BattleECS.Components.TypeComponent
      if self._utility.IsAttackSkill(skill) then
        if self._entity:GetComponent(TypeComponent)._isImaged then
          self._utility.SetSkillID(self._entity, skill)
        elseif not self._buffUtility.IsRoleHasCanNotAttackSkillBuff(self._entity) then
          self._utility.SetSkillID(self._entity, skill)
        else
          self._utility.ClearSkillCurrentTime(self._entity, skill)
        end
      elseif not self._entity:GetComponent(TypeComponent)._isImaged then
        self._utility.SetSkillID(self._entity, skill)
      else
        self._utility.ClearSkillCurrentTime(self._entity, skill)
      end
    end
  end
  return TaskStatus.Failure
end

function SkillInCountDown:OnEnd()
end

return SkillInCountDown
