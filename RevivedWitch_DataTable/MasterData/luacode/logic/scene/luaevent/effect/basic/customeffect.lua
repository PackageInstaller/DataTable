-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/customeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local CustomEffect = class("CustomEffect", EffectBase)
CustomEffect.Ctor = function(self, callback)
  -- function num : 0_0
  self._callback = callback
end

CustomEffect.Run = function(self)
  -- function num : 0_1
  (self._callback)()
end

return CustomEffect

