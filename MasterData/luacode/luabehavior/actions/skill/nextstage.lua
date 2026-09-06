local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local Logic_SkillSystem = require("logic.battle.system.logic.skillsystem")
local NextStage = class("NextStage", Task)

function NextStage:Ctor(context)
  NextStage.super.Ctor(self)
  self._context = context
end

function NextStage:OnUpdate(deltaTime)
  if self._context._world:GetSystem(Logic_SkillSystem):CalculateTarget(self._context._attacker._entityId) then
    return TaskStatus.Success
  end
  return TaskStatus.Failure
end

return NextStage
