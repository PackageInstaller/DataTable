-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/cameraanimation.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local CameraAnimation = class("CameraAnimation", Task)
CameraAnimation.Ctor = function(self, context, paraNum, delayTime)
  -- function num : 0_0 , upvalues : CameraAnimation, _ENV
  ((CameraAnimation.super).Ctor)(self)
  self._battleWorld = context._battleworld
  self._paraNum = tonumber(paraNum)
  self._delayTime = delayTime
  self._protocolUtility = (BattleECS.Utility).ProtocolUtility
end

CameraAnimation.OnStart = function(self)
  -- function num : 0_1
end

CameraAnimation.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : TaskStatus
  ((self._protocolUtility).SendPlayBattleCameraAnimationName)(self._paraNum, self._delayTime, -1, 0, self._battleWorld)
  return TaskStatus.Success
end

CameraAnimation.OnEnd = function(self)
  -- function num : 0_3
end

return CameraAnimation

