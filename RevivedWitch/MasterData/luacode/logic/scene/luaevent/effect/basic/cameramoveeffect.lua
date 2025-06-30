-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/cameramoveeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local CameraMoveEffect = class("CameraMoveEffect", EffectBase)
local EffectRunner = require("logic.scene.luaevent.effect.effectrunner")
CameraMoveEffect.Ctor = function(self, target, duration, staytime)
  -- function num : 0_0 , upvalues : _ENV
  self._target = target
  self._camera = nil
  self._time = 0
  self._duration = duration or 0.5
  self._staytime = staytime or 0.5
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  self._camera = controller:GetCameraFollowPoint()
  self._op = {}
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R5 in 'UnsetPending'

  if target.x == 0 and target.y == 0 and target.z == 0 then
    (self._op).getPosition = (((CS.PixelNeko).Lua).TransformStaticFunctions).GetLocalPosition
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._op).setPosition = (((CS.PixelNeko).Lua).TransformStaticFunctions).SetLocalPosition
  else
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._op).getPosition = (((CS.PixelNeko).Lua).TransformStaticFunctions).GetPosition
    -- DECOMPILER ERROR at PC59: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._op).setPosition = (((CS.PixelNeko).Lua).TransformStaticFunctions).SetPosition
  end
end

local on_update_end = function(self)
  -- function num : 0_1 , upvalues : EffectRunner, _ENV
  (EffectRunner.RemoveEffect)(self._runnerID)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_SceneEffectEnd, self, self)
  if self._callback then
    (self._callback)()
  end
end

CameraMoveEffect.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : _ENV, on_update_end
  if self._running then
    self._time = self._time + deltaTime
    ;
    (self._tween):update(deltaTime)
    ;
    ((self._op).setPosition)(self._camera, (self._source).x, 0, (self._source).z)
    if self._duration < self._time then
      self._running = false
      ;
      (GameTimer.AddTask)(self._staytime, 0, on_update_end, self)
    end
  end
end

CameraMoveEffect.Run = function(self, args)
  -- function num : 0_3 , upvalues : _ENV, EffectRunner
  if (args and args.skip_camera) or self._running then
    return 
  end
  local x, y, z = ((self._op).getPosition)(self._camera)
  if x ~= (self._target).x or y ~= (self._target).y or z ~= (self._target).z then
    self._source = {x = x, y = y, z = z}
    self._tween = (Tween.new)(self._duration, self._source, self._target, "inOutQuad")
    self._running = true
    self._time = 0
    self._runnerID = (EffectRunner.AddEffect)(self)
  end
end

CameraMoveEffect.Cancel = function(self)
  -- function num : 0_4 , upvalues : on_update_end
  if self._running then
    on_update_end(self)
  end
end

CameraMoveEffect.Then = function(self, callback)
  -- function num : 0_5 , upvalues : CameraMoveEffect
  if self._running then
    self._callback = callback
  else
    ;
    ((CameraMoveEffect.super).Then)(self, callback)
  end
end

return CameraMoveEffect

