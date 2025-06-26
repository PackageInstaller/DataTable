-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/component/buffcomponent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Component = require("ecs.component")
local BuffComponent = dataclass("BuffComponent", Component)
BuffComponent.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BuffComponent, _ENV
  ((BuffComponent.super).Ctor)(self, ...)
  self._buffList = {}
  self._dispelbuffnum = 0
  self._buffnum = {}
  self._orderPowerCost = fixedpoint_zero
  self._chaosPowerCost = fixedpoint_zero
  self._phyDmgLimit = -fixedpoint.maxinteger
  self._magicDmgLimit = -fixedpoint.maxinteger
  self._dmgLimitRate = fixedpoint_zero
  self._bringOutPhyDmgLimit = -fixedpoint.maxinteger
  self._bringOutMagicDmgLimit = -fixedpoint.maxinteger
  self._delayBuffList = {}
  self._isPowerCost = {Order = false, Chaos = false}
  self._attackTime = fixedpoint_zero
  self._removeBuffClassNameList = {}
  self._isHasChangeBuff = {}
  self._skillsectionendbuffSnapShoot = {}
  self._skillsectionendbuffSkillId = 0
  self._skillsectionendbuffSkillEffect = {}
end

return BuffComponent

