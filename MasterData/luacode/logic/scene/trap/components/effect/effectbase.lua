local EffectBase = class("EffectBase")

function EffectBase:Ctor(effectfunc)
  self._callback = effectfunc
end

function EffectBase:OnUpdate(deltaTime)
  assert(false)
end

return EffectBase
