local FixedPos = class("FixedPos")
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")

function FixedPos:Ctor(delegate, area)
  self._delegate = delegate
  self._area = area
end

function FixedPos:BuildEnterEvent()
  local event = EventManager.CreateEvent()
  local trigger = TriggerManager.CreateTrigger("gridpos", event:GetID(), self._area, true)
  event:AddTrigger("gridpos", trigger)
  event:AddEffect(EffectFactory.CreateCustomEffect(function()
    local leave = self:BuildLeaveEvent()
    EventManager.AddEvent(leave)
  end))
  event:AddEffect(EffectFactory.CreateCustomEffect(function()
    if self._delegate.OnEnterArea then
      self._delegate:OnEnterArea(self)
    end
  end))
  self._activeID = event:GetID()
  return event
end

function FixedPos:BuildLeaveEvent()
  local event = EventManager.CreateEvent()
  local trigger = TriggerManager.CreateTrigger("gridpos", event:GetID(), self._area, true)
  local negative = Not.Create()
  negative:SetTask(trigger)
  local composedtrigger = ComposedTrigger.Create(nil, event:GetID())
  composedtrigger:AddTask(negative)
  event:AddTrigger("composed", composedtrigger)
  event:AddEffect(EffectFactory.CreateCustomEffect(function()
    local enter = self:BuildEnterEvent()
    EventManager.AddEvent(enter)
  end))
  event:AddEffect(EffectFactory.CreateCustomEffect(function()
    if self._delegate.OnLeaveArea then
      self._delegate:OnLeaveArea(self)
    end
  end))
  self._activeID = event:GetID()
  return event
end

function FixedPos:BuildFixedEvent()
  local event = EventManager.CreateEvent(true)
  local trigger = TriggerManager.CreateTrigger("gridpos", event:GetID(), self._area, true)
  event:AddTrigger("gridpos", trigger)
  event:AddEffect(EffectFactory.CreateCustomEffect(function()
    if self._delegate.OnEnterArea then
      self._delegate:OnEnterArea(self)
    end
  end))
  self._activeID = event:GetID()
  return event
end

function FixedPos:Destroy()
  if self._activeID then
    EventManager.RemoveEvent(self._activeID)
    self._activeID = nil
  end
end

return FixedPos
