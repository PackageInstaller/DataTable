local TriggerControllerBase = require("logic.scene.luaevent.trigger.triggercontrollerbase")
local CollisionTriggerController = class("CollisionTriggerController", TriggerControllerBase)
local CollisionTrigger = require("logic.scene.luaevent.trigger.basic.collision.collisiontrigger")

function CollisionTriggerController:Ctor(...)
  CollisionTriggerController.super.Ctor(self, ...)
end

function CollisionTriggerController:CreateTriggerInstance(id, eventid, colliderID)
  return CollisionTrigger.Create("collision", id, eventid, colliderID)
end

function CollisionTriggerController:OnCollision(id)
  self:CheckImpl(nil, id)
end

return CollisionTriggerController
