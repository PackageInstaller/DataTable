local Trap = class("Trap")
local StaticEvent = require("logic.scene.luaevent.event.staticevent")
local Future = require("logic.scene.luaevent.effect.future")

function Trap:Ctor(instanceid, id, object, initialstate, preservestate)
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

function Trap:Destroy()
  for _, v in pairs(self._eventIDs) do
    EventManager.RemoveEvent(v)
  end
  self._eventIDs = {}
end

function Trap:Activate()
end

function Trap:Deactivate()
end

function Trap:SetEffectArea(area)
  self._effectArea = area
end

function Trap:GetEffectArea()
  return self._effectArea
end

function Trap:BuildStateEffects()
end

function Trap:AddStateEffect(state, effectid)
  self._stateEffects = self._stateEffects or {}
  self._stateEffects[state] = StaticEvent.CreateSwitchEffect(effectid)
  self._stateEffects[state]:Bind(self._object)
end

function Trap:OnUpdate(deltaTime)
  if self._onDamage and self._damageEffects[self._state + 1] then
    self._damageEffects[self._state + 1]:OnUpdate(deltaTime)
  end
end

function Trap:GetInstanceID()
  return self._instanceid
end

function Trap:GetID()
  return self._id
end

function Trap:GetKey()
  return self._key
end

function Trap:SetKey(key)
  self._key = key
end

function Trap:GetState()
  return self._state
end

function Trap:GetInitialState()
  return self._initialState
end

function Trap:GetObject()
  return self._object
end

function Trap:ShouldSaveState()
  return self._preservestate
end

function Trap:ToNextState()
  self._state = (self._state + 1) % table.nums(self._stateEffects)
  return self:OnStateChange()
end

function Trap:CheckState()
  return Future.NoOp()
end

function Trap:OnStateChange(args)
  local future = Future.Create(self._stateEffects[self._state], args)
  return future
end

function Trap:ToState(state, args)
  if self._state == state and (not args or not args.init) then
    return Future.NoOp()
  end
  self._state = state
  return self:OnStateChange(args)
end

function Trap:RestoreState(state)
  return self:ToState(state, {init = true})
end

return Trap
