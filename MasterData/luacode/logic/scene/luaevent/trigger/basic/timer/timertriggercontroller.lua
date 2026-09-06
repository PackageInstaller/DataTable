local TriggerControllerBase = require("logic.scene.luaevent.trigger.triggercontrollerbase")
local TimerTriggerController = class("TimerTriggerController", TriggerControllerBase)
local TimerTrigger = require("logic.scene.luaevent.trigger.basic.timer.timertrigger")

function TimerTriggerController:Ctor(...)
  TimerTriggerController.super.Ctor(self, ...)
  self._currentTime = 0
end

function TimerTriggerController:CreateTriggerInstance(id, eventid, delay, period)
  return TimerTrigger.Create("timer", id, eventid, delay or 0, period or 0)
end

function TimerTriggerController:OnUpdate(deltaTime)
  self._currentTime = self._currentTime + deltaTime
  for time, v in pairs(self._triggers) do
    if time <= self._currentTime then
      for _, trigger in pairs(v) do
        trigger:Check()
        if trigger:GetPeriod() ~= 0 then
          self:AddTrigger(trigger, trigger:GetPeriod())
        end
      end
    end
    if v and table.nums(v) == 0 then
      self._triggers[time] = nil
    end
  end
end

function TimerTriggerController:AddTrigger(trigger, period)
  local delay = period or trigger:GetDelay()
  if delay == 0 then
    trigger:Check()
    if trigger:GetPeriod() ~= 0 then
      delay = trigger:GetPeriod()
    else
      return
    end
  end
  local time = delay + self._currentTime
  self._triggers[time] = self._triggers[time] or {}
  table.insert(self._triggers[time], trigger)
end

function TimerTriggerController:RemoveTrigger(id)
  local found = false
  for time, v in pairs(self._triggers) do
    for k, trigger in pairs(v) do
      if trigger:GetID() == id then
        v[k] = nil
        found = true
        break
      end
    end
    if found then
      if table.nums(v) == 0 then
        self._triggers[time] = nil
      end
      return true
    end
  end
  return false
end

function TimerTriggerController:GetTrigger(id)
  for _, v in pairs(self._triggers) do
    for _, vv in pairs(v) do
      if vv:GetID() == id then
        return vv
      end
    end
  end
end

function TimerTriggerController:OnTriggerAdd(trigger)
  if trigger:GetDelay() == 0 then
    trigger:Check()
  end
end

return TimerTriggerController
