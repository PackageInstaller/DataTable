local TriggerControllerBase = class("TriggerControllerBase")

function TriggerControllerBase:Ctor()
  self._triggers = {}
  self._adding = {}
  self._removing = {}
  self._checking = false
end

function TriggerControllerBase:Destroy()
  self._triggers = {}
end

function TriggerControllerBase:OnSceneChange()
end

local function check_table(remove, tbl, pred, ...)
  for _, trigger in pairs(tbl) do
    if not remove[trigger:GetID()] and (not pred or pred(trigger, ...)) then
      trigger:Check(...)
    end
  end
end

function TriggerControllerBase:CheckImpl(pred, ...)
  self._checking = true
  check_table(self._removing, self._triggers, pred, ...)
  for i, v in ipairs(self._adding) do
    if not self._removing[v:GetID()] then
      self._triggers[v:GetID()] = v
    end
  end
  self._adding = {}
  self._removing = {}
  self._checking = false
end

function TriggerControllerBase:CreateTrigger(eventid, ...)
  local id = TriggerManager.GenID()
  local trigger = self:CreateTriggerInstance(id, eventid, ...)
  if self.OnTriggerCreate then
    self:OnTriggerCreate(trigger)
  end
  return trigger
end

function TriggerControllerBase:AddTrigger(trigger)
  if not self._checking then
    self._triggers[trigger:GetID()] = trigger
  else
    self._adding[#self._adding + 1] = trigger
  end
  if self.OnTriggerAdd then
    self:OnTriggerAdd(trigger)
  end
end

function TriggerControllerBase:RemoveTrigger(id)
  local t = self._triggers[id]
  if not self._checking then
    self._triggers[id] = nil
  else
    self._removing[id] = true
  end
  return t ~= nil
end

function TriggerControllerBase:GetTrigger(id)
  return not self._removing[id] and (self._triggers[id] or table.first(self._adding, function(k, v)
    return v == id
  end))
end

return TriggerControllerBase
