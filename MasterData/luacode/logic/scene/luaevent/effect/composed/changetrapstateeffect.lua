local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local ChangeTrapStateEffect = class("ChangeTrapStateEffect", EffectBase)
local Future = require("logic.scene.luaevent.effect.future")
local PathResolver = require("logic.scene.pathresolver")

function ChangeTrapStateEffect:Ctor(root)
  self._root = root
end

function ChangeTrapStateEffect:Destroy()
  self._finished = false
  if self._callback then
    self._callback()
    self._callback = nil
  end
  LuaNotificationCenter.PostNotification(Common.n_SceneEffectEnd, self, self)
  self._futures = {}
end

function ChangeTrapStateEffect:Add(root)
  self._root = root
end

function ChangeTrapStateEffect:Run()
  self._root:Run()
  self._root:Then(function()
    if self._callback then
      self._finished = false
      self:Destroy()
    else
      self._finished = true
    end
  end)
end

function ChangeTrapStateEffect:Then(callback)
  self._callback = callback
  if self._finished then
    self:Destroy()
  end
end

ChangeTrapStateEffect.Sequence = class("ChangeTrapStateSequence")

function ChangeTrapStateEffect.Sequence:Ctor(...)
  self._names = {
    ...
  }
  self._futures = {}
end

function ChangeTrapStateEffect.Sequence:Destroy()
  LuaNotificationCenter.PostNotification(Common.n_SceneEffectEnd, self, self)
  self._futures = {}
end

function ChangeTrapStateEffect.Sequence:Add(element)
  self._names[#self._names + 1] = element
end

local function change_next_state(self, next)
  return function()
    if next > #self._futures then
      if self._callback then
        self._callback()
        self._callback = nil
      else
        self._finished = true
      end
      self:Destroy()
      return
    end
    self._futures[next]:Run()
    self._futures[next]:Then(change_next_state(self, next + 1))
  end
end

function ChangeTrapStateEffect.Sequence:Run()
  self._finished = false
  for i = 1, #self._names do
    if type(self._names[i]) == "string" then
      local object = PathResolver.ResolveObject(self._names[i])
      self._futures[i] = object:ToNextState()
    else
      self._futures[i] = self._names[i]:ToNextState()
    end
  end
  change_next_state(self, 1)()
end

function ChangeTrapStateEffect.Sequence:ToNextState()
  return Future.Create(self)
end

function ChangeTrapStateEffect.Sequence:Then(callback)
  if self._finished then
    self._finished = false
    callback()
    self._callback = nil
  else
    self._callback = callback
  end
end

ChangeTrapStateEffect.Parallel = class("ChangeTrapStateParallel")

function ChangeTrapStateEffect.Parallel:Ctor(...)
  self._names = {
    ...
  }
  self._futures = {}
  self._finished = 0
end

function ChangeTrapStateEffect.Parallel:Destroy()
  if self._callback then
    self._callback()
    self._callback = nil
  end
  self._futures = {}
  self._finished = -1
  LuaNotificationCenter.PostNotification(Common.n_SceneEffectEnd, self, self)
end

function ChangeTrapStateEffect.Parallel:Add(element)
  self._names[#self._names + 1] = element
end

function ChangeTrapStateEffect.Parallel:Run()
  self._finished = 0
  for i = 1, #self._names do
    if type(self._names[i]) == "string" then
      local object = PathResolver.ResolveObject(self._names[i])
      self._futures[i] = object:ToNextState()
    else
      self._futures[i] = self._names[i]:ToNextState()
    end
    self._futures[i]:Then(function()
      self:OnEffectFinish()
    end)
    self._futures[i]:Run()
  end
end

function ChangeTrapStateEffect.Parallel:ToNextState()
  return Future.Create(self)
end

function ChangeTrapStateEffect.Parallel:Then(callback)
  if self._finished == #self._names or self._finished == -1 then
    callback()
    self._callback = nil
    self._finished = 0
  else
    self._callback = callback
  end
end

function ChangeTrapStateEffect.Parallel:OnEffectFinish()
  self._finished = self._finished + 1
  if self._finished == #self._names then
    self:Destroy()
  end
end

return ChangeTrapStateEffect
