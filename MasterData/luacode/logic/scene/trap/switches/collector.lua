local Switch = require("logic.scene.trap.switch")
local Collector = class("Collector", Switch)
local Future = require("logic.scene.luaevent.effect.future")

function Collector:Ctor(...)
  Collector.super.Ctor(self, ...)
end

function Collector:BuildStateEffects()
  Collector.super.BuildStateEffects(self)
end

function Collector:ToState(state, args)
  self._state = state
  if SwitchManager.IsRestoreMode() then
    return Future.NoOp()
  else
    local root = EffectFactory.CreateComposedEffect()
    if state == 0 then
      if args.error == self._id then
        local effect = self._stateEffects[0]
        effect:Bind(self:GetTargetCollection():GetObject())
        root:AddEffect(effect)
      end
      local info = self._partInfo.target
      local switch = SwitchManager.GetSwitch(info.instance, info.id)
      root:AddEffect(switch:ToState(0))
    else
      root:AddEffect(self:GetTargetCollection():AddPart(self:GetID()))
    end
    return root
  end
end

function Collector:ToNextState()
  if self._state == 1 then
    return Future.NoOp()
  end
  return self:ToState((self._state or 0) + 1)
end

function Collector:SetPartInfo(info)
  self._partInfo = info
end

function Collector:RestoreState(state)
  if state == 1 then
    local info = self._effectArgs.switches[1]
    local switch = SwitchManager.GetSwitch(info.instance, info.id)
    return switch:RestorePart(self:GetID())
  end
  return Future.NoOp()
end

function Collector:GetTargetCollection()
  if not self._target then
    local info = self._effectArgs.switches[1]
    self._target = SwitchManager.GetSwitch(info.instance, info.id)
  end
  return self._target
end

return Collector
