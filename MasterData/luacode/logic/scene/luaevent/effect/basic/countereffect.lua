local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local CounterEffect = class("CounterEffect", EffectBase)

function CounterEffect:Ctor(tag, value)
  self._tag = tag
  self._value = tonumber(value)
end

function CounterEffect:Run()
  local prev = NekoData.BehaviorManager.BM_Counter:GetCounterValue(self._tag) or 0
  NekoData.BehaviorManager.BM_Counter:SetCounterValue(self._tag, prev + self._value)
end

return CounterEffect
