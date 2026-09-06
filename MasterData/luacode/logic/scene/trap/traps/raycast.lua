local Trap = require("logic.scene.trap.trap")
local Raycast = class("Raycast", Trap)
local Future = require("logic.scene.luaevent.effect.future")

function Raycast:Activate()
  self:BuildStateEffects()
end

function Raycast:ToNextState()
  if self._state == 0 then
    return Raycast.super.ToNextState(self)
  end
  return Future.NoOp()
end

return Raycast
