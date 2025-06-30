-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/trap/components/state/statebase.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local StateBase = class("StateBase")
StateBase.StateType = {Normal = 1, Damage = 2, SP = 3}
StateBase.Ctor = function(self)
  -- function num : 0_0
end

StateBase.GetCurrentState = function(self)
  -- function num : 0_1 , upvalues : _ENV
  assert(false)
end

StateBase.NextState = function(self)
  -- function num : 0_2 , upvalues : _ENV
  assert(false)
end

StateBase.OnUpdate = function(self, deltaTime)
  -- function num : 0_3
end

StateBase.OnStateChange = function(self)
  -- function num : 0_4
end

return StateBase

