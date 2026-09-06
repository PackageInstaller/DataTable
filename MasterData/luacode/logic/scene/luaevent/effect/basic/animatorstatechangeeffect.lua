local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local AnimatorStateChangeEffect = class("AnimatorStateChangeEffect", EffectBase)
local PathResolver = require("logic.scene.pathresolver")
local AnimationHelper = CS.PixelNeko.Animation.AnimationHelper

function AnimatorStateChangeEffect:Ctor(path, name, value, state, target)
  self._path = path
  self._name = name
  self._value = tonumber(value)
  if state ~= "" then
    self._state = state
  end
  self._target = tonumber(target)
end

function AnimatorStateChangeEffect:Run()
  if global_var_debug and self:GetParam("pause") then
    CS.PixelNeko.LuaManager.Pause()
  end
  local object = self._object or PathResolver.Resolve(self._path)
  local animator = object:GetComponent("Animator")
  if animator then
    local current = animator:GetInteger(self._name)
    if current == self._value then
      if self._callback then
        self._callback:Destroy(true)
        self._callback = nil
        LuaNotificationCenter.PostNotification(Common.n_SceneEffectEnd, self, self)
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
        AnimationHelper.SetAnimatorInteger2(object, self._name, tonumber(self._value))
      end
      self._finished = false
    end
  else
    LogWarning("effect", "no animator")
  end
end

function AnimatorStateChangeEffect:Then(callback)
  if self._callback then
    self._callback:Destroy(true)
    self._callback = nil
  end
  local object = self._object or PathResolver.Resolve(self._path)
  local animator = object:GetComponent("Animator")
  if animator then
    if self._finished then
      self._currentStateHash = nil
      self._finished = false
      LuaNotificationCenter.PostNotification(Common.n_SceneEffectEnd, self, self)
      callback()
    else
      self._callback = AnimatorStateChangeEffect.Callback.Create(object, function()
        self._callback = nil
        self._running = false
        self._currentStateHash = nil
        LuaNotificationCenter.PostNotification(Common.n_SceneEffectEnd, self, self)
        callback()
      end, self._state, self._target, self._currentStateHash)
      self._callback:Bind()
    end
  end
end

AnimatorStateChangeEffect.Callback = class("AnimatorStateChangeCallback")

function AnimatorStateChangeEffect.Callback:Ctor(object, callback, state, target, initialstate)
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

function AnimatorStateChangeEffect.Callback:Destroy(invoke_callback)
  self._newState = 0
  self._lastTime = 0
  if self._handler then
    CS.PixelNeko.Animation.EventTriggerHelper.RemoveStateUpdateListener(self._object, self._handler)
    self._handler = nil
  end
  if invoke_callback and self._callback then
    self._callback()
  end
end

function AnimatorStateChangeEffect.Callback:Bind()
  self._handler = CS.PixelNeko.Animation.EventTriggerHelper.AddStateUpdateListener(self._object, self.OnStateUpdate, self)
end

function AnimatorStateChangeEffect.Callback:OnStateUpdate(handle, stateName, normalizedTime)
  if self._stateHash then
    local stateinfo = self._animator:GetCurrentAnimatorStateInfo()
    if stateinfo.fullPathHash ~= self._stateHash then
      self._newState = self._newState + 1
    elseif self._lastTime == 0 and normalizedTime < 1 then
      self._newState = self._newState + 1
    end
    self._stateHash = stateinfo.fullPathHash
  elseif normalizedTime < self._lastTime then
    self._newState = self._newState + 1
  elseif self._lastTime == 0 and normalizedTime < 1 then
    self._newState = self._newState + 1
  end
  if self._newState > 1 or self._newState > 0 and 1 < normalizedTime then
    self:Destroy(true)
  end
  if stateName == self._state and normalizedTime >= self._target then
    self:Destroy(true)
  end
  self._lastTime = normalizedTime
end

return AnimatorStateChangeEffect
