local TriggerBase = require("logic.scene.luaevent.trigger.triggerbase")
local TrapOpenTrigger = class("TrapOpenTrigger", TriggerBase)

function TrapOpenTrigger:Ctor(triggertype, id, eventid, instanceID, trapList, stateList)
  TrapOpenTrigger.super.Ctor(self, triggertype, id, eventid)
  self._instanceID = instanceID
  self._trapList = trapList
  self._stateList = stateList
end

function TrapOpenTrigger:OnCheck()
  local controller = TriggerManager.GetController("trapopen")
  if controller:IsCheckOver() then
    return false
  end
  local switch, trap
  for i, id in ipairs(self._trapList) do
    switch = SwitchManager.GetSwitch(self._instanceID, id)
    if switch and switch:GetState() == self._stateList[i] then
      return false
    else
      trap = TrapManager.GetTrap(self._instanceID, id)
      if trap and trap:GetState() == self._stateList[i] then
        return false
      end
    end
  end
  controller:SetCheckOver()
  return true
end

return TrapOpenTrigger
