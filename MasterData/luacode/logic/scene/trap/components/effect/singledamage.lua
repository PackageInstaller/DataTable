local EffectBase = require("logic.scene.trap.components.effect.effectbase")
local SingleDamage = class("SingleDamage", EffectBase)

function SingleDamage:Ctor(cb)
  self._finished = false
  SingleDamage.super.Ctor(self, cb)
end

function SingleDamage:OnUpdate(deltaTime)
  if not self._finished then
    self._finished = true
    self._callback()
  end
end

function SingleDamage:Reset()
  self._finished = false
end

return SingleDamage
