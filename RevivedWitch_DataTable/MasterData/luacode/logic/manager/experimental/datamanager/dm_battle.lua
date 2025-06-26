-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_battle.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Battler = require("logic.manager.experimental.types.battler")
local ProjectileEffect = require("logic.manager.experimental.types.projectileeffect")
local DM_Battle = class("DM_Battle")
DM_Battle.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._battle = (NekoData.Data).battle
  self:Clear()
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._battle).arenaEnemysName = {}
end

DM_Battle.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if (self._battle).leftBattlers then
    for k,v in pairs((self._battle).leftBattlers) do
      v:Destroy()
    end
    for k,v in pairs((self._battle).leftBattlers) do
      -- DECOMPILER ERROR at PC20: Confused about usage of register: R6 in 'UnsetPending'

      ((self._battle).leftBattlers)[k] = nil
    end
  end
  do
    if (self._battle).leftBattlersSummon then
      for k,v in pairs((self._battle).leftBattlersSummon) do
        v:Destroy()
      end
      for k,v in pairs((self._battle).leftBattlersSummon) do
        -- DECOMPILER ERROR at PC43: Confused about usage of register: R6 in 'UnsetPending'

        ((self._battle).leftBattlersSummon)[k] = nil
      end
    end
    do
      if (self._battle).rightBattlersSummon then
        for k,v in pairs((self._battle).rightBattlersSummon) do
          v:Destroy()
        end
        for k,v in pairs((self._battle).rightBattlersSummon) do
          -- DECOMPILER ERROR at PC66: Confused about usage of register: R6 in 'UnsetPending'

          ((self._battle).rightBattlersSummon)[k] = nil
        end
      end
      do
        if (self._battle).leftPartners then
          for k,v in pairs((self._battle).leftPartners) do
            v:Destroy()
          end
          for k,v in pairs((self._battle).leftPartners) do
            -- DECOMPILER ERROR at PC89: Confused about usage of register: R6 in 'UnsetPending'

            ((self._battle).leftPartners)[k] = nil
          end
        end
        do
          if (self._battle).ownSideRolesInfo then
            for k,v in pairs((self._battle).ownSideRolesInfo) do
              -- DECOMPILER ERROR at PC103: Confused about usage of register: R6 in 'UnsetPending'

              ((self._battle).ownSideRolesInfo)[k] = nil
            end
          end
          do
            if (self._battle).enemySideRolesInfo then
              for k,v in pairs((self._battle).enemySideRolesInfo) do
                -- DECOMPILER ERROR at PC117: Confused about usage of register: R6 in 'UnsetPending'

                ((self._battle).enemySideRolesInfo)[k] = nil
              end
            end
            do
              if (self._battle).rightBattlers then
                for k,v in pairs((self._battle).rightBattlers) do
                  v:Destroy()
                end
                for k,v in pairs((self._battle).rightBattlers) do
                  -- DECOMPILER ERROR at PC140: Confused about usage of register: R6 in 'UnsetPending'

                  ((self._battle).rightBattlers)[k] = nil
                end
              end
              do
                if (self._battle).projectileEffects then
                  for k,v in pairs((self._battle).projectileEffects) do
                    v:Destroy()
                  end
                  for k,v in pairs((self._battle).projectileEffects) do
                    -- DECOMPILER ERROR at PC163: Confused about usage of register: R6 in 'UnsetPending'

                    ((self._battle).projectileEffects)[k] = nil
                  end
                end
                do
                  if (self._battle).fixedEffects then
                    for k,v in pairs((self._battle).fixedEffects) do
                      -- DECOMPILER ERROR at PC177: Confused about usage of register: R6 in 'UnsetPending'

                      ((self._battle).fixedEffects)[k] = nil
                    end
                  end
                  do
                    -- DECOMPILER ERROR at PC182: Confused about usage of register: R1 in 'UnsetPending'

                    ;
                    (self._battle).leftBattlers = {}
                    -- DECOMPILER ERROR at PC185: Confused about usage of register: R1 in 'UnsetPending'

                    ;
                    (self._battle).leftPartners = {}
                    -- DECOMPILER ERROR at PC188: Confused about usage of register: R1 in 'UnsetPending'

                    ;
                    (self._battle).ownSideRolesInfo = {}
                    -- DECOMPILER ERROR at PC191: Confused about usage of register: R1 in 'UnsetPending'

                    ;
                    (self._battle).enemySideRolesInfo = {}
                    -- DECOMPILER ERROR at PC194: Confused about usage of register: R1 in 'UnsetPending'

                    ;
                    (self._battle).rightBattlers = {}
                    -- DECOMPILER ERROR at PC197: Confused about usage of register: R1 in 'UnsetPending'

                    ;
                    (self._battle).projectileEffects = {}
                    -- DECOMPILER ERROR at PC200: Confused about usage of register: R1 in 'UnsetPending'

                    ;
                    (self._battle).fixedEffects = {}
                    -- DECOMPILER ERROR at PC202: Confused about usage of register: R1 in 'UnsetPending'

                    ;
                    (self._battle).power1 = 0
                    -- DECOMPILER ERROR at PC204: Confused about usage of register: R1 in 'UnsetPending'

                    ;
                    (self._battle).power1Max = 210
                    -- DECOMPILER ERROR at PC206: Confused about usage of register: R1 in 'UnsetPending'

                    ;
                    (self._battle).power2 = 0
                    -- DECOMPILER ERROR at PC208: Confused about usage of register: R1 in 'UnsetPending'

                    ;
                    (self._battle).power2Max = 210
                    -- DECOMPILER ERROR at PC210: Confused about usage of register: R1 in 'UnsetPending'

                    ;
                    (self._battle).battleId = 0
                    -- DECOMPILER ERROR at PC212: Confused about usage of register: R1 in 'UnsetPending'

                    ;
                    (self._battle).battleType = 0
                    -- DECOMPILER ERROR at PC214: Confused about usage of register: R1 in 'UnsetPending'

                    ;
                    (self._battle).controller = nil
                    -- DECOMPILER ERROR at PC216: Confused about usage of register: R1 in 'UnsetPending'

                    ;
                    (self._battle).autoBattleInfo = nil
                    -- DECOMPILER ERROR at PC218: Confused about usage of register: R1 in 'UnsetPending'

                    ;
                    (self._battle).tmpAutoBattleInfo = nil
                    -- DECOMPILER ERROR at PC221: Confused about usage of register: R1 in 'UnsetPending'

                    ;
                    (self._battle).leftBattlersSummon = {}
                    -- DECOMPILER ERROR at PC224: Confused about usage of register: R1 in 'UnsetPending'

                    ;
                    (self._battle).rightBattlersSummon = {}
                    -- DECOMPILER ERROR at PC227: Confused about usage of register: R1 in 'UnsetPending'

                    ;
                    (self._battle).sceneEffect = {}
                    -- DECOMPILER ERROR at PC230: Confused about usage of register: R1 in 'UnsetPending'

                    ;
                    (self._battle).currentBattleInjury = {}
                    -- DECOMPILER ERROR at PC233: Confused about usage of register: R1 in 'UnsetPending'

                    ;
                    (self._battle).currentBattleTreatment = {}
                    -- DECOMPILER ERROR at PC236: Confused about usage of register: R1 in 'UnsetPending'

                    ;
                    (self._battle).currentBattleDamage = {}
                    -- DECOMPILER ERROR at PC239: Confused about usage of register: R1 in 'UnsetPending'

                    ;
                    (self._battle).entityBuffList = {}
                    if (self._battle).defaultModeAutoBattleSkillInfo then
                      for _,v in ipairs((self._battle).defaultModeAutoBattleSkillInfo) do
                        if v.loadTimeTask then
                          (GameTimer.RemoveTask)(v.loadTimeTask)
                          v.loadTimeTask = nil
                        end
                      end
                      do
                        while 1 do
                          -- DECOMPILER ERROR at PC272: Confused about usage of register: R1 in 'UnsetPending'

                          if ((self._battle).defaultModeAutoBattleSkillInfo)[#(self._battle).defaultModeAutoBattleSkillInfo] then
                            ((self._battle).defaultModeAutoBattleSkillInfo)[#(self._battle).defaultModeAutoBattleSkillInfo] = nil
                            -- DECOMPILER ERROR at PC273: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC273: LeaveBlock: unexpected jumping out IF_STMT

                          end
                        end
                        if (self._battle).optionalModeAutoBattleSkillInfo then
                          for _,v in ipairs((self._battle).optionalModeAutoBattleSkillInfo) do
                            if v.loadTimeTask then
                              (GameTimer.RemoveTask)(v.loadTimeTask)
                              v.loadTimeTask = nil
                            end
                          end
                          do
                            while 1 do
                              -- DECOMPILER ERROR at PC306: Confused about usage of register: R1 in 'UnsetPending'

                              if ((self._battle).optionalModeAutoBattleSkillInfo)[#(self._battle).optionalModeAutoBattleSkillInfo] then
                                ((self._battle).optionalModeAutoBattleSkillInfo)[#(self._battle).optionalModeAutoBattleSkillInfo] = nil
                                -- DECOMPILER ERROR at PC307: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                -- DECOMPILER ERROR at PC307: LeaveBlock: unexpected jumping out IF_STMT

                              end
                            end
                            ;
                            ((((((CS.PixelNeko).P1).Scene).Battle).BattleSceneHelper).ReleaseAllAsset)()
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
    end
  end
end

DM_Battle.AddSceneEffectData = function(self, gameObject)
  -- function num : 0_2 , upvalues : _ENV
  (table.insert)((self._battle).sceneEffect, gameObject)
end

DM_Battle.ClearSceneEffects = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if (self._battle).sceneEffect then
    for _,v in pairs((self._battle).sceneEffect) do
      ((((CS.PixelNeko).Common).GameObjectHelper).DestroyObject)(v)
    end
  end
  do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._battle).sceneEffect = {}
  end
end

DM_Battle.ClearProjectileEffects = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if (self._battle).projectileEffects then
    for k,v in pairs((self._battle).projectileEffects) do
      v:Destroy()
    end
  end
  do
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._battle).projectileEffects = {}
  end
end

DM_Battle.AddLeftBattler = function(self, entityId, attribute, gameObject, isInitial)
  -- function num : 0_5 , upvalues : Battler
  if not ((self._battle).leftBattlers)[entityId] then
    local battler = (Battler.Create)()
    battler:Init(entityId, attribute, gameObject, isInitial)
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self._battle).leftBattlers)[entityId] = battler
    return battler
  end
end

DM_Battle.AddLeftPartnet = function(self, entityId, attribute, gameObject)
  -- function num : 0_6 , upvalues : Battler
  if not ((self._battle).leftPartners)[entityId] then
    local battler = (Battler.Create)()
    battler:Init(entityId, attribute, gameObject)
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._battle).leftPartners)[entityId] = battler
    return battler
  end
end

DM_Battle.AddLeftBattlerSummon = function(self, entityId, attribute, gameObject)
  -- function num : 0_7 , upvalues : Battler
  if not ((self._battle).leftBattlersSummon)[entityId] then
    local battler = (Battler.Create)()
    battler:Init(entityId, attribute, gameObject)
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._battle).leftBattlersSummon)[entityId] = battler
  end
end

DM_Battle.AddRightBattlerSummon = function(self, entityId, attribute, gameObject)
  -- function num : 0_8 , upvalues : Battler
  if not ((self._battle).rightBattlersSummon)[entityId] then
    local battler = (Battler.Create)()
    battler:Init(entityId, attribute, gameObject)
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._battle).rightBattlersSummon)[entityId] = battler
  end
end

DM_Battle.ChangeLeftBattlerGameObject = function(self, entityId, gameObject)
  -- function num : 0_9
  if ((self._battle).leftBattlers)[entityId] then
    (((self._battle).leftBattlers)[entityId]):SetGameObject(gameObject)
  end
end

DM_Battle.ChangeLeftBattler = function(self, entityid, gameObject)
  -- function num : 0_10
  local battler = ((self._battle).leftBattlers)[entityid]
  if not battler then
    battler = ((self._battle).leftBattlersSummon)[entityid]
  end
  if battler then
    battler:SetGameObject(gameObject)
  end
end

DM_Battle.ChangeRightBattler = function(self, entityid, gameObject)
  -- function num : 0_11
  local battler = ((self._battle).rightBattlers)[entityid]
  if not battler then
    battler = ((self._battle).rightBattlersSummon)[entityid]
  end
  if battler then
    battler:SetGameObject(gameObject)
  end
end

DM_Battle.OnAddOwnSideRolesInfo = function(self, protocol)
  -- function num : 0_12
  if not ((self._battle).ownSideRolesInfo)[protocol.entityid] then
    local attribute = {}
    attribute.id = (protocol.attribute).id
    attribute.key = (protocol.attribute).key
    attribute.hp = (protocol.attribute).hp
    attribute.hpmax = (protocol.attribute).hpmax
    attribute.onceequipskills = {}
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self._battle).ownSideRolesInfo)[protocol.entityid] = attribute
  end
end

DM_Battle.OnAddEnemySideRolesInfo = function(self, protocol)
  -- function num : 0_13
  if not ((self._battle).enemySideRolesInfo)[protocol.entityid] then
    local attribute = {}
    attribute.id = (protocol.attribute).id
    attribute.key = (protocol.attribute).key
    attribute.hp = (protocol.attribute).hp
    attribute.hpmax = (protocol.attribute).hpmax
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self._battle).enemySideRolesInfo)[protocol.entityid] = attribute
  end
end

DM_Battle.AddOnceUseEquipSkill = function(self, entityId, skillid)
  -- function num : 0_14 , upvalues : _ENV
  local attribute = ((self._battle).ownSideRolesInfo)[entityId]
  if attribute then
    (table.insert)(attribute.onceequipskills, skillid)
  end
end

DM_Battle.OnRefreshBothSideRolesInfo = function(self, protocol)
  -- function num : 0_15
  local attribute = ((self._battle).ownSideRolesInfo)[protocol.entityId]
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  if attribute then
    (((self._battle).ownSideRolesInfo)[protocol.entityId]).hp = protocol.currentHp
  else
    attribute = ((self._battle).enemySideRolesInfo)[protocol.entityId]
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

    if attribute then
      (((self._battle).enemySideRolesInfo)[protocol.entityId]).hp = protocol.currentHp
    end
  end
end

DM_Battle.AddRightBattler = function(self, entityId, attribute, gameObject, isInitial)
  -- function num : 0_16 , upvalues : Battler, _ENV
  if not ((self._battle).rightBattlers)[entityId] then
    local battler = (Battler.Create)()
    battler:Init(entityId, attribute, gameObject, isInitial)
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self._battle).rightBattlers)[entityId] = battler
    if isInitial and (self._battle).controller and battler:IsBoss() and ((self._battle).controller)._bsc_isBossViolent then
      battler:SetViolentState(true)
    end
  else
    do
      LogError("DM_Battle", "战斗单位已存在")
    end
  end
end

DM_Battle.AddProjectileEffect = function(self, entityId, playerEntityId, skillId, camp, gameObject)
  -- function num : 0_17 , upvalues : ProjectileEffect
  if not ((self._battle).projectileEffects)[entityId] then
    local battler = (ProjectileEffect.Create)()
    battler:Init(entityId, playerEntityId, skillId, camp, gameObject)
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self._battle).projectileEffects)[entityId] = battler
  end
end

DM_Battle.RemoveEntity = function(self, entityId)
  -- function num : 0_18 , upvalues : _ENV
  if ((self._battle).rightBattlers)[entityId] then
    (((self._battle).rightBattlers)[entityId]):Destroy()
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self._battle).rightBattlers)[entityId] = nil
  else
    if ((self._battle).leftBattlers)[entityId] then
      (((self._battle).leftBattlers)[entityId]):Destroy()
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self._battle).leftBattlers)[entityId] = nil
    else
      if ((self._battle).leftBattlersSummon)[entityId] then
        (((self._battle).leftBattlersSummon)[entityId]):Destroy()
        -- DECOMPILER ERROR at PC40: Confused about usage of register: R2 in 'UnsetPending'

        ;
        ((self._battle).leftBattlersSummon)[entityId] = nil
      else
        if ((self._battle).rightBattlersSummon)[entityId] then
          (((self._battle).rightBattlersSummon)[entityId]):Destroy()
          -- DECOMPILER ERROR at PC54: Confused about usage of register: R2 in 'UnsetPending'

          ;
          ((self._battle).rightBattlersSummon)[entityId] = nil
        else
          if ((self._battle).leftPartners)[entityId] then
            (((self._battle).leftPartners)[entityId]):Destroy()
            -- DECOMPILER ERROR at PC68: Confused about usage of register: R2 in 'UnsetPending'

            ;
            ((self._battle).leftPartners)[entityId] = nil
          else
            if ((self._battle).projectileEffects)[entityId] then
              (((self._battle).projectileEffects)[entityId]):Destroy()
              -- DECOMPILER ERROR at PC82: Confused about usage of register: R2 in 'UnsetPending'

              ;
              ((self._battle).projectileEffects)[entityId] = nil
            else
              LogError("DM_Battle", "需要移除的对象不存在" .. entityId)
            end
          end
        end
      end
    end
  end
end

DM_Battle.SetBattlePower = function(self, power1, power1Max, power2, power2Max)
  -- function num : 0_19
  if not power2 then
    power2 = 0
  end
  if not power2Max then
    power2Max = 0
  end
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._battle).power1 = power1
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._battle).power1Max = power1Max
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._battle).power2 = power2
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._battle).power2Max = power2Max
end

DM_Battle.SetBattleId = function(self, battleId, controller, battleType)
  -- function num : 0_20
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R4 in 'UnsetPending'

  (self._battle).battleId = battleId
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._battle).battleType = battleType
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._battle).controller = controller
end

DM_Battle.SetAutoBattleInfo = function(self, info)
  -- function num : 0_21 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._battle).autoBattleInfo = info
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._battle).tmpAutoBattleInfo = clone(info)
end

DM_Battle.RecordCurrentBattleInjury = function(self, recorder)
  -- function num : 0_22
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._battle).currentBattleInjury)[recorder.entityId] = recorder
end

DM_Battle.RecordCurrentBattleTreatment = function(self, recorder)
  -- function num : 0_23
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._battle).currentBattleTreatment)[recorder.entityId] = recorder
end

DM_Battle.RecordCurrentBattleDamage = function(self, recorder)
  -- function num : 0_24
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._battle).currentBattleDamage)[recorder.entityId] = recorder
end

DM_Battle.SetArenaEnemysName = function(self, info)
  -- function num : 0_25 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._battle).arenaEnemysName = {}
  for k,v in ipairs(info) do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R7 in 'UnsetPending'

    ((self._battle).arenaEnemysName)[v.battleId] = (v.enemyUserData).userName
  end
end

DM_Battle.SetSeasonData = function(self, data)
  -- function num : 0_26
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._battle).SeasonData = data
end

DM_Battle.SetSeasonNotify = function(self, data)
  -- function num : 0_27
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._battle).SeasonNotify = data
end

return DM_Battle

