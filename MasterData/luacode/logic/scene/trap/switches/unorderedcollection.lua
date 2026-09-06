local Switch = require("logic.scene.trap.switch")
local UnorderedCollection = class("UnorderedCollection", Switch)
local StaticEvent = require("logic.scene.luaevent.event.staticevent")
local Future = require("logic.scene.luaevent.effect.future")

function UnorderedCollection:Ctor(...)
  UnorderedCollection.super.Ctor(self, ...)
end

function UnorderedCollection:BuildStateEffects()
  UnorderedCollection.super.BuildStateEffects(self)
  local tmp = {}
  tmp[0] = self._stateEffects[0]
  for i, v in ipairs(self._partInfo) do
    local root = EffectFactory.CreateEffectList()
    root:AddEffect(self._stateEffects[1])
    root:AddEffect(StaticEvent.CreateSwitchEffect(v.effectid))
    root:Bind(self._object)
    tmp[#tmp + 1] = root
  end
  tmp[#tmp + 1] = self._stateEffects[2]
  self._stateEffects = tmp
end

function UnorderedCollection:AddPartEffects(info)
  self._partInfo = info
end

function UnorderedCollection:ToNextState(args)
  if self._state == table.nums(self._stateEffects) - 3 then
    local root = EffectFactory.CreateComposedEffect()
    local effect = UnorderedCollection.super.ToNextState(self, args)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    effect = UnorderedCollection.super.ToNextState(self, args)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    return root
  else
    return UnorderedCollection.super.ToNextState(self, args)
  end
end

function UnorderedCollection:AddPart(switchid, args)
  for _, v in pairs(self._partInfo) do
    if switchid == v.index then
      return self:ToNextState(args)
    end
  end
  return Future.NoOp()
end

function UnorderedCollection:RestoreState(state)
  if state == 0 then
    return UnorderedCollection.super.RestoreState(self, state)
  elseif state == 2 then
    return UnorderedCollection.super.RestoreState(self, table.nums(self._stateEffects) - 1)
  else
    return Future.NoOp()
  end
end

function UnorderedCollection:RestorePart(switchid)
  if not self._state or self._state ~= table.nums(self._stateEffects) - 1 then
    return self:ToState((self._state or 0) + 1, {init = true})
  end
  return Future.NoOp()
end

return UnorderedCollection
