local Switch = require("logic.scene.trap.switch")
local ImpactPoint = class("ImpactPoint", Switch)

function ImpactPoint:Ctor(...)
  ImpactPoint.super.Ctor(self, ...)
end

local function add_collision_test(self)
  if self._collisionEvent then
    EventManager.RemoveEvent(self._collisionEvent:GetID())
    self._collisionEvent = nil
  end
  local event = EventManager.CreateEvent()
  local trigger = TriggerManager.CreateTrigger("collision", event:GetID(), "trap " .. self._path)
  event:AddTrigger(trigger:GetType(), trigger)
  event:AddEffect(EffectFactory.CreateCustomEffect(function()
    self:ToNextState():Run()
    LuaNotificationCenter.PostNotification(Common.n_ImpactHit, self, self)
  end))
  EventManager.AddEvent(event)
  self._collisionEvent = event
end

function ImpactPoint:BuildStateEffects()
  ImpactPoint.super.BuildStateEffects(self)
  local effect = EffectFactory.CreateCustomEffect(function()
    add_collision_test(self)
  end)
  effect:SetParam("runoninit")
  self._stateEffects[0]:AddEffect(effect)
  self._stateEffects[0]:AddEffect(EffectFactory.CreateTrapCheckEffect({}, {
    self._effectArgs.switches[1]
  }))
  self._stateEffects[1]:AddEffect(effect)
  self._stateEffects[1]:AddEffect(EffectFactory.CreateTrapCheckEffect({}, {
    self._effectArgs.switches[1]
  }))
end

function ImpactPoint:Deactivate()
  print("deactivate", debug.traceback())
  ImpactPoint.super.Deactivate(self)
  if self._collisionEvent then
    EventManager.RemoveEvent(self._collisionEvent:GetID())
    self._collisionEvent = nil
  end
end

return ImpactPoint
