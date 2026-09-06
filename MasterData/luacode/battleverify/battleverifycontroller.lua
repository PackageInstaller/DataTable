local BattleWorld = require("logic.newbattle.battleworld")
local SRoleCreate = BattleClientProtocolManager.GetProtocolDef("action.srolecreate")
local SRoleSummon = BattleClientProtocolManager.GetProtocolDef("action.srolesummoncreate")
local LineUpStation = BattleClientProtocolManager.GetBeanDef("data.lineupstation")
local BattleEndType = BattleClientProtocolManager.GetBeanDef("data.battleendtype")
local CBattleConfig = BeanManager.GetTableByName("battle.cbattleconstcfg")
local CRoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CMonsterConfigTable = BeanManager.GetTableByName("npc.cmonsterconfig")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CSkin = BeanManager.GetTableByName("role.cskin")
local CSceneInfoStatic = BeanManager.GetTableByName("scene.csceneinfostatic")
local CBattleSceneCfg = BeanManager.GetTableByName("scene.cbattlescenecfg")
local CBattleInfo = BeanManager.GetTableByName("battle.cbattleinfo")
local BattleVerifyController = class("BattleVerifyController")
local ResultType = {
  None = -1,
  Success = 0,
  StepDiff = 1,
  SkinWrong = 2,
  SceneZero = 3
}

function BattleVerifyController:Ctor()
  self._bsc_localProtocolData = {}
  self._bsc_battleWorld = nil
  self._bsc_battleStartProtocol = nil
  self._bsc_stepNum = 0
  self._bsc_battleResult = 0
  self._verify_step = 0
  self._bsc_isUsePartner = 0
  self._battle = {
    ownSideRolesInfo = {},
    enemySideRolesInfo = {},
    leftBattlers = {},
    rightBattlers = {},
    leftBattlersSummon = {},
    rightBattlersSummon = {},
    leftPartners = {},
    power1 = 0,
    power1Max = 0,
    power2 = 0,
    power2Max = 0
  }
  self._result = JSON.encode({
    result = ResultType.None
  })
end

function BattleVerifyController:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function BattleVerifyController:Init(proAndStep, stepNum)
  self._sendprotocolList = proAndStep
  self._verify_step = stepNum
  self._result = JSON.encode({
    result = ResultType.None
  })
end

function BattleVerifyController:BSC_GetStepNum()
  return self._bsc_stepNum
end

function BattleVerifyController:BSC_InitBattleScene(battleId)
  self._bsc_stepNum = 0
end

function BattleVerifyController:BSC_InitBattle()
  local Enum_Camp = BattleClientProtocolManager.GetBeanDef("data.enum_camp")
  self._bsc_battleWorld = BattleWorld.Create(function(protocol)
    self:BSC_SendProtocolToViewController(protocol)
  end, self._bsc_battleStartProtocol.battleid, self._battle_scene_id, self._bsc_battleStartProtocol.battleBuffs, self._bsc_battlePosList)
  self._bsc_battleWorld:SetAssistData(self._bsc_battleStartProtocol.assist)
  self._bsc_battleWorld:SetRandomSeed(self._bsc_battleStartProtocol.seed)
  local stationNumList = {
    LineUpStation.FRONT_ROW,
    LineUpStation.MIDDLE_ROW,
    LineUpStation.BACK_ROW
  }
  local initialTagType = {Not = 0, Is = 1}
  local leftRoleList = {}
  local leftAllRoleList = {}
  for _, i in ipairs(stationNumList) do
    local fighter = self._bsc_battleStartProtocol.left[i]
    local alternateFighter, alternateI
    if i == LineUpStation.FRONT_ROW then
      alternateI = LineUpStation.ALTERNATE_FRONT_ROW
      alternateFighter = self._bsc_battleStartProtocol.left[alternateI]
    elseif i == LineUpStation.MIDDLE_ROW then
      alternateI = LineUpStation.ALTERNATE_MIDDLE_ROW
      alternateFighter = self._bsc_battleStartProtocol.left[alternateI]
    elseif i == LineUpStation.BACK_ROW then
      alternateI = LineUpStation.ALTERNATE_BACK_ROW
      alternateFighter = self._bsc_battleStartProtocol.left[alternateI]
    end
    if fighter then
      local fighterBean = self:BSC_InitServerPlayer(Enum_Camp.LeftFighter, i, fighter, alternateFighter ~= nil)
      local alternateFighterBean
      table.insert(leftAllRoleList, fighter.id)
      if alternateFighter and alternateI then
        table.insert(leftAllRoleList, alternateFighter.id)
        alternateFighterBean = self:BSC_InitServerPlayer(Enum_Camp.LeftFighter, alternateI, alternateFighter)
      end
      self._bsc_battleWorld:CreateLeftPlayer(fighterBean, {
        alternateFighterBean = alternateFighterBean,
        isInitial = initialTagType.Is
      })
    end
  end
  for i = 1, 5 do
    local fighter = self._bsc_battleStartProtocol.right[i]
    if fighter then
      local fighterBean = self:BSC_InitServerPlayer(Enum_Camp.RightFighter, i, fighter)
      self._bsc_battleWorld:CreateRightPlayer(fighterBean, {
        isInitial = initialTagType.Is
      })
    end
  end
  local leftLineupList = {}
  leftLineupList.element = {}
  leftLineupList.vocation = {}
  for _, id in ipairs(leftAllRoleList) do
    local recorder = CRoleConfigTable:GetRecorder(id)
    if recorder then
      if leftLineupList.element[recorder.element] then
        leftLineupList.element[recorder.element] = leftLineupList.element[recorder.element] + 1
      else
        leftLineupList.element[recorder.element] = 1
      end
      if leftLineupList.vocation[recorder.vocation] then
        leftLineupList.vocation[recorder.vocation] = leftLineupList.vocation[recorder.vocation] + 1
      else
        leftLineupList.vocation[recorder.vocation] = 1
      end
    else
      LogErrorFormat("NewBattleSceneController", "No Exist croleconfig ID: %s", id)
    end
  end
  self._bsc_battleWorld:SetLeftLineupInfo(leftLineupList)
  self._bsc_battleWorld:SetWorldState("start")
  self._bsc_battleWorld:UpdataZero()
  self:BSC_UpdateLocalProtocol()
end

function BattleVerifyController:BSC_UpdateBattleLogic()
  while self._bsc_stepNum < self._verify_step do
    for _, p in ipairs(self._sendprotocolList) do
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

function BattleVerifyController:BSC_BattleLogicEnd()
  if not self._bsc_battleWorld then
    LogWarning("BattleVerifyController", "battleworld is nil in BSC_BattleLogicEnd")
    return
  end
  self._bsc_battleWorld:Destroy()
  self._bsc_battleWorld = nil
end

function BattleVerifyController:BSC_UpdateBattleLogicOneStep()
  self._bsc_stepNum = self._bsc_stepNum + 1
  self._bsc_battleWorld:Update()
  self:BSC_UpdateLocalProtocol()
  LuaNotificationCenter.PostNotification(Common.n_FrameNumUsed, BattleVerifyController, self._bsc_stepNum)
end

function BattleVerifyController:OnSBattleStart(protocol)
  self:BSC_InitBattleScene(protocol.battleid)
  self._bsc_battleStartProtocol = protocol
  self._battle_scene_id = protocol.battleSceneId
  if self._battle_scene_id == 0 then
    self._result = JSON.encode({
      result = ResultType.SceneZero
    })
    return
  else
    self._bsc_battlePosList = {}
    local sceneName = CSceneInfoStatic:GetRecorder(self._battle_scene_id).asset
    local posFile = require("data.battledata.scenepos." .. string.lower(sceneName))
    for i = 1, #posFile do
      local currentIndexPos = posFile[i]
      local x, y, z = currentIndexPos.x, currentIndexPos.y, currentIndexPos.z
      if x and y and z then
        self._bsc_battlePosList[i] = {
          x = fixedpoint(x) * 1000,
          y = fixedpoint(y) * 1000,
          z = fixedpoint(z) * 1000
        }
      else
        LogErrorFormat("BattleVerifyController", "pos index %s get x %s y %s z %s", i, x, y, z)
      end
    end
  end
  local battleSceneCfgRecorder = CBattleSceneCfg:GetRecorder(self._battle_scene_id)
  if battleSceneCfgRecorder and battleSceneCfgRecorder.hasBulletTime == 1 then
    self._bsc_canWaitingForEndTimeline = true
  else
    self._bsc_canWaitingForEndTimeline = false
  end
  self:BSC_InitBattle()
end

function BattleVerifyController:BSC_SendProtocolToViewController(protocol)
  table.insert(self._bsc_localProtocolData, protocol)
end

function BattleVerifyController:BSC_SendProtocolToLogicWorld(protocol)
  if self._bsc_battleWorld then
    protocol:Process(self._bsc_battleWorld)
  end
end

function BattleVerifyController:BSC_UpdateLocalProtocol()
  for _, v in ipairs(self._bsc_localProtocolData) do
    v:Process(self)
  end
  self._bsc_localProtocolData = {}
end

function BattleVerifyController:BSC_InitServerPlayer(camp, posId, fighter, haveAlternate)
  local Enum_Camp = BattleClientProtocolManager.GetBeanDef("data.enum_camp")
  local bean = BattleClientProtocolManager.CreateBean("data.attribute")
  bean.id = fighter.id
  bean.key = posId
  bean.camp = camp
  local AttrTypeEnum = BattleClientProtocolManager.GetBeanDef("data.attrtype")
  bean.hp = fighter.attrs[AttrTypeEnum.HP]
  bean.hpmax = fighter.attrs[AttrTypeEnum.MAX_HP]
  bean.atk = fighter.attrs[AttrTypeEnum.ATTACK]
  bean.def = fighter.attrs[AttrTypeEnum.DEFEND]
  bean.mdef = fighter.attrs[AttrTypeEnum.MAGIC_DEFEND]
  bean.damage = fighter.attrs[AttrTypeEnum.DAMAGE] or 0
  bean.physicalbonus = fighter.attrs[AttrTypeEnum.PHYSICALBONUS] or 0
  bean.physicalreduce = fighter.attrs[AttrTypeEnum.PHYSICALREDUCE] or 0
  bean.magicbonus = fighter.attrs[AttrTypeEnum.MAGICBONUS] or 0
  bean.magicreduce = fighter.attrs[AttrTypeEnum.MAGICREDUCE] or 0
  bean.physicalcritrate = fighter.attrs[AttrTypeEnum.CRITRATE] or 0
  bean.physicalcritdegree = fighter.attrs[AttrTypeEnum.CRITDEGREE] or 0
  bean.attackspeed = fighter.attrs[AttrTypeEnum.ATTACKSPEED] or 0
  bean.magiclifesteal = fighter.attrs[AttrTypeEnum.MAGICLIFESTEAL] or 0
  bean.physicallifesteal = fighter.attrs[AttrTypeEnum.PHYSICALLIFESTEAL] or 0
  bean.physicalevasion = fighter.attrs[AttrTypeEnum.EVASION] or 0
  bean.physicalblock = fighter.attrs[AttrTypeEnum.PHYSICALBLOCK] or 0
  bean.magicblock = fighter.attrs[AttrTypeEnum.MAGICBLOCK] or 0
  bean.physicaldefbreak = fighter.attrs[AttrTypeEnum.PHYSICALDEFBREAK] or 0
  bean.magicdefbreak = fighter.attrs[AttrTypeEnum.MAGICDEFBREAK] or 0
  bean.critrateresistance = fighter.attrs[AttrTypeEnum.CRITRATERESISTANCE] or 0
  bean.critdegreeresistance = fighter.attrs[AttrTypeEnum.CRITDEGREERESISTANCE] or 0
  bean.extraphysicaldamage = fighter.attrs[AttrTypeEnum.EXTRAPHYSICALDAMAGE] or 0
  bean.extramagicdamage = fighter.attrs[AttrTypeEnum.EXTRAMAGICDAMAGE] or 0
  bean.curativebonus = fighter.attrs[AttrTypeEnum.CURATIVEBONUS] or 0
  bean.accuracy = fighter.attrs[AttrTypeEnum.ACCURACY] or 0
  bean.critratelevel = fighter.attrs[AttrTypeEnum.CRIT_LEVEL] or 0
  bean.critdegreelevel = fighter.attrs[AttrTypeEnum.CRIT_DEGREE_LEVEL] or 0
  bean.healingpower = fighter.attrs[AttrTypeEnum.HEALING_POWER] or 0
  bean.comborate1 = fighter.attrs[AttrTypeEnum.COMBORATE1] or 0
  bean.comborate2 = fighter.attrs[AttrTypeEnum.COMBORATE2] or 0
  bean.damagereduce = fighter.attrs[AttrTypeEnum.DAMAGE_REDUCE] or 0
  bean.runelv = fighter.attrs[AttrTypeEnum.RUNE_LV] or 0
  bean.baseskill = fighter.baseSkill or 0
  bean.passiveskill = fighter.passiveSkills or {}
  bean.bosshpstr = tostring(fighter.hpStrip)
  bean.level = fighter.level or 0
  bean.evolutionLevel = fighter.evolutionlevel or 0
  bean.exclusiveLevel = fighter.exclusivelevel or 0
  bean.equipskilllist = fighter.equipSkills or {}
  bean.runeskilllist = fighter.runeskill or {}
  bean.autoExploreSkill = fighter.autoexploreskill or {}
  if haveAlternate then
    bean.havealternate = 1
  end
  for k, v in ipairs(fighter.skills) do
    table.insert(bean.skilllist, v)
  end
  local shapeRecorder
  local cskinRecoder = CSkin:GetRecorder(fighter.skinId)
  LogInfoFormat("BattleVerifyController", "skinId %s", fighter.skinId)
  if cskinRecoder then
    shapeRecorder = CNpcShapeTable:GetRecorder(cskinRecoder.shapeID)
  else
    local roleRecoder = CRoleConfigTable:GetRecorder(fighter.id)
    roleRecoder = roleRecoder or CMonsterConfigTable:GetRecorder(fighter.id)
    if roleRecoder then
      shapeRecorder = CNpcShapeTable:GetRecorder(roleRecoder.shapeID)
    else
      LogErrorFormat("BattleVerifyController", "fighter id %s dont have roleconfig or cmonsterconfig, so assetBundleName and prefabName are emptystring", fighter.id)
      shapeRecorder = {assetBundleName = "", prefabName = ""}
    end
  end
  bean.assetbundlename = shapeRecorder.assetBundleName
  bean.prefabname = shapeRecorder.prefabName
  if Enum_Camp.LeftFighter == camp then
    if bean.key == LineUpStation.FRONT_ROW or bean.key == LineUpStation.ALTERNATE_FRONT_ROW then
      bean.pos = tonumber(CBattleConfig:GetRecorder(50).attr)
    elseif bean.key == LineUpStation.MIDDLE_ROW or bean.key == LineUpStation.ALTERNATE_MIDDLE_ROW then
      bean.pos = tonumber(CBattleConfig:GetRecorder(51).attr)
    elseif bean.key == LineUpStation.BACK_ROW or bean.key == LineUpStation.ALTERNATE_BACK_ROW then
      bean.pos = tonumber(CBattleConfig:GetRecorder(52).attr)
    else
      bean.pos = bean.key
    end
  elseif Enum_Camp.RightFighter == camp then
    if bean.key <= 3 then
      bean.pos = tonumber(CBattleConfig:GetRecorder(bean.key + 52).attr)
    elseif bean.key == 4 then
      bean.pos = tonumber(CBattleConfig:GetRecorder(63).attr)
    elseif bean.key == 5 then
      bean.pos = tonumber(CBattleConfig:GetRecorder(64).attr)
    else
      bean.pos = bean.key
    end
  end
  return bean
end

function BattleVerifyController:OnSCreateFixPointSkillAttackedInfo(protocol)
  local battler
  if self._battle.leftBattlers[protocol.entityId] then
    battler = self._battle.leftBattlers[protocol.entityId]
  end
  battler = battler or self._battle.rightBattlers[protocol.entityId]
  battler = battler or self._battle.leftBattlersSummon[protocol.entityId]
  battler = battler or self._battle.rightBattlersSummon[protocol.entityId]
  if battler then
    battler.attribute.hp = protocol.currentHp
    if self._battle.ownSideRolesInfo[tostring(protocol.entityId)] then
      self._battle.ownSideRolesInfo[tostring(protocol.entityId)].hp = protocol.currentHp
    end
    if self._battle.enemySideRolesInfo[tostring(protocol.entityId)] then
      self._battle.enemySideRolesInfo[tostring(protocol.entityId)].hp = protocol.currentHp
    end
  end
end

function BattleVerifyController:OnSDestroyObject(protocol)
  if not self:GetBattlerByEntityId(protocol.entityid) then
    if self._battle.leftBattlersSummon[protocol.entityid] then
      LogInfoFormat("BattleVerifyController", "leftBattlersSummon entity %d destroy", protocol.entityid)
    end
    if self._battle.rightBattlersSummon[protocol.entityid] then
      LogInfoFormat("BattleVerifyController", "rightBattlersSummon entity %d destroy", protocol.entityid)
    end
    if protocol.skillid == 0 then
      if self._battle.rightBattlers[protocol.entityid] then
        self._battle.rightBattlers[protocol.entityid] = nil
      elseif self._battle.leftBattlers[protocol.entityid] then
        self._battle.leftBattlers[protocol.entityid] = nil
      elseif self._battle.leftBattlersSummon[protocol.entityid] then
        self._battle.leftBattlersSummon[protocol.entityid] = nil
      elseif self._battle.rightBattlersSummon[protocol.entityid] then
        self._battle.rightBattlersSummon[protocol.entityid] = nil
      else
        if self._battle.leftPartners[protocol.entityid] then
          self._battle.leftPartners[protocol.entityid] = nil
        else
        end
      end
    end
  elseif protocol.isimageentity == 1 then
    if self._battle.rightBattlers[protocol.entityid] then
      self._battle.rightBattlers[protocol.entityid] = nil
    elseif self._battle.leftBattlers[protocol.entityid] then
      self._battle.leftBattlers[protocol.entityid] = nil
    elseif self._battle.leftBattlersSummon[protocol.entityid] then
      self._battle.leftBattlersSummon[protocol.entityid] = nil
    elseif self._battle.rightBattlersSummon[protocol.entityid] then
      self._battle.rightBattlersSummon[protocol.entityid] = nil
    else
      if self._battle.leftPartners[protocol.entityid] then
        self._battle.leftPartners[protocol.entityid] = nil
      else
      end
    end
  end
end

function BattleVerifyController:OnSBattleWorldPowerShow(protocol)
  local power2 = protocol.blueCurrentPower or 0
  local power2Max = protocol.blueMaxPower or 0
  self._battle.power1 = protocol.redCurrentPower
  self._battle.power1Max = protocol.redMaxPower
  self._battle.power2 = power2
  self._battle.power2Max = power2Max
end

function BattleVerifyController:OnSRoleCreate(protocol)
  local Enum_Camp = BattleClientProtocolManager.GetBeanDef("data.enum_camp")
  if not self:GetBattlerByEntityId(protocol.entityid) then
    local gameObject
    if protocol.type == SRoleCreate.Role then
      if not self._battle.leftBattlers[protocol.entityid] then
        local battler = {
          entityId = protocol.entityid,
          attribute = protocol.attribute
        }
        self._battle.leftBattlers[protocol.entityid] = battler
      end
    elseif not self._battle.rightBattlers[protocol.entityid] then
      local battler = {
        entityId = protocol.entityid,
        attribute = protocol.attribute
      }
      self._battle.rightBattlers[protocol.entityid] = battler
    end
    if protocol.attribute.camp == Enum_Camp.LeftFighter and protocol.attribute.key > 0 then
      if not self._battle.ownSideRolesInfo[tostring(protocol.entityid)] then
        local attribute = {}
        attribute.id = protocol.attribute.id
        attribute.key = protocol.attribute.key
        attribute.hp = protocol.attribute.hp
        attribute.hpmax = protocol.attribute.hpmax
        attribute.onceequipskills = {}
        self._battle.ownSideRolesInfo[tostring(protocol.entityid)] = attribute
      end
    elseif protocol.attribute.camp == Enum_Camp.RightFighter and protocol.attribute.key > 0 and not self._battle.enemySideRolesInfo[tostring(protocol.entityid)] then
      local attribute = {}
      attribute.id = protocol.attribute.id
      attribute.key = protocol.attribute.key
      attribute.hp = protocol.attribute.hp
      attribute.hpmax = protocol.attribute.hpmax
      attribute.onceequipskills = {}
      self._battle.enemySideRolesInfo[tostring(protocol.entityid)] = attribute
    end
  else
    local battler = self:GetBattlerByEntityId(protocol.entityid)
    battler.attribute.hp = protocol.attribute.hp
    battler.attribute.hpmax = protocol.attribute.hpmax or battler.attribute.hpmax
  end
end

function BattleVerifyController:OnSPartnerCreate(protocol)
  local gameObject
  if not self:GetPartnerByEntityId(protocol.entityid) then
    local battler = {
      entityId = protocol.entityid,
      attribute = protocol.attribute
    }
    self._battle.leftPartners[protocol.entityid] = battler
  end
end

function BattleVerifyController:OnSRoleSummonCreate(protocol)
  if not self:GetBattlerByEntityId(protocol.entityid) then
    local gameObject
    if protocol.attribute.camp == SRoleSummon.Role then
      if not self._battle.leftBattlersSummon[protocol.entityid] then
        local battler = {
          entityId = protocol.entityid,
          attribute = protocol.attribute
        }
        self._battle.leftBattlersSummon[protocol.entityid] = battler
      end
    elseif protocol.attribute.camp == SRoleSummon.Monster and not self._battle.rightBattlersSummon[protocol.entityid] then
      local battler = {
        entityId = protocol.entityid,
        attribute = protocol.attribute
      }
      self._battle.rightBattlersSummon[protocol.entityid] = battler
    end
    if protocol.type == SRoleSummon.Role then
      if not self._battle.ownSideRolesInfo[tostring(protocol.entityid)] then
        local attribute = {}
        attribute.id = protocol.attribute.id
        attribute.key = protocol.attribute.key
        attribute.hp = protocol.attribute.hp
        attribute.hpmax = protocol.attribute.hpmax
        attribute.onceequipskills = {}
        self._battle.ownSideRolesInfo[tostring(protocol.entityid)] = attribute
      end
    elseif protocol.attribute.camp == SRoleSummon.Monster and not self._battle.enemySideRolesInfo[tostring(protocol.entityid)] then
      local attribute = {}
      attribute.id = protocol.attribute.id
      attribute.key = protocol.attribute.key
      attribute.hp = protocol.attribute.hp
      attribute.hpmax = protocol.attribute.hpmax
      attribute.onceequipskills = {}
      self._battle.enemySideRolesInfo[tostring(protocol.entityid)] = attribute
    end
  end
end

function BattleVerifyController:OnSRoleDead(protocol)
  if not self:GetBattlerByEntityId(protocol.entityId) and not self:GetSummonByEntityId(protocol.entityId) then
    LogErrorFormat("BattleVerifyController", "wrong entity %d", protocol.entityId)
  end
end

function BattleVerifyController:OnSBattleResult(protocol)
  local battleRes
  local battleID = self._bsc_battleStartProtocol.battleid
  local isLoseSettle = CBattleInfo:GetRecorder(battleID).defeatResult == 1
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
  self._result = JSON.encode({
    battleId = self._bsc_battleStartProtocol.battleid,
    ownSideRolesInfo = self._battle.ownSideRolesInfo,
    battleResult = self._bsc_battleResult,
    result = result
  })
end

function BattleVerifyController:OnSBattleEnd(protocol)
  LogInfo("BattleVerifyController-------------------------OnSBattleEnd : ", self._bsc_stepNum)
end

function BattleVerifyController:OnSUpdateRoleBuffs(protocol)
  LogInfoFormat("BattleVerifyController", "-- frame %s -- : buffid %s entityid %s counttime %s ", self._bsc_stepNum, protocol.buffid, protocol.entityid, protocol.counttime)
end

function BattleVerifyController:GetVerifyResult()
  if self._bsc_battleWorld then
    LogWarning("BattleVerifyController", string.format("verify logic is not end, the verify_step is %s", self._verify_step))
  end
  return self._result
end

function BattleVerifyController:GetBattlerByEntityId(entityId)
  if self._battle.leftBattlers[entityId] then
    return self._battle.leftBattlers[entityId]
  end
  if self._battle.rightBattlers[entityId] then
    return self._battle.rightBattlers[entityId]
  end
end

function BattleVerifyController:GetSummonByEntityId(entityId)
  if self._battle.leftBattlersSummon[entityId] then
    return self._battle.leftBattlersSummon[entityId]
  end
  if self._battle.rightBattlersSummon[entityId] then
    return self._battle.rightBattlersSummon[entityId]
  end
end

function BattleVerifyController:GetPartnerByEntityId(entityId)
  if self._battle.leftPartners[entityId] then
    return self._battle.leftPartners[entityId]
  end
end

return BattleVerifyController
