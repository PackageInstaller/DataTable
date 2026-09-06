local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local ECameraMoveType = require("luabehavior.agent.ecameramovetype")
local BattlerPositionComponent = require("logic.battle.component.battlerpositioncomponent")
local CameraStateComponent = require("logic.battle.component.camerastatecomponent")
local ChangeCamera = class("ChangeCamera", Task)

function ChangeCamera:Ctor(context, cameraMoveType)
  ChangeCamera.super.Ctor(self)
  self._context = context
  self._cameraMoveType = cameraMoveType
end

function ChangeCamera:OnStart()
  local battlerPositionComponent = self._context._skill:GetAttacker():GetComponent(BattlerPositionComponent)
  local cameraStateComponent = self._context._battleScene:GetComponent(CameraStateComponent)
  cameraStateComponent._needRefresh = true
  if battlerPositionComponent._orientation < 0 then
    if self._cameraMoveType == ECameraMoveType.CameraReset then
      cameraStateComponent._currentState = "Normal"
    elseif self._cameraMoveType == ECameraMoveType.ShowSkillHit1 then
      cameraStateComponent._currentState = "Skill1Right"
    elseif self._cameraMoveType == ECameraMoveType.MoveToSelf then
      cameraStateComponent._currentState = "Left"
    elseif self._cameraMoveType == ECameraMoveType.MoveToEnemy then
      cameraStateComponent._currentState = "Right"
    end
  elseif self._cameraMoveType == ECameraMoveType.CameraReset then
    cameraStateComponent._currentState = "Normal"
  elseif self._cameraMoveType == ECameraMoveType.ShowSkillHit1 then
    cameraStateComponent._currentState = "Skill1Left"
  elseif self._cameraMoveType == ECameraMoveType.MoveToSelf then
    cameraStateComponent._currentState = "Right"
  elseif self._cameraMoveType == ECameraMoveType.MoveToEnemy then
    cameraStateComponent._currentState = "Left"
  end
end

function ChangeCamera:OnUpdate(deltaTime)
  return Behavior_Status.Success
end

return ChangeCamera
