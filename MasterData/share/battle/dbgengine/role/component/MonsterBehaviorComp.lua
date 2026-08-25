local System = require("System.System")
local BattleComponent = require("Battle.Ecs.BattleComponent")
local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BattleCmdServer = require("Battle.DbgEngine.Cmd.BattleCmdServer")
local BattleCmdParser = require("Battle.DbgEngine.Cmd.BattleCmdParser")
local BattleUtilServer = require("Battle.Util.BattleUtilServer")
local BP = bc.BattleProperty
local MonsterBehaviorComp, Super = System.NewClass("MonsterBehaviorComp", BattleComponent)
MonsterBehaviorComp.SkillListType = {
  Init = "InitSkillList",
  Loop1 = "CycleSkillList1",
  Loop2 = "CycleSkillList2",
  Loop3 = "CycleSkillList3"
}

function MonsterBehaviorComp:ctor(entity, battleEngine)
  Super.ctor(self, entity)
  self.monster = entity
  self.battleEngine = battleEngine
  self.skillListType = MonsterBehaviorComp.SkillListType.Init
  local cfg = self.monster.configData
  if not cfg[self.skillListType] or next(cfg[self.skillListType]) == nil then
    self.skillListType = MonsterBehaviorComp.SkillListType.Loop1
  end
  self.skillIndex = 0
  self.intention = nil
  self.intentionRun = nil
  self.lastIntention = nil
  self.lastDamageData = {}
  self.lastIntentionDescArgs = {}
  self.intentionDescArgs = {}
  self.tempSkillList = {}
end

function MonsterBehaviorComp:Serialize()
  return {
    skillIndex = self.skillIndex,
    lastIntention = self.lastIntention,
    lastDamageData = self.lastDamageData,
    skillListType = self.skillListType,
    intentionDescArgs = self.intentionDescArgs,
    lastIntentionDescArgs = self.lastIntentionDescArgs
  }
end

function MonsterBehaviorComp:OnSnapShot()
  return {
    skillIndex = self.skillIndex,
    skillListType = self.skillListType,
    intention = self.intention,
    intentionRun = self.intentionRun,
    lastIntention = self.lastIntention,
    lastDamageData = self.lastDamageData,
    intentionDescArgs = self.intentionDescArgs,
    lastIntentionDescArgs = self.lastIntentionDescArgs,
    tempSkillList = self.tempSkillList,
    damage = self.damage,
    damageTimes = self.damageTimes,
    damageSubType = self.damageSubType
  }
end

function MonsterBehaviorComp:OnRecover(behaviorData)
  self.intention = behaviorData.intention
  self.skillIndex = behaviorData.skillIndex or 0
  self.lastIntention = behaviorData.lastIntention
  self.lastDamageData = behaviorData.lastDamageData or {}
  self.skillListType = behaviorData.skillListType
  self.intentionRun = behaviorData.intentionRun
  self.intentionDescArgs = behaviorData.intentionDescArgs or {}
  self.lastIntentionDescArgs = behaviorData.lastIntentionDescArgs or {}
  self.tempSkillList = behaviorData.tempSkillList or {}
  self.damage = behaviorData.damage
  self.damageTimes = behaviorData.damageTimes
  self.damageSubType = behaviorData.damageSubType
  local DT = self.battleEngine.battleDT
  local skillCfg = DT.Skill[self.intention]
  if skillCfg and skillCfg.CmdList then
    local cmd = self:__GetIntentionCmd(skillCfg)
    local cmdCtorData = {
      skillConfigId = self.intention,
      cmdId = cmd,
      castRoleUid = self.monster.uid,
      configPara = skillCfg.Para,
      genArgsInstantly = true
    }
    self.intentionCmdServer = BattleCmdServer(self.battleEngine, cmdCtorData)
  end
end

function MonsterBehaviorComp:NextSkillInList()
  local list = self.monster.configData[self.skillListType]
  self.skillIndex = self.skillIndex + 1
  if self.skillListType == MonsterBehaviorComp.SkillListType.Init and #list < self.skillIndex then
    self.skillListType = MonsterBehaviorComp.SkillListType.Loop1
    self.skillIndex = 1
    list = self.monster.configData[self.skillListType]
  end
  list = list or {}
  if #list < self.skillIndex then
    self.skillIndex = 1
  end
  self.battleEngine:Debug("NextSkillInList {skillIndex} {skillConfigId}", self.skillIndex, list[self.skillIndex])
  return list[self.skillIndex]
end

function MonsterBehaviorComp:ChangeSkill(skillConfigId, changeType)
  if changeType == bc.MonsterSkillChangeType.Substitute then
    self.tempSkillList = {}
  elseif changeType == bc.MonsterSkillChangeType.Insert and not self.intentionRun and self.intention then
    table.insert(self.tempSkillList, {
      intention = self.intention,
      changeType = changeType
    })
  end
  self:SetIntention(skillConfigId)
end

function MonsterBehaviorComp:ChangeSkillList(skillListIndex)
  self.tempSkillList = {}
  local skillListType = "CycleSkillList" .. tostring(skillListIndex)
  local list = self.monster.configData[skillListType]
  local skillConfigId
  if nil == list then
    self.battleEngine:Error("不存在的怪物技能循环列表 " .. skillListType)
  else
    self.skillListType = skillListType
    self.skillIndex = 1
    skillConfigId = list[self.skillIndex]
  end
  self:SetIntention(skillConfigId)
end

function MonsterBehaviorComp:SetIntention(skillId)
  if self.intentionCmdServer then
    self.intentionCmdServer:Dispose()
  end
  self.lastIntention = self.intention
  self.intention = skillId
  if not self.intention then
    self:UpdateIntentionDamage(true)
  else
    self.intentionRun = false
  end
  local eventData = {
    uid = self.monster.uid,
    lastIntention = self.lastIntention,
    intention = self.intention
  }
  self.battleEngine:CreateEventEffect(BattleLogicEvent.IntentionChanged, eventData)
  local DT = self.battleEngine.battleDT
  local skillCfg = DT.Skill[self.intention]
  local name = skillCfg and skillCfg.CnID or "无"
  self.battleEngine:LogBattleWithTab("%s 意图变为 %s", self.monster:GetBattleLogName(), name)
  if not skillCfg then
    return
  end
  if not skillCfg.CmdList then
    self.intentionCmdServer = nil
    self.battleEngine.recordMgr:OnMonsterIntenion(self.monster.uid, self.intention, {})
    self.lastDamageData.damage = 0
    self.lastDamageData.damageTimes = 0
    return
  end
  local cmd = self:__GetIntentionCmd(skillCfg)
  local cmdCtorData = {}
  cmdCtorData.skillConfigId = self.intention
  cmdCtorData.cmdId = cmd
  cmdCtorData.castRoleUid = self.monster.uid
  cmdCtorData.configPara = skillCfg.Para
  cmdCtorData.genArgsInstantly = true
  self.intentionCmdServer = BattleCmdServer(self.battleEngine, cmdCtorData)
  local _, descArgs = self.intentionCmdServer:GetSkillArgs()
  self.intentionDescArgs = descArgs
  self:UpdateIntentionDamage()
end

function MonsterBehaviorComp:UpdateIntentionDamage(isEmpty)
  if isEmpty then
    self.battleEngine.recordMgr:OnMonsterIntenion(self.monster.uid, self.intention, {}, self.intentionDescArgs)
    self.lastDamageData.damage = nil
    self.lastDamageData.damageTimes = nil
    self.lastIntentionDescArgs = self.intentionDescArgs or {}
    return
  end
  if not self.intentionCmdServer then
    return
  end
  local _, descArgs = self.intentionCmdServer:GetSkillArgs()
  self.intentionDescArgs = descArgs
  local damage, damageTimes, damageSubType
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local effectList = self.intentionCmdServer:GenerateEffectList()
  for _, effect in ipairs(effectList or {}) do
    if effect.effectType == bc.BattleEffectType.BEActiveDamage then
      local cmdServer = effect.cmdServer
      local params = cmdServer:GetValueListByCmd(effect.cmdCfg.Para)
      local baseDamage = params[1]
      damageSubType = effect:GetDamageSubTypeValue(params)
      damage = math.ceil(cmdServer:GetRealDmg(baseDamage, player, false))
      damage = math.max(0, damage)
      damageTimes = params[2] or 1
      damageTimes = damageTimes + self.monster:GetProperty(bc.BattleProperty.damagetimes_plus)
      damageTimes = math.ceil(damageTimes * (1 + self.monster:GetProperty(BP.damagetimes_per) / 100))
      damageTimes = math.max(1, damageTimes)
      break
    end
  end
  self.damage = damage
  self.damageTimes = damageTimes
  self.damageSubType = damageSubType
  
  local function isTableEqual(a, b)
    if a == b then
      return true
    end
    if type(a) ~= "table" or type(b) ~= "table" then
      return false
    end
    for k, v in pairs(a) do
      if b[k] ~= v then
        return false
      end
    end
    for k, _ in pairs(b) do
      if nil == a[k] then
        return false
      end
    end
    return true
  end
  
  local lastDescArgs = self.lastIntentionDescArgs or {}
  local curDescArgs = self.intentionDescArgs or {}
  local isDescChanged = not isTableEqual(lastDescArgs, curDescArgs)
  if self.lastIntention ~= self.intention or self.lastDamageData.damage ~= damage or self.lastDamageData.damageTimes ~= damageTimes or isDescChanged then
    self.lastIntention = self.intention
    self.lastDamageData.damage = damage
    self.lastDamageData.damageTimes = damageTimes
    self.lastDamageData.damageSubType = damageSubType
    self.lastIntentionDescArgs = self.intentionDescArgs or {}
    self.battleEngine.recordMgr:OnMonsterIntenion(self.monster.uid, self.intention, {
      damage,
      damageTimes,
      damageSubType
    }, self.intentionDescArgs)
  end
end

function MonsterBehaviorComp:GetDamageInfo()
  return {
    self.damage,
    self.damageTimes,
    self.damageSubType
  }
end

function MonsterBehaviorComp:GetDamageInfoValue()
  if not self.intentionCmdServer then
    return
  end
  if not self.intention then
    return
  end
  local damageInfo = self:GetDamageInfo()
  return {
    (damageInfo[1] or 0) * (damageInfo[2] or 1),
    damageInfo[2] or 1,
    damageInfo[3] or 0
  }
end

function MonsterBehaviorComp:GetIntention()
  return self.intention
end

function MonsterBehaviorComp:ActByIntention()
  if self.monster:IsDead() or self.monster:HpIs0() or not self.intention then
    return
  end
  self.intentionRun = true
  self.battleEngine.roleMgr:SetCurCaster(self.monster.uid)
  self:__ActIntention(self.intentionCmdServer, self.intention)
end

function MonsterBehaviorComp:CalcNextIntention()
  if self.intention then
    return
  end
  local skillId
  if #self.tempSkillList > 0 then
    local tempSkillInfo = table.remove(self.tempSkillList)
    skillId = tempSkillInfo.intention
  else
    skillId = self:NextSkillInList()
  end
  self:SetIntention(skillId)
  return true
end

function MonsterBehaviorComp:GetIntentionType()
  local DT = self.battleEngine.battleDT
  local skillCfg = DT.Skill[self.intention]
  if not skillCfg then
    return
  end
  return skillCfg.Type[1]
end

function MonsterBehaviorComp:InitExistState()
  local role = self.monster
  local DT = self.battleEngine.battleDT
  local monsterConfig = self.monster.configData
  local stateLayersStr = monsterConfig.StateLayers
  local stateParamsStr = monsterConfig.StateParams
  local ctorData = {
    castRoleUid = role.uid
  }
  local cmdParser = BattleCmdParser(self.battleEngine, ctorData)
  local layers = {}
  if stateLayersStr then
    layers = table.pack(cmdParser:GetValueByCmd(stateLayersStr))
  end
  local stateParams = {}
  if stateParamsStr then
    stateParams = table.pack(cmdParser:GetValueByCmd(stateParamsStr))
  end
  for i, stateId in ipairs(monsterConfig.ExistState or {}) do
    local createArgs = {
      stateId = stateId,
      castRoleUid = role.uid,
      stateParams = stateParams,
      layer = math.ceil(layers[i] or 1)
    }
    self.battleEngine.stateMgr:CreateState(role, createArgs)
  end
  for _, colName in pairs(MonsterBehaviorComp.SkillListType) do
    local skillList = monsterConfig[colName]
    if skillList and #skillList > 0 then
      for _, skillId in ipairs(skillList) do
        local skillCfg = DT.Skill[skillId]
        local skillStatelayers = {}
        if skillCfg.StateLayer then
          layers = cmdParser:GetValueByCmdList(skillCfg.StateLayer)
        end
        local skillStateParams = {}
        if skillCfg.StatePara then
          layers = cmdParser:GetValueByCmdList(skillCfg.StatePara)
        end
        local skillCtorData = {
          castRoleUid = role.uid,
          skillConfigId = skillId
        }
        local existStates = self.battleEngine:GetValByCondList(skillCtorData, skillId, "ExistState") or {}
        for i, stateId in ipairs(existStates) do
          local createArgs = {
            stateId = stateId,
            castRoleUid = role.uid,
            stateParams = skillStateParams,
            layer = math.ceil(skillStatelayers[i] or 1)
          }
          self.battleEngine.stateMgr:CreateState(role, createArgs)
        end
      end
    end
  end
  local stageId = self.battleEngine:GetStageId()
  local difficultyId = self.battleEngine:GetDifficultyId()
  local mapNodeGroupId = self.battleEngine:GetMapNodeGroupId()
  local dataConfig = BattleUtilServer.GetStageMonsterData(DT, stageId, difficultyId, monsterConfig.BattleTag, mapNodeGroupId)
  local stageLayers = {}
  if dataConfig.StageStateLayers then
    stageLayers = table.pack(cmdParser:GetValueByCmd(dataConfig.StageStateLayers))
  end
  local stageStateParams = {}
  if dataConfig.StageStateParams then
    stageStateParams = table.pack(cmdParser:GetValueByCmd(dataConfig.StageStateParams))
  end
  for i, stateId in ipairs(dataConfig.StageStatus or {}) do
    local createArgs = {
      stateId = stateId,
      castRoleUid = role.uid,
      stateParams = stageStateParams,
      layer = math.ceil(stageLayers[i] or 1)
    }
    self.battleEngine.stateMgr:CreateState(role, createArgs)
  end
end

function MonsterBehaviorComp:GetMonsterClass()
  return self.monster.configData.MonsterClass
end

function MonsterBehaviorComp:ClearIntentionAfterAction()
  if self.intentionRun then
    self:SetIntention(nil)
  end
end

function MonsterBehaviorComp:ActByAttachPost(skillTid, attachPostParam)
  if self.monster:IsDead() or self.monster:HpIs0() then
    return
  end
  local cmdServer = self.monster:GetSkillCmd(skillTid, 1)
  cmdServer.attachPostParam = attachPostParam
  self:__ActIntention(cmdServer, skillTid)
  local attachEventData = {
    executorUid = self.monster.uid,
    cmdServerUid = cmdServer.uid,
    skillTid = skillTid
  }
  self.battleEngine:CreateEventEffect(BattleLogicEvent.AfterAttachPostAction, attachEventData)
end

function MonsterBehaviorComp:__ActIntention(cmdServer, skillTid)
  local DT = self.battleEngine.battleDT
  local intentionName = "无"
  if cmdServer then
    local skillCfg = DT.Skill[skillTid]
    intentionName = skillCfg.CnID
    cmdServer:ClearStats()
    local targetEffectConfig = {
      effectType = bc.BattleEffectType.BEGenerateTargets,
      cmdServer = cmdServer,
      targetType = self.battleEngine:GetSkillTargetType(self.monster.uid, skillTid, 1),
      castRoleUid = self.monster.uid
    }
    self.battleEngine.effectMgr:CreateEffect(targetEffectConfig)
  end
  self.battleEngine:LogBattle("%s 开始行动: 意图 %s", self.monster:GetBattleLogName(), intentionName)
  local beforeEffectConfig = {
    effectType = bc.BattleEffectType.BESendEvent,
    eventId = BattleLogicEvent.BeforeMonsterAction,
    eventData = {
      castRoleUid = self.monster.uid,
      skillId = skillTid,
      cmdServer = cmdServer
    }
  }
  self.battleEngine.effectMgr:CreateEffect(beforeEffectConfig)
  if cmdServer then
    local skillEffectConfig = {
      effectType = bc.BattleEffectType.BECreateSkillPhase,
      cmdServer = cmdServer
    }
    self.battleEngine.effectMgr:CreateEffect(skillEffectConfig)
  end
  local afterEffectConfig = {
    effectType = bc.BattleEffectType.BEAfterMonsterAction,
    castRoleUid = self.monster.uid,
    cmdServer = cmdServer
  }
  self.battleEngine.effectMgr:CreateEffect(afterEffectConfig)
end

function MonsterBehaviorComp:__GetIntentionCmd(skillCfg)
  local cmd
  if skillCfg.IsPVP then
    local condList = skillCfg.CmdList
    cmd = BattleUtilServer.GetTrueConditionByCmd(self.intentionCmdServer, condList)
  else
    cmd = tonumber(skillCfg.CmdList)
  end
  return cmd
end

return MonsterBehaviorComp
