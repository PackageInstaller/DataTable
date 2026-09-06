local BM_Counter = class("BM_Counter")

function BM_Counter:Ctor()
  self._counter = NekoData.Data.counter
end

function BM_Counter:GetCounterValue(tag)
  return self._counter[tag]
end

function BM_Counter:SetCounterValue(tag, value)
  self._counter[tag] = value
  TriggerManager.OnCounterChange(tag, value)
end

return BM_Counter
