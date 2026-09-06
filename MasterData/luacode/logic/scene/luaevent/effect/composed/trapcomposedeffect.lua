local ComposedEffect = require("logic.scene.luaevent.effect.composed.composedeffect")
local TrapComposedEffect = class("TrapComposedEffect", ComposedEffect)

function TrapComposedEffect:Ctor()
  TrapComposedEffect.super.Ctor(self)
end

function TrapComposedEffect:Run(skip_camera)
  skip_camera = skip_camera or self._skipCamera
  TrapComposedEffect.super.Run(self, {skip_camera = skip_camera})
end

function TrapComposedEffect:SetSkipCamera(skip)
  self._skipCamera = skip
end

local function noop()
end

function TrapComposedEffect:Cancel()
  if self._current then
    local effect = self._effects[self._current]
    effect:Then(noop)
    effect:Cancel()
  end
end

return TrapComposedEffect
