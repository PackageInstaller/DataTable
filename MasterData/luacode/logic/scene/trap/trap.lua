-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/trap/trap.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Trap = class("Trap")
local StaticEvent = require("logic.scene.luaevent.event.staticevent")
local Future = require("logic.scene.luaevent.effect.future")
Trap.Ctor = function(self, instanceid, id, object, initialstate, preservestate)
  -- function num : 0_0
  self._instanceid = instanceid
  self._id = id
  self._object = object
  self._animator = object:GetComponent("Animator")
  self._state = initialstate
  self._initialState = initialstate
  self._preservestate = preservestate
  self._onDamage = false
  self._stateEffects = {}
  self._damageEffects = {}
  self._eventIDs = {}
end

Trap.Destroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  for _,v in pairs(self._eventIDs) do
    (EventManager.RemoveEvent)(v)
  end
  self._eventIDs = {}
end

Trap.Activate = function(self)
  -- function num : 0_2
end

Trap.Deactivate = function(self)
  -- function num : 0_3
end

Trap.SetEffectArea = function(self, area)
  -- function num : 0_4
  self._effectArea = area
end

Trap.GetEffectArea = function(self)
  -- function num : 0_5
  return self._effectArea
end

Trap.BuildStateEffects = function(self)
  -- function num : 0_6
end

Trap.AddStateEffect = function(self, state, effectid)
  -- function num : 0_7 , upvalues : StaticEvent
  if not self._stateEffects then
    self._stateEffects = {}
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._stateEffects)[state] = (StaticEvent.CreateSwitchEffect)(effectid)
    ;
    ((self._stateEffects)[state]):Bind(self._object)
  end
end

Trap.OnUpdate = function(self, deltaTime)
  -- function num : 0_8
  if self._onDamage and (self._damageEffects)[self._state + 1] then
    ((self._damageEffects)[self._state + 1]):OnUpdate(deltaTime)
  end
end

Trap.GetInstanceID = function(self)
  -- function num : 0_9
  return self._instanceid
end

Trap.GetID = function(self)
  -- function num : 0_10
  return self._id
end

Trap.GetKey = function(self)
  -- function num : 0_11
  return self._key
end

Trap.SetKey = function(self, key)
  -- function num : 0_12
  self._key = key
end

Trap.GetState = function(self)
  -- function num : 0_13
  return self._state
end

Trap.GetInitialState = function(self)
  -- function num : 0_14
  return self._initialState
end

Trap.GetObject = function(self)
  -- function num : 0_15
  return self._object
end

Trap.ShouldSaveState = function(self)
  -- function num : 0_16
  return self._preservestate
end

Trap.ToNextState = function(self)
  -- function num : 0_17 , upvalues : _ENV
  self._state = (self._state + 1) % (table.nums)(self._stateEffects)
  return self:OnStateChange()
end

Trap.CheckState = function(self)
  -- function num : 0_18 , upvalues : Future
  return (Future.NoOp)()
end

Trap.OnStateChange = function(self, args)
  -- function num : 0_19 , upvalues : Future
  local future = (Future.Create)((self._stateEffects)[self._state], args)
  return future
end

Trap.ToState = function(self, state, args)
  -- function num : 0_20 , upvalues : Future
  if self._state == state and (not args or not args.init) then
    return (Future.NoOp)()
  end
  self._state = state
  return self:OnStateChange(args)
end

Trap.RestoreState = function(self, state)
  -- function num : 0_21
  return self:ToState(state, {init = true})
end

return Trap

