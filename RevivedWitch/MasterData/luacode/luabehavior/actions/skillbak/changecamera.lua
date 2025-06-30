-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/skillbak/changecamera.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local ECameraMoveType = require("luabehavior.agent.ecameramovetype")
local BattlerPositionComponent = require("logic.battle.component.battlerpositioncomponent")
local CameraStateComponent = require("logic.battle.component.camerastatecomponent")
local ChangeCamera = class("ChangeCamera", Task)
ChangeCamera.Ctor = function(self, context, cameraMoveType)
  -- function num : 0_0 , upvalues : ChangeCamera
  ((ChangeCamera.super).Ctor)(self)
  self._context = context
  self._cameraMoveType = cameraMoveType
end

ChangeCamera.OnStart = function(self)
  -- function num : 0_1 , upvalues : BattlerPositionComponent, CameraStateComponent, ECameraMoveType
  local battlerPositionComponent = (((self._context)._skill):GetAttacker()):GetComponent(BattlerPositionComponent)
  local cameraStateComponent = ((self._context)._battleScene):GetComponent(CameraStateComponent)
  cameraStateComponent._needRefresh = true
  if battlerPositionComponent._orientation < 0 then
    if self._cameraMoveType == ECameraMoveType.CameraReset then
      cameraStateComponent._currentState = "Normal"
    else
      if self._cameraMoveType == ECameraMoveType.ShowSkillHit1 then
        cameraStateComponent._currentState = "Skill1Right"
      else
        if self._cameraMoveType == ECameraMoveType.MoveToSelf then
          cameraStateComponent._currentState = "Left"
        else
          if self._cameraMoveType == ECameraMoveType.MoveToEnemy then
            cameraStateComponent._currentState = "Right"
          end
        end
      end
    end
  else
    if self._cameraMoveType == ECameraMoveType.CameraReset then
      cameraStateComponent._currentState = "Normal"
    else
      if self._cameraMoveType == ECameraMoveType.ShowSkillHit1 then
        cameraStateComponent._currentState = "Skill1Left"
      else
        if self._cameraMoveType == ECameraMoveType.MoveToSelf then
          cameraStateComponent._currentState = "Right"
        else
          if self._cameraMoveType == ECameraMoveType.MoveToEnemy then
            cameraStateComponent._currentState = "Left"
          end
        end
      end
    end
  end
end

ChangeCamera.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : Behavior_Status
  return Behavior_Status.Success
end

return ChangeCamera

