local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local IsHighestElementDamege = class("IsHighestElementDamege", Task)

function IsHighestElementDamege:Ctor(context, elementType)
  IsHighestElementDamege.super.Ctor(self)
  self._entity = nil
  self._elementType = elementType
  for i, e in ipairs(context._battleworld._entitys) do
    if e._entityId == context._entityId then
      self._entity = e
      break
    end
  end
  self._utility = BattleECS.Utility.Utility
end

function IsHighestElementDamege:OnStart()
end

function IsHighestElementDamege:OnUpdate(deltaTime)
  if self._utility.IsEntityHighestElementDamage(self._entity, self._elementType) then
    return TaskStatus.Success
  end
  return TaskStatus.Failure
end

function IsHighestElementDamege:OnEnd()
end

return IsHighestElementDamege
