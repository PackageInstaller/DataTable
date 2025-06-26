-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/basic/worldpos/worldpostriggercontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerControllerBase = require("logic.scene.luaevent.trigger.triggercontrollerbase")
local WorldPosTriggerController = class("WorldPosTriggerController", TriggerControllerBase)
local WorldPosTrigger = require("logic.scene.luaevent.trigger.basic.worldpos.worldpostrigger")
WorldPosTriggerController.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : WorldPosTriggerController
  ((WorldPosTriggerController.super).Ctor)(self, ...)
  self._x = 0
  self._y = 0
end

WorldPosTriggerController.CreateTriggerInstance = function(self, id, eventid, x, y)
  -- function num : 0_1 , upvalues : WorldPosTrigger
  return (WorldPosTrigger.Create)("worldpos", id, eventid, x, y)
end

WorldPosTriggerController.OnCharacterMove = function(self, x, y)
  -- function num : 0_2
  self._x = x
  self._y = y
  self:CheckImpl(nil, x, y)
end

WorldPosTriggerController.OnTriggerAdd = function(self, trigger)
  -- function num : 0_3
  trigger:Check(self._x, self._y)
end

return WorldPosTriggerController

