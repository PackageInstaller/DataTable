local System = require("System.System")
local BattleEntity = require("Battle.Ecs.BattleEntity")
local bc = require("Battle.BattleConst")
local BattleEffectServer, Super = System.NewClass("BattleEffectServer", BattleEntity)

function BattleEffectServer:ctor(battleEngine, effectConfig)
  Super.ctor(self)
  self.battleEngine = battleEngine
  self.uid = self.battleEngine:GenObjUid(self)
  self.effectConfig = effectConfig
  self.effectType = effectConfig.effectType
  self.fixArg = effectConfig.fixArg
  self.cmdCfg = effectConfig.cmdCfg
  self.cmdServer = effectConfig.cmdServer
  self.cmdServerUid = self.cmdServer and self.cmdServer.uid
  self.isDeleted = false
  self.preTriggerTime = 0
  self.leftEffectTimes = nil
  self.totalEffectTimes = nil
  self.subEffectList = {}
end

function BattleEffectServer:Dispose()
  Super.Dispose(self)
  self.battleEngine:UnregisterAllEventsByTarget(self)
end

function BattleEffectServer:DoEffect()
  self:PlayEffectSfx()
end

function BattleEffectServer:PlayEffectSfx()
  if self.cmdCfg ~= nil and nil ~= self.cmdCfg.VFX then
    local rand = self.battleEngine.rand
    local performType
    local targetUids = {}
    if self.cmdCfg.PerformTarget == "MineFieldCenter" then
      local casterRoleUid = self.cmdServer.castRoleUid
      if nil ~= casterRoleUid then
        local role = self.battleEngine:GetObj(casterRoleUid)
        if role and role.camp == bc.BattleCamp.Camp1 then
          performType = bc.PerformTargetType.Camp1FieldCenter
        else
          performType = bc.PerformTargetType.Camp2FieldCenter
        end
      end
    elseif self.cmdCfg.PerformTarget == "EnemyFieldCenter" then
      local casterRoleUid = self.cmdServer.castRoleUid
      if nil ~= casterRoleUid then
        local role = self.battleEngine:GetObj(casterRoleUid)
        if role and role.camp == bc.BattleCamp.Camp1 then
          performType = bc.PerformTargetType.Camp2FieldCenter
        else
          performType = bc.PerformTargetType.Camp1FieldCenter
        end
      end
    else
      local targets
      if nil == self.cmdCfg.PerformTarget then
        targets = self.targets
      elseif self.cmdCfg.PerformTarget == "CmdTarget" then
        targets = self.targets
      else
        targets = self:GenPerformTargets()
      end
      if nil == targets or 0 == #targets then
        return
      end
      local target = targets[1]
      if target:IsRoleType(bc.RoleType.Player) then
        performType = bc.PerformTargetType.Role
      elseif target:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) then
        performType = bc.PerformTargetType.Awaker
      elseif target.__name == "BattleCardServer" then
        performType = bc.PerformTargetType.Card
      end
      if performType == bc.PerformTargetType.Awaker then
        for _, t in ipairs(targets) do
          local awakerUid = t.uid
          table.insert(targetUids, awakerUid)
        end
      elseif performType == bc.PerformTargetType.Role then
        performType = bc.PerformTargetType.Awaker
        for _, t in ipairs(targets) do
          local awakerList = t:GetAwakerList()
          if #awakerList > 0 then
            local index = rand:random(1, #awakerList)
            local awaker = awakerList[index]
            table.insert(targetUids, awaker.uid)
          end
        end
      else
        for _, t in ipairs(targets) do
          table.insert(targetUids, t.uid)
        end
      end
    end
    if nil ~= performType then
      local cmdId = self.cmdServer and self.cmdServer.cmdId
      self.battleEngine.recordMgr:OnPlayEffectSfx(performType, targetUids, self.cmdCfg.VFX, cmdId)
    end
  end
end

function BattleEffectServer:CheckCondition()
  if self.battleEngine:IsBattleFinish() then
    return false
  end
  if not self.cmdServer then
    return true
  end
  local ret, reason = self:__CheckDeadCondition()
  if not ret then
    self.battleEngine:LogBattleWithTab("指令 %s 检查死亡条件失败 %s", self.cmdServer.cmdId, reason)
    return false
  end
  if not self.cmdCfg or not self.cmdCfg.Cond then
    return true
  end
  do return self.cmdServer.CheckCondition, self.cmdServer end
  return self.cmdServer.CheckCondition, self.cmdServer, self.cmdCfg.Cond, self.cmdServer.cmdId, reason
end

function BattleEffectServer:TryDoEffect()
  if self.cmdServer and self.cmdServer.castRoleUid then
    local caster = self.battleEngine:GetObj(self.cmdServer.castRoleUid)
    if not caster then
      return
    end
  end
  self.battleEngine.effectMgr:SetRunningEffect(self)
  local beforeDelay = self:GetConfigBeforeDelay()
  self.battleEngine:AddPassTime(beforeDelay)
  local ret = self:CheckCondition()
  if not ret then
    return ret
  end
  ret = self:GenTargets()
  if ret == bc.YIELD_FLAG then
    self.battleEngine:Debug("TryDoEffect yield {effectUid} {effectType}", self.uid, self.effectConfig.effectType)
    return ret
  end
  self:GenParams()
  return true
end

function BattleEffectServer:OnSelectTargets(msgData)
  local effectMgr = self.battleEngine.effectMgr
  local yieldData = effectMgr.yieldData
  if yieldData.targetSelectType == bc.TargetSelectType.CardDrop then
    local packIndexList = msgData.packIndexList
    if not self.cmdServer or not self.cmdServer.cmdParser then
      return false
    end
    if not self.cmdServer.cmdParser:ValidateCardDropPackIndexList(yieldData, packIndexList) then
      return false
    end
    local cardList = self.cmdServer.cmdParser:ExpandCardDropPackIndexList(yieldData.packList, packIndexList)
    local cardUids = {}
    for _, card in ipairs(cardList or {}) do
      table.insert(cardUids, card.uid)
    end
    effectMgr:Resume()
    self:GenTargetsBySelect(cardUids)
    self:GenParams()
    do return self.XpcallDoEffect end
    return self.XpcallDoEffect, self, cardUids, ipairs(cardList or {})
  end
  if yieldData.targetSelectType == bc.TargetSelectType.KeeperSkillDrop then
    local packIndexList = msgData.packIndexList
    if not self.cmdServer or not self.cmdServer.cmdParser then
      return false
    end
    if not self.cmdServer.cmdParser:ValidateKeeperSkillDropPackIndexList(yieldData, packIndexList) then
      return false
    end
    local keeperSkillList = self.cmdServer.cmdParser:ExpandKeeperSkillDropPackIndexList(yieldData.packList, packIndexList)
    self.cmdServer.cmdParser:OnSelectRandUnlockKeeperSkillDropPack(keeperSkillList)
    local keeperSkillUids = {}
    for _, keeperSkill in ipairs(keeperSkillList or {}) do
      table.insert(keeperSkillUids, keeperSkill.uid)
    end
    effectMgr:Resume()
    self:GenTargetsBySelect(keeperSkillUids)
    self:GenParams()
    do return self.XpcallDoEffect end
    return self.XpcallDoEffect, self, keeperSkillUids, ipairs(keeperSkillList or {})
  end
  local selectTargets = {}
  for _, targetUid in ipairs(yieldData.targetUids or {}) do
    if yieldData.targetSelectType == bc.TargetSelectType.KeeperSkill then
      selectTargets[targetUid.uid] = true
    else
      selectTargets[targetUid] = true
    end
  end
  local uids = msgData.targetUids
  if not uids then
    return false
  end
  local selectIds = {}
  for _, uid in ipairs(uids) do
    local target = self.battleEngine:GetObj(uid)
    if yieldData.targetSelectType == bc.TargetSelectType.KeeperSkill and self.battleEngine:IsPVE() then
      table.insert(selectIds, target.data.tid)
    end
    if not selectTargets[uid] then
      self.battleEngine:Error("选择目标不匹配!!!")
      return false
    end
  end
  if yieldData.targetSelectType == bc.TargetSelectType.KeeperSkill and self.battleEngine:IsPVE() then
    local skillConfigId = self.cmdServer and self.cmdServer.skillConfigId
    local stateId = self.cmdServer and self.cmdServer.stateId
    local sourceId = stateId or skillConfigId
    local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
    player:OnSelectKeeperSkills(sourceId, selectIds)
  end
  effectMgr:Resume()
  self:GenTargetsBySelect(uids)
  self:GenParams()
  do return self.XpcallDoEffect end
  return self.XpcallDoEffect, self, uids, self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1), player.OnSelectKeeperSkills, player, sourceId, selectIds, self.battleEngine, "选择目标不匹配!!!"
end

function BattleEffectServer:GenTargetsBySelect(uids)
  local targets = {}
  for _, uid in ipairs(uids) do
    local target = self.battleEngine:GetObj(uid)
    table.insert(targets, target)
  end
  self.targets = targets
end

function BattleEffectServer:GetTargetUids()
  local targetUids = {}
  for _, target in ipairs(self.targets) do
    table.insert(targetUids, target.uid)
  end
  return targetUids
end

function BattleEffectServer:PreTrigger(triggerData)
  if not triggerData and self.cmdServer then
    triggerData = self.cmdServer.triggerData
  end
  self.parentEffectUid = self.battleEngine.effectMgr:GetParentEffectUid()
  self.preTriggerTime = self.battleEngine:GetCurPassTime()
  self.triggerData = triggerData
  self:AppendToParentEffect()
end

function BattleEffectServer:GenPerformTargets()
  if self.effectConfig and self.effectConfig.performTargets then
    self.performTargets = self.effectConfig.performTargets
    return self.performTargets
  end
  local targetType = self.cmdCfg and self.cmdCfg.PerformTarget
  local performTargets
  if not targetType then
    performTargets = {}
  else
    local ret = self.cmdServer:GenerateTargetsExp(targetType, self.uid)
    if ret == bc.YIELD_FLAG then
      return ret
    end
    performTargets = ret:GetTargetList()
  end
  self.performTargets = performTargets
  return self.performTargets
end

function BattleEffectServer:GenTargets()
  if self.effectConfig and self.effectConfig.targets then
    self.targets = self.effectConfig.targets
    return self.targets
  end
  local targetType = self.cmdCfg and self.cmdCfg.Target
  local targets
  if not targetType then
    targets = {}
  else
    local ret = self.cmdServer:GenerateTargetsExp(targetType, self.uid)
    if ret == bc.YIELD_FLAG then
      return ret
    end
    targets = ret:GetTargetList()
  end
  self.targets = targets
  return self.targets
end

function BattleEffectServer:GenParams()
  if self.effectConfig and self.effectConfig.params then
    self.params = self.effectConfig.params
  elseif self.cmdServer and self.cmdCfg then
    if bc.SkipParserParamEffect[self.cmdCfg.Type] then
      self.params = {
        self.cmdCfg.Para
      }
    elseif self.cmdCfg.Para then
      self.params = self.cmdServer:GetValueListByCmd(self.cmdCfg.Para)
    end
  end
end

function BattleEffectServer:AppendToParentEffect()
  local parentEffectUid = self.parentEffectUid
  local parentEffect = self.battleEngine.effectMgr:GetEffectByUid(parentEffectUid)
  if parentEffect then
    parentEffect:AddRunningSubEffect(self)
  end
end

function BattleEffectServer:RemoveFromParentEffect()
  local parentEffectUid = self.parentEffectUid
  if not parentEffectUid then
    return
  end
  local parentEffect = self.battleEngine.effectMgr:GetEffectByUid(parentEffectUid)
  if parentEffect then
    do return parentEffect.SubEffectEnd end
    return parentEffect.SubEffectEnd, parentEffect
  end
end

function BattleEffectServer:EffectEnd()
  local parentEffect = self.battleEngine.effectMgr:GetEffectByUid(self.parentEffectUid)
  if parentEffect and self.battleEngine.effectMgr:GetRunningEffect() == self then
    self.battleEngine.effectMgr:SetRunningEffect(parentEffect)
  end
  self.isDeleted = true
  self.battleEngine.effectMgr:EffectEnd(self.uid)
  self.battleEngine:AddPassTime(self:GetConfigAfterDelay())
  do return self.RemoveFromParentEffect end
  return self.RemoveFromParentEffect, self, self:GetConfigAfterDelay()
end

function BattleEffectServer:AddRunningSubEffect(subEffect)
  table.insert(self.subEffectList, subEffect)
end

function BattleEffectServer:AfterEffect()
  if self.battleEngine:IsBattleFinish() then
    do return self.EffectEnd end
    return self.EffectEnd, self, nil
  end
  if self:GetEffectConfig("isFromCmd") and self.cmdServer then
    self.cmdServer:SetLastEffect(self.uid)
  end
  if self:CheckSubEffectEmpty() then
    do return self.RunNextMultiEffect end
    return self.RunNextMultiEffect, self, self.uid
  else
    do return self.RunSubEffect end
    return self.RunSubEffect, self, self.uid
  end
end

function BattleEffectServer:RunNextMultiEffect()
  if not self.leftEffectTimes or self.leftEffectTimes <= 0 then
    do return self.EffectEnd end
    return self.EffectEnd, self, nil, nil
  end
  local targetType = self.cmdCfg and self.cmdCfg.Target
  if string.find(targetType or "", "Random") then
    self.targets = self:GenTargets()
  end
  if self:DoMultiEffect() then
    if string.find(self.effectType, "Damage") or self.effectType == "BETentacleAttack" then
      self:PlayEffectSfx()
    end
    do return self.AfterEffect end
    return self.AfterEffect, self, "Damage"
  else
    do return self.EffectEnd end
    return self.EffectEnd, self, "Damage"
  end
end

function BattleEffectServer:SubEffectEnd()
  if self.battleEngine:IsBattleFinish() then
    do return self.EffectEnd end
    return self.EffectEnd, self
  end
  do return self.AfterEffect end
  return self.AfterEffect, self
end

function BattleEffectServer:CheckSubEffectEmpty()
  local isEmpty = true
  for _, _ in pairs(self.subEffectList) do
    isEmpty = false
  end
  return isEmpty
end

function BattleEffectServer:RunSubEffect()
  if self.battleEngine.effectMgr:IsOverflow() then
    self.battleEngine:Error("EffectOrder Overflow !!!! ")
    for _, subEffect in ipairs(self.subEffectList or {}) do
      subEffect.isDeleted = true
    end
    do return self.EffectEnd end
    return self.EffectEnd, self, ipairs(self.subEffectList or {})
  end
  local subEffect = table.remove(self.subEffectList, 1)
  if not subEffect then
    do return self.EffectEnd end
    return self.EffectEnd, self, ipairs(self.subEffectList or {})
  end
  local DT = self.battleEngine.battleDT
  if subEffect.effectConfig.cmdIndex then
    self.battleEngine:LogBattleWithTab("---> 执行次序: %s", subEffect.effectConfig.cmdIndex)
  end
  local ret = subEffect:TryDoEffect()
  local subEffectType = subEffect.effectConfig.effectType
  if DT.BattleApi[subEffectType] then
    self.battleEngine:LogBattleWithTab("执行子指令: %s 条件校验结果：%s", DT.BattleApi[subEffectType].CnID, ret)
    self.battleEngine:Debug("执行子指令: %s %s", subEffect.uid, DT.BattleApi[subEffectType].CnID)
  end
  if ret == bc.YIELD_FLAG then
    self.battleEngine:Debug("RunSubEffect yield {subEffectUid} {effectType}", subEffect.uid, subEffectType)
    return
  end
  if ret then
    do return subEffect.XpcallDoEffect end
    return subEffect.XpcallDoEffect, subEffect, "RunSubEffect yield {subEffectUid} {effectType}", subEffect.uid, subEffectType
  else
    do return subEffect.EffectEnd end
    return subEffect.EffectEnd, subEffect, "RunSubEffect yield {subEffectUid} {effectType}", subEffect.uid, subEffectType
  end
end

function BattleEffectServer:XpcallDoEffect()
  self.battleEngine.effectMgr:AddRunEffectNum(1)
  local DT = self.battleEngine.battleDT
  local ret, result = xpcall(self.DoEffect, function(error)
    local cmdId = self.cmdServer and self.cmdServer.cmdId or "nil"
    if "nil" ~= cmdId then
      local cmdCfg = DT.Cmd[cmdId]
      cmdId = cmdCfg and cmdCfg.CnID or cmdId
    end
    self.battleEngine:Error("效果 %s 指令 %s 运行错误 error: %s", self.effectConfig.effectType, cmdId, error)
    return error
  end, self)
  if result == bc.YIELD_FLAG then
    return
  end
  if ret and result then
    do return self.AfterEffect end
    return self.AfterEffect, self
  else
    do return self.EffectEnd end
    return self.EffectEnd, self
  end
end

function BattleEffectServer:GetConfigBeforeDelay()
  return self.effectConfig.BeforeDelay or 0
end

function BattleEffectServer:GetConfigAfterDelay()
  return self.effectConfig.AfterDelay or 0
end

function BattleEffectServer:GetStackNum()
  local parentEffectUid = self.parentEffectUid
  local parentEffect = self.battleEngine.effectMgr:GetEffectByUid(parentEffectUid)
  if not parentEffect then
    return 0
  end
  local exist = true
  return parentEffect:GetStackNum() + (exist and 1 or 0)
end

function BattleEffectServer:DoMultiEffect()
  local ret, result = xpcall(function()
    do return self.__DoMultiEffect end
    return self.__DoMultiEffect, self
  end, function(error)
    local cmdId = self.cmdServer and self.cmdServer.cmdId or "nil"
    self.battleEngine:Error("效果 %s 指令 %s 运行错误 error: %s", self.effectConfig.effectType, cmdId, error)
  end)
  if ret and result then
    return true
  else
    return false
  end
end

function BattleEffectServer:__DoMultiEffect()
  self.battleEngine:Error("子类需要实现多次效果内置方法")
  return false
end

function BattleEffectServer:GetDamageSubType(subType)
  subType = tonumber(subType) or 0
  if not bc.DamageSubTypeMatch[subType] then
    self.battleEngine:Warn("subType error: ", self.effectConfig.effectType, subType)
    subType = 0
  end
  return subType
end

function BattleEffectServer:GetPropertyChangeSource(reason, castValue)
  return {
    castRoleUid = self.effectConfig.castRoleUid,
    reason = reason,
    cmdServerUid = self.cmdServerUid,
    castValue = castValue,
    skillConfigId = self.cmdServer and self.cmdServer.skillConfigId
  }
end

function BattleEffectServer:GetEffectConfig(key)
  return self.effectConfig and self.effectConfig[key]
end

function BattleEffectServer:CalFinalVal(val)
  if val > 0 then
    local fina_per = self:GetDimensionFixPer()
    val = val * (1 + fina_per / 100)
  end
  do return math.ceil end
  return math.ceil, val
end

function BattleEffectServer:GetDimensionFixPer()
  local casterRoleUid = self.cmdServer.castRoleUid
  if nil ~= casterRoleUid then
    local role = self.battleEngine:GetObj(casterRoleUid)
    if role and role.camp == bc.BattleCamp.Camp1 then
      local player = role:GetPlayer()
      return player and player:GetProperty(bc.BattleProperty.dimension_fix_per)
    end
  end
  return 0
end

function BattleEffectServer:__CheckDeadCondition()
  local ignoreDead = self.triggerData and self.triggerData.ignoreDead
  local cmdServer = self.cmdServer
  local isFromState = cmdServer.stateId or cmdServer.stateUid
  local isFromSkill = cmdServer.skillConfigId
  if ignoreDead then
    return true
  end
  if self.battleEngine:IsPVE() then
    if isFromSkill then
      local cmdOwner = self.battleEngine:GetObj(self.cmdServer.castRoleUid)
      local cmdOwnerPlayer = cmdOwner and cmdOwner:GetPlayer()
      if not cmdOwnerPlayer or cmdOwnerPlayer:IsDead() then
        return false, "PVE:skill caster is dead"
      end
    end
    if isFromState then
      local stateObj = self.battleEngine:GetObj(cmdServer.stateUid)
      local owner = stateObj and stateObj.owner
      local ownerPlayer = owner and owner:GetPlayer()
      if not ownerPlayer or ownerPlayer:IsDead() then
        return false, "PVE:state owner is dead"
      end
    end
  else
    local cmdOwner = self.battleEngine:GetObj(self.cmdServer.castRoleUid)
    if not cmdOwner then
      return false, "PVP: no CmdCaster"
    end
  end
  return true
end

function BattleEffectServer:IsTriggerBST()
  local cmdServer = self.cmdServer
  if not cmdServer and self.effectConfig.cardUid then
    local cardUid = self.effectConfig.cardUid
    local card = self.battleEngine:GetObj(cardUid)
    if card then
      cmdServer = card:GetCardCmdServer()
    end
  end
  if cmdServer then
    do return cmdServer.IsTriggerBST end
    return cmdServer.IsTriggerBST, cmdServer, card:GetCardCmdServer(), card
  end
  return true
end

return BattleEffectServer
