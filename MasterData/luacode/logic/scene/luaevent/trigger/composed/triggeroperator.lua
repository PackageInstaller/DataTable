local TriggerOperatorBase = class("TriggerOperatorBase")

function TriggerOperatorBase:Ctor(id)
  self._id = id
  self._tasks = {}
end

function TriggerOperatorBase:Destroy()
  for _, v in pairs(self._tasks) do
    if v:GetType() == "operator" then
      v:Destroy()
    else
      TriggerManager.RemoveTrigger(v:GetType(), v:GetID())
    end
  end
  self._tasks = {}
end

function TriggerOperatorBase:GetID()
  return self._id
end

function TriggerOperatorBase:GetType()
  return "operator"
end

function TriggerOperatorBase:Check()
  return false
end

function TriggerOperatorBase:AddTask(value)
  for _, v in pairs(self._tasks) do
    if v:GetType() ~= "operator" and v:GetType() == value:GetType() and v:GetID() == value:GetID() then
      return
    end
  end
  self._tasks[#self._tasks + 1] = value
end

function TriggerOperatorBase:IsActive()
  return self:Check()
end

function TriggerOperatorBase:Activate()
  self._active = true
  for _, v in pairs(self._tasks) do
    if v:GetType() == "operator" then
      v:Activate()
    else
      TriggerManager.AddTrigger(v:GetType(), v)
    end
  end
end

function TriggerOperatorBase:Reset()
  for _, v in pairs(self._tasks) do
    if v:GetType() == "operator" then
      v:Reset()
    else
      v:SetState(0)
    end
  end
end

return TriggerOperatorBase
