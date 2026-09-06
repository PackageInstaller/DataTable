local Switch = require("logic.scene.trap.switch")
local Mirror = class("Mirror", Switch)
local StaticEvent = require("logic.scene.luaevent.event.staticevent")

function Mirror:Ctor(...)
  Mirror.super.Ctor(self, ...)
end

function Mirror:BuildStateEffects()
  Mirror.super.BuildStateEffects(self)
end

function Mirror:SetStateInfo(info)
  self._lightEffects = {}
  for state, effectid in pairs(info) do
    self._lightEffects[state] = StaticEvent.CreateSwitchEffect(effectid)
  end
end

function Mirror:Activate()
  self:BuildStateEffects()
  self:BuildSceneObject()
end

function Mirror:ShowLight(has_income)
  if not self._state then
    return
  end
  if has_income then
    self._lightEffects[self._state + 1]:Run()
    self._lightState = self._state + 1
  else
    self._lightEffects[0]:Run()
    self._lightState = 0
  end
end

function Mirror:GetLightState()
  return self._lightState or 0
end

return Mirror
