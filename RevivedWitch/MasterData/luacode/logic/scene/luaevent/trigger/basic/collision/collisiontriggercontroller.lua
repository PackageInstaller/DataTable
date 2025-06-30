-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/basic/collision/collisiontriggercontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerControllerBase = require("logic.scene.luaevent.trigger.triggercontrollerbase")
local CollisionTriggerController = class("CollisionTriggerController", TriggerControllerBase)
local CollisionTrigger = require("logic.scene.luaevent.trigger.basic.collision.collisiontrigger")
CollisionTriggerController.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CollisionTriggerController
  ((CollisionTriggerController.super).Ctor)(self, ...)
end

CollisionTriggerController.CreateTriggerInstance = function(self, id, eventid, colliderID)
  -- function num : 0_1 , upvalues : CollisionTrigger
  return (CollisionTrigger.Create)("collision", id, eventid, colliderID)
end

CollisionTriggerController.OnCollision = function(self, id)
  -- function num : 0_2
  self:CheckImpl(nil, id)
end

return CollisionTriggerController

