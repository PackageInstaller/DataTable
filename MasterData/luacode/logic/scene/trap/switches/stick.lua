local Switch = require("logic.scene.trap.switch")
local Stick = class("Stick", Switch)

function Stick:Ctor(...)
  Stick.super.Ctor(self, ...)
end

function Stick:Activate()
  self:BuildStateEffects()
  self:BuildSceneObject()
end

function Stick:Deactivate()
  Stick.super.Deactivate(self)
end

return Stick
