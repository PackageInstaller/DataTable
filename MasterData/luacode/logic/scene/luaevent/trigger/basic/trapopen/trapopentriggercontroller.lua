local TriggerControllerBase = require("logic.scene.luaevent.trigger.triggercontrollerbase")
local TrapOpenTriggerController = class("TrapOpenTriggerController", TriggerControllerBase)
local TrapOpenTrigger = require("logic.scene.luaevent.trigger.basic.trapopen.trapopentrigger")

function TrapOpenTriggerController:Ctor(...)
  TrapOpenTriggerController.super.Ctor(self, ...)
  self._checkOver = false
end

function TrapOpenTriggerController:CreateTriggerInstance(id, eventid, instanceID, trapList, stateList)
  return TrapOpenTrigger.Create("trapopen", id, eventid, instanceID, trapList, stateList)
end

function TrapOpenTriggerController:OnCheckTrap()
  self._checkOver = false
  self:CheckImpl(nil)
end

function TrapOpenTriggerController:OnTriggerAdd(trigger)
end

function TrapOpenTriggerController:SetCheckOver()
  self._checkOver = true
end

function TrapOpenTriggerController:IsCheckOver()
  return self._checkOver
end

return TrapOpenTriggerController
