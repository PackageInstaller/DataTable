local TriggerBase = require("logic.scene.luaevent.trigger.triggerbase")
local TimerTrigger = class("TimerTrigger", TriggerBase)

function TimerTrigger:Ctor(type, id, eventid, delay, period)
  TimerTrigger.super.Ctor(self, type, id, eventid)
  self._delay = tonumber(delay)
  self._period = tonumber(period)
end

function TimerTrigger:OnCheck()
  return true
end

function TimerTrigger:GetDelay()
  return self._delay
end

function TimerTrigger:GetPeriod()
  return self._period
end

return TimerTrigger
