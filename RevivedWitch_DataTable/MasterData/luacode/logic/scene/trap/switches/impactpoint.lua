-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/trap/switches/impactpoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Switch = require("logic.scene.trap.switch")
local ImpactPoint = class("ImpactPoint", Switch)
ImpactPoint.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ImpactPoint
  ((ImpactPoint.super).Ctor)(self, ...)
end

local add_collision_test = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if self._collisionEvent then
    (EventManager.RemoveEvent)((self._collisionEvent):GetID())
    self._collisionEvent = nil
  end
  local event = (EventManager.CreateEvent)()
  local trigger = (TriggerManager.CreateTrigger)("collision", event:GetID(), "trap " .. self._path)
  event:AddTrigger(trigger:GetType(), trigger)
  event:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_1_0 , upvalues : self, _ENV
    (self:ToNextState()):Run()
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_ImpactHit, self, self)
  end
))
  ;
  (EventManager.AddEvent)(event)
  self._collisionEvent = event
end

ImpactPoint.BuildStateEffects = function(self)
  -- function num : 0_2 , upvalues : ImpactPoint, _ENV, add_collision_test
  ((ImpactPoint.super).BuildStateEffects)(self)
  local effect = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_2_0 , upvalues : add_collision_test, self
    add_collision_test(self)
  end
)
  effect:SetParam("runoninit")
  ;
  ((self._stateEffects)[0]):AddEffect(effect)
  ;
  ((self._stateEffects)[0]):AddEffect((EffectFactory.CreateTrapCheckEffect)({}, {((self._effectArgs).switches)[1]}))
  ;
  ((self._stateEffects)[1]):AddEffect(effect)
  ;
  ((self._stateEffects)[1]):AddEffect((EffectFactory.CreateTrapCheckEffect)({}, {((self._effectArgs).switches)[1]}))
end

ImpactPoint.Deactivate = function(self)
  -- function num : 0_3 , upvalues : _ENV, ImpactPoint
  print("deactivate", (debug.traceback)())
  ;
  ((ImpactPoint.super).Deactivate)(self)
  if self._collisionEvent then
    (EventManager.RemoveEvent)((self._collisionEvent):GetID())
    self._collisionEvent = nil
  end
end

return ImpactPoint

