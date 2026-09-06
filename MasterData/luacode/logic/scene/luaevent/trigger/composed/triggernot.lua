local TriggerOperatorBase = require("logic.scene.luaevent.trigger.composed.triggeroperator")
local TriggerOperatorNot = class("TriggerNot", TriggerOperatorBase)

function TriggerOperatorNot:Ctor(...)
  TriggerOperatorNot.super.Ctor(self, ...)
  self._task = nil
end

function TriggerOperatorNot:Destroy()
  if self._task:GetType() == "operator" then
    self._task:Destroy()
  else
    TriggerManager.RemoveTrigger(self._task:GetType(), self._task:GetID())
  end
end

function TriggerOperatorNot:SetTask(task)
  self._task = task
end

function TriggerOperatorNot:Check()
  if not self._active then
    return false
  end
  if self._task:GetType() == "operator" then
    return not self._task:Check()
  else
    return not self._task:GetState()
  end
end

function TriggerOperatorNot:Activate()
  self._active = true
  TriggerManager.AddTrigger(self._task:GetType(), self._task)
end

function TriggerOperatorNot:Reset()
  if self._task:GetType() == "operator" then
    self._task:Reset()
  else
    self._task:SetState(0)
  end
end

return TriggerOperatorNot
