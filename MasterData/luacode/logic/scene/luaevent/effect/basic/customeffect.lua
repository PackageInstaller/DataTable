local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local CustomEffect = class("CustomEffect", EffectBase)

function CustomEffect:Ctor(callback)
  self._callback = callback
end

function CustomEffect:Run()
  self._callback()
end

return CustomEffect
