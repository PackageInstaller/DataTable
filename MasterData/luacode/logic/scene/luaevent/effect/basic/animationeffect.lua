local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local AnimationEffect = class("ObjectPlayAnimationEffect", EffectBase)
local PathResolver = require("logic.scene.pathresolver")

function AnimationEffect:Ctor(path, name)
  self._path = path
  self._name = name
end

function AnimationEffect:Run()
  if global_var_debug and self:GetParam("pause") then
    CS.PixelNeko.LuaManager.Pause()
  end
  local object = PathResolver.Resolve(self._path) or self._object
  local animator = object:GetComponent("Animator")
  if animator then
    animator:Play(self._name)
    self._finished = false
  else
    LogWarning("effect", "no animator")
  end
end

function AnimationEffect:Then(callback)
  if self._callback then
    self._callback:Destroy(true)
    self._callback = nil
  end
  local object = PathResolver.Resolve(self._path) or self._object
  local animator = object:GetComponent("Animator")
  if animator then
    if self._finished then
      self._finished = false
      callback()
      LuaNotificationCenter.PostNotification(Common.n_SceneEffectEnd, self, self)
    else
      self._callback = AnimationEffect.Callback.Create(object, function()
        self._callback = nil
        callback()
        LuaNotificationCenter.PostNotification(Common.n_SceneEffectEnd, self, self)
      end)
      self._callback:Bind()
    end
  end
end

AnimationEffect.Callback = class("ObjectPlayAnimationCallback")

function AnimationEffect.Callback:Ctor(object, callback)
  self._object = object
  self._callback = callback
  self._handler = nil
  self._newState = 0
  self._lastTime = 0
end

function AnimationEffect.Callback:Destroy(invoke_callback)
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

function AnimationEffect.Callback:Bind()
  self._handler = CS.PixelNeko.Animation.EventTriggerHelper.AddStateUpdateListener(self._object, self.OnStateUpdate, self)
end

function AnimationEffect.Callback:OnStateUpdate(handle, stateName, normalizedTime)
  if self._lastTime == 0 and 1 < normalizedTime then
    self._wait = true
  end
  if self._wait and normalizedTime < 1 then
    self._wait = false
  end
  if not self._wait and 1 < normalizedTime then
    self:Destroy(true)
  end
  self._lastTime = normalizedTime
end

return AnimationEffect
