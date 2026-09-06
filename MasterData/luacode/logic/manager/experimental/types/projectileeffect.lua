local BattleSceneHelper = CS.PixelNeko.P1.Scene.Battle.BattleSceneHelper
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local AnimationHelper = CS.PixelNeko.Animation.AnimationHelper
local ProjectileEffect = class("ProjectileEffect")

function ProjectileEffect:Ctor()
  self._entityId = 0
  self._playerEntityId = 0
  self._skillId = 0
  self._position = {
    x = 0,
    y = 0,
    z = 0
  }
  self._radian = 0
  self._gameObject = nil
  self._camp = nil
end

function ProjectileEffect:Destroy()
  if self._gameObject then
    CS.PixelNeko.Common.GameObjectHelper.DestroyObject(self._gameObject)
    self._gameObject = nil
  end
end

function ProjectileEffect:Init(entityId, playerEntityId, skillId, camp, gameObject)
  self._entityId = entityId
  self.playerEntityId = playerEntityId
  self._skillId = skillId
  self._camp = camp
  self._gameObject = gameObject
  self._position.x, self._position.y, self._position.z = TransformStaticFunctions.GetPosition(self._gameObject)
  self._position.x, self._position.y, self._position.z = self._position.x * 1000, self._position.y * 1000, self._position.z * 1000
end

function ProjectileEffect:IsLeftCamp()
  local def = BattleClientProtocolManager.GetBeanDef("data.enum_camp")
  return self._camp == def.LeftFighter
end

function ProjectileEffect:IsRightCamp()
  local def = BattleClientProtocolManager.GetBeanDef("data.enum_camp")
  return self._camp == def.RightFighter
end

function ProjectileEffect:SetPosition(posX, posY, posZ)
  posZ = posZ or self._position.z
  self._position.x, self._position.y, self._position.z = posX, posY, posZ
  if self._gameObject then
    TransformStaticFunctions.SetPosition(self._gameObject, self._position.x / 1000, self._position.y / 1000, self._position.z / 1000)
  end
end

function ProjectileEffect:SetRadian(radian)
  self._radian = radian
end

return ProjectileEffect
