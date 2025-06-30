-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/countereffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local CounterEffect = class("CounterEffect", EffectBase)
CounterEffect.Ctor = function(self, tag, value)
  -- function num : 0_0 , upvalues : _ENV
  self._tag = tag
  self._value = tonumber(value)
end

CounterEffect.Run = function(self)
  -- function num : 0_1 , upvalues : _ENV
  local prev = ((NekoData.BehaviorManager).BM_Counter):GetCounterValue(self._tag) or 0
  ;
  ((NekoData.BehaviorManager).BM_Counter):SetCounterValue(self._tag, prev + self._value)
end

return CounterEffect

