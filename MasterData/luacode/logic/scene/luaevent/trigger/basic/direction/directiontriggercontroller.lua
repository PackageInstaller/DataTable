local TriggerControllerBase = require("logic.scene.luaevent.trigger.triggercontrollerbase")
local DirectionTrigger = require("logic.scene.luaevent.trigger.basic.direction.directiontrigger")
local DirectionTriggerController = class("DirectionTriggerController", TriggerControllerBase)

function DirectionTriggerController:Ctor(...)
  DirectionTriggerController.super.Ctor(self, ...)
  self._dir = 1
end

function DirectionTriggerController:CreateTriggerInstance(id, eventid, direction)
  return DirectionTrigger.Create("direction", id, eventid, direction)
end

function DirectionTriggerController:OnTriggerAdd(trigger)
  trigger:Check(self._dir)
end

function DirectionTriggerController:OnDirectionChange(direction)
  self._dir = direction
  self:CheckImpl(nil, direction)
end

return DirectionTriggerController
