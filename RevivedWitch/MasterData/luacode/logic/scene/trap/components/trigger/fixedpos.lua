-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/trap/components/trigger/fixedpos.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local FixedPos = class("FixedPos")
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
FixedPos.Ctor = function(self, delegate, area)
  -- function num : 0_0
  self._delegate = delegate
  self._area = area
end

FixedPos.BuildEnterEvent = function(self)
  -- function num : 0_1 , upvalues : _ENV
  local event = (EventManager.CreateEvent)()
  local trigger = (TriggerManager.CreateTrigger)("gridpos", event:GetID(), self._area, true)
  event:AddTrigger("gridpos", trigger)
  event:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_1_0 , upvalues : self, _ENV
    local leave = self:BuildLeaveEvent()
    ;
    (EventManager.AddEvent)(leave)
  end
))
  event:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_1_1 , upvalues : self
    if (self._delegate).OnEnterArea then
      (self._delegate):OnEnterArea(self)
    end
  end
))
  self._activeID = event:GetID()
  return event
end

FixedPos.BuildLeaveEvent = function(self)
  -- function num : 0_2 , upvalues : _ENV, Not, ComposedTrigger
  local event = (EventManager.CreateEvent)()
  local trigger = (TriggerManager.CreateTrigger)("gridpos", event:GetID(), self._area, true)
  local negative = (Not.Create)()
  negative:SetTask(trigger)
  local composedtrigger = (ComposedTrigger.Create)(nil, event:GetID())
  composedtrigger:AddTask(negative)
  event:AddTrigger("composed", composedtrigger)
  event:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_2_0 , upvalues : self, _ENV
    local enter = self:BuildEnterEvent()
    ;
    (EventManager.AddEvent)(enter)
  end
))
  event:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_2_1 , upvalues : self
    if (self._delegate).OnLeaveArea then
      (self._delegate):OnLeaveArea(self)
    end
  end
))
  self._activeID = event:GetID()
  return event
end

FixedPos.BuildFixedEvent = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local event = (EventManager.CreateEvent)(true)
  local trigger = (TriggerManager.CreateTrigger)("gridpos", event:GetID(), self._area, true)
  event:AddTrigger("gridpos", trigger)
  event:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_3_0 , upvalues : self
    if (self._delegate).OnEnterArea then
      (self._delegate):OnEnterArea(self)
    end
  end
))
  self._activeID = event:GetID()
  return event
end

FixedPos.Destroy = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self._activeID then
    (EventManager.RemoveEvent)(self._activeID)
    self._activeID = nil
  end
end

return FixedPos

