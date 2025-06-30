-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/component/skilleffectcomponent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Component = require("ecs.component")
local SkillEffectComponent = dataclass("SkillEffectComponent", Component)
SkillEffectComponent.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SkillEffectComponent, _ENV
  ((SkillEffectComponent.super).Ctor)(self, ...)
  self._flightPropEffectAtk = {}
  self._typeMineEffectAtkList = {}
  self._invalidEffectAtkList = {}
  self._noColliderEffectList = {}
  self._warningEffectList = {}
  self._animationAtkList = {}
  self._startAnimationDelayTime = 0
  self._useSkillEntityID = 0
  self._attackEntityList = {}
  self._attackTime = 0
  self._skillID = 0
  self._flyEntityList = {}
  self._flyNeedDestroyMaxFrap = 0
  self._randomDeltXOffect = fixedpoint_zero
  self._typeMineEffectAtkEffectTime = 0
end

return SkillEffectComponent

