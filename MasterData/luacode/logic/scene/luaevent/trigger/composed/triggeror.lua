local TriggerOperatorBase = require("logic.scene.luaevent.trigger.composed.triggeroperator")
local TriggerOperatorOr = class("TriggerOr", TriggerOperatorBase)

function TriggerOperatorOr:Ctor(...)
  TriggerOperatorOr.super.Ctor(self, ...)
end

function TriggerOperatorOr:Check()
  if not self._active then
    return false
  end
  for _, v in pairs(self._tasks) do
    if v:GetType() == "operator" then
      if v:Check() then
        return true
      end
    elseif v:GetState() then
      return true
    end
  end
  return false
end

return TriggerOperatorOr
