local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local UseSkill = class("UseSkill", Task)

function UseSkill:Ctor(context, skillid)
  UseSkill.super.Ctor(self)
  self._skillID = skillid
  self._entity = nil
  for i, e in ipairs(context._battleworld._entitys) do
    if e._entityId == context._entityId then
      self._entity = e
      break
    end
  end
  self._battleWorld = context._battleworld
  self._utility = BattleECS.Utility.Utility
end

function UseSkill:OnStart()
end

function UseSkill:OnUpdate(deltaTime)
  if self._entity then
    local hittedEntityList = self._utility.GetSkillEffectEntity(self._skillID, self._entity._entityId, self._battleWorld)
    if #hittedEntityList ~= 0 then
      LogInfo("技能id.....", self._skillID)
      self._utility.SetSkillID(self._entity, self._skillID)
      return TaskStatus.Success
    else
      return TaskStatus.Failure
    end
  end
  return TaskStatus.Success
end

function UseSkill:OnEnd()
end

return UseSkill
