local Switch = require("logic.scene.trap.switch")
local JailBreaker = class("JailBreaker", Switch)
local FixedPos = require("logic.scene.trap.components.trigger.fixedpos")

function JailBreaker:Ctor(...)
  JailBreaker.super.Ctor(self, ...)
end

function JailBreaker:Destroy()
  self._builder:Destroy()
end

function JailBreaker:Activate()
  self._builder = FixedPos.Create(self, self:GetEffectArea())
  self:BuildStateEffects()
  local event = self._builder:BuildEnterEvent()
  EventManager.AddEvent(event)
end

function JailBreaker:Deactivate()
  JailBreaker.super.Deactivate(self)
end

function JailBreaker:OnEnterArea()
  self:ToNextState():Run()
end

function JailBreaker:OnLeaveArea()
  self:ToNextState():Run()
end

return JailBreaker
