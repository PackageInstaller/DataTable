local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local MonsterSkillIsInCD = class("MonsterSkillIsInCD", Task)

function MonsterSkillIsInCD:Ctor(context, skillid)
  MonsterSkillIsInCD.super.Ctor(self)
  self._context = context
  self._skillID = skillid
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

function MonsterSkillIsInCD:OnStart()
end

function MonsterSkillIsInCD:OnUpdate(deltaTime)
  if self._entity then
    local effectType = {
      AttackSkill = 1,
      UseSkill = 2,
      Both = 3
    }
    if self._buffUtility.IsRoleHasCanNotUseSkillBuff(self._entity, effectType.Both, self._skillID) then
      return TaskStatus.Failure
    end
    if self._utility.IsMonsterSkillInCD(self._entity, self._skillID) then
      return TaskStatus.Failure
    else
      return TaskStatus.Success
    end
  else
    return TaskStatus.Failure
  end
end

function MonsterSkillIsInCD:OnEnd()
end

return MonsterSkillIsInCD
