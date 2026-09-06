local TriggerBase = require("logic.scene.luaevent.trigger.triggerbase")
local DirectionTrigger = class("DirectionTrigger", TriggerBase)

function DirectionTrigger:Ctor(type, id, eventid, ...)
  DirectionTrigger.super.Ctor(self, type, id, eventid)
  self._direction = {}
  local params = {
    ...
  }
  if #params == 1 then
    for _, v in pairs(params[1]) do
      table.insert(self._direction, v)
    end
  end
end

function DirectionTrigger:OnCheck(direction)
  if #self._direction == 0 then
    return true
  end
  for _, v in ipairs(self._direction) do
    if direction == v then
      return true
    end
  end
  return false
end

return DirectionTrigger
