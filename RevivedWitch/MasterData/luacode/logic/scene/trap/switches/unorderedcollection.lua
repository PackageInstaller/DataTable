-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/trap/switches/unorderedcollection.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Switch = require("logic.scene.trap.switch")
local UnorderedCollection = class("UnorderedCollection", Switch)
local StaticEvent = require("logic.scene.luaevent.event.staticevent")
local Future = require("logic.scene.luaevent.effect.future")
UnorderedCollection.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : UnorderedCollection
  ((UnorderedCollection.super).Ctor)(self, ...)
end

UnorderedCollection.BuildStateEffects = function(self)
  -- function num : 0_1 , upvalues : UnorderedCollection, _ENV, StaticEvent
  ((UnorderedCollection.super).BuildStateEffects)(self)
  local tmp = {}
  tmp[0] = (self._stateEffects)[0]
  for i,v in ipairs(self._partInfo) do
    local root = (EffectFactory.CreateEffectList)()
    root:AddEffect((self._stateEffects)[1])
    root:AddEffect((StaticEvent.CreateSwitchEffect)(v.effectid))
    root:Bind(self._object)
    tmp[#tmp + 1] = root
  end
  tmp[#tmp + 1] = (self._stateEffects)[2]
  self._stateEffects = tmp
end

UnorderedCollection.AddPartEffects = function(self, info)
  -- function num : 0_2
  self._partInfo = info
end

UnorderedCollection.ToNextState = function(self, args)
  -- function num : 0_3 , upvalues : _ENV, UnorderedCollection
  if self._state == (table.nums)(self._stateEffects) - 3 then
    local root = (EffectFactory.CreateComposedEffect)()
    local effect = ((UnorderedCollection.super).ToNextState)(self, args)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    effect = ((UnorderedCollection.super).ToNextState)(self, args)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    return root
  else
    do
      do return ((UnorderedCollection.super).ToNextState)(self, args) end
    end
  end
end

UnorderedCollection.AddPart = function(self, switchid, args)
  -- function num : 0_4 , upvalues : _ENV, Future
  for _,v in pairs(self._partInfo) do
    if switchid == v.index then
      return self:ToNextState(args)
    end
  end
  return (Future.NoOp)()
end

UnorderedCollection.RestoreState = function(self, state)
  -- function num : 0_5 , upvalues : UnorderedCollection, _ENV, Future
  if state == 0 then
    return ((UnorderedCollection.super).RestoreState)(self, state)
  else
    if state == 2 then
      return ((UnorderedCollection.super).RestoreState)(self, (table.nums)(self._stateEffects) - 1)
    else
      return (Future.NoOp)()
    end
  end
end

UnorderedCollection.RestorePart = function(self, switchid)
  -- function num : 0_6 , upvalues : _ENV, Future
  if not self._state then
    do return self:ToState((self._state and self._state == (table.nums)(self._stateEffects) - 1 or 0) + 1, {init = true}) end
    return (Future.NoOp)()
  end
end

return UnorderedCollection

