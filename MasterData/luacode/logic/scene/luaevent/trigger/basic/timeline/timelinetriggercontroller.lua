local TriggerControllerBase = require("logic.scene.luaevent.trigger.triggercontrollerbase")
local TimelineTriggerController = class("TimelineTriggerController", TriggerControllerBase)
local TimelineTrigger = require("logic.scene.luaevent.trigger.basic.timeline.timelinetrigger")

function TimelineTriggerController:Ctor(...)
  TimelineTriggerController.super.Ctor(self, ...)
end

function TimelineTriggerController:CreateTriggerInstance(id, eventid, director)
  return TimelineTrigger.Create("timeline", id, eventid, director)
end

function TimelineTriggerController:OnTimelineEnd(director)
  self:CheckImpl(nil, director)
end

return TimelineTriggerController
