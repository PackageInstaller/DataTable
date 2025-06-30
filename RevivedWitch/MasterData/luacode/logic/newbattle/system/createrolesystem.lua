-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/system/createrolesystem.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local System = require("ecs.system")
local CreateRoleSystem = (strictclass("CreateRoleSystem", System))
local CreateRoleComponent, TypeComponent, HpComponent, AttackComponent, BehaviorComponent, PhysicsComponent, PositionComponent, DefenseComponent, AnimationEventComponent, BuffComponent, SummonDataComponent, SkillComponent, DeadDisappearCountComponent = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
CreateRoleSystem.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CreateRoleSystem, _ENV, CreateRoleComponent, TypeComponent, HpComponent, AttackComponent, BehaviorComponent, PhysicsComponent, PositionComponent, DefenseComponent, AnimationEventComponent, BuffComponent, SummonDataComponent, SkillComponent, DeadDisappearCountComponent
  ((CreateRoleSystem.super).Ctor)(self, ...)
  self._protocolUtility = (BattleECS.Utility).ProtocolUtility
  self._buffUtility = (BattleECS.Utility).BuffUtility
  self._physicsUtility = (BattleECS.Utility).PhysicsUtility
  self._dataUtility = (BattleECS.Utility).DataUtility
  self._utility = (BattleECS.Utility).Utility
  CreateRoleComponent = (BattleECS.Components).CreateRoleComponent
  TypeComponent = (BattleECS.Components).TypeComponent
  HpComponent = (BattleECS.Components).HpComponent
  AttackComponent = (BattleECS.Components).AttackComponent
  BehaviorComponent = (BattleECS.Components).BehaviorComponent
  PhysicsComponent = (BattleECS.Components).PhysicsComponent
  PositionComponent = (BattleECS.Components).PositionComponent
  DefenseComponent = (BattleECS.Components).DefenseComponent
  AnimationEventComponent = (BattleECS.Components).AnimationEventComponent
  BuffComponent = (BattleECS.Components).BuffComponent
  SummonDataComponent = (BattleECS.Components).SummonDataComponent
  SkillComponent = (BattleECS.Components).SkillComponent
  DeadDisappearCountComponent = (BattleECS.Components).DeadDisappearCountComponent
  ;
  (table.insert)(self._requiredComponents, (BattleECS.Components).CreateRoleComponent)
end

CreateRoleSystem.Destroy = function(self)
  -- function num : 0_1 , upvalues : CreateRoleSystem
  ((CreateRoleSystem.super).Destroy)(self)
end

CreateRoleSystem.Update = function(self)
  -- function num : 0_2 , upvalues : _ENV, CreateRoleComponent, TypeComponent, HpComponent, AttackComponent, DefenseComponent, AnimationEventComponent, BuffComponent, SummonDataComponent, PhysicsComponent, PositionComponent, SkillComponent, BehaviorComponent
  for _,entity in ipairs(self._entitys) do
    local createRoleComponent = entity:GetComponent(CreateRoleComponent)
    for _,infoList in ipairs(createRoleComponent._playerInfoList) do
      local playerInfo = infoList.playerInfo
      local config = ((self._dataUtility).roleConfigTable)[playerInfo.id]
      if not config then
        config = ((self._dataUtility).cMonsterCfgTable)[playerInfo.id]
      end
      if config then
        local pointNum = playerInfo.pos
        local posCfg = ((self._world)._battlePosList)[pointNum]
        local x, y, z = posCfg.x, posCfg.y, posCfg.z
        local entity = (self._world):NewEntity()
        local component = entity:AddComponent(TypeComponent)
        local roleRecord = (((BattleECS.Utility).DataUtility).roleConfigTable)[playerInfo.id]
        if roleRecord then
          component._roleElementType = roleRecord.element
          component._roleVocationType = roleRecord.vocation
        end
        component._camp = infoList.camp
        component._roleID = playerInfo.id
        component._rolePointNum = pointNum
        component._oriShapeAssetBundleName = playerInfo.assetbundlename
        component._oriShapePrefabName = playerInfo.prefabname
        component._level = playerInfo.level
        component._evolutionLevel = playerInfo.evolutionLevel
        component._exclusiveLevel = playerInfo.exclusiveLevel
        component._runelv = playerInfo.runelv
        component = entity:AddComponent(HpComponent)
        component._maxHp = fixedpoint(playerInfo.hpmax)
        component._basicMaxHp = component._maxHp
        component._currentHp = fixedpoint(playerInfo.hp)
        component = entity:AddComponent(AttackComponent)
        component._attack = fixedpoint(playerInfo.atk)
        component._basicAttack = component._attack
        component._attackDamageAddition = fixedpoint(playerInfo.physicalbonus) / 1000
        component._magicDamageAddition = fixedpoint(playerInfo.magicbonus) / 1000
        component._attackSuckBlood = fixedpoint(playerInfo.physicallifesteal) / 100
        component._magicSuckBlood = fixedpoint(playerInfo.magiclifesteal) / 100
        component._attackSpeed = fixedpoint(playerInfo.attackspeed) / 1000
        component._attackDefBreak = fixedpoint(playerInfo.physicaldefbreak)
        component._magicDefBreak = fixedpoint(playerInfo.magicdefbreak)
        component._attackCritRate = fixedpoint(playerInfo.physicalcritrate) / 1000
        component._basicAttackCritRate = component._attackCritRate
        component._attackCritDegree = fixedpoint(playerInfo.physicalcritdegree) / 1000
        component._basicAttackCritDegree = component._attackCritDegree
        component._attackAddition = fixedpoint(playerInfo.extraphysicaldamage)
        component._magicAddition = fixedpoint(playerInfo.extramagicdamage)
        component._treatmentAddition = fixedpoint(playerInfo.curativebonus) / 1000
        component._hitRate = fixedpoint(playerInfo.accuracy) / 1000
        component._healingPower = fixedpoint(playerInfo.healingpower)
        component._attackCritLevel = fixedpoint(playerInfo.critratelevel)
        component._attackCritDegreeLevel = fixedpoint(playerInfo.critdegreelevel)
        component = entity:AddComponent(DefenseComponent)
        component._attackDefense = fixedpoint(playerInfo.def)
        component._basicAttackDefense = component._attackDefense
        component._magicDefense = fixedpoint(playerInfo.mdef)
        component._basicMagicDefense = component._magicDefense
        component._attackDefenseAddition = fixedpoint(playerInfo.physicalreduce) / 1000
        component._magicDefenseAddition = fixedpoint(playerInfo.magicreduce) / 1000
        component._attackInjuryReduceNumber = fixedpoint(playerInfo.physicalblock)
        component._magicInjuryReduceNumber = fixedpoint(playerInfo.magicblock)
        component._attackMiss = fixedpoint(playerInfo.physicalevasion) / 1000
        component._attackCritDefense = fixedpoint(playerInfo.critrateresistance) / 1000
        component._attackCritDegreeDefense = fixedpoint(playerInfo.critdegreeresistance) / 1000
        component._damageReduce = fixedpoint(playerInfo.damagereduce) / 1000
        entity:AddComponent(AnimationEventComponent)
        entity:AddComponent(BuffComponent)
        component = entity:AddComponent(SummonDataComponent)
        if not infoList.alternateFighterBean then
          component._alternateFighter = {}
          local BodyId = (box2d.newBody)((self._world)._physicsWorld, 2, x, y)
          ;
          (box2d.bodySetUserData)((self._world)._physicsWorld, BodyId, {entityid = entity._entityId, camp = infoList.camp, skillid = 0, rad = 0, useskillentityid = entity._entityId})
          local colliderData = require("data.battledata.npcshapedata." .. (string.lower)(playerInfo.prefabname))
          local attackedColliserOffectX = (colliderData.attackedColliserOffect).x
          if infoList.camp == (TypeComponent.CampType).Right then
            attackedColliserOffectX = -attackedColliserOffectX
          end
          local hitFixtureId = (box2d.newBoxShapeFixture)((self._world)._physicsWorld, BodyId, (colliderData.attackedColliserSize).x, (colliderData.attackedColliserSize).y, attackedColliserOffectX, (colliderData.attackedColliserOffect).y, 0, 200, 0, 0, true, 3, 3)
          ;
          (box2d.fixtureSetUserData)((self._world)._physicsWorld, BodyId, hitFixtureId, {fixid = hitFixtureId, fixtype = "hitted"})
          local landFixtureId = (box2d.newBoxShapeFixture)((self._world)._physicsWorld, BodyId, 50, 50, 0, 0, 0, 5000, 0, 1000, false, tonumber((string.format)("%#x", tostring(2 ^ (self._world):GetBatterIndex()))), tonumber((string.format)("%#x", tostring(2 ^ (self._world):GetBatterIndex()))))
          ;
          (box2d.fixtureSetUserData)((self._world)._physicsWorld, BodyId, landFixtureId, {fixid = landFixtureId, fixtype = "land"})
          component = entity:AddComponent(PhysicsComponent)
          component._box2DBodyID = BodyId
          component = entity:AddComponent(PositionComponent)
          -- DECOMPILER ERROR at PC364: Confused about usage of register: R27 in 'UnsetPending'

          ;
          (component._position).x = x
          -- DECOMPILER ERROR at PC366: Confused about usage of register: R27 in 'UnsetPending'

          ;
          (component._position).y = y
          -- DECOMPILER ERROR at PC368: Confused about usage of register: R27 in 'UnsetPending'

          ;
          (component._position).z = z
          -- DECOMPILER ERROR at PC370: Confused about usage of register: R27 in 'UnsetPending'

          ;
          (component._targetPos).x = x
          -- DECOMPILER ERROR at PC372: Confused about usage of register: R27 in 'UnsetPending'

          ;
          (component._targetPos).y = y
          component = entity:AddComponent(SkillComponent)
          component._comborate1 = fixedpoint(playerInfo.comborate1)
          component._comborate2 = fixedpoint(playerInfo.comborate2)
          component._comborateRemainingNum = (fixedpoint.max)(component._comborate1, component._comborate2)
          entity:AddComponent(BehaviorComponent)
          local behavior = nil
          if config.behaviacAI and config.behaviacAI ~= "" then
            behavior = (BehaviorManager.NewBehavior)("newbattle/" .. config.behaviacAI)
            behavior._behaviorSkillList = {}
          else
            behavior = (BehaviorManager.NewBehavior)("newbattle/newbattle")
            if playerInfo.baseskill ~= 0 then
              behavior._behaviorSkillList = {playerInfo.baseskill}
            else
              behavior._behaviorSkillList = {}
            end
          end
          if playerInfo.baseskill ~= 0 then
            local cd = (((self._dataUtility).cSkillCostTable)[playerInfo.baseskill]).CDfraps
            local hasSaveSkillInSkillComponentSkillList = false
            for _,skillTable in ipairs(component._skillList) do
              if skillTable.skillId == playerInfo.baseskill then
                skillTable.cdTime = fixedpoint(cd)
                skillTable.currentTime = config.silentFraps
                hasSaveSkillInSkillComponentSkillList = true
                break
              end
            end
            do
              do
                if not hasSaveSkillInSkillComponentSkillList then
                  (table.insert)(component._skillList, {skillId = playerInfo.baseskill, cdTime = fixedpoint(cd), currentTime = config.silentFraps})
                end
                behavior._data = {RandomFunction = (self._world)._randomPcg}
                behavior._entityId = entity._entityId
                behavior._battleworld = self._world
                behavior:SetTree()
                ;
                (entity:GetComponent(BehaviorComponent))._behavior = behavior
                local attribute = (BattleClientProtocolManager.CreateBean)("data.attribute")
                local bosshpstage = {}
                if #playerInfo.bosshpstage == 0 then
                  bosshpstage = (string.split)(playerInfo.bosshpstr, ";")
                else
                  bosshpstage = playerInfo.bosshpstage
                end
                local bosshpstagelist = {}
                local hpStageNum = (table.nums)(bosshpstage)
                -- DECOMPILER ERROR at PC512: Confused about usage of register: R32 in 'UnsetPending'

                if hpStageNum > 1 or config.bossOrNot == 1 then
                  (self._world)._bossEntityid = entity._entityId
                  for k,v in ipairs(bosshpstage) do
                    bosshpstagelist[k] = tonumber(v)
                  end
                  local hpdelta = 0
                  for k,_ in ipairs(bosshpstage) do
                    local revertHpValue = tonumber(bosshpstage[hpStageNum - k + 1])
                    ;
                    (table.insert)((self._world)._bossHpStage, {totalHpNum = revertHpValue + hpdelta, num = revertHpValue, stage = false})
                    hpdelta = hpdelta + revertHpValue
                  end
                else
                  do
                    bosshpstagelist[1] = tonumber(bosshpstage[1])
                    attribute.bosshpstage = bosshpstagelist
                    attribute.hp = playerInfo.hp
                    attribute.hpmax = playerInfo.hpmax
                    attribute.atk = playerInfo.atk
                    attribute.def = playerInfo.def
                    attribute.matk = playerInfo.matk
                    attribute.mdef = playerInfo.mdef
                    attribute.level = playerInfo.level
                    attribute.camp = infoList.camp
                    attribute.speed = 0
                    attribute.skilllist = playerInfo.skilllist
                    attribute.baseskill = playerInfo.baseskill
                    attribute.passiveskill = playerInfo.passiveskill
                    attribute.key = playerInfo.key
                    attribute.id = playerInfo.id
                    attribute.x = (fixedpoint.tonumber)(x)
                    attribute.y = (fixedpoint.tonumber)(y)
                    attribute.z = (fixedpoint.tonumber)(z)
                    attribute.havealternate = playerInfo.havealternate
                    attribute.assetbundlename = playerInfo.assetbundlename
                    attribute.prefabname = playerInfo.prefabname
                    attribute.nameTextId = config.nameTextID
                    attribute.healingpower = playerInfo.healingpower
                    attribute.comborate1 = playerInfo.comborate1
                    attribute.comborate2 = playerInfo.comborate2
                    attribute.exclusiveLevel = playerInfo.exclusiveLevel
                    ;
                    ((self._protocolUtility).SendRoleCreate)(entity._entityId, infoList.camp, attribute, {}, infoList.isInitial, self._world)
                    for _,v in ipairs(playerInfo.passiveskill) do
                      LogInfoFormat("CreateRoleSystem", "roleid %s passiveskillid:%s", playerInfo.id, v)
                      ;
                      ((self._buffUtility).SetBuffListToOwnCampEntityBySkillID)(entity, entity, v, self._world)
                    end
                    if config.defaultBuff and config.defaultBuff ~= "" then
                      for _,v in ipairs((string.split)(config.defaultBuff, ";")) do
                        ((self._buffUtility).InsertEntityDifferentBuff)({entity = entity, enermyentity = entity, buffid = tonumber(v), buffparamter = "time=99999", skillid = 0, battleworld = self._world})
                      end
                    end
                    do
                      for k,v in ipairs(playerInfo.autoExploreSkill) do
                        LogInfoFormat("CreateRoleSystem", "roleid %s autoExploreSkill skillid %s", playerInfo.id, v)
                        ;
                        ((self._buffUtility).SetBuffListToOwnCampEntityBySkillID)(entity, entity, v, self._world)
                      end
                      if infoList.camp == (TypeComponent.CampType).Left then
                        self:ConfigLeftPlayer(entity, playerInfo, config)
                        local hasEntity = false
                        for i,e in ipairs((self._world)._leftPlayerList) do
                          -- DECOMPILER ERROR at PC709: Confused about usage of register: R38 in 'UnsetPending'

                          if e._entityId == entity._entityId then
                            ((self._world)._leftPlayerList)[i] = entity
                            hasEntity = true
                          end
                        end
                        if not hasEntity then
                          (table.insert)((self._world)._leftPlayerList, entity)
                          for _,v in ipairs((self._world)._battleBuffsList) do
                            local record = ((self._dataUtility).cGlobalBuffConfigTable)[v.buffId]
                            if record and (record.target == (TypeComponent.CampType).Left or record.target == (TypeComponent.CampType).Both) and record.time == -1 and ((self._buffUtility).CanAddGlobalBuffBuff)(entity, v.buffId, self._world) then
                              ((self._buffUtility).InsertEntityDifferentBuff)({entity = entity, enermyentity = entity, buffid = v.buffId, buffparamter = record.buffattr, skillid = 0, battleworld = self._world})
                            end
                          end
                        end
                      else
                        do
                          if infoList.camp == (TypeComponent.CampType).Right then
                            self:ConfigRightPlayer(entity, playerInfo, config)
                            local hasEntity = false
                            for i,e in ipairs((self._world)._rightPlayerList) do
                              -- DECOMPILER ERROR at PC791: Confused about usage of register: R38 in 'UnsetPending'

                              if e._entityId == entity._entityId then
                                ((self._world)._rightPlayerList)[i] = entity
                                hasEntity = true
                              end
                            end
                            if not hasEntity then
                              (table.insert)((self._world)._rightPlayerList, entity)
                              for _,v in ipairs((self._world)._battleBuffsList) do
                                local record = ((self._dataUtility).cGlobalBuffConfigTable)[v.buffId]
                                if record and (record.target == (TypeComponent.CampType).Right or record.target == (TypeComponent.CampType).Both) and record.time == -1 and ((self._buffUtility).CanAddGlobalBuffBuff)(entity, v.buffId, self._world) then
                                  ((self._buffUtility).InsertEntityDifferentBuff)({entity = entity, enermyentity = entity, buffid = v.buffId, buffparamter = record.buffattr, skillid = 0, battleworld = self._world})
                                end
                              end
                            end
                          end
                          do
                            do
                              LogErrorFormat("CreateRoleSystem", "wrong player id %s, not exist in roleconfig or cmonsterconfig", playerInfo.id)
                              -- DECOMPILER ERROR at PC856: LeaveBlock: unexpected jumping out DO_STMT

                              -- DECOMPILER ERROR at PC856: LeaveBlock: unexpected jumping out DO_STMT

                              -- DECOMPILER ERROR at PC856: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                              -- DECOMPILER ERROR at PC856: LeaveBlock: unexpected jumping out IF_STMT

                              -- DECOMPILER ERROR at PC856: LeaveBlock: unexpected jumping out DO_STMT

                              -- DECOMPILER ERROR at PC856: LeaveBlock: unexpected jumping out DO_STMT

                              -- DECOMPILER ERROR at PC856: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                              -- DECOMPILER ERROR at PC856: LeaveBlock: unexpected jumping out IF_STMT

                              -- DECOMPILER ERROR at PC856: LeaveBlock: unexpected jumping out DO_STMT

                              -- DECOMPILER ERROR at PC856: LeaveBlock: unexpected jumping out DO_STMT

                              -- DECOMPILER ERROR at PC856: LeaveBlock: unexpected jumping out IF_THEN_STMT

                              -- DECOMPILER ERROR at PC856: LeaveBlock: unexpected jumping out IF_STMT

                              -- DECOMPILER ERROR at PC856: LeaveBlock: unexpected jumping out IF_THEN_STMT

                              -- DECOMPILER ERROR at PC856: LeaveBlock: unexpected jumping out IF_STMT

                              -- DECOMPILER ERROR at PC856: LeaveBlock: unexpected jumping out IF_THEN_STMT

                              -- DECOMPILER ERROR at PC856: LeaveBlock: unexpected jumping out IF_STMT

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
    createRoleComponent._playerInfoList = {}
  end
end

CreateRoleSystem.ConfigLeftPlayer = function(self, entity, playerInfo, config)
  -- function num : 0_3 , upvalues : PhysicsComponent, _ENV, SkillComponent
  local component = entity:GetComponent(PhysicsComponent)
  if playerInfo.id == 20054 then
    ((self._physicsUtility).SetEntityPhyscisComponentAwake)(entity, false)
    ;
    ((self._physicsUtility).SetEntityAwake)((self._world)._physicsWorld, entity, false)
  end
  component._moveMaxFraps = 1
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R5 in 'UnsetPending'

  if config.speed then
    (component._toTargetMaxSpeed).x = fixedpoint(config.speed) * 10
  else
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (component._toTargetMaxSpeed).x = fixedpoint(config.speedConstant) * 10
  end
  component = entity:GetComponent(SkillComponent)
  for _,v in ipairs(playerInfo.equipskilllist) do
    LogInfoFormat("BattleWorld", "equipskillid:%s", v)
    if v == 20039 then
      local hasOccur = false
      for _,inV in ipairs((self._world)._leftPlayerPowerIncreaseSpeedList) do
        if inV.entityId == entity._entityId then
          inV.speed = fixedpoint((((self._dataUtility).cBattleConstCfgTable)[67]).attr) / 1000
          hasOccur = true
          break
        end
      end
      do
        do
          do
            if not hasOccur then
              (table.insert)((self._world)._leftPlayerPowerIncreaseSpeedList, {entityId = entity._entityId, speed = fixedpoint((((self._dataUtility).cBattleConstCfgTable)[67]).attr) / 1000})
            end
            ;
            ((self._buffUtility).SetBuffListToOwnCampEntityBySkillID)(entity, entity, v, self._world)
            -- DECOMPILER ERROR at PC98: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC98: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC98: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC98: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  for _,v in ipairs(playerInfo.runeskilllist) do
    LogInfoFormat("BattleWorld", "runeskilllist:%s", v)
    ;
    ((self._buffUtility).SetBuffListToOwnCampEntityBySkillID)(entity, entity, v, self._world)
  end
  local hasOccur = false
  for _,inV in ipairs((self._world)._leftPlayerPowerIncreaseSpeedList) do
    if inV.entityId == entity._entityId then
      hasOccur = true
      break
    end
  end
  do
    if not hasOccur then
      (table.insert)((self._world)._leftPlayerPowerIncreaseSpeedList, {entityId = entity._entityId, speed = 1})
    end
    for k,v in ipairs(playerInfo.skilllist) do
      if v ~= 0 then
        if playerInfo.id <= 5000 then
          local cd = (((self._dataUtility).cSkillCostTable)[v]).CDfraps
          local hasSaveSkillInSkillComponentSkillList = false
          for _,skillTable in ipairs(component._skillList) do
            if skillTable.skillId == v then
              skillTable.cdTime = fixedpoint(cd)
              skillTable.currentTime = config.silentFraps
              hasSaveSkillInSkillComponentSkillList = true
              break
            end
          end
          do
            do
              if not hasSaveSkillInSkillComponentSkillList then
                (table.insert)(component._skillList, {skillId = v, cdTime = fixedpoint(cd), currentTime = (((self._dataUtility).cSkillCostTable)[v]).CDfraps, activeSkillIndex = k})
              end
              local cd = (((self._dataUtility).cSkillCostTable)[v]).CDfraps
              local hasSaveSkillInSkillComponentSkillList = false
              for _,skillTable in ipairs(component._skillList) do
                if skillTable.skillId == v then
                  skillTable.cdTime = fixedpoint(cd)
                  skillTable.currentTime = config.silentFraps
                  hasSaveSkillInSkillComponentSkillList = true
                  break
                end
              end
              do
                do
                  if not hasSaveSkillInSkillComponentSkillList then
                    (table.insert)(component._skillList, {skillId = v, cdTime = fixedpoint(cd), currentTime = 0, activeSkillIndex = k})
                  end
                  -- DECOMPILER ERROR at PC229: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC229: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC229: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC229: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC229: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC229: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC229: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
          end
        end
      end
    end
  end
end

CreateRoleSystem.ConfigRightPlayer = function(self, entity, playerInfo, config)
  -- function num : 0_4 , upvalues : TypeComponent, DeadDisappearCountComponent, _ENV, PhysicsComponent, BehaviorComponent, SkillComponent
  local component = entity:GetComponent(TypeComponent)
  component._monsterType = config.MonsterStyle or 0
  component = entity:AddComponent(DeadDisappearCountComponent)
  local animationEndData = require("data.battledata.npcshapeanimationdata." .. (string.lower)(playerInfo.prefabname))
  if animationEndData.DeadDisappear then
    component._deadTotalCount = (animationEndData.DeadDisappear).endEventFrames
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self._world)._stopBattleWorldTimeCountTotalRight = (animationEndData.DeadDisappear).endEventFrames
  else
    component._deadTotalCount = 0
  end
  if animationEndData.LogicBattleEnd then
    component._battleEndTotalCount = (animationEndData.LogicBattleEnd).endEventFrames
  else
    component._battleEndTotalCount = 0
  end
  component = entity:GetComponent(PhysicsComponent)
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R6 in 'UnsetPending'

  if config.speed then
    (component._toTargetMaxSpeed).x = fixedpoint(config.speed) * 10
  else
    -- DECOMPILER ERROR at PC59: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (component._toTargetMaxSpeed).x = fixedpoint(config.speedConstant) * 10
  end
  for _,v in ipairs((self._dataUtility).cCellBattleInfoTable) do
    if (self._world)._battleID == tonumber(v.battleId) then
      local buffId = tonumber(v.buff)
      do
        do
          if buffId ~= 0 then
            local record = ((self._dataUtility).cGlobalBuffConfigTable)[buffId]
            if record then
              LogInfoFormat("CreateRoleSystem", "cCellBattleInfoTable battleid %s add buffid %s entityid %s", v.battleId, v.buff, entity._entityId)
              ;
              ((self._buffUtility).InsertEntityDifferentBuff)({entity = entity, enermyentity = entity, buffid = buffId, buffparamter = record.buffattr, skillid = 0, battleworld = self._world})
            end
          end
          do break end
          -- DECOMPILER ERROR at PC102: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC102: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC102: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  local behavior = (entity:GetComponent(BehaviorComponent))._behavior
  component = entity:GetComponent(SkillComponent)
  for k,v in ipairs(playerInfo.skilllist) do
    if v ~= 0 then
      local cRecord = ((self._dataUtility).cSkillCostTable)[v]
      if not cRecord then
        LogErrorFormat("CreateRoleSystem", "monster %s skillid %s is not in ccostskill", playerInfo.id, v)
      else
        if playerInfo.id <= 5000 then
          local delayTime = 0
          local LineUpStation = (BattleClientProtocolManager.GetBeanDef)("data.lineupstation")
          if playerInfo.key == LineUpStation.FRONT_ROW then
            delayTime = tonumber((((self._dataUtility).cBattleConstCfgTable)[121]).attr)
          else
            if playerInfo.key == LineUpStation.MIDDLE_ROW then
              delayTime = tonumber((((self._dataUtility).cBattleConstCfgTable)[122]).attr)
            else
              if playerInfo.key == LineUpStation.BACK_ROW then
                delayTime = tonumber((((self._dataUtility).cBattleConstCfgTable)[123]).attr)
              end
            end
          end
          local cd = (((self._dataUtility).cCardRoleSkillCDTable)[v]).cd
          local hasSaveSkillInSkillComponentSkillList = false
          for _,skillTable in ipairs(component._skillList) do
            if skillTable.skillId == v then
              skillTable.cdTime = fixedpoint(cd)
              skillTable.currentTime = delayTime
              hasSaveSkillInSkillComponentSkillList = true
              break
            end
          end
          do
            do
              if not hasSaveSkillInSkillComponentSkillList then
                (table.insert)(component._skillList, {skillId = v, cdTime = fixedpoint(cd), currentTime = delayTime, activeSkillIndex = k})
              end
              local cd = cRecord.CDfraps
              local hasSaveSkillInSkillComponentSkillList = false
              for _,skillTable in ipairs(component._skillList) do
                if skillTable.skillId == v then
                  skillTable.cdTime = fixedpoint(cd)
                  skillTable.currentTime = 0
                  hasSaveSkillInSkillComponentSkillList = true
                  break
                end
              end
              do
                do
                  do
                    if not hasSaveSkillInSkillComponentSkillList then
                      (table.insert)(component._skillList, {skillId = v, cdTime = fixedpoint(cd), currentTime = 0, activeSkillIndex = k})
                    end
                    ;
                    (table.insert)(behavior._behaviorSkillList, v)
                    -- DECOMPILER ERROR at PC246: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC246: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC246: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC246: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC246: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC246: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC246: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                    -- DECOMPILER ERROR at PC246: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC246: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC246: LeaveBlock: unexpected jumping out IF_STMT

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

return CreateRoleSystem

