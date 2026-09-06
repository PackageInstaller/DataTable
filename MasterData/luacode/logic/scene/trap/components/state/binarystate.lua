local StateBase = require("logic.scene.trap.components.state.statebase")
local BinaryState = class("BinaryState", StateBase)

function BinaryState:Ctor(initial_state, statechange)
  self._states = {
    self.StateType.Normal,
    self.StateType.Damage
  }
  self._current = initial_state or 0
  self._callback = statechange
end

function BinaryState:GetCurrentState()
  return self._states[self._current + 1]
end

function BinaryState:NextState()
  self._current = (self._current + 1) % #self._states
  self:OnStateChange()
  return self:GetCurrentState()
end

function BinaryState:OnUpdate(deltaTime)
end

function BinaryState:OnStateChange()
  if self._callback then
    self._callback()
  end
end

return BinaryState
