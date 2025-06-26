-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/component/hpcomponent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Component = require("ecs.component")
local HpComponent = dataclass("HpComponent", Component)
HpComponent.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : HpComponent, _ENV
  ((HpComponent.super).Ctor)(self, ...)
  self._maxHp = fixedpoint_zero
  self._basicMaxHp = fixedpoint_zero
  self._currentHp = fixedpoint_zero
  self._damageSheildNumberList = {}
  self._lastDamage = fixedpoint_zero
  self._lastDamageFrom = 0
  self._skillListOnceDamage = {}
  self._totalDamage = fixedpoint_zero
  self._elementDamageList = {}
  self._hpStage = "alive"
  self._buffDamgeSkillId = 0
  self._forceCritFlag = false
end

return HpComponent

