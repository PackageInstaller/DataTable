local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local MonsterCurrentHpLessEqualNumber = class("MonsterCurrentHpLessEqualNumber", Task)

function MonsterCurrentHpLessEqualNumber:Ctor(context, hp)
  MonsterCurrentHpLessEqualNumber.super.Ctor(self)
  self._hpNum = hp
  local entity
  for i, e in ipairs(context._battleworld._entitys) do
    if e._entityId == context._entityId then
      entity = e
      break
    end
  end
  if entity then
    self._HpComponnet = entity:GetComponent(BattleECS.Components.HpComponent)
  end
end

function MonsterCurrentHpLessEqualNumber:OnStart()
end

function MonsterCurrentHpLessEqualNumber:OnUpdate(deltaTime)
  if self._HpComponnet then
    if self._HpComponnet._currentHp <= self._hpNum then
      return TaskStatus.Success
    else
      return TaskStatus.Failure
    end
  else
    return TaskStatus.Failure
  end
  return TaskStatus.Failure
end

function MonsterCurrentHpLessEqualNumber:OnEnd()
end

return MonsterCurrentHpLessEqualNumber
