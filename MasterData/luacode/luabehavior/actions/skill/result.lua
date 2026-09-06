local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local Logic_SkillSystem = require("logic.battle.system.logic.skillsystem")
local Result = class("Result", Task)

function Result:Ctor(context, stageNum)
  Result.super.Ctor(self)
  self._context = context
  self._stageNum = stageNum
end

function Result:OnUpdate(deltaTime)
  self._context._world:GetSystem(Logic_SkillSystem):CalculateResult(self._context._attacker._entityId)
  return TaskStatus.Success
end

return Result
