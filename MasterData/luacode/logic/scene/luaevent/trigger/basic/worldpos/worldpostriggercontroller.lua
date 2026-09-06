local TriggerControllerBase = require("logic.scene.luaevent.trigger.triggercontrollerbase")
local WorldPosTriggerController = class("WorldPosTriggerController", TriggerControllerBase)
local WorldPosTrigger = require("logic.scene.luaevent.trigger.basic.worldpos.worldpostrigger")

function WorldPosTriggerController:Ctor(...)
  WorldPosTriggerController.super.Ctor(self, ...)
  self._x = 0
  self._y = 0
end

function WorldPosTriggerController:CreateTriggerInstance(id, eventid, x, y)
  return WorldPosTrigger.Create("worldpos", id, eventid, x, y)
end

function WorldPosTriggerController:OnCharacterMove(x, y)
  self._x = x
  self._y = y
  self:CheckImpl(nil, x, y)
end

function WorldPosTriggerController:OnTriggerAdd(trigger)
  trigger:Check(self._x, self._y)
end

return WorldPosTriggerController
