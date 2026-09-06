local TriggerBase = class("TriggerBase")

function TriggerBase:Ctor(type, id, eventid)
  self._active = false
  self._type = type
  self._id = id
  self._eventID = eventid
end

function TriggerBase:IsActive()
  return self._active
end

function TriggerBase:GetID()
  return self._id
end

function TriggerBase:GetEventID()
  return self._eventID
end

function TriggerBase:GetType()
  return self._type
end

function TriggerBase:SetState(state)
  self._active = state
end

function TriggerBase:GetState()
  return self._active
end

function TriggerBase:Check(...)
  local prev_state = self._active
  self:SetState(self:OnCheck(...))
  if self._active ~= prev_state then
    TriggerManager.OnTriggerStateChange(self)
  end
end

function TriggerBase:OnCheck(...)
end

return TriggerBase
