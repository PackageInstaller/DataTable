local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local ChangeName = class("ChangeName", Task)

function ChangeName:Ctor(context, nameid)
  ChangeName.super.Ctor(self)
  self._context = context
  self._nameId = nameid
  self._protocolUtility = BattleECS.Utility.ProtocolUtility
end

function ChangeName:OnStart()
end

function ChangeName:OnUpdate(deltaTime)
  self._protocolUtility.ChangeEntityNameTextId(self._context._entityId, self._nameId, self._context._battleworld)
  return TaskStatus.Success
end

function ChangeName:OnEnd()
end

return ChangeName
