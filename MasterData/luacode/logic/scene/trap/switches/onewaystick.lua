local Switch = require("logic.scene.trap.switch")
local OneWayStick = class("OneWayStick", Switch)
local Future = require("logic.scene.luaevent.effect.future")

function OneWayStick:Ctor(...)
  OneWayStick.super.Ctor(self, ...)
end

function OneWayStick:Activate()
  self:BuildStateEffects()
  self:BuildSceneObject()
end

function OneWayStick:Deactivate()
  OneWayStick.super.Deactivate(self)
end

function OneWayStick:ToNextState()
  if self._state == 1 then
    return Future.NoOp()
  end
  return OneWayStick.super.ToNextState(self)
end

return OneWayStick
