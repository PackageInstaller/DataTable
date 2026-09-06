local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local MonsterCurrentHpMoreEqualNumber = class("MonsterCurrentHpMoreEqualNumber", Task)

function MonsterCurrentHpMoreEqualNumber:Ctor(context, hp)
  MonsterCurrentHpMoreEqualNumber.super.Ctor(self)
  self._hpNum = hp
  local entity
  for i, e in ipairs(context._battleworld._entitys) do
    if e._entityId == context._entityId then
      entity = e
      break
    end
  end
  if entity then
    self._hpComponent = entity:GetComponent(BattleECS.Components.HpComponent)
  end
end

function MonsterCurrentHpMoreEqualNumber:OnStart()
end

function MonsterCurrentHpMoreEqualNumber:OnUpdate(deltaTime)
  if self._hpComponent then
    if self._hpComponent._currentHp >= self._hpNum then
      return TaskStatus.Success
    else
      return TaskStatus.Failure
    end
  else
    return TaskStatus.Failure
  end
  return TaskStatus.Failure
end

function MonsterCurrentHpMoreEqualNumber:OnEnd()
end

return MonsterCurrentHpMoreEqualNumber
