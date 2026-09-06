local System = require("ecs.system")
local SpritePhysicsSystem = strictclass("SpritePhysicsSystem", System)

function SpritePhysicsSystem:Ctor(...)
  SpritePhysicsSystem.super.Ctor(self, ...)
  self._utility = BattleECS.Utility.Utility
  self._buffUtility = BattleECS.Utility.BuffUtility
end

function SpritePhysicsSystem:Destroy()
  SpritePhysicsSystem.super.Destroy(self)
end

function SpritePhysicsSystem:Update()
  local PhysicsComponent = BattleECS.Components.PhysicsComponent
  local FlySkillDataComponent = BattleECS.Components.FlySkillDataComponent
  local TypeComponent = BattleECS.Components.TypeComponent
  self:CountHittedEntityNumber(self._world._leftPlayerList)
  self:CountHittedEntityNumber(self._world._leftPlayerSummonList)
  self:CountHittedEntityNumber(self._world._rightPlayerList)
  self:CountHittedEntityNumber(self._world._rightPlayerSummonList)
  for _, entity in ipairs(self._world._leftPlayerList) do
    for _, v in ipairs(entity:GetComponent(PhysicsComponent)._hittedContactList) do
      local useSkillEntity
      for i, e in ipairs(self._world._entitys) do
        if e._entityId == v.useSkillEntityID then
          useSkillEntity = e
          break
        end
      end
      local vEntity
      for i, e in ipairs(self._world._entitys) do
        if e._entityId == v.entityid then
          vEntity = e
          break
        end
      end
      if v.skillid ~= 0 and v.isEffect then
        if self._utility.IsMoLiZhenDang(v.skillid) then
          v.isEffect = false
          self._buffUtility.SetBuffListToOwnCampEntityBySkillID(entity, useSkillEntity, v.skillid, self._world)
        elseif vEntity then
          local typeComponent = vEntity:GetComponent(TypeComponent)
          if self._world:GetCampWinState() == "" then
            self._buffUtility.SetBuffListToEnemyCampEntityBySkillID(entity, useSkillEntity, v.skillid, self._world, 0)
          end
          local component = vEntity:GetComponent(FlySkillDataComponent)
          if component then
            if component._skillEffectType == FlySkillDataComponent.SkillEffectType.FlyProp or component._skillEffectType == FlySkillDataComponent.SkillEffectType.ConfirmFlyProp then
              component._skillCurrentContactNumber = component._skillCurrentContactNumber + 1
              v.isEffect = false
              if component._skillCurrentContactNumber >= component._skillMaxContactNumber then
                vEntity:GetComponent(PhysicsComponent)._isNeedReleaseBox = true
                typeComponent._isNeedDestroy = true
                for i, inV in ipairs(self._world._playerSkillEffectEntityList) do
                  if inV._entityId == vEntity._entityId then
                    table.remove(self._world._playerSkillEffectEntityList, i)
                    break
                  end
                end
              end
            elseif component._skillEffectType == FlySkillDataComponent.SkillEffectType.ConfirmProp then
              v.isEffect = false
            elseif component._skillEffectType == FlySkillDataComponent.SkillEffectType.ParaFlyProp then
              v.isEffect = false
              vEntity:GetComponent(PhysicsComponent)._isNeedReleaseBox = true
              typeComponent._isNeedDestroy = true
            end
          else
            v.isEffect = false
            vEntity:GetComponent(PhysicsComponent)._isNeedReleaseBox = true
            typeComponent._isNeedDestroy = true
          end
        end
      end
    end
  end
  for _, entity in ipairs(self._world._leftPlayerSummonList) do
    for _, v in ipairs(entity:GetComponent(PhysicsComponent)._hittedContactList) do
      local useSkillEntity
      for i, e in ipairs(self._world._entitys) do
        if e._entityId == v.useSkillEntityID then
          useSkillEntity = e
          break
        end
      end
      if not (v.skillid ~= 0 and v.isEffect) or self._utility.IsMoLiZhenDang(v.skillid) then
      else
        local damageEntity
        for i, e in ipairs(self._world._entitys) do
          if e._entityId == v.entityid then
            damageEntity = e
            break
          end
        end
        if damageEntity then
          if self._world:GetCampWinState() == "" then
            self._buffUtility.SetBuffListToEnemyCampEntityBySkillID(entity, useSkillEntity, v.skillid, self._world, 0)
          end
          local component = damageEntity:GetComponent(FlySkillDataComponent)
          if component then
            if component._skillEffectType == FlySkillDataComponent.SkillEffectType.FlyProp or component._skillEffectType == FlySkillDataComponent.SkillEffectType.ConfirmFlyProp then
              component._skillCurrentContactNumber = component._skillCurrentContactNumber + 1
              v.isEffect = false
              if component._skillCurrentContactNumber >= component._skillMaxContactNumber then
                damageEntity:GetComponent(PhysicsComponent)._isNeedReleaseBox = true
                damageEntity:GetComponent(TypeComponent)._isNeedDestroy = true
                for i, inV in ipairs(self._world._playerSkillEffectEntityList) do
                  if inV._entityId == damageEntity._entityId then
                    table.remove(self._world._playerSkillEffectEntityList, i)
                    break
                  end
                end
              end
            elseif component._skillEffectType == FlySkillDataComponent.SkillEffectType.ConfirmProp then
              v.isEffect = false
            elseif component._skillEffectType == FlySkillDataComponent.SkillEffectType.ParaFlyProp then
              v.isEffect = false
            end
          else
            v.isEffect = false
            damageEntity:GetComponent(PhysicsComponent)._isNeedReleaseBox = true
            damageEntity:GetComponent(TypeComponent)._isNeedDestroy = true
          end
        end
      end
    end
  end
  for _, entity in ipairs(self._world._playerSkillEffectEntityList) do
    for _, v in ipairs(entity:GetComponent(PhysicsComponent)._hittedContactList) do
      local useSkillEntity
      for i, e in ipairs(self._world._entitys) do
        if e._entityId == v.useSkillEntityID then
          useSkillEntity = e
          break
        end
      end
      if not (v.skillid ~= 0 and v.isEffect) or self._utility.IsMoLiZhenDang(v.skillid) then
      else
        local damageEntity
        for i, e in ipairs(self._world._entitys) do
          if e._entityId == v.entityid then
            damageEntity = e
            break
          end
        end
        if damageEntity then
          if self._world:GetCampWinState() == "" then
            self._buffUtility.SetBuffListToEnemyCampEntityBySkillID(entity, useSkillEntity, v.skillid, self._world, 0)
          end
          local component = damageEntity:GetComponent(FlySkillDataComponent)
          if component then
            if component._skillEffectType == FlySkillDataComponent.SkillEffectType.FlyProp or component._skillEffectType == FlySkillDataComponent.SkillEffectType.ConfirmFlyProp then
              if entity:GetComponent(FlySkillDataComponent)._skillEffectType == FlySkillDataComponent.SkillEffectType.DefendFlyProp then
                v.isEffect = false
                damageEntity:GetComponent(PhysicsComponent)._isNeedReleaseBox = true
                damageEntity:GetComponent(TypeComponent)._isNeedDestroy = true
              else
                component._skillCurrentContactNumber = component._skillCurrentContactNumber + 1
                v.isEffect = false
                if component._skillCurrentContactNumber >= component._skillMaxContactNumber then
                  damageEntity:GetComponent(PhysicsComponent)._isNeedReleaseBox = true
                  damageEntity:GetComponent(TypeComponent)._isNeedDestroy = true
                  for i, inV in ipairs(self._world._playerSkillEffectEntityList) do
                    if inV._entityId == damageEntity._entityId then
                      table.remove(self._world._playerSkillEffectEntityList, i)
                      break
                    end
                  end
                end
              end
            elseif component._skillEffectType == FlySkillDataComponent.SkillEffectType.ConfirmProp then
              v.isEffect = false
            elseif component._skillEffectType == FlySkillDataComponent.SkillEffectType.ParaFlyProp then
              v.isEffect = false
              if entity:GetComponent(FlySkillDataComponent)._skillEffectType == FlySkillDataComponent.SkillEffectType.DefendFlyProp then
                damageEntity:GetComponent(PhysicsComponent)._isNeedReleaseBox = true
                damageEntity:GetComponent(TypeComponent)._isNeedDestroy = true
              end
            end
          else
            v.isEffect = false
            damageEntity:GetComponent(PhysicsComponent)._isNeedReleaseBox = true
            damageEntity:GetComponent(TypeComponent)._isNeedDestroy = true
          end
        end
      end
    end
  end
  for _, entity in ipairs(self._world._rightPlayerList) do
    for _, v in ipairs(entity:GetComponent(PhysicsComponent)._hittedContactList) do
      local useSkillEntity
      for i, e in ipairs(self._world._entitys) do
        if e._entityId == v.useSkillEntityID then
          useSkillEntity = e
          break
        end
      end
      local vEntity
      for i, e in ipairs(self._world._entitys) do
        if e._entityId == v.entityid then
          vEntity = e
          break
        end
      end
      if v.skillid ~= 0 and v.isEffect then
        if self._utility.IsMoLiZhenDang(v.skillid) then
          if vEntity then
            if self._world:GetCampWinState() == "" then
              self._buffUtility.SetBuffListToEnemyCampEntityBySkillID(entity, useSkillEntity, v.skillid, self._world, 0)
            end
            vEntity:GetComponent(PhysicsComponent)._isNeedReleaseBox = true
            vEntity:GetComponent(TypeComponent)._isNeedDestroy = true
          end
        elseif vEntity then
          if self._world:GetCampWinState() == "" then
            self._buffUtility.SetBuffListToEnemyCampEntityBySkillID(entity, useSkillEntity, v.skillid, self._world, v.rad)
          end
          local component = vEntity:GetComponent(FlySkillDataComponent)
          if component then
            if component._skillEffectType == FlySkillDataComponent.SkillEffectType.FlyProp or component._skillEffectType == FlySkillDataComponent.SkillEffectType.ConfirmFlyProp then
              component._skillCurrentContactNumber = component._skillCurrentContactNumber + 1
              v.isEffect = false
              if component._skillCurrentContactNumber >= component._skillMaxContactNumber then
                vEntity:GetComponent(PhysicsComponent)._isNeedReleaseBox = true
                vEntity:GetComponent(TypeComponent)._isNeedDestroy = true
                for i, inV in ipairs(self._world._playerSkillEffectEntityList) do
                  if inV._entityId == vEntity._entityId then
                    table.remove(self._world._playerSkillEffectEntityList, i)
                    break
                  end
                end
              end
            elseif component._skillEffectType == FlySkillDataComponent.SkillEffectType.ConfirmProp then
              v.isEffect = false
            end
          else
            v.isEffect = false
            vEntity:GetComponent(PhysicsComponent)._isNeedReleaseBox = true
            vEntity:GetComponent(TypeComponent)._isNeedDestroy = true
          end
        end
      end
    end
  end
  for _, entity in ipairs(self._world._rightPlayerSummonList) do
    for _, v in ipairs(entity:GetComponent(PhysicsComponent)._hittedContactList) do
      local useSkillEntity
      for i, e in ipairs(self._world._entitys) do
        if e._entityId == v.useSkillEntityID then
          useSkillEntity = e
          break
        end
      end
      if not (v.skillid ~= 0 and v.isEffect) or self._utility.IsMoLiZhenDang(v.skillid) then
      else
        local damageEntity
        for i, e in ipairs(self._world._entitys) do
          if e._entityId == v.entityid then
            damageEntity = e
            break
          end
        end
        if damageEntity then
          if self._world:GetCampWinState() == "" then
            self._buffUtility.SetBuffListToEnemyCampEntityBySkillID(entity, useSkillEntity, v.skillid, self._world, 0)
          end
          local component = damageEntity:GetComponent(FlySkillDataComponent)
          if component then
            if component._skillEffectType == FlySkillDataComponent.SkillEffectType.FlyProp or component._skillEffectType == FlySkillDataComponent.SkillEffectType.ConfirmFlyProp then
              component._skillCurrentContactNumber = component._skillCurrentContactNumber + 1
              v.isEffect = false
              if component._skillCurrentContactNumber >= component._skillMaxContactNumber then
                damageEntity:GetComponent(PhysicsComponent)._isNeedReleaseBox = true
                damageEntity:GetComponent(TypeComponent)._isNeedDestroy = true
                for i, inV in ipairs(self._world._playerSkillEffectEntityList) do
                  if inV._entityId == damageEntity._entityId then
                    table.remove(self._world._playerSkillEffectEntityList, i)
                    break
                  end
                end
              end
            elseif component._skillEffectType == FlySkillDataComponent.SkillEffectType.ConfirmProp then
              v.isEffect = false
            elseif component._skillEffectType == FlySkillDataComponent.SkillEffectType.ParaFlyProp then
              v.isEffect = false
            end
          else
            v.isEffect = false
            damageEntity:GetComponent(PhysicsComponent)._isNeedReleaseBox = true
            damageEntity:GetComponent(TypeComponent)._isNeedDestroy = true
          end
        end
      end
    end
  end
  for _, entity in ipairs(self._world._otherPhysicsEntityList) do
    for _, v in ipairs(entity:GetComponent(PhysicsComponent)._hittedContactList) do
      if v.entityid == 0 then
        entity:GetComponent(PhysicsComponent)._isNeedReleaseBox = true
        entity:GetComponent(TypeComponent)._isNeedDestroy = true
      end
    end
  end
end

function SpritePhysicsSystem:CountHittedEntityNumber(entityList)
  local PhysicsComponent = BattleECS.Components.PhysicsComponent
  local SkillComponent = BattleECS.Components.SkillComponent
  for _, entity in ipairs(entityList) do
    for _, v in ipairs(entity:GetComponent(PhysicsComponent)._hittedContactList) do
      local useSkillEntity
      for i, e in ipairs(self._world._entitys) do
        if e._entityId == v.useSkillEntityID then
          useSkillEntity = e
          break
        end
      end
      local vEntity
      for i, e in ipairs(self._world._entitys) do
        if e._entityId == v.entityid then
          vEntity = e
          break
        end
      end
      if v.skillid ~= 0 and v.isEffect and not self._utility.IsMoLiZhenDang(v.skillid) and vEntity and useSkillEntity then
        local skillCom = useSkillEntity:GetComponent(SkillComponent)
        if skillCom then
          skillCom._hittedEntityNumber = skillCom._hittedEntityNumber + 1
        end
      end
    end
  end
end

return SpritePhysicsSystem
