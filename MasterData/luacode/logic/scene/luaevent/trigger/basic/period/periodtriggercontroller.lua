local TriggerControllerBase = require("logic.scene.luaevent.trigger.triggercontrollerbase")
local PeriodTrigger = require("logic.scene.luaevent.trigger.basic.period.periodtrigger")
local PeriodTriggerController = class("PeriodTriggerController", TriggerControllerBase)

function PeriodTriggerController:Ctor(...)
  PeriodTriggerController.super.Ctor(self, ...)
end

function PeriodTriggerController:CreateTriggerInstance(id, eventid, stratTime, endTime)
  return PeriodTrigger.Create("period", id, eventid, stratTime, endTime)
end

function PeriodTriggerController:OnTriggerAdd(trigger)
  local serverTime = ServerGameTimer.GetServerTime()
  local stime = os.date("*t", serverTime // 1000)
  trigger:Check(stime)
end

function PeriodTriggerController:OnPeriodArrival(currentTime)
  for _, trigger in pairs(self._triggers) do
    trigger:Check(currentTime)
  end
end

return PeriodTriggerController
