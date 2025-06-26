-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/animatorstatechangeeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local AnimatorStateChangeEffect = class("AnimatorStateChangeEffect", EffectBase)
local PathResolver = require("logic.scene.pathresolver")
local AnimationHelper = ((CS.PixelNeko).Animation).AnimationHelper
AnimatorStateChangeEffect.Ctor = function(self, path, name, value, state, target)
  -- function num : 0_0 , upvalues : _ENV
  self._path = path
  self._name = name
  self._value = tonumber(value)
  if state ~= "" then
    self._state = state
  end
  self._target = tonumber(target)
end

AnimatorStateChangeEffect.Run = function(self)
  -- function num : 0_1 , upvalues : _ENV, PathResolver, AnimationHelper
  if global_var_debug and self:GetParam("pause") then
    (((CS.PixelNeko).LuaManager).Pause)()
  end
  if not self._object then
    local object = (PathResolver.Resolve)(self._path)
  end
  local animator = object:GetComponent("Animator")
  if animator then
    local current = animator:GetInteger(self._name)
    if current == self._value then
      if self._callback then
        (self._callback):Destroy(true)
        self._callback = nil
        ;
        (LuaNotificationCenter.PostNotification)(Common.n_SceneEffectEnd, self, self)
      else
        self._finished = true
      end
      self._currentStateHash = nil
    else
      local stateinfo = animator:GetCurrentAnimatorStateInfo()
      self._currentStateHash = stateinfo.fullPathHash
      if self:GetParam("raw") then
        animator:SetInteger(self._name, tonumber(self._value))
      else
        ;
        (AnimationHelper.SetAnimatorInteger2)(object, self._name, tonumber(self._value))
      end
      self._finished = false
    end
  else
    do
      LogWarning("effect", "no animator")
    end
  end
end

AnimatorStateChangeEffect.Then = function(self, callback)
  -- function num : 0_2 , upvalues : PathResolver, _ENV, AnimatorStateChangeEffect
  if self._callback then
    (self._callback):Destroy(true)
    self._callback = nil
  end
  if not self._object then
    local object = (PathResolver.Resolve)(self._path)
  end
  local animator = object:GetComponent("Animator")
  if animator then
    if self._finished then
      self._currentStateHash = nil
      self._finished = false
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_SceneEffectEnd, self, self)
      callback()
    else
      self._callback = ((AnimatorStateChangeEffect.Callback).Create)(object, function()
    -- function num : 0_2_0 , upvalues : self, _ENV, callback
    self._callback = nil
    self._running = false
    self._currentStateHash = nil
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_SceneEffectEnd, self, self)
    callback()
  end
, self._state, self._target, self._currentStateHash)
      ;
      (self._callback):Bind()
    end
  end
end

AnimatorStateChangeEffect.Callback = class("AnimatorStateChangeCallback")
-- DECOMPILER ERROR at PC26: Confused about usage of register: R4 in 'UnsetPending'

;
(AnimatorStateChangeEffect.Callback).Ctor = function(self, object, callback, state, target, initialstate)
  -- function num : 0_3
  self._object = object
  self._animator = object:GetComponent("Animator")
  self._callback = callback
  self._state = state
  self._target = target
  self._handler = nil
  self._newState = 0
  self._lastTime = 0
  self._stateHash = initialstate
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

;
(AnimatorStateChangeEffect.Callback).Destroy = function(self, invoke_callback)
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

-- DECOMPILER ERROR at PC32: Confused about usage of register: R4 in 'UnsetPending'

;
(AnimatorStateChangeEffect.Callback).Bind = function(self)
  -- function num : 0_5 , upvalues : _ENV
  self._handler = ((((CS.PixelNeko).Animation).EventTriggerHelper).AddStateUpdateListener)(self._object, self.OnStateUpdate, self)
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R4 in 'UnsetPending'

;
(AnimatorStateChangeEffect.Callback).OnStateUpdate = function(self, handle, stateName, normalizedTime)
  -- function num : 0_6
  if self._stateHash then
    local stateinfo = (self._animator):GetCurrentAnimatorStateInfo()
    if stateinfo.fullPathHash ~= self._stateHash then
      self._newState = self._newState + 1
    else
      if self._lastTime == 0 and normalizedTime < 1 then
        self._newState = self._newState + 1
      end
    end
    self._stateHash = stateinfo.fullPathHash
  else
    do
      if normalizedTime < self._lastTime then
        self._newState = self._newState + 1
      else
        if self._lastTime == 0 and normalizedTime < 1 then
          self._newState = self._newState + 1
        end
      end
      if self._newState > 1 or self._newState > 0 and normalizedTime > 1 then
        self:Destroy(true)
      end
      if stateName == self._state and self._target <= normalizedTime then
        self:Destroy(true)
      end
      self._lastTime = normalizedTime
    end
  end
end

return AnimatorStateChangeEffect

