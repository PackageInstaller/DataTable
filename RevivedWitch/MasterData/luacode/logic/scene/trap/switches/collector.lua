-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/trap/switches/collector.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Switch = require("logic.scene.trap.switch")
local Collector = class("Collector", Switch)
local Future = require("logic.scene.luaevent.effect.future")
Collector.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : Collector
  ((Collector.super).Ctor)(self, ...)
end

Collector.BuildStateEffects = function(self)
  -- function num : 0_1 , upvalues : Collector
  ((Collector.super).BuildStateEffects)(self)
end

Collector.ToState = function(self, state, args)
  -- function num : 0_2 , upvalues : _ENV, Future
  self._state = state
  if (SwitchManager.IsRestoreMode)() then
    return (Future.NoOp)()
  else
    local root = (EffectFactory.CreateComposedEffect)()
    if state == 0 then
      do
        if args.error == self._id then
          local effect = (self._stateEffects)[0]
          effect:Bind((self:GetTargetCollection()):GetObject())
          root:AddEffect(effect)
        end
        local info = (self._partInfo).target
        do
          local switch = (SwitchManager.GetSwitch)(info.instance, info.id)
          root:AddEffect(switch:ToState(0))
          root:AddEffect((self:GetTargetCollection()):AddPart(self:GetID()))
          do return root end
        end
      end
    end
  end
end

Collector.ToNextState = function(self)
  -- function num : 0_3 , upvalues : Future
  if self._state == 1 then
    return (Future.NoOp)()
  end
  return self:ToState((self._state or 0) + 1)
end

Collector.SetPartInfo = function(self, info)
  -- function num : 0_4
  self._partInfo = info
end

Collector.RestoreState = function(self, state)
  -- function num : 0_5 , upvalues : _ENV, Future
  if state == 1 then
    local info = ((self._effectArgs).switches)[1]
    local switch = (SwitchManager.GetSwitch)(info.instance, info.id)
    return switch:RestorePart(self:GetID())
  end
  do
    return (Future.NoOp)()
  end
end

Collector.GetTargetCollection = function(self)
  -- function num : 0_6 , upvalues : _ENV
  do
    if not self._target then
      local info = ((self._effectArgs).switches)[1]
      self._target = (SwitchManager.GetSwitch)(info.instance, info.id)
    end
    return self._target
  end
end

return Collector

