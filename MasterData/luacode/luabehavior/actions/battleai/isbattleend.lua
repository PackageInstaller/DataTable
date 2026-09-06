local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local IsBattleEnd = class("IsBattleEnd", Task)

function IsBattleEnd:Ctor(context)
  IsBattleEnd.super.Ctor(self)
  self._context = context
end

function IsBattleEnd:OnStart()
end

function IsBattleEnd:OnUpdate(deltaTime)
  if self._context._battleworld:GetCampWinState() ~= "" then
    return TaskStatus.Failure
  else
    return TaskStatus.Success
  end
end

function IsBattleEnd:OnEnd()
end

return IsBattleEnd
