local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local MonsterSkillTimeDelay = class("MonsterSkillTimeDelay", Task)

function MonsterSkillTimeDelay:Ctor(context, deltaTimeDown, deltaTimeUp)
  MonsterSkillTimeDelay.super.Ctor(self)
  self._context = context
  if deltaTimeUp == deltaTimeDown then
    self._delayTime = deltaTimeDown
  else
    self._delayTime = self._context._battleworld._randomPcg(deltaTimeDown, deltaTimeUp)
  end
  self._countIndex = 0
  self._entity = nil
  for i, e in ipairs(self._context._battleworld._entitys) do
    if e._entityId == self._context._entityId then
      self._entity = e
      break
    end
  end
  self._utility = BattleECS.Utility.Utility
end

function MonsterSkillTimeDelay:OnStart()
end

function MonsterSkillTimeDelay:OnUpdate(deltaTime)
  self._countIndex = self._countIndex + 1
  if self._countIndex >= self._delayTime then
    return TaskStatus.Success
  end
  self._utility.ClearEntityAllSkillCurrentTime(self._entity)
  return TaskStatus.Failure
end

function MonsterSkillTimeDelay:OnEnd()
end

return MonsterSkillTimeDelay
