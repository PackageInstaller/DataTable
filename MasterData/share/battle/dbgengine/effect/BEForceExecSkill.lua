local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BP = bc.BattleProperty
local ForceConsumeMode = bc.ForceConsumeMode
local BEForceExecSkill, Super = System.NewClass("BEForceExecSkill", BattleEffectServer)

function BEForceExecSkill:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEForceExecSkill:Dispose()
  Super.Dispose(self)
end

function BEForceExecSkill:DoEffect()
  Super.DoEffect(self)
  local consumeModeRaw = self.params and self.params[1]
  local consumeMode = tonumber(consumeModeRaw)
  if not consumeMode and type(consumeModeRaw) == "string" and self.cmdServer then
    consumeMode = tonumber(self.cmdServer:GetValueByCmd(consumeModeRaw))
  end
  if consumeMode ~= ForceConsumeMode.IgnoreCost and consumeMode ~= ForceConsumeMode.PartialPay and consumeMode ~= ForceConsumeMode.FullPay then
    consumeMode = ForceConsumeMode.FullPay
  end
  local respectTimesRaw = self.params and self.params[2]
  local shouldCountRaw = self.params and self.params[3]
  local respectTimes = tonumber(respectTimesRaw)
  if nil == respectTimes and type(respectTimesRaw) == "string" and self.cmdServer then
    respectTimes = tonumber(self.cmdServer:GetValueByCmd(respectTimesRaw))
  end
  respectTimes = respectTimes or 0
  local shouldCount = tonumber(shouldCountRaw)
  if nil == shouldCount and type(shouldCountRaw) == "string" and self.cmdServer then
    shouldCount = tonumber(self.cmdServer:GetValueByCmd(shouldCountRaw))
  end
  shouldCount = shouldCount or 0
  local roleList = self.targets or {}
  self.battleEngine:DebugS("[BEForceExecSkill] start {effectUid} {consumeMode} {consumeModeRaw} {respectTimes} {respectTimesRaw} {shouldCount} {shouldCountRaw} {roleCount}", self.uid, consumeMode, consumeModeRaw, respectTimes, respectTimesRaw, shouldCount, shouldCountRaw, #roleList)
  if 0 == #roleList then
    self.battleEngine:DebugS("[BEForceExecSkill] failed {effectUid} {reason}", self.uid, "no_role")
    return false
  end
  local hasSuccess = false
  for _, role in ipairs(roleList) do
    local ret, reason = self:ExecuteOneRole(role, consumeMode, respectTimes, shouldCount)
    if ret then
      hasSuccess = true
      self.battleEngine:DebugS("[BEForceExecSkill] success {effectUid} {roleUid} {roleType} {consumeMode}", self.uid, role.uid, role.roleType, consumeMode)
    else
      self.battleEngine:DebugS("[BEForceExecSkill] skip {effectUid} {roleUid} {roleType} {reason}", self.uid, role and role.uid, role and role.roleType, reason or "unknown")
    end
  end
  self.battleEngine:DebugS("[BEForceExecSkill] finish {effectUid} {hasSuccess}", self.uid, hasSuccess and 1 or 0)
  return hasSuccess
end

function BEForceExecSkill:ExecuteOneRole(role, consumeMode, respectTimes, shouldCount)
  if not role or not role.roleType then
    return false, "invalid_role"
  end
  if role.roleType == bc.RoleType.Player then
    do return self.ExecutePlayer, self, role, consumeMode, respectTimes end
    return self.ExecutePlayer, self, role, consumeMode, respectTimes, shouldCount
  end
  if role.roleType == bc.RoleType.Awaker then
    do return self.ExecuteAwaker, self, role, consumeMode, respectTimes end
    return self.ExecuteAwaker, self, role, consumeMode, respectTimes, shouldCount
  end
  if role.roleType == bc.RoleType.Monster then
    do return self.ExecuteMonster, self end
    return self.ExecuteMonster, self, role, consumeMode, respectTimes, shouldCount
  end
  return false, "unsupported_role_type"
end

function BEForceExecSkill:ExecutePlayer(player, consumeMode, respectTimes, shouldCount)
  if not player or player:IsDead() or player:HpIs0() then
    return false, "player_dead"
  end
  local skillId, skillLevel = player:GetSkillIdAndLevel()
  if not skillId then
    return false, "player_no_skill"
  end
  local timesLimit = player:GetProperty(BP.bout_skill_times) or 0
  local usedTimes = player.data.boutSkillTimes or 0
  if 1 == respectTimes and timesLimit > 0 and timesLimit <= usedTimes then
    return false, "player_no_times"
  end
  local skillCfg = self.battleEngine.battleDT.Skill[skillId]
  if not skillCfg then
    return false, "player_skill_cfg_not_found"
  end
  local cost = player:GetKeeperSkillCost()
  local keeperEnergy = player:GetProperty(BP.keeper_energy) or 0
  if consumeMode == ForceConsumeMode.FullPay and cost > keeperEnergy then
    return false, "player_no_energy"
  end
  local cmdServer = player:GetSkillCmd(skillId, skillLevel)
  if cmdServer then
    cmdServer:SetMemberValue("ForceConsumeMode", consumeMode)
    cmdServer:SetMemberValue("ForceCountAfter", shouldCount)
  end
  self.battleEngine:DebugS("[BEForceExecSkill] player_exec {roleUid} {skillId} {skillLevel} {keeperEnergy} {needCost} {consumeMode}", player.uid, skillId, skillLevel, keeperEnergy, cost, consumeMode)
  self.battleEngine.roleMgr:SetCurCaster(player.uid)
  self.battleEngine:LogBattleWithTab("%s 释放技能: %s 等级: %s", player:GetBattleLogName(), skillCfg.CnID, skillLevel)
  player:CreateSkillEffect(skillId, skillLevel, bc.BattleEffectType.BEUseKeeperSkill, bc.BattleEffectType.BEAfterUseKeeperSkill, nil, nil, cmdServer)
  return true, "ok"
end

function BEForceExecSkill:ExecuteAwaker(awaker, consumeMode, respectTimes, shouldCount)
  if not awaker or awaker:IsDead() or awaker:HpIs0() then
    return false, "awaker_dead"
  end
  local ret, reason = awaker:CanUseUltiSkill()
  if not ret then
    if reason == bc.UltiFailedReason.NoTimes and 0 == respectTimes then
      ret = true
    elseif reason == bc.UltiFailedReason.NoEnergy and consumeMode ~= ForceConsumeMode.FullPay then
      ret = true
    else
      return false, string.format("awaker_can_use_failed_%s", reason or "nil")
    end
  end
  local skillId, skillLevel = awaker:GetSkillIdAndLevel()
  if not skillId then
    return false, "awaker_no_skill"
  end
  local baseCost = awaker:GetUltiCost()
  local maxUltiEnergy = awaker.property:GetMaxUltiEnergy()
  local curEnergy = awaker:GetProperty(BP.ulti_energy) or 0
  if consumeMode == ForceConsumeMode.FullPay and baseCost > curEnergy then
    return false, "awaker_no_energy"
  end
  local canSuper = awaker.data and awaker.data.doubleUltiEnergy
  local isForceSuper = false
  if canSuper then
    if consumeMode == ForceConsumeMode.IgnoreCost then
      isForceSuper = true
    elseif consumeMode == ForceConsumeMode.PartialPay then
      isForceSuper = baseCost <= curEnergy
    elseif consumeMode == ForceConsumeMode.FullPay then
      isForceSuper = maxUltiEnergy <= curEnergy
    end
  end
  local cmdServer = awaker:GetSkillCmd(skillId, skillLevel)
  if cmdServer then
    cmdServer:SetMemberValue("ForceConsumeMode", consumeMode)
    cmdServer:SetMemberValue("ForceCountAfter", shouldCount)
    cmdServer:SetMemberValue("ForceSuperUltiSkill", isForceSuper and 1 or 0)
    cmdServer:SetMemberValue("ForceUltiBaseCost", baseCost)
  end
  self.battleEngine:DebugS("[BEForceExecSkill] awaker_exec {roleUid} {skillId} {skillLevel} {curEnergy} {baseCost} {consumeMode} {forceSuper}", awaker.uid, skillId, skillLevel, curEnergy, baseCost, consumeMode, isForceSuper and 1 or 0)
  local beforeEffType = awaker:GetBeforeSkillEffectType()
  local afterEffType = awaker:GetAfterSkillEffectType()
  local awakerSkillCfg = self.battleEngine.battleDT.Skill[skillId]
  self.battleEngine.roleMgr:SetCurCaster(awaker.uid)
  if awakerSkillCfg then
    self.battleEngine:LogBattleWithTab("%s 释放技能: %s 等级: %s", awaker:GetBattleLogName(), awakerSkillCfg.CnID, skillLevel)
  end
  awaker:CreateSkillEffect(skillId, skillLevel, beforeEffType, afterEffType, nil, nil, cmdServer)
  return true, "ok"
end

function BEForceExecSkill:ExecuteMonster(monster)
  if not monster or monster:IsDead() or monster:HpIs0() then
    return false, "monster_dead"
  end
  local behavior = monster.monsterBehaviorComp
  if not (behavior and behavior.intention) or not behavior.intentionCmdServer then
    return false, "monster_no_intention"
  end
  self.battleEngine:DebugS("[BEForceExecSkill] monster_exec {roleUid} {intention}", monster.uid, behavior.intention)
  behavior.intentionRun = true
  self.battleEngine.roleMgr:SetCurCaster(monster.uid)
  behavior:__ActIntention(behavior.intentionCmdServer, behavior.intention)
  local switchConfig = {
    effectType = bc.BattleEffectType.BEFunctionEffect,
    func = self.OnMonsterActionEnd,
    funcTarget = self,
    funcArgs = {
      monster.uid
    }
  }
  self.battleEngine.effectMgr:CreateEffect(switchConfig)
  return true, "ok"
end

function BEForceExecSkill:OnMonsterActionEnd(monsterUid)
  local monster = self.battleEngine:GetObj(monsterUid)
  if not monster or not monster.monsterBehaviorComp then
    return
  end
  local behavior = monster.monsterBehaviorComp
  behavior:ClearIntentionAfterAction()
  behavior:CalcNextIntention()
  self.battleEngine:DebugS("[BEForceExecSkill] monster_switch_next {roleUid} {nextIntention}", monsterUid, behavior.intention)
end

return BEForceExecSkill
