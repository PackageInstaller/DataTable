-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/trap/components/effect/singledamage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.trap.components.effect.effectbase")
local SingleDamage = class("SingleDamage", EffectBase)
SingleDamage.Ctor = function(self, cb)
  -- function num : 0_0 , upvalues : SingleDamage
  self._finished = false
  ;
  ((SingleDamage.super).Ctor)(self, cb)
end

SingleDamage.OnUpdate = function(self, deltaTime)
  -- function num : 0_1
  if not self._finished then
    self._finished = true
    ;
    (self._callback)()
  end
end

SingleDamage.Reset = function(self)
  -- function num : 0_2
  self._finished = false
end

return SingleDamage

