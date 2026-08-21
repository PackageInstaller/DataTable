-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/system/spritephysicssystem.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local System = require("ecs.system")
local SpritePhysicsSystem = strictclass("SpritePhysicsSystem", System)
SpritePhysicsSystem.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SpritePhysicsSystem, _ENV
  ((SpritePhysicsSystem.super).Ctor)(self, ...)
  self._utility = (BattleECS.Utility).Utility
  self._buffUtility = (BattleECS.Utility).BuffUtility
end

SpritePhysicsSystem.Destroy = function(self)
  -- function num : 0_1 , upvalues : SpritePhysicsSystem
  ((SpritePhysicsSystem.super).Destroy)(self)
end

SpritePhysicsSystem.Update = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local PhysicsComponent = (BattleECS.Components).PhysicsComponent
  local FlySkillDataComponent = (BattleECS.Components).FlySkillDataComponent
  local TypeComponent = (BattleECS.Components).TypeComponent
  self:CountHittedEntityNumber((self._world)._leftPlayerList)
  self:CountHittedEntityNumber((self._world)._leftPlayerSummonList)
  self:CountHittedEntityNumber((self._world)._rightPlayerList)
  self:CountHittedEntityNumber((self._world)._rightPlayerSummonList)
  for _,entity in ipairs((self._world)._leftPlayerList) do
    for _,v in ipairs((entity:GetComponent(PhysicsComponent))._hittedContactList) do
      local useSkillEntity = nil
      for i,e in ipairs((self._world)._entitys) do
        if e._entityId == v.useSkillEntityID then
          useSkillEntity = e
          break
        end
      end
      do
        local vEntity = nil
        for i,e in ipairs((self._world)._entitys) do
          if e._entityId == v.entityid then
            vEntity = e
            break
          end
        end
        do
          if v.skillid ~= 0 and v.isEffect then
            if ((self._utility).IsMoLiZhenDang)(v.skillid) then
              v.isEffect = false
              ;
              ((self._buffUtility).SetBuffListToOwnCampEntityBySkillID)(entity, useSkillEntity, v.skillid, self._world)
            else
              if vEntity then
                local typeComponent = vEntity:GetComponent(TypeComponent)
                if (self._world):GetCampWinState() == "" then
                  ((self._buffUtility).SetBuffListToEnemyCampEntityBySkillID)(entity, useSkillEntity, v.skillid, self._world, 0)
                end
                local component = vEntity:GetComponent(FlySkillDataComponent)
                if component then
                  if component._skillEffectType == (FlySkillDataComponent.SkillEffectType).FlyProp or component._skillEffectType == (FlySkillDataComponent.SkillEffectType).ConfirmFlyProp then
                    component._skillCurrentContactNumber = component._skillCurrentContactNumber + 1
                    v.isEffect = false
                    if component._skillMaxContactNumber <= component._skillCurrentContactNumber then
                      (vEntity:GetComponent(PhysicsComponent))._isNeedReleaseBox = true
                      typeComponent._isNeedDestroy = true
                      for i,inV in ipairs((self._world)._playerSkillEffectEntityList) do
                        if inV._entityId == vEntity._entityId then
                          (table.remove)((self._world)._playerSkillEffectEntityList, i)
                          break
                        end
                      end
                    end
                  else
                    do
                      do
                        if component._skillEffectType == (FlySkillDataComponent.SkillEffectType).ConfirmProp then
                          v.isEffect = false
                        else
                          if component._skillEffectType == (FlySkillDataComponent.SkillEffectType).ParaFlyProp then
                            v.isEffect = false
                            ;
                            (vEntity:GetComponent(PhysicsComponent))._isNeedReleaseBox = true
                            typeComponent._isNeedDestroy = true
                          end
                        end
                        v.isEffect = false
                        ;
                        (vEntity:GetComponent(PhysicsComponent))._isNeedReleaseBox = true
                        typeComponent._isNeedDestroy = true
                        -- DECOMPILER ERROR at PC176: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC176: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                        -- DECOMPILER ERROR at PC176: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC176: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC176: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC176: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC176: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC176: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                        -- DECOMPILER ERROR at PC176: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC176: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC176: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC176: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC176: LeaveBlock: unexpected jumping out DO_STMT

                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  for _,entity in ipairs((self._world)._leftPlayerSummonList) do
    for _,v in ipairs((entity:GetComponent(PhysicsComponent))._hittedContactList) do
      local useSkillEntity = nil
      for i,e in ipairs((self._world)._entitys) do
        if e._entityId == v.useSkillEntityID then
          useSkillEntity = e
          break
        end
      end
      do
        if v.skillid ~= 0 and v.isEffect then
          if ((self._utility).IsMoLiZhenDang)(v.skillid) then
            local damageEntity = nil
            for i,e in ipairs((self._world)._entitys) do
              if e._entityId == v.entityid then
                damageEntity = e
                break
              end
            end
            do
              if damageEntity then
                if (self._world):GetCampWinState() == "" then
                  ((self._buffUtility).SetBuffListToEnemyCampEntityBySkillID)(entity, useSkillEntity, v.skillid, self._world, 0)
                end
                local component = damageEntity:GetComponent(FlySkillDataComponent)
                if component then
                  if component._skillEffectType == (FlySkillDataComponent.SkillEffectType).FlyProp or component._skillEffectType == (FlySkillDataComponent.SkillEffectType).ConfirmFlyProp then
                    component._skillCurrentContactNumber = component._skillCurrentContactNumber + 1
                    v.isEffect = false
                    if component._skillMaxContactNumber <= component._skillCurrentContactNumber then
                      (damageEntity:GetComponent(PhysicsComponent))._isNeedReleaseBox = true
                      ;
                      (damageEntity:GetComponent(TypeComponent))._isNeedDestroy = true
                      for i,inV in ipairs((self._world)._playerSkillEffectEntityList) do
                        if inV._entityId == damageEntity._entityId then
                          (table.remove)((self._world)._playerSkillEffectEntityList, i)
                          break
                        end
                      end
                    end
                  else
                    do
                      do
                        if component._skillEffectType == (FlySkillDataComponent.SkillEffectType).ConfirmProp then
                          v.isEffect = false
                        else
                          if component._skillEffectType == (FlySkillDataComponent.SkillEffectType).ParaFlyProp then
                            v.isEffect = false
                          end
                        end
                        v.isEffect = false
                        ;
                        (damageEntity:GetComponent(PhysicsComponent))._isNeedReleaseBox = true
                        ;
                        (damageEntity:GetComponent(TypeComponent))._isNeedDestroy = true
                        -- DECOMPILER ERROR at PC321: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC321: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                        -- DECOMPILER ERROR at PC321: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC321: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC321: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC321: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC321: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC321: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC321: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC321: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC321: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC321: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC321: LeaveBlock: unexpected jumping out DO_STMT

                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  for _,entity in ipairs((self._world)._playerSkillEffectEntityList) do
    for _,v in ipairs((entity:GetComponent(PhysicsComponent))._hittedContactList) do
      local useSkillEntity = nil
      for i,e in ipairs((self._world)._entitys) do
        if e._entityId == v.useSkillEntityID then
          useSkillEntity = e
          break
        end
      end
      do
        if v.skillid ~= 0 and v.isEffect then
          if ((self._utility).IsMoLiZhenDang)(v.skillid) then
            local damageEntity = nil
            for i,e in ipairs((self._world)._entitys) do
              if e._entityId == v.entityid then
                damageEntity = e
                break
              end
            end
            do
              if damageEntity then
                if (self._world):GetCampWinState() == "" then
                  ((self._buffUtility).SetBuffListToEnemyCampEntityBySkillID)(entity, useSkillEntity, v.skillid, self._world, 0)
                end
                local component = damageEntity:GetComponent(FlySkillDataComponent)
                if component then
                  if component._skillEffectType == (FlySkillDataComponent.SkillEffectType).FlyProp or component._skillEffectType == (FlySkillDataComponent.SkillEffectType).ConfirmFlyProp then
                    if (entity:GetComponent(FlySkillDataComponent))._skillEffectType == (FlySkillDataComponent.SkillEffectType).DefendFlyProp then
                      v.isEffect = false
                      ;
                      (damageEntity:GetComponent(PhysicsComponent))._isNeedReleaseBox = true
                      ;
                      (damageEntity:GetComponent(TypeComponent))._isNeedDestroy = true
                    else
                      component._skillCurrentContactNumber = component._skillCurrentContactNumber + 1
                      v.isEffect = false
                      if component._skillMaxContactNumber <= component._skillCurrentContactNumber then
                        (damageEntity:GetComponent(PhysicsComponent))._isNeedReleaseBox = true
                        ;
                        (damageEntity:GetComponent(TypeComponent))._isNeedDestroy = true
                        for i,inV in ipairs((self._world)._playerSkillEffectEntityList) do
                          if inV._entityId == damageEntity._entityId then
                            (table.remove)((self._world)._playerSkillEffectEntityList, i)
                            break
                          end
                        end
                      end
                    end
                  else
                    do
                      do
                        if component._skillEffectType == (FlySkillDataComponent.SkillEffectType).ConfirmProp then
                          v.isEffect = false
                        else
                          if component._skillEffectType == (FlySkillDataComponent.SkillEffectType).ParaFlyProp then
                            v.isEffect = false
                            if (entity:GetComponent(FlySkillDataComponent))._skillEffectType == (FlySkillDataComponent.SkillEffectType).DefendFlyProp then
                              (damageEntity:GetComponent(PhysicsComponent))._isNeedReleaseBox = true
                              ;
                              (damageEntity:GetComponent(TypeComponent))._isNeedDestroy = true
                            end
                          end
                        end
                        v.isEffect = false
                        ;
                        (damageEntity:GetComponent(PhysicsComponent))._isNeedReleaseBox = true
                        ;
                        (damageEntity:GetComponent(TypeComponent))._isNeedDestroy = true
                        -- DECOMPILER ERROR at PC500: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC500: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                        -- DECOMPILER ERROR at PC500: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC500: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC500: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC500: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC500: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC500: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC500: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC500: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC500: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC500: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC500: LeaveBlock: unexpected jumping out DO_STMT

                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  for _,entity in ipairs((self._world)._rightPlayerList) do
    for _,v in ipairs((entity:GetComponent(PhysicsComponent))._hittedContactList) do
      local useSkillEntity = nil
      for i,e in ipairs((self._world)._entitys) do
        if e._entityId == v.useSkillEntityID then
          useSkillEntity = e
          break
        end
      end
      do
        local vEntity = nil
        for i,e in ipairs((self._world)._entitys) do
          if e._entityId == v.entityid then
            vEntity = e
            break
          end
        end
        do
          if v.skillid ~= 0 and v.isEffect and ((self._utility).IsMoLiZhenDang)(v.skillid) and vEntity then
            if (self._world):GetCampWinState() == "" then
              ((self._buffUtility).SetBuffListToEnemyCampEntityBySkillID)(entity, useSkillEntity, v.skillid, self._world, 0)
            end
            ;
            (vEntity:GetComponent(PhysicsComponent))._isNeedReleaseBox = true
            ;
            (vEntity:GetComponent(TypeComponent))._isNeedDestroy = true
          end
          if vEntity then
            if (self._world):GetCampWinState() == "" then
              ((self._buffUtility).SetBuffListToEnemyCampEntityBySkillID)(entity, useSkillEntity, v.skillid, self._world, v.rad)
            end
            local component = vEntity:GetComponent(FlySkillDataComponent)
            if component then
              if component._skillEffectType == (FlySkillDataComponent.SkillEffectType).FlyProp or component._skillEffectType == (FlySkillDataComponent.SkillEffectType).ConfirmFlyProp then
                component._skillCurrentContactNumber = component._skillCurrentContactNumber + 1
                v.isEffect = false
                if component._skillMaxContactNumber <= component._skillCurrentContactNumber then
                  (vEntity:GetComponent(PhysicsComponent))._isNeedReleaseBox = true
                  ;
                  (vEntity:GetComponent(TypeComponent))._isNeedDestroy = true
                  for i,inV in ipairs((self._world)._playerSkillEffectEntityList) do
                    if inV._entityId == vEntity._entityId then
                      (table.remove)((self._world)._playerSkillEffectEntityList, i)
                      break
                    end
                  end
                end
              else
                do
                  do
                    if component._skillEffectType == (FlySkillDataComponent.SkillEffectType).ConfirmProp then
                      v.isEffect = false
                    end
                    v.isEffect = false
                    ;
                    (vEntity:GetComponent(PhysicsComponent))._isNeedReleaseBox = true
                    ;
                    (vEntity:GetComponent(TypeComponent))._isNeedDestroy = true
                    -- DECOMPILER ERROR at PC661: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC661: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                    -- DECOMPILER ERROR at PC661: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC661: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC661: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC661: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC661: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC661: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC661: LeaveBlock: unexpected jumping out DO_STMT

                  end
                end
              end
            end
          end
        end
      end
    end
  end
  for _,entity in ipairs((self._world)._rightPlayerSummonList) do
    for _,v in ipairs((entity:GetComponent(PhysicsComponent))._hittedContactList) do
      local useSkillEntity = nil
      for i,e in ipairs((self._world)._entitys) do
        if e._entityId == v.useSkillEntityID then
          useSkillEntity = e
          break
        end
      end
      do
        if v.skillid ~= 0 and v.isEffect then
          if ((self._utility).IsMoLiZhenDang)(v.skillid) then
            local damageEntity = nil
            for i,e in ipairs((self._world)._entitys) do
              if e._entityId == v.entityid then
                damageEntity = e
                break
              end
            end
            do
              if damageEntity then
                if (self._world):GetCampWinState() == "" then
                  ((self._buffUtility).SetBuffListToEnemyCampEntityBySkillID)(entity, useSkillEntity, v.skillid, self._world, 0)
                end
                local component = damageEntity:GetComponent(FlySkillDataComponent)
                if component then
                  if component._skillEffectType == (FlySkillDataComponent.SkillEffectType).FlyProp or component._skillEffectType == (FlySkillDataComponent.SkillEffectType).ConfirmFlyProp then
                    component._skillCurrentContactNumber = component._skillCurrentContactNumber + 1
                    v.isEffect = false
                    if component._skillMaxContactNumber <= component._skillCurrentContactNumber then
                      (damageEntity:GetComponent(PhysicsComponent))._isNeedReleaseBox = true
                      ;
                      (damageEntity:GetComponent(TypeComponent))._isNeedDestroy = true
                      for i,inV in ipairs((self._world)._playerSkillEffectEntityList) do
                        if inV._entityId == damageEntity._entityId then
                          (table.remove)((self._world)._playerSkillEffectEntityList, i)
                          break
                        end
                      end
                    end
                  else
                    do
                      do
                        if component._skillEffectType == (FlySkillDataComponent.SkillEffectType).ConfirmProp then
                          v.isEffect = false
                        else
                          if component._skillEffectType == (FlySkillDataComponent.SkillEffectType).ParaFlyProp then
                            v.isEffect = false
                          end
                        end
                        v.isEffect = false
                        ;
                        (damageEntity:GetComponent(PhysicsComponent))._isNeedReleaseBox = true
                        ;
                        (damageEntity:GetComponent(TypeComponent))._isNeedDestroy = true
                        -- DECOMPILER ERROR at PC806: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC806: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                        -- DECOMPILER ERROR at PC806: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC806: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC806: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC806: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC806: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC806: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC806: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC806: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC806: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC806: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC806: LeaveBlock: unexpected jumping out DO_STMT

                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  for _,entity in ipairs((self._world)._otherPhysicsEntityList) do
    for _,v in ipairs((entity:GetComponent(PhysicsComponent))._hittedContactList) do
      if v.entityid == 0 then
        (entity:GetComponent(PhysicsComponent))._isNeedReleaseBox = true
        ;
        (entity:GetComponent(TypeComponent))._isNeedDestroy = true
      end
    end
  end
end

SpritePhysicsSystem.CountHittedEntityNumber = function(self, entityList)
  -- function num : 0_3 , upvalues : _ENV
  local PhysicsComponent = (BattleECS.Components).PhysicsComponent
  local SkillComponent = (BattleECS.Components).SkillComponent
  for _,entity in ipairs(entityList) do
    for _,v in ipairs((entity:GetComponent(PhysicsComponent))._hittedContactList) do
      local useSkillEntity = nil
      for i,e in ipairs((self._world)._entitys) do
        if e._entityId == v.useSkillEntityID then
          useSkillEntity = e
          break
        end
      end
      do
        local vEntity = nil
        for i,e in ipairs((self._world)._entitys) do
          if e._entityId == v.entityid then
            vEntity = e
            break
          end
        end
        do
          do
            if v.skillid ~= 0 and v.isEffect and not ((self._utility).IsMoLiZhenDang)(v.skillid) and vEntity and useSkillEntity then
              local skillCom = useSkillEntity:GetComponent(SkillComponent)
              if skillCom then
                skillCom._hittedEntityNumber = skillCom._hittedEntityNumber + 1
              end
            end
            -- DECOMPILER ERROR at PC69: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC69: LeaveBlock: unexpected jumping out DO_STMT

          end
        end
      end
    end
  end
end

return SpritePhysicsSystem

