-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/component/positioncomponent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Component = require("ecs.component")
local PositionComponent = dataclass("PositionComponent", Component)
PositionComponent.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : PositionComponent, _ENV
  ((PositionComponent.super).Ctor)(self, ...)
  self._position = {}
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._position).x = fixedpoint_zero
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._position).y = fixedpoint_zero
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._position).z = fixedpoint_zero
  self._targetPos = {}
  self._velocity = {}
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._velocity).x = fixedpoint_zero
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._velocity).y = fixedpoint_zero
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._velocity).z = fixedpoint_zero
  self._toUseSkillEntityPositonDeltaPosition = {}
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._toUseSkillEntityPositonDeltaPosition).x = fixedpoint_zero
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._toUseSkillEntityPositonDeltaPosition).y = fixedpoint_zero
end

return PositionComponent

