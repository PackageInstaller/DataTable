local TriggerBase = require("logic.scene.luaevent.trigger.triggerbase")
local RoleStatusTrigger = class("RoleStatusTrigger", TriggerBase)

function RoleStatusTrigger:Ctor(triggertype, id, eventid, list)
  RoleStatusTrigger.super.Ctor(self, triggertype, id, eventid)
  self._list = list
  self._value = self._list.value
end

function RoleStatusTrigger:OnCheck(value)
  if type(value) == "number" then
    if value == self._value then
      return true
    end
  elseif type(value) == "table" then
    for _, v in pairs(value) do
      if self._value == v then
        return true
      end
    end
  end
  return false
end

function RoleStatusTrigger:GetTriList()
  return self._list
end

return RoleStatusTrigger
