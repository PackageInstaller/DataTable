local Trap = require("logic.scene.trap.trap")
local Elevator = class("Elevator", Trap)

function Elevator:Ctor(...)
  Elevator.super.Ctor(self, ...)
  local x, y, z = CS.PixelNeko.Lua.TransformStaticFunctions.GetPosition(self._object)
  self._blocks = {
    x = math.floor(x / 0.4 + 0.5),
    y = math.floor(z / -0.56 + 0.5)
  }
end

function Elevator:Activate()
  Elevator.super.Activate(self)
  self:BuildStateEffects()
end

function Elevator:OnStateChange(args)
  local future = Elevator.super.OnStateChange(self, args)
  local effect = EffectFactory.CreateBlockChangeEffect(self._blocks.x, self._blocks.y, 1, 1, self:GetState() == 1)
  effect:Run()
  return future
end

return Elevator
