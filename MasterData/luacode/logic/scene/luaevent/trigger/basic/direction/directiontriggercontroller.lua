-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/basic/direction/directiontriggercontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerControllerBase = require("logic.scene.luaevent.trigger.triggercontrollerbase")
local DirectionTrigger = require("logic.scene.luaevent.trigger.basic.direction.directiontrigger")
local DirectionTriggerController = class("DirectionTriggerController", TriggerControllerBase)
DirectionTriggerController.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DirectionTriggerController
  ((DirectionTriggerController.super).Ctor)(self, ...)
  self._dir = 1
end

DirectionTriggerController.CreateTriggerInstance = function(self, id, eventid, direction)
  -- function num : 0_1 , upvalues : DirectionTrigger
  return (DirectionTrigger.Create)("direction", id, eventid, direction)
end

DirectionTriggerController.OnTriggerAdd = function(self, trigger)
  -- function num : 0_2
  trigger:Check(self._dir)
end

DirectionTriggerController.OnDirectionChange = function(self, direction)
  -- function num : 0_3
  self._dir = direction
  self:CheckImpl(nil, direction)
end

return DirectionTriggerController

