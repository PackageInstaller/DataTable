-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/trap/components/effect/perioddamage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.trap.components.effect.effectbase")
local PeriodDamage = class("PeriodDamage", EffectBase)
PeriodDamage.Ctor = function(self, period)
  -- function num : 0_0
  self._time = 0
  self._period = period
  self._states = {}
  self._current = 1
end

PeriodDamage.OnUpdate = function(self, deltaTime)
  -- function num : 0_1
  self._time = self._time + deltaTime
  for i = self._current, #self._states do
    local state = (self._states)[i]
    if state.time < self._time then
      self._time = self._time - state.time
    else
      self._current = i
      ;
      (self._callback)(state)
    end
  end
end

PeriodDamage.SetStates = function(self, states)
  -- function num : 0_2
  self._states = states
  self._time = 0
end

return PeriodDamage

