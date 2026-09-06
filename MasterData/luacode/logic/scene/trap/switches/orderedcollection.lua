local Switch = require("logic.scene.trap.switch")
local OrderedCollection = class("OrderedCollection", Switch)
local StaticEvent = require("logic.scene.luaevent.event.staticevent")
local Future = require("logic.scene.luaevent.effect.future")

function OrderedCollection:Ctor(...)
  OrderedCollection.super.Ctor(self, ...)
end

function OrderedCollection:Activate()
  self:BuildStateEffects()
end

function OrderedCollection:BuildStateEffects()
  OrderedCollection.super.BuildStateEffects(self)
  local tmp = {}
  tmp[0] = self._stateEffects[0]
  for i, v in ipairs(self._partInfo) do
    local root = EffectFactory.CreateComposedEffect()
    root:AddEffect(self._stateEffects[1])
    root:AddEffect(StaticEvent.CreateSwitchEffect(v.effectid))
    root:Bind(self._object)
    tmp[#tmp + 1] = root
  end
  tmp[#tmp + 1] = self._stateEffects[2]
  self._stateEffects = tmp
end

function OrderedCollection:AddPartEffects(info)
  self._partInfo = info
end

function OrderedCollection:ToState(state, args)
  args = args or {}
  local state_count = table.nums(self._stateEffects)
  if state == state_count - 1 then
    return OrderedCollection.super.ToState(self, state, args)
  end
  if state == 0 then
    if args.init then
      return Future.Create(self._stateEffects[0], args)
    else
      self._state = 0
      local root = EffectFactory.CreateComposedEffect()
      local switch_root = EffectFactory.CreateEffectList()
      for _, v in pairs(self._effectArgs.switches) do
        local switch = SwitchManager.GetSwitch(v.instance, v.id)
        switch_root:AddEffect(switch:ToState(0, args))
      end
      root:AddEffect(switch_root)
      root:AddEffect(EffectFactory.CreateCustomEffect(function()
        local effect = EffectFactory.CreateAnimatorStateChangeEffect(nil, "trigger", 0)
        effect:Bind(self._object)
        effect:Run()
      end))
      return root
    end
  end
  local prev = self._state
  self._state = state
  local root = EffectFactory.CreateComposedEffect()
  if state - prev == 1 then
    root:AddEffect(self._stateEffects[state])
    if state == state_count - 2 then
      local effect = self:ToState(state_count - 1)
      root:AddEffect(effect)
    end
    return Future.Create(root, args)
  else
    return self:ToState(0, {
      error = self._effectArgs.switches[state].id,
      init = args.init
    })
  end
end

function OrderedCollection:ToNextState(args)
  if self._state == table.nums(self._stateEffects) - 1 then
    return Future.NoOp()
  end
  return self:ToState((self._state or 0) + 1, args)
end

function OrderedCollection:AddPart(switchid)
  local index
  for _, v in pairs(self._partInfo) do
    if v.index == switchid then
      index = v.index
      break
    end
  end
  if not index then
    return Future.NoOp()
  end
  if index - self._state ~= 1 then
    return self:ToState(0, {
      error = self._effectArgs.switches[index].id
    })
  end
  return self:ToState(index)
end

local function restore(self, switchid)
  local index
  for _, v in pairs(self._partInfo) do
    if v.index == switchid then
      index = v.index
      break
    end
  end
  if not index then
    return Future.NoOp()
  end
  if index > (self._state or 0) then
    return self:ToState(index, {init = true})
  else
    return Future.Create(self._stateEffects[index], {init = true})
  end
end

function OrderedCollection:RestoreState(state)
  if state == 0 then
    return OrderedCollection.super.RestoreState(self, state)
  elseif state == 2 then
    return OrderedCollection.super.RestoreState(self, table.nums(self._stateEffects) - 1)
  else
    local root = EffectFactory.CreateComposedEffect()
    for _, v in ipairs(self._restored) do
      root:AddEffect(restore(self, v))
    end
    self._restored = {}
    return root
  end
end

function OrderedCollection:RestorePart(switchid)
  if self._state == table.nums(self._stateEffects) - 1 then
    return Future.NoOp()
  end
  self._restored = self._restored or {}
  local index
  for i, v in pairs(self._effectArgs.switches) do
    if v.id == switchid then
      index = i
      break
    end
  end
  self._restored[index] = switchid
end

return OrderedCollection
