-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/trap/components/effect/effectbase.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = class("EffectBase")
EffectBase.Ctor = function(self, effectfunc)
  -- function num : 0_0
  self._callback = effectfunc
end

EffectBase.OnUpdate = function(self, deltaTime)
  -- function num : 0_1 , upvalues : _ENV
  assert(false)
end

return EffectBase

