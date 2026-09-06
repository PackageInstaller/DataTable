local TriggerControllerBase = require("logic.scene.luaevent.trigger.triggercontrollerbase")
local CounterTriggerController = class("CounterTriggerController", TriggerControllerBase)
local CounterTrigger = require("logic.scene.luaevent.trigger.basic.counter.countertrigger")

function CounterTriggerController:Ctor(...)
  CounterTriggerController.super.Ctor(self, ...)
end

function CounterTriggerController:CreateTriggerInstance(id, eventid, tag, value)
  return CounterTrigger.Create("counter", id, eventid, tag, value)
end

function CounterTriggerController:OnCounterChange(tag, value)
  if not self._triggers[tag] then
    print(tag, value, debug.traceback())
    return
  end
  for _, trigger in pairs(self._triggers[tag]) do
    trigger:Check(tag, value)
  end
end

function CounterTriggerController:AddTrigger(trigger, period)
  local tag = trigger:GetTag()
  self._triggers[tag] = self._triggers[tag] or {}
  table.insert(self._triggers[tag], trigger)
  print("counter trigger added", tag)
end

function CounterTriggerController:RemoveTrigger(id)
  local found = false
  for tag, v in pairs(self._triggers) do
    for k, trigger in pairs(v) do
      if trigger:GetID() == id then
        v[k] = nil
        found = true
        break
      end
    end
    if found then
      if table.nums(v) == 0 then
        self._triggers[tag] = nil
      end
      return true
    end
  end
  return false
end

function CounterTriggerController:OnTriggerAdd(trigger)
  trigger:Check(trigger:GetTag(), NekoData.BehaviorManager.BM_Counter:GetCounterValue(trigger:GetTag()))
end

function CounterTriggerController:GetTrigger(id)
  for _, v in pairs(self._triggers) do
    for _, vv in pairs(v) do
      if vv:GetID() == id then
        return vv
      end
    end
  end
end

return CounterTriggerController
