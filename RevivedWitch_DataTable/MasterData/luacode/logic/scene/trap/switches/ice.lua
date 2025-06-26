-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/trap/switches/ice.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Switch = require("logic.scene.trap.switch")
local Ice = class("Ice", Switch)
local Future = require("logic.scene.luaevent.effect.future")
local FixedPos = require("logic.scene.trap.components.trigger.fixedpos")
Ice.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : Ice, _ENV, FixedPos
  ((Ice.super).Ctor)(self, ...)
  local x, y, z = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetPosition)(self._object)
  self._effectAreas = {
{x = (math.floor)(x / 0.4 + 0.5), y = (math.floor)(z / -0.56 + 0.5)}
}
  self._builder = (FixedPos.Create)(self, self:GetEffectArea())
end

Ice.Destroy = function(self)
  -- function num : 0_1 , upvalues : Ice
  ((Ice.super).Destroy)(self)
  if self._builder then
    (self._builder):Destroy()
  end
end

Ice.BuildStateEffects = function(self)
  -- function num : 0_2 , upvalues : Ice, _ENV
  ((Ice.super).BuildStateEffects)(self)
  local root = (EffectFactory.CreateComposedEffect)()
  root:AddEffect((self._stateEffects)[0])
  do
    local effect = (EffectFactory.CreateBlockChangeEffect)(((self._effectAreas)[1]).x, ((self._effectAreas)[1]).y, 1, 1, false)
    root:AddEffect(effect)
    root:Bind(self._object)
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._stateEffects)[0] = root
    local root = (EffectFactory.CreateComposedEffect)()
    root:AddEffect((self._stateEffects)[1])
    local effect = (EffectFactory.CreateBlockChangeEffect)(((self._effectAreas)[1]).x, ((self._effectAreas)[1]).y, 1, 1, true)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    root:Bind(self._object)
    -- DECOMPILER ERROR at PC60: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._stateEffects)[1] = root
  end
end

Ice.Activate = function(self)
  -- function num : 0_3 , upvalues : Ice, _ENV
  ((Ice.super).Activate)(self)
  local event = (self._builder):BuildEnterEvent()
  ;
  (EventManager.AddEvent)(event)
end

Ice.Deactivate = function(self)
  -- function num : 0_4 , upvalues : Ice
  ((Ice.super).Deactivate)(self)
  if self._builder then
    (self._builder):Destroy()
  end
end

Ice.ToState = function(self, state, args)
  -- function num : 0_5 , upvalues : _ENV, Future, Ice
  if state == 1 then
    local info = ((self._effectArgs).switches)[1]
    local skate = (SwitchManager.GetSwitch)(info.instance, info.id)
    if skate:GetState() == 0 and (not args or not args.init) then
      return (Future.NoOp)()
    end
  end
  do
    return ((Ice.super).ToState)(self, state, args)
  end
end

Ice.ToNextState = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local state = ((self._state or 0) + 1) % (table.nums)(self._stateEffects)
  return self:ToState(state)
end

Ice.OnEnterArea = function(self, builder)
  -- function num : 0_7
end

Ice.OnLeaveArea = function(self, builder)
  -- function num : 0_8
  (self:ToState(1)):Run()
end

return Ice

