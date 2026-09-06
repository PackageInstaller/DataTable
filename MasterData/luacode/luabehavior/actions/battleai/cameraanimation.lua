local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local CameraAnimation = class("CameraAnimation", Task)

function CameraAnimation:Ctor(context, paraNum, delayTime)
  CameraAnimation.super.Ctor(self)
  self._battleWorld = context._battleworld
  self._paraNum = tonumber(paraNum)
  self._delayTime = delayTime
  self._protocolUtility = BattleECS.Utility.ProtocolUtility
end

function CameraAnimation:OnStart()
end

function CameraAnimation:OnUpdate(deltaTime)
  self._protocolUtility.SendPlayBattleCameraAnimationName(self._paraNum, self._delayTime, -1, 0, self._battleWorld)
  return TaskStatus.Success
end

function CameraAnimation:OnEnd()
end

return CameraAnimation
