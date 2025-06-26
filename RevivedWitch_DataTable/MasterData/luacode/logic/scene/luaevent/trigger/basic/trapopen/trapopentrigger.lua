-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/basic/trapopen/trapopentrigger.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerBase = require("logic.scene.luaevent.trigger.triggerbase")
local TrapOpenTrigger = class("TrapOpenTrigger", TriggerBase)
TrapOpenTrigger.Ctor = function(self, triggertype, id, eventid, instanceID, trapList, stateList)
  -- function num : 0_0 , upvalues : TrapOpenTrigger
  ((TrapOpenTrigger.super).Ctor)(self, triggertype, id, eventid)
  self._instanceID = instanceID
  self._trapList = trapList
  self._stateList = stateList
end

TrapOpenTrigger.OnCheck = function(self)
  -- function num : 0_1 , upvalues : _ENV
  local controller = (TriggerManager.GetController)("trapopen")
  if controller:IsCheckOver() then
    return false
  end
  local switch, trap = nil, nil
  for i,id in ipairs(self._trapList) do
    switch = (SwitchManager.GetSwitch)(self._instanceID, id)
    if switch and switch:GetState() == (self._stateList)[i] then
      return false
    else
      trap = (TrapManager.GetTrap)(self._instanceID, id)
      if trap and trap:GetState() == (self._stateList)[i] then
        return false
      end
    end
  end
  controller:SetCheckOver()
  return true
end

return TrapOpenTrigger

