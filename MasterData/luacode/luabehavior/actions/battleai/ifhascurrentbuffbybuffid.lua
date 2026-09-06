local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local IfHasCurrentBuffByBuffID = class("IfHasCurrentBuffByBuffID", Task)

function IfHasCurrentBuffByBuffID:Ctor(context, buffid)
  IfHasCurrentBuffByBuffID.super.Ctor(self)
  self._context = context
  self._buffID = buffid
  self._entity = nil
  for i, e in ipairs(self._context._battleworld._entitys) do
    if e._entityId == self._context._entityId then
      self._entity = e
      break
    end
  end
  self._buffUtility = BattleECS.Utility.BuffUtility
end

function IfHasCurrentBuffByBuffID:OnStart()
end

function IfHasCurrentBuffByBuffID:OnUpdate(deltaTime)
  if self._entity then
    if self._buffUtility.IsHasCurrentBuff(self._entity, self._buffID) then
      return TaskStatus.Success
    else
      return TaskStatus.Failure
    end
  else
    return TaskStatus.Failure
  end
end

function IfHasCurrentBuffByBuffID:OnEnd()
end

return IfHasCurrentBuffByBuffID
