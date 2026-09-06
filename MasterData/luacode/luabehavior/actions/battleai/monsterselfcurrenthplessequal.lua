local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local MonsterSelfCurrentHPLessEqual = class("MonsterSelfCurrentHPLessEqual", Task)

function MonsterSelfCurrentHPLessEqual:Ctor(context, hpPercent)
  MonsterSelfCurrentHPLessEqual.super.Ctor(self)
  self._context = context
  self._hpPercent = fixedpoint(hpPercent)
  self._entity = nil
  for i, e in ipairs(self._context._battleworld._entitys) do
    if e._entityId == self._context._entityId then
      self._entity = e
      break
    end
  end
end

function MonsterSelfCurrentHPLessEqual:OnStart()
end

function MonsterSelfCurrentHPLessEqual:OnUpdate(deltaTime)
  if self._entity then
    local HpComponent = BattleECS.Components.HpComponent
    local hpComponent = self._entity:GetComponent(HpComponent)
    if hpComponent then
      if hpComponent._currentHp <= hpComponent._maxHp * (self._hpPercent / 100) then
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
end

function MonsterSelfCurrentHPLessEqual:OnEnd()
end

return MonsterSelfCurrentHPLessEqual
