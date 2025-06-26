-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/trap/components/state/binarystate.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local StateBase = require("logic.scene.trap.components.state.statebase")
local BinaryState = class("BinaryState", StateBase)
BinaryState.Ctor = function(self, initial_state, statechange)
  -- function num : 0_0
  self._states = {(self.StateType).Normal, (self.StateType).Damage}
  self._current = initial_state or 0
  self._callback = statechange
end

BinaryState.GetCurrentState = function(self)
  -- function num : 0_1
  return (self._states)[self._current + 1]
end

BinaryState.NextState = function(self)
  -- function num : 0_2
  self._current = (self._current + 1) % #self._states
  self:OnStateChange()
  return self:GetCurrentState()
end

BinaryState.OnUpdate = function(self, deltaTime)
  -- function num : 0_3
end

BinaryState.OnStateChange = function(self)
  -- function num : 0_4
  if self._callback then
    (self._callback)()
  end
end

return BinaryState

