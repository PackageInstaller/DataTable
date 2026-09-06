local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local BattleStartFramesLessEqual = class("BattleStartFramesLessEqual", Task)

function BattleStartFramesLessEqual:Ctor(context, frames)
  BattleStartFramesLessEqual.super.Ctor(self)
  self._context = context
  self._frames = frames
end

function BattleStartFramesLessEqual:OnStart()
end

function BattleStartFramesLessEqual:OnUpdate(deltaTime)
  local frames = self._context._battleworld._battleWorldStartFrames
  if frames <= self._frames then
    return TaskStatus.Success
  else
    return TaskStatus.Failure
  end
end

function BattleStartFramesLessEqual:OnEnd()
end

return BattleStartFramesLessEqual
