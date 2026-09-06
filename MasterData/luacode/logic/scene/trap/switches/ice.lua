local Switch = require("logic.scene.trap.switch")
local Ice = class("Ice", Switch)
local Future = require("logic.scene.luaevent.effect.future")
local FixedPos = require("logic.scene.trap.components.trigger.fixedpos")

function Ice:Ctor(...)
  Ice.super.Ctor(self, ...)
  local x, y, z = CS.PixelNeko.Lua.TransformStaticFunctions.GetPosition(self._object)
  self._effectAreas = {
    {
      x = math.floor(x / 0.4 + 0.5),
      y = math.floor(z / -0.56 + 0.5)
    }
  }
  self._builder = FixedPos.Create(self, self:GetEffectArea())
end

function Ice:Destroy()
  Ice.super.Destroy(self)
  if self._builder then
    self._builder:Destroy()
  end
end

function Ice:BuildStateEffects()
  Ice.super.BuildStateEffects(self)
  do
    local root = EffectFactory.CreateComposedEffect()
    root:AddEffect(self._stateEffects[0])
    local effect = EffectFactory.CreateBlockChangeEffect(self._effectAreas[1].x, self._effectAreas[1].y, 1, 1, false)
    root:AddEffect(effect)
    root:Bind(self._object)
    self._stateEffects[0] = root
  end
  do
    local root = EffectFactory.CreateComposedEffect()
    root:AddEffect(self._stateEffects[1])
    local effect = EffectFactory.CreateBlockChangeEffect(self._effectAreas[1].x, self._effectAreas[1].y, 1, 1, true)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    root:Bind(self._object)
    self._stateEffects[1] = root
  end
end

function Ice:Activate()
  Ice.super.Activate(self)
  local event = self._builder:BuildEnterEvent()
  EventManager.AddEvent(event)
end

function Ice:Deactivate()
  Ice.super.Deactivate(self)
  if self._builder then
    self._builder:Destroy()
  end
end

function Ice:ToState(state, args)
  if state == 1 then
    local info = self._effectArgs.switches[1]
    local skate = SwitchManager.GetSwitch(info.instance, info.id)
    if skate:GetState() == 0 and (not args or not args.init) then
      return Future.NoOp()
    end
  end
  return Ice.super.ToState(self, state, args)
end

function Ice:ToNextState()
  local state = ((self._state or 0) + 1) % table.nums(self._stateEffects)
  return self:ToState(state)
end

function Ice:OnEnterArea(builder)
end

function Ice:OnLeaveArea(builder)
  self:ToState(1):Run()
end

return Ice
