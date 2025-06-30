-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/trap/switches/orderedcollection.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Switch = require("logic.scene.trap.switch")
local OrderedCollection = class("OrderedCollection", Switch)
local StaticEvent = require("logic.scene.luaevent.event.staticevent")
local Future = require("logic.scene.luaevent.effect.future")
OrderedCollection.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : OrderedCollection
  ((OrderedCollection.super).Ctor)(self, ...)
end

OrderedCollection.Activate = function(self)
  -- function num : 0_1
  self:BuildStateEffects()
end

OrderedCollection.BuildStateEffects = function(self)
  -- function num : 0_2 , upvalues : OrderedCollection, _ENV, StaticEvent
  ((OrderedCollection.super).BuildStateEffects)(self)
  local tmp = {}
  tmp[0] = (self._stateEffects)[0]
  for i,v in ipairs(self._partInfo) do
    local root = (EffectFactory.CreateComposedEffect)()
    root:AddEffect((self._stateEffects)[1])
    root:AddEffect((StaticEvent.CreateSwitchEffect)(v.effectid))
    root:Bind(self._object)
    tmp[#tmp + 1] = root
  end
  tmp[#tmp + 1] = (self._stateEffects)[2]
  self._stateEffects = tmp
end

OrderedCollection.AddPartEffects = function(self, info)
  -- function num : 0_3
  self._partInfo = info
end

OrderedCollection.ToState = function(self, state, args)
  -- function num : 0_4 , upvalues : _ENV, OrderedCollection, Future
  if not args then
    args = {}
  end
  local state_count = (table.nums)(self._stateEffects)
  if state == state_count - 1 then
    return ((OrderedCollection.super).ToState)(self, state, args)
  end
  if state == 0 then
    if args.init then
      return (Future.Create)((self._stateEffects)[0], args)
    else
      self._state = 0
      local root = (EffectFactory.CreateComposedEffect)()
      local switch_root = (EffectFactory.CreateEffectList)()
      for _,v in pairs((self._effectArgs).switches) do
        local switch = (SwitchManager.GetSwitch)(v.instance, v.id)
        switch_root:AddEffect(switch:ToState(0, args))
      end
      root:AddEffect(switch_root)
      root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_4_0 , upvalues : _ENV, self
    local effect = (EffectFactory.CreateAnimatorStateChangeEffect)(nil, "trigger", 0)
    effect:Bind(self._object)
    effect:Run()
  end
))
      return root
    end
  end
  do
    local prev = self._state
    self._state = state
    local root = (EffectFactory.CreateComposedEffect)()
    if state - prev == 1 then
      root:AddEffect((self._stateEffects)[state])
      do
        if state == state_count - 2 then
          local effect = self:ToState(state_count - 1)
          root:AddEffect(effect)
        end
        do return (Future.Create)(root, args) end
        do return self:ToState(0, {error = (((self._effectArgs).switches)[state]).id, init = args.init}) end
      end
    end
  end
end

OrderedCollection.ToNextState = function(self, args)
  -- function num : 0_5 , upvalues : _ENV, Future
  if self._state == (table.nums)(self._stateEffects) - 1 then
    return (Future.NoOp)()
  end
  return self:ToState((self._state or 0) + 1, args)
end

OrderedCollection.AddPart = function(self, switchid)
  -- function num : 0_6 , upvalues : _ENV, Future
  local index = nil
  for _,v in pairs(self._partInfo) do
    if v.index == switchid then
      index = v.index
      break
    end
  end
  do
    if not index then
      return (Future.NoOp)()
    end
    if index - self._state ~= 1 then
      return self:ToState(0, {error = (((self._effectArgs).switches)[index]).id})
    end
    return self:ToState(index)
  end
end

local restore = function(self, switchid)
  -- function num : 0_7 , upvalues : _ENV, Future
  local index = nil
  for _,v in pairs(self._partInfo) do
    if v.index == switchid then
      index = v.index
      break
    end
  end
  do
    if not index then
      return (Future.NoOp)()
    end
    if self._state or 0 < index then
      return self:ToState(index, {init = true})
    else
      return (Future.Create)((self._stateEffects)[index], {init = true})
    end
  end
end

OrderedCollection.RestoreState = function(self, state)
  -- function num : 0_8 , upvalues : OrderedCollection, _ENV, restore
  if state == 0 then
    return ((OrderedCollection.super).RestoreState)(self, state)
  else
    if state == 2 then
      return ((OrderedCollection.super).RestoreState)(self, (table.nums)(self._stateEffects) - 1)
    else
      local root = (EffectFactory.CreateComposedEffect)()
      for _,v in ipairs(self._restored) do
        root:AddEffect(restore(self, v))
      end
      self._restored = {}
      return root
    end
  end
end

OrderedCollection.RestorePart = function(self, switchid)
  -- function num : 0_9 , upvalues : _ENV, Future
  if self._state == (table.nums)(self._stateEffects) - 1 then
    return (Future.NoOp)()
  end
  if not self._restored then
    self._restored = {}
    local index = nil
    for i,v in pairs((self._effectArgs).switches) do
      if v.id == switchid then
        index = i
        break
      end
    end
    do
      -- DECOMPILER ERROR at PC30: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (self._restored)[index] = switchid
    end
  end
end

return OrderedCollection

