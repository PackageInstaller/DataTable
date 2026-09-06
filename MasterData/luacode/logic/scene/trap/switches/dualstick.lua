local Switch = require("logic.scene.trap.switch")
local DualStick = class("DualStick", Switch)

function DualStick:Ctor(...)
  DualStick.super.Ctor(self, ...)
end

function DualStick:Activate()
  self:BuildStateEffects()
  self:BuildSceneObject()
end

function DualStick:Deactivate()
  DualStick.super.Deactivate(self)
end

return DualStick
