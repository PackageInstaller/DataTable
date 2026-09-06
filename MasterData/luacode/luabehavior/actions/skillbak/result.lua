local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local EResultType = require("luabehavior.agent.eresulttype")
local Result = class("Result", Task)

function Result:Ctor(context, resultType)
  Result.super.Ctor(self)
  self._context = context
  self._resultType = resultType
end

function Result:OnUpdate(deltaTime)
  self._context._skill:CalculateResult()
  return Behavior_Status.Success
end

return Result
