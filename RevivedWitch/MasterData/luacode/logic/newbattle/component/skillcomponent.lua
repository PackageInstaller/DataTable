-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/component/skillcomponent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Component = require("ecs.component")
local SkillComponent = dataclass("SkillComponent", Component)
SkillComponent.SkillIndexType = {BigSkill = 2}
SkillComponent.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SkillComponent, _ENV
  ((SkillComponent.super).Ctor)(self, ...)
  self._skillId = 0
  self._buffCastSkillId = 0
  self._isClickUseSkill = false
  self._skillList = {}
  self._skillCostPowerList = {}
  self._skillCostPowerReduceList = {}
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._skillCostPowerReduceList).chaos = fixedpoint_zero
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._skillCostPowerReduceList).order = fixedpoint_zero
  self._passiveSkillList = {}
  self._attackEntitySkillList = {}
  self._isCostPower = true
  self._comboNumber = fixedpoint_zero
  self._bossComboNumber = fixedpoint_zero
  self._hittedEntityNumber = 0
  self._skillCoolDownReduce = fixedpoint_zero
  self._isHasPassiveSkillParamter = fixedpoint_zero
  self._useActSkillList = {}
  self._comborate1 = fixedpoint_zero
  self._comborate2 = fixedpoint_zero
  self._comborateRemainingNum = fixedpoint_zero
end

return SkillComponent

