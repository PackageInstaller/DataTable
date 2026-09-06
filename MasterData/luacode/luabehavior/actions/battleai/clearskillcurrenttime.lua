local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local ClearSkillCurrentTime = class("ClearSkillCurrentTime", Task)

function ClearSkillCurrentTime:Ctor(context, skillid)
  ClearSkillCurrentTime.super.Ctor(self)
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
end

function ClearSkillCurrentTime:OnStart()
end

function ClearSkillCurrentTime:OnUpdate(deltaTime)
  if self._entity then
    self._utility.ClearSkillCurrentTime(self._entity, self._skillID)
  end
  return TaskStatus.Success
end

function ClearSkillCurrentTime:OnEnd()
end

return ClearSkillCurrentTime
