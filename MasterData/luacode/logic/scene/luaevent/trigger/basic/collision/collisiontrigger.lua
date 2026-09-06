local TriggerBase = require("logic.scene.luaevent.trigger.triggerbase")
local CollisionTrigger = class("CollisionTrigger", TriggerBase)

function CollisionTrigger:Ctor(triggertype, id, eventid, colliderID)
  CollisionTrigger.super.Ctor(self, triggertype, id, eventid)
  self._colliderID = colliderID
end

function CollisionTrigger:OnCheck(id)
  return id == self._colliderID
end

return CollisionTrigger
