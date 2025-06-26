-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/component/typecomponent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Component = require("ecs.component")
local TypeComponent = dataclass("TypeComponent", Component)
TypeComponent.CampType = {None = 0, Left = 1, Right = 2, Both = 3}
TypeComponent.ElementType = {None = 0, Mercury = 1, SaltStone = 2, SulfurFire = 3, Ether = 4}
TypeComponent.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TypeComponent
  ((TypeComponent.super).Ctor)(self, ...)
  self._camp = (TypeComponent.CampType).None
  self._isNeedDestroy = false
  self._isNeedSendProtocolDestroy = true
  self._roleID = 0
  self._roleElementType = 0
  self._roleVocationType = 0
  self._monsterType = 0
  self._changeShapeID = 0
  self._rolePointNum = 0
  self._bindingSkillID = 0
  self._summonName = ""
  self._summonScenePosition = 0
  self._summonFatherEntityid = 0
  self._isImaged = false
  self._imageFatherEntityID = 0
  self._oriShapeAssetBundleName = ""
  self._oriShapePrefabName = ""
  self._level = 0
  self._evolutionLevel = 0
  self._exclusiveLevel = 0
  self._runelv = 0
end

return TypeComponent

