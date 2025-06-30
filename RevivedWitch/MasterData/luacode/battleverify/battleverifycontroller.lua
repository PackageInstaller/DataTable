-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/battleverify/battleverifycontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BattleWorld = require("logic.newbattle.battleworld")
local SRoleCreate = (BattleClientProtocolManager.GetProtocolDef)("action.srolecreate")
local SRoleSummon = (BattleClientProtocolManager.GetProtocolDef)("action.srolesummoncreate")
local LineUpStation = (BattleClientProtocolManager.GetBeanDef)("data.lineupstation")
local BattleEndType = (BattleClientProtocolManager.GetBeanDef)("data.battleendtype")
local CBattleConfig = (BeanManager.GetTableByName)("battle.cbattleconstcfg")
local CRoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CMonsterConfigTable = (BeanManager.GetTableByName)("npc.cmonsterconfig")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local CSceneInfoStatic = (BeanManager.GetTableByName)("scene.csceneinfostatic")
local CBattleSceneCfg = (BeanManager.GetTableByName)("scene.cbattlescenecfg")
local CBattleInfo = (BeanManager.GetTableByName)("battle.cbattleinfo")
local BattleVerifyController = class("BattleVerifyController")
local ResultType = {None = -1, Success = 0, StepDiff = 1, SkinWrong = 2, SceneZero = 3}
BattleVerifyController.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV, ResultType
  self._bsc_localProtocolData = {}
  self._bsc_battleWorld = nil
  self._bsc_battleStartProtocol = nil
  self._bsc_stepNum = 0
  self._bsc_battleResult = 0
  self._verify_step = 0
  self._bsc_isUsePartner = 0
  self._battle = {
ownSideRolesInfo = {}
, 
enemySideRolesInfo = {}
, 
leftBattlers = {}
, 
rightBattlers = {}
, 
leftBattlersSummon = {}
, 
rightBattlersSummon = {}
, 
leftPartners = {}
, power1 = 0, power1Max = 0, power2 = 0, power2Max = 0}
  self._result = (JSON.encode)({result = ResultType.None})
end

BattleVerifyController.OnDestroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

BattleVerifyController.Init = function(self, proAndStep, stepNum)
  -- function num : 0_2 , upvalues : _ENV, ResultType
  self._sendprotocolList = proAndStep
  self._verify_step = stepNum
  self._result = (JSON.encode)({result = ResultType.None})
end

BattleVerifyController.BSC_GetStepNum = function(self)
  -- function num : 0_3
  return self._bsc_stepNum
end

BattleVerifyController.BSC_InitBattleScene = function(self, battleId)
  -- function num : 0_4
  self._bsc_stepNum = 0
end

BattleVerifyController.BSC_InitBattle = function(self)
  -- function num : 0_5 , upvalues : _ENV, BattleWorld, LineUpStation, CRoleConfigTable
  local Enum_Camp = (BattleClientProtocolManager.GetBeanDef)("data.enum_camp")
  self._bsc_battleWorld = (BattleWorld.Create)(function(protocol)
    -- function num : 0_5_0 , upvalues : self
    self:BSC_SendProtocolToViewController(protocol)
  end
, (self._bsc_battleStartProtocol).battleid, self._battle_scene_id, (self._bsc_battleStartProtocol).battleBuffs, self._bsc_battlePosList)
  ;
  (self._bsc_battleWorld):SetAssistData((self._bsc_battleStartProtocol).assist)
  ;
  (self._bsc_battleWorld):SetRandomSeed((self._bsc_battleStartProtocol).seed)
  local stationNumList = {LineUpStation.FRONT_ROW, LineUpStation.MIDDLE_ROW, LineUpStation.BACK_ROW}
  local initialTagType = {Not = 0, Is = 1}
  local leftRoleList = {}
  local leftAllRoleList = {}
  for _,i in ipairs(stationNumList) do
    local fighter = ((self._bsc_battleStartProtocol).left)[i]
    local alternateFighter, alternateI = nil, nil
    if i == LineUpStation.FRONT_ROW then
      alternateI = LineUpStation.ALTERNATE_FRONT_ROW
      alternateFighter = ((self._bsc_battleStartProtocol).left)[alternateI]
    else
      if i == LineUpStation.MIDDLE_ROW then
        alternateI = LineUpStation.ALTERNATE_MIDDLE_ROW
        alternateFighter = ((self._bsc_battleStartProtocol).left)[alternateI]
      else
        if i == LineUpStation.BACK_ROW then
          alternateI = LineUpStation.ALTERNATE_BACK_ROW
          alternateFighter = ((self._bsc_battleStartProtocol).left)[alternateI]
        end
      end
    end
    if alternateFighter == nil then
      local fighterBean = (self:BSC_InitServerPlayer(Enum_Camp.LeftFighter, i, fighter, not fighter))
      do
        local alternateFighterBean = nil
        ;
        (table.insert)(leftAllRoleList, fighter.id)
        if alternateFighter and alternateI then
          (table.insert)(leftAllRoleList, alternateFighter.id)
          alternateFighterBean = self:BSC_InitServerPlayer(Enum_Camp.LeftFighter, alternateI, alternateFighter)
        end
        ;
        (self._bsc_battleWorld):CreateLeftPlayer(fighterBean, {alternateFighterBean = alternateFighterBean, isInitial = initialTagType.Is})
        -- DECOMPILER ERROR at PC105: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC105: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  for i = 1, 5 do
    local fighter = ((self._bsc_battleStartProtocol).right)[i]
    if fighter then
      local fighterBean = self:BSC_InitServerPlayer(Enum_Camp.RightFighter, i, fighter)
      ;
      (self._bsc_battleWorld):CreateRightPlayer(fighterBean, {isInitial = initialTagType.Is})
    end
  end
  local leftLineupList = {}
  leftLineupList.element = {}
  leftLineupList.vocation = {}
  for _,id in ipairs(leftAllRoleList) do
    local recorder = CRoleConfigTable:GetRecorder(id)
    -- DECOMPILER ERROR at PC155: Confused about usage of register: R13 in 'UnsetPending'

    if recorder then
      if (leftLineupList.element)[recorder.element] then
        (leftLineupList.element)[recorder.element] = (leftLineupList.element)[recorder.element] + 1
      else
        -- DECOMPILER ERROR at PC159: Confused about usage of register: R13 in 'UnsetPending'

        (leftLineupList.element)[recorder.element] = 1
      end
      -- DECOMPILER ERROR at PC171: Confused about usage of register: R13 in 'UnsetPending'

      if (leftLineupList.vocation)[recorder.vocation] then
        (leftLineupList.vocation)[recorder.vocation] = (leftLineupList.vocation)[recorder.vocation] + 1
      else
        -- DECOMPILER ERROR at PC175: Confused about usage of register: R13 in 'UnsetPending'

        (leftLineupList.vocation)[recorder.vocation] = 1
      end
    else
      LogErrorFormat("NewBattleSceneController", "No Exist croleconfig ID: %s", id)
    end
  end
  ;
  (self._bsc_battleWorld):SetLeftLineupInfo(leftLineupList)
  ;
  (self._bsc_battleWorld):SetWorldState("start")
  ;
  (self._bsc_battleWorld):UpdataZero()
  self:BSC_UpdateLocalProtocol()
  -- DECOMPILER ERROR: 9 unprocessed JMP targets
end

BattleVerifyController.BSC_UpdateBattleLogic = function(self)
  -- function num : 0_6 , upvalues : _ENV
  while self._bsc_stepNum < self._verify_step do
    for _,p in ipairs(self._sendprotocolList) do
      if p.step == self._bsc_stepNum then
        self:BSC_SendProtocolToLogicWorld(p.protocol)
      end
    end
    if not self._bsc_battleWorld then
      return 
    end
    self:BSC_UpdateBattleLogicOneStep()
  end
end

BattleVerifyController.BSC_BattleLogicEnd = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if not self._bsc_battleWorld then
    LogWarning("BattleVerifyController", "battleworld is nil in BSC_BattleLogicEnd")
    return 
  end
  ;
  (self._bsc_battleWorld):Destroy()
  self._bsc_battleWorld = nil
end

BattleVerifyController.BSC_UpdateBattleLogicOneStep = function(self)
  -- function num : 0_8 , upvalues : _ENV, BattleVerifyController
  self._bsc_stepNum = self._bsc_stepNum + 1
  ;
  (self._bsc_battleWorld):Update()
  self:BSC_UpdateLocalProtocol()
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_FrameNumUsed, BattleVerifyController, self._bsc_stepNum)
end

BattleVerifyController.OnSBattleStart = function(self, protocol)
  -- function num : 0_9 , upvalues : _ENV, ResultType, CSceneInfoStatic, CBattleSceneCfg
  self:BSC_InitBattleScene(protocol.battleid)
  self._bsc_battleStartProtocol = protocol
  self._battle_scene_id = protocol.battleSceneId
  if self._battle_scene_id == 0 then
    self._result = (JSON.encode)({result = ResultType.SceneZero})
    return 
  else
    self._bsc_battlePosList = {}
    local sceneName = (CSceneInfoStatic:GetRecorder(self._battle_scene_id)).asset
    local posFile = require("data.battledata.scenepos." .. (string.lower)(sceneName))
    for i = 1, #posFile do
      local currentIndexPos = posFile[i]
      local x, y, z = currentIndexPos.x, currentIndexPos.y, currentIndexPos.z
      -- DECOMPILER ERROR at PC64: Confused about usage of register: R12 in 'UnsetPending'

      if x and y and z then
        (self._bsc_battlePosList)[i] = {x = fixedpoint(x) * 1000, y = fixedpoint(y) * 1000, z = fixedpoint(z) * 1000}
      else
        LogErrorFormat("BattleVerifyController", "pos index %s get x %s y %s z %s", i, x, y, z)
      end
    end
  end
  do
    local battleSceneCfgRecorder = CBattleSceneCfg:GetRecorder(self._battle_scene_id)
    if battleSceneCfgRecorder and battleSceneCfgRecorder.hasBulletTime == 1 then
      self._bsc_canWaitingForEndTimeline = true
    else
      self._bsc_canWaitingForEndTimeline = false
    end
    self:BSC_InitBattle()
  end
end

BattleVerifyController.BSC_SendProtocolToViewController = function(self, protocol)
  -- function num : 0_10 , upvalues : _ENV
  (table.insert)(self._bsc_localProtocolData, protocol)
end

BattleVerifyController.BSC_SendProtocolToLogicWorld = function(self, protocol)
  -- function num : 0_11
  if self._bsc_battleWorld then
    protocol:Process(self._bsc_battleWorld)
  end
end

BattleVerifyController.BSC_UpdateLocalProtocol = function(self)
  -- function num : 0_12 , upvalues : _ENV
  for _,v in ipairs(self._bsc_localProtocolData) do
    v:Process(self)
  end
  self._bsc_localProtocolData = {}
end

BattleVerifyController.BSC_InitServerPlayer = function(self, camp, posId, fighter, haveAlternate)
  -- function num : 0_13 , upvalues : _ENV, CSkin, CNpcShapeTable, CRoleConfigTable, CMonsterConfigTable, LineUpStation, CBattleConfig
  local Enum_Camp = (BattleClientProtocolManager.GetBeanDef)("data.enum_camp")
  local bean = (BattleClientProtocolManager.CreateBean)("data.attribute")
  bean.id = fighter.id
  bean.key = posId
  bean.camp = camp
  local AttrTypeEnum = (BattleClientProtocolManager.GetBeanDef)("data.attrtype")
  bean.hp = (fighter.attrs)[AttrTypeEnum.HP]
  bean.hpmax = (fighter.attrs)[AttrTypeEnum.MAX_HP]
  bean.atk = (fighter.attrs)[AttrTypeEnum.ATTACK]
  bean.def = (fighter.attrs)[AttrTypeEnum.DEFEND]
  bean.mdef = (fighter.attrs)[AttrTypeEnum.MAGIC_DEFEND]
  bean.damage = (fighter.attrs)[AttrTypeEnum.DAMAGE] or 0
  bean.physicalbonus = (fighter.attrs)[AttrTypeEnum.PHYSICALBONUS] or 0
  bean.physicalreduce = (fighter.attrs)[AttrTypeEnum.PHYSICALREDUCE] or 0
  bean.magicbonus = (fighter.attrs)[AttrTypeEnum.MAGICBONUS] or 0
  bean.magicreduce = (fighter.attrs)[AttrTypeEnum.MAGICREDUCE] or 0
  bean.physicalcritrate = (fighter.attrs)[AttrTypeEnum.CRITRATE] or 0
  bean.physicalcritdegree = (fighter.attrs)[AttrTypeEnum.CRITDEGREE] or 0
  bean.attackspeed = (fighter.attrs)[AttrTypeEnum.ATTACKSPEED] or 0
  bean.magiclifesteal = (fighter.attrs)[AttrTypeEnum.MAGICLIFESTEAL] or 0
  bean.physicallifesteal = (fighter.attrs)[AttrTypeEnum.PHYSICALLIFESTEAL] or 0
  bean.physicalevasion = (fighter.attrs)[AttrTypeEnum.EVASION] or 0
  bean.physicalblock = (fighter.attrs)[AttrTypeEnum.PHYSICALBLOCK] or 0
  bean.magicblock = (fighter.attrs)[AttrTypeEnum.MAGICBLOCK] or 0
  bean.physicaldefbreak = (fighter.attrs)[AttrTypeEnum.PHYSICALDEFBREAK] or 0
  bean.magicdefbreak = (fighter.attrs)[AttrTypeEnum.MAGICDEFBREAK] or 0
  bean.critrateresistance = (fighter.attrs)[AttrTypeEnum.CRITRATERESISTANCE] or 0
  bean.critdegreeresistance = (fighter.attrs)[AttrTypeEnum.CRITDEGREERESISTANCE] or 0
  bean.extraphysicaldamage = (fighter.attrs)[AttrTypeEnum.EXTRAPHYSICALDAMAGE] or 0
  bean.extramagicdamage = (fighter.attrs)[AttrTypeEnum.EXTRAMAGICDAMAGE] or 0
  bean.curativebonus = (fighter.attrs)[AttrTypeEnum.CURATIVEBONUS] or 0
  bean.accuracy = (fighter.attrs)[AttrTypeEnum.ACCURACY] or 0
  bean.critratelevel = (fighter.attrs)[AttrTypeEnum.CRIT_LEVEL] or 0
  bean.critdegreelevel = (fighter.attrs)[AttrTypeEnum.CRIT_DEGREE_LEVEL] or 0
  bean.healingpower = (fighter.attrs)[AttrTypeEnum.HEALING_POWER] or 0
  bean.comborate1 = (fighter.attrs)[AttrTypeEnum.COMBORATE1] or 0
  bean.comborate2 = (fighter.attrs)[AttrTypeEnum.COMBORATE2] or 0
  bean.damagereduce = (fighter.attrs)[AttrTypeEnum.DAMAGE_REDUCE] or 0
  bean.runelv = (fighter.attrs)[AttrTypeEnum.RUNE_LV] or 0
  bean.baseskill = fighter.baseSkill or 0
  if not fighter.passiveSkills then
    bean.passiveskill = {}
    bean.bosshpstr = tostring(fighter.hpStrip)
    bean.level = fighter.level or 0
    bean.evolutionLevel = fighter.evolutionlevel or 0
    bean.exclusiveLevel = fighter.exclusivelevel or 0
    if not fighter.equipSkills then
      bean.equipskilllist = {}
      if not fighter.runeskill then
        bean.runeskilllist = {}
        if not fighter.autoexploreskill then
          bean.autoExploreSkill = {}
          if haveAlternate then
            bean.havealternate = 1
          end
          for k,v in ipairs(fighter.skills) do
            (table.insert)(bean.skilllist, v)
          end
          local shapeRecorder = nil
          local cskinRecoder = CSkin:GetRecorder(fighter.skinId)
          LogInfoFormat("BattleVerifyController", "skinId %s", fighter.skinId)
          if cskinRecoder then
            shapeRecorder = CNpcShapeTable:GetRecorder(cskinRecoder.shapeID)
          else
            local roleRecoder = CRoleConfigTable:GetRecorder(fighter.id)
            if not roleRecoder then
              roleRecoder = CMonsterConfigTable:GetRecorder(fighter.id)
            end
            if roleRecoder then
              shapeRecorder = CNpcShapeTable:GetRecorder(roleRecoder.shapeID)
            else
              LogErrorFormat("BattleVerifyController", "fighter id %s dont have roleconfig or cmonsterconfig, so assetBundleName and prefabName are emptystring", fighter.id)
              shapeRecorder = {assetBundleName = "", prefabName = ""}
            end
          end
          do
            bean.assetbundlename = shapeRecorder.assetBundleName
            bean.prefabname = shapeRecorder.prefabName
            if Enum_Camp.LeftFighter == camp then
              if bean.key == LineUpStation.FRONT_ROW or bean.key == LineUpStation.ALTERNATE_FRONT_ROW then
                bean.pos = tonumber((CBattleConfig:GetRecorder(50)).attr)
              else
                if bean.key == LineUpStation.MIDDLE_ROW or bean.key == LineUpStation.ALTERNATE_MIDDLE_ROW then
                  bean.pos = tonumber((CBattleConfig:GetRecorder(51)).attr)
                else
                  if bean.key == LineUpStation.BACK_ROW or bean.key == LineUpStation.ALTERNATE_BACK_ROW then
                    bean.pos = tonumber((CBattleConfig:GetRecorder(52)).attr)
                  else
                    bean.pos = bean.key
                  end
                end
              end
            else
              if Enum_Camp.RightFighter == camp then
                if bean.key <= 3 then
                  bean.pos = tonumber((CBattleConfig:GetRecorder(bean.key + 52)).attr)
                else
                  if bean.key == 4 then
                    bean.pos = tonumber((CBattleConfig:GetRecorder(63)).attr)
                  else
                    if bean.key == 5 then
                      bean.pos = tonumber((CBattleConfig:GetRecorder(64)).attr)
                    else
                      bean.pos = bean.key
                    end
                  end
                end
              end
            end
            return bean
          end
        end
      end
    end
  end
end

BattleVerifyController.OnSCreateFixPointSkillAttackedInfo = function(self, protocol)
  -- function num : 0_14 , upvalues : _ENV
  local battler = nil
  if ((self._battle).leftBattlers)[protocol.entityId] then
    battler = ((self._battle).leftBattlers)[protocol.entityId]
  end
  if not battler then
    battler = ((self._battle).rightBattlers)[protocol.entityId]
  end
  if not battler then
    battler = ((self._battle).leftBattlersSummon)[protocol.entityId]
  end
  if not battler then
    battler = ((self._battle).rightBattlersSummon)[protocol.entityId]
  end
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R3 in 'UnsetPending'

  if battler then
    (battler.attribute).hp = protocol.currentHp
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R3 in 'UnsetPending'

    if ((self._battle).ownSideRolesInfo)[tostring(protocol.entityId)] then
      (((self._battle).ownSideRolesInfo)[tostring(protocol.entityId)]).hp = protocol.currentHp
    end
    -- DECOMPILER ERROR at PC65: Confused about usage of register: R3 in 'UnsetPending'

    if ((self._battle).enemySideRolesInfo)[tostring(protocol.entityId)] then
      (((self._battle).enemySideRolesInfo)[tostring(protocol.entityId)]).hp = protocol.currentHp
    end
  end
end

BattleVerifyController.OnSDestroyObject = function(self, protocol)
  -- function num : 0_15 , upvalues : _ENV
  if not self:GetBattlerByEntityId(protocol.entityid) then
    if ((self._battle).leftBattlersSummon)[protocol.entityid] then
      LogInfoFormat("BattleVerifyController", "leftBattlersSummon entity %d destroy", protocol.entityid)
    end
    if ((self._battle).rightBattlersSummon)[protocol.entityid] then
      LogInfoFormat("BattleVerifyController", "rightBattlersSummon entity %d destroy", protocol.entityid)
    end
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R2 in 'UnsetPending'

    if protocol.skillid == 0 then
      if ((self._battle).rightBattlers)[protocol.entityid] then
        ((self._battle).rightBattlers)[protocol.entityid] = nil
      else
        -- DECOMPILER ERROR at PC50: Confused about usage of register: R2 in 'UnsetPending'

        if ((self._battle).leftBattlers)[protocol.entityid] then
          ((self._battle).leftBattlers)[protocol.entityid] = nil
        else
          -- DECOMPILER ERROR at PC61: Confused about usage of register: R2 in 'UnsetPending'

          if ((self._battle).leftBattlersSummon)[protocol.entityid] then
            ((self._battle).leftBattlersSummon)[protocol.entityid] = nil
          else
            -- DECOMPILER ERROR at PC72: Confused about usage of register: R2 in 'UnsetPending'

            if ((self._battle).rightBattlersSummon)[protocol.entityid] then
              ((self._battle).rightBattlersSummon)[protocol.entityid] = nil
            else
              -- DECOMPILER ERROR at PC83: Confused about usage of register: R2 in 'UnsetPending'

              if ((self._battle).leftPartners)[protocol.entityid] then
                ((self._battle).leftPartners)[protocol.entityid] = nil
              end
            end
          end
        end
      end
    end
  else
    -- DECOMPILER ERROR at PC98: Confused about usage of register: R2 in 'UnsetPending'

    if protocol.isimageentity == 1 then
      if ((self._battle).rightBattlers)[protocol.entityid] then
        ((self._battle).rightBattlers)[protocol.entityid] = nil
      else
        -- DECOMPILER ERROR at PC109: Confused about usage of register: R2 in 'UnsetPending'

        if ((self._battle).leftBattlers)[protocol.entityid] then
          ((self._battle).leftBattlers)[protocol.entityid] = nil
        else
          -- DECOMPILER ERROR at PC120: Confused about usage of register: R2 in 'UnsetPending'

          if ((self._battle).leftBattlersSummon)[protocol.entityid] then
            ((self._battle).leftBattlersSummon)[protocol.entityid] = nil
          else
            -- DECOMPILER ERROR at PC131: Confused about usage of register: R2 in 'UnsetPending'

            if ((self._battle).rightBattlersSummon)[protocol.entityid] then
              ((self._battle).rightBattlersSummon)[protocol.entityid] = nil
            else
              -- DECOMPILER ERROR at PC142: Confused about usage of register: R2 in 'UnsetPending'

              if ((self._battle).leftPartners)[protocol.entityid] then
                ((self._battle).leftPartners)[protocol.entityid] = nil
              end
            end
          end
        end
      end
    end
  end
end

BattleVerifyController.OnSBattleWorldPowerShow = function(self, protocol)
  -- function num : 0_16
  local power2 = protocol.blueCurrentPower or 0
  local power2Max = protocol.blueMaxPower or 0
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._battle).power1 = protocol.redCurrentPower
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._battle).power1Max = protocol.redMaxPower
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._battle).power2 = power2
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._battle).power2Max = power2Max
end

BattleVerifyController.OnSRoleCreate = function(self, protocol)
  -- function num : 0_17 , upvalues : _ENV, SRoleCreate
  local Enum_Camp = (BattleClientProtocolManager.GetBeanDef)("data.enum_camp")
  if not self:GetBattlerByEntityId(protocol.entityid) then
    local gameObject = nil
    do
      if protocol.type == SRoleCreate.Role and not ((self._battle).leftBattlers)[protocol.entityid] then
        local battler = {entityId = protocol.entityid, attribute = protocol.attribute}
        -- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'

        ;
        ((self._battle).leftBattlers)[protocol.entityid] = battler
      end
      do
        if not ((self._battle).rightBattlers)[protocol.entityid] then
          local battler = {entityId = protocol.entityid, attribute = protocol.attribute}
          -- DECOMPILER ERROR at PC44: Confused about usage of register: R5 in 'UnsetPending'

          ;
          ((self._battle).rightBattlers)[protocol.entityid] = battler
        end
        do
          if (protocol.attribute).camp == Enum_Camp.LeftFighter and (protocol.attribute).key > 0 and not ((self._battle).ownSideRolesInfo)[tostring(protocol.entityid)] then
            local attribute = {}
            attribute.id = (protocol.attribute).id
            attribute.key = (protocol.attribute).key
            attribute.hp = (protocol.attribute).hp
            attribute.hpmax = (protocol.attribute).hpmax
            attribute.onceequipskills = {}
            -- DECOMPILER ERROR at PC82: Confused about usage of register: R5 in 'UnsetPending'

            ;
            ((self._battle).ownSideRolesInfo)[tostring(protocol.entityid)] = attribute
          end
          do
            if (protocol.attribute).camp == Enum_Camp.RightFighter and (protocol.attribute).key > 0 and not ((self._battle).enemySideRolesInfo)[tostring(protocol.entityid)] then
              local attribute = {}
              attribute.id = (protocol.attribute).id
              attribute.key = (protocol.attribute).key
              attribute.hp = (protocol.attribute).hp
              attribute.hpmax = (protocol.attribute).hpmax
              attribute.onceequipskills = {}
              -- DECOMPILER ERROR at PC121: Confused about usage of register: R5 in 'UnsetPending'

              ;
              ((self._battle).enemySideRolesInfo)[tostring(protocol.entityid)] = attribute
            end
            local battler = self:GetBattlerByEntityId(protocol.entityid)
            -- DECOMPILER ERROR at PC129: Confused about usage of register: R4 in 'UnsetPending'

            ;
            (battler.attribute).hp = (protocol.attribute).hp
            -- DECOMPILER ERROR at PC137: Confused about usage of register: R4 in 'UnsetPending'

            if not (protocol.attribute).hpmax then
              (battler.attribute).hpmax = (battler.attribute).hpmax
            end
          end
        end
      end
    end
  end
end

BattleVerifyController.OnSPartnerCreate = function(self, protocol)
  -- function num : 0_18
  local gameObject = nil
  if not self:GetPartnerByEntityId(protocol.entityid) then
    local battler = {entityId = protocol.entityid, attribute = protocol.attribute}
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self._battle).leftPartners)[protocol.entityid] = battler
  end
end

BattleVerifyController.OnSRoleSummonCreate = function(self, protocol)
  -- function num : 0_19 , upvalues : SRoleSummon, _ENV
  if not self:GetBattlerByEntityId(protocol.entityid) then
    local gameObject = nil
    do
      if (protocol.attribute).camp == SRoleSummon.Role and not ((self._battle).leftBattlersSummon)[protocol.entityid] then
        local battler = {entityId = protocol.entityid, attribute = protocol.attribute}
        -- DECOMPILER ERROR at PC25: Confused about usage of register: R4 in 'UnsetPending'

        ;
        ((self._battle).leftBattlersSummon)[protocol.entityid] = battler
      end
      do
        if (protocol.attribute).camp == SRoleSummon.Monster and not ((self._battle).rightBattlersSummon)[protocol.entityid] then
          local battler = {entityId = protocol.entityid, attribute = protocol.attribute}
          -- DECOMPILER ERROR at PC46: Confused about usage of register: R4 in 'UnsetPending'

          ;
          ((self._battle).rightBattlersSummon)[protocol.entityid] = battler
        end
        do
          if protocol.type == SRoleSummon.Role and not ((self._battle).ownSideRolesInfo)[tostring(protocol.entityid)] then
            local attribute = {}
            attribute.id = (protocol.attribute).id
            attribute.key = (protocol.attribute).key
            attribute.hp = (protocol.attribute).hp
            attribute.hpmax = (protocol.attribute).hpmax
            attribute.onceequipskills = {}
            -- DECOMPILER ERROR at PC79: Confused about usage of register: R4 in 'UnsetPending'

            ;
            ((self._battle).ownSideRolesInfo)[tostring(protocol.entityid)] = attribute
          end
          if (protocol.attribute).camp == SRoleSummon.Monster and not ((self._battle).enemySideRolesInfo)[tostring(protocol.entityid)] then
            local attribute = {}
            attribute.id = (protocol.attribute).id
            attribute.key = (protocol.attribute).key
            attribute.hp = (protocol.attribute).hp
            attribute.hpmax = (protocol.attribute).hpmax
            attribute.onceequipskills = {}
            -- DECOMPILER ERROR at PC114: Confused about usage of register: R4 in 'UnsetPending'

            ;
            ((self._battle).enemySideRolesInfo)[tostring(protocol.entityid)] = attribute
          end
        end
      end
    end
  end
end

BattleVerifyController.OnSRoleDead = function(self, protocol)
  -- function num : 0_20 , upvalues : _ENV
  if not self:GetBattlerByEntityId(protocol.entityId) and not self:GetSummonByEntityId(protocol.entityId) then
    LogErrorFormat("BattleVerifyController", "wrong entity %d", protocol.entityId)
  end
end

BattleVerifyController.OnSBattleResult = function(self, protocol)
  -- function num : 0_21 , upvalues : CBattleInfo, BattleEndType, _ENV, ResultType
  local battleRes = nil
  local battleID = (self._bsc_battleStartProtocol).battleid
  local isLoseSettle = (CBattleInfo:GetRecorder(battleID)).defeatResult == 1
  if isLoseSettle and protocol.type ~= BattleEndType.RightWinCBattleKill then
    battleRes = BattleEndType.LoseSettle
  else
    battleRes = protocol.type
  end
  self._bsc_battleResult = battleRes
  self._bsc_isUsePartner = protocol.isjoin
  LogInfo("BattleVerifyController-------------------------OnSBattleResult : ", self._bsc_stepNum)
  self:BSC_BattleLogicEnd()
  local result = ResultType.Success
  if self._bsc_stepNum ~= self._verify_step then
    result = ResultType.StepDiff
  end
  self._result = (JSON.encode)({battleId = (self._bsc_battleStartProtocol).battleid, ownSideRolesInfo = (self._battle).ownSideRolesInfo, battleResult = self._bsc_battleResult, result = result})
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

BattleVerifyController.OnSBattleEnd = function(self, protocol)
  -- function num : 0_22 , upvalues : _ENV
  LogInfo("BattleVerifyController-------------------------OnSBattleEnd : ", self._bsc_stepNum)
end

BattleVerifyController.OnSUpdateRoleBuffs = function(self, protocol)
  -- function num : 0_23 , upvalues : _ENV
  LogInfoFormat("BattleVerifyController", "-- frame %s -- : buffid %s entityid %s counttime %s ", self._bsc_stepNum, protocol.buffid, protocol.entityid, protocol.counttime)
end

BattleVerifyController.GetVerifyResult = function(self)
  -- function num : 0_24 , upvalues : _ENV
  if self._bsc_battleWorld then
    LogWarning("BattleVerifyController", (string.format)("verify logic is not end, the verify_step is %s", self._verify_step))
  end
  return self._result
end

BattleVerifyController.GetBattlerByEntityId = function(self, entityId)
  -- function num : 0_25
  if ((self._battle).leftBattlers)[entityId] then
    return ((self._battle).leftBattlers)[entityId]
  end
  if ((self._battle).rightBattlers)[entityId] then
    return ((self._battle).rightBattlers)[entityId]
  end
end

BattleVerifyController.GetSummonByEntityId = function(self, entityId)
  -- function num : 0_26
  if ((self._battle).leftBattlersSummon)[entityId] then
    return ((self._battle).leftBattlersSummon)[entityId]
  end
  if ((self._battle).rightBattlersSummon)[entityId] then
    return ((self._battle).rightBattlersSummon)[entityId]
  end
end

BattleVerifyController.GetPartnerByEntityId = function(self, entityId)
  -- function num : 0_27
  if ((self._battle).leftPartners)[entityId] then
    return ((self._battle).leftPartners)[entityId]
  end
end

return BattleVerifyController

