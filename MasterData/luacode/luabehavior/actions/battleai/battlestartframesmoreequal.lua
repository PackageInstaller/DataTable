local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local BattleStartFramesMoreEqual = class("BattleStartFramesMoreEqual", Task)

function BattleStartFramesMoreEqual:Ctor(context, frames)
  BattleStartFramesMoreEqual.super.Ctor(self)
  self._context = context
  self._frames = frames
end

function BattleStartFramesMoreEqual:OnStart()
end

function BattleStartFramesMoreEqual:OnUpdate(deltaTime)
  local frames = self._context._battleworld._battleWorldStartFrames
  if frames >= self._frames then
    return TaskStatus.Success
  else
    return TaskStatus.Failure
  end
end

function BattleStartFramesMoreEqual:OnEnd()
end

return BattleStartFramesMoreEqual
