local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local IsRoleDead = class("IsRoleDead", Task)

function IsRoleDead:Ctor(context)
  IsRoleDead.super.Ctor(self)
  self._entity = nil
  for i, e in ipairs(context._battleworld._entitys) do
    if e._entityId == context._entityId then
      self._entity = e
      break
    end
  end
  self._utility = BattleECS.Utility.Utility
end

function IsRoleDead:OnStart()
end

function IsRoleDead:OnUpdate(deltaTime)
  if self._entity then
    if self._utility.IsRoleDead(self._entity) then
      return TaskStatus.Failure
    else
      return TaskStatus.Success
    end
  else
    return TaskStatus.Failure
  end
end

function IsRoleDead:OnEnd()
end

return IsRoleDead
