-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/trap/traps/elevator.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Trap = require("logic.scene.trap.trap")
local Elevator = class("Elevator", Trap)
Elevator.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : Elevator, _ENV
  ((Elevator.super).Ctor)(self, ...)
  local x, y, z = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetPosition)(self._object)
  self._blocks = {x = (math.floor)(x / 0.4 + 0.5), y = (math.floor)(z / -0.56 + 0.5)}
end

Elevator.Activate = function(self)
  -- function num : 0_1 , upvalues : Elevator
  ((Elevator.super).Activate)(self)
  self:BuildStateEffects()
end

Elevator.OnStateChange = function(self, args)
  -- function num : 0_2 , upvalues : Elevator, _ENV
  local future = ((Elevator.super).OnStateChange)(self, args)
  local effect = (EffectFactory.CreateBlockChangeEffect)((self._blocks).x, (self._blocks).y, 1, 1, self:GetState() == 1)
  effect:Run()
  do return future end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return Elevator

