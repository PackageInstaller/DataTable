-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/basic/trapopen/trapopentriggercontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerControllerBase = require("logic.scene.luaevent.trigger.triggercontrollerbase")
local TrapOpenTriggerController = class("TrapOpenTriggerController", TriggerControllerBase)
local TrapOpenTrigger = require("logic.scene.luaevent.trigger.basic.trapopen.trapopentrigger")
TrapOpenTriggerController.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TrapOpenTriggerController
  ((TrapOpenTriggerController.super).Ctor)(self, ...)
  self._checkOver = false
end

TrapOpenTriggerController.CreateTriggerInstance = function(self, id, eventid, instanceID, trapList, stateList)
  -- function num : 0_1 , upvalues : TrapOpenTrigger
  return (TrapOpenTrigger.Create)("trapopen", id, eventid, instanceID, trapList, stateList)
end

TrapOpenTriggerController.OnCheckTrap = function(self)
  -- function num : 0_2
  self._checkOver = false
  self:CheckImpl(nil)
end

TrapOpenTriggerController.OnTriggerAdd = function(self, trigger)
  -- function num : 0_3
end

TrapOpenTriggerController.SetCheckOver = function(self)
  -- function num : 0_4
  self._checkOver = true
end

TrapOpenTriggerController.IsCheckOver = function(self)
  -- function num : 0_5
  return self._checkOver
end

return TrapOpenTriggerController

