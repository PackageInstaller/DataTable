-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/composed/trapcomposedeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ComposedEffect = require("logic.scene.luaevent.effect.composed.composedeffect")
local TrapComposedEffect = class("TrapComposedEffect", ComposedEffect)
TrapComposedEffect.Ctor = function(self)
  -- function num : 0_0 , upvalues : TrapComposedEffect
  ((TrapComposedEffect.super).Ctor)(self)
end

TrapComposedEffect.Run = function(self, skip_camera)
  -- function num : 0_1 , upvalues : TrapComposedEffect
  if not skip_camera then
    skip_camera = self._skipCamera
  end
  ;
  ((TrapComposedEffect.super).Run)(self, {skip_camera = skip_camera})
end

TrapComposedEffect.SetSkipCamera = function(self, skip)
  -- function num : 0_2
  self._skipCamera = skip
end

local noop = function()
  -- function num : 0_3
end

TrapComposedEffect.Cancel = function(self)
  -- function num : 0_4 , upvalues : noop
  if self._current then
    local effect = (self._effects)[self._current]
    effect:Then(noop)
    effect:Cancel()
  end
end

return TrapComposedEffect

