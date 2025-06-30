-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/types/projectileeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BattleSceneHelper = ((((CS.PixelNeko).P1).Scene).Battle).BattleSceneHelper
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local AnimationHelper = ((CS.PixelNeko).Animation).AnimationHelper
local ProjectileEffect = class("ProjectileEffect")
ProjectileEffect.Ctor = function(self)
  -- function num : 0_0
  self._entityId = 0
  self._playerEntityId = 0
  self._skillId = 0
  self._position = {x = 0, y = 0, z = 0}
  self._radian = 0
  self._gameObject = nil
  self._camp = nil
end

ProjectileEffect.Destroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if self._gameObject then
    ((((CS.PixelNeko).Common).GameObjectHelper).DestroyObject)(self._gameObject)
    self._gameObject = nil
  end
end

ProjectileEffect.Init = function(self, entityId, playerEntityId, skillId, camp, gameObject)
  -- function num : 0_2 , upvalues : TransformStaticFunctions
  self._entityId = entityId
  self.playerEntityId = playerEntityId
  self._skillId = skillId
  self._camp = camp
  self._gameObject = gameObject
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R8 in 'UnsetPending'

  -- DECOMPILER ERROR at PC12: Confused about usage of register: R7 in 'UnsetPending'

  -- DECOMPILER ERROR at PC13: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self._position).x = (TransformStaticFunctions.GetPosition)(self._gameObject)
  -- DECOMPILER ERROR at PC24: Overwrote pending register: R11 in 'AssignReg'

  -- DECOMPILER ERROR at PC25: Overwrote pending register: R11 in 'AssignReg'

  -- DECOMPILER ERROR at PC26: Confused about usage of register: R8 in 'UnsetPending'

  -- DECOMPILER ERROR at PC27: Confused about usage of register: R7 in 'UnsetPending'

  -- DECOMPILER ERROR at PC28: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self._position).x = (self._position).x * 1000
end

ProjectileEffect.IsLeftCamp = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local def = (BattleClientProtocolManager.GetBeanDef)("data.enum_camp")
  do return self._camp == def.LeftFighter end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ProjectileEffect.IsRightCamp = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local def = (BattleClientProtocolManager.GetBeanDef)("data.enum_camp")
  do return self._camp == def.RightFighter end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ProjectileEffect.SetPosition = function(self, posX, posY, posZ)
  -- function num : 0_5 , upvalues : TransformStaticFunctions
  if not posZ then
    posZ = (self._position).z
  end
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R6 in 'UnsetPending'

  -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

  -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._position).x = posX
  if self._gameObject then
    (TransformStaticFunctions.SetPosition)(self._gameObject, (self._position).x / 1000, (self._position).y / 1000, (self._position).z / 1000)
  end
end

ProjectileEffect.SetRadian = function(self, radian)
  -- function num : 0_6
  self._radian = radian
end

return ProjectileEffect

