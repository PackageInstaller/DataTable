local TriggerBase = require("logic.scene.luaevent.trigger.triggerbase")
local CounterTrigger = class("CounterTrigger", TriggerBase)

function CounterTrigger:Ctor(type, id, eventid, tag, value)
  CounterTrigger.super.Ctor(self, type, id, eventid)
  self._tag = tag
  self._value = value
end

function CounterTrigger:OnCheck(tag, value)
  return self._tag == tag and self._value == value
end

function CounterTrigger:GetTag()
  return self._tag
end

function CounterTrigger:GetValue()
  return self._value
end

return CounterTrigger
