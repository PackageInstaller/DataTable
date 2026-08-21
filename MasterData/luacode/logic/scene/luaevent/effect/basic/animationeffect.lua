-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/animationeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local AnimationEffect = class("ObjectPlayAnimationEffect", EffectBase)
local PathResolver = require("logic.scene.pathresolver")
AnimationEffect.Ctor = function(self, path, name)
  -- function num : 0_0
  self._path = path
  self._name = name
end

AnimationEffect.Run = function(self)
  -- function num : 0_1 , upvalues : _ENV, PathResolver
  if global_var_debug and self:GetParam("pause") then
    (((CS.PixelNeko).LuaManager).Pause)()
  end
  if not (PathResolver.Resolve)(self._path) then
    local object = self._object
  end
  local animator = object:GetComponent("Animator")
  if animator then
    animator:Play(self._name)
    self._finished = false
  else
    LogWarning("effect", "no animator")
  end
end

AnimationEffect.Then = function(self, callback)
  -- function num : 0_2 , upvalues : PathResolver, _ENV, AnimationEffect
  if self._callback then
    (self._callback):Destroy(true)
    self._callback = nil
  end
  if not (PathResolver.Resolve)(self._path) then
    local object = self._object
  end
  local animator = object:GetComponent("Animator")
  if animator then
    if self._finished then
      self._finished = false
      callback()
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_SceneEffectEnd, self, self)
    else
      self._callback = ((AnimationEffect.Callback).Create)(object, function()
    -- function num : 0_2_0 , upvalues : self, callback, _ENV
    self._callback = nil
    callback()
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_SceneEffectEnd, self, self)
  end
)
      ;
      (self._callback):Bind()
    end
  end
end

AnimationEffect.Callback = class("ObjectPlayAnimationCallback")
-- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

;
(AnimationEffect.Callback).Ctor = function(self, object, callback)
  -- function num : 0_3
  self._object = object
  self._callback = callback
  self._handler = nil
  self._newState = 0
  self._lastTime = 0
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

;
(AnimationEffect.Callback).Destroy = function(self, invoke_callback)
  -- function num : 0_4 , upvalues : _ENV
  self._newState = 0
  self._lastTime = 0
  if self._handler then
    ((((CS.PixelNeko).Animation).EventTriggerHelper).RemoveStateUpdateListener)(self._object, self._handler)
    self._handler = nil
  end
  if invoke_callback and self._callback then
    (self._callback)()
  end
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

;
(AnimationEffect.Callback).Bind = function(self)
  -- function num : 0_5 , upvalues : _ENV
  self._handler = ((((CS.PixelNeko).Animation).EventTriggerHelper).AddStateUpdateListener)(self._object, self.OnStateUpdate, self)
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R3 in 'UnsetPending'

;
(AnimationEffect.Callback).OnStateUpdate = function(self, handle, stateName, normalizedTime)
  -- function num : 0_6
  if self._lastTime == 0 and normalizedTime > 1 then
    self._wait = true
  end
  if self._wait and normalizedTime < 1 then
    self._wait = false
  end
  if not self._wait and normalizedTime > 1 then
    self:Destroy(true)
  end
  self._lastTime = normalizedTime
end

return AnimationEffect

