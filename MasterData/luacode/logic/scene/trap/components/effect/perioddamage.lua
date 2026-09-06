local EffectBase = require("logic.scene.trap.components.effect.effectbase")
local PeriodDamage = class("PeriodDamage", EffectBase)

function PeriodDamage:Ctor(period)
  self._time = 0
  self._period = period
  self._states = {}
  self._current = 1
end

function PeriodDamage:OnUpdate(deltaTime)
  self._time = self._time + deltaTime
  for i = self._current, #self._states do
    local state = self._states[i]
    if self._time > state.time then
      self._time = self._time - state.time
    else
      self._current = i
      self._callback(state)
    end
  end
end

function PeriodDamage:SetStates(states)
  self._states = states
  self._time = 0
end

return PeriodDamage
