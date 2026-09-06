local TriggerOperatorBase = require("logic.scene.luaevent.trigger.composed.triggeroperator")
local TriggerOperatorAnd = class("TriggerAnd", TriggerOperatorBase)

function TriggerOperatorAnd:Ctor(...)
  TriggerOperatorAnd.super.Ctor(self, ...)
end

function TriggerOperatorAnd:Check()
  if not self._active then
    return false
  end
  for _, v in pairs(self._tasks) do
    if v:GetType() == "operator" then
      if not v:Check() then
        return false
      end
    elseif not v:GetState() then
      return false
    end
  end
  return true
end

return TriggerOperatorAnd
