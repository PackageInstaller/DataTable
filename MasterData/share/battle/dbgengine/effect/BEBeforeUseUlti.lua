local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local ForceConsumeMode = bc.ForceConsumeMode
local BEBeforeUseUlti, Super = System.NewClass("BEBeforeUseUlti", BattleEffectServer)

function BEBeforeUseUlti:DoEffect()
  Super.DoEffect(self)
  self:__AddSkillTimes()
  self.battleEngine.cardMgr:InsertHistory(nil, self.effectConfig.castRoleUid, self.effectConfig.skillToCard)
  self:__CostEnergy()
  self:__FireBeforeUseUltiSkill()
  return true
end

function BEBeforeUseUlti:__FireBeforeUseUltiSkill()
  if not self:IsTriggerBST() then
    return
  end
  local skillId = self.effectConfig.skillId
  local castRoleUid = self.effectConfig.castRoleUid
  local level = self.effectConfig.level
  local eventData = {
    skillId = skillId,
    castRoleUid = castRoleUid,
    level = level,
    cmdServer = self.cmdServer
  }
  local beforeEffectConfig = {
    effectType = bc.BattleEffectType.BESendEvent,
    eventId = BattleLogicEvent.BeforeUseUltiSkill,
    eventData = eventData
  }
  self.battleEngine.effectMgr:CreateEffect(beforeEffectConfig)
end

function BEBeforeUseUlti:__AddSkillTimes()
  if self.cmdServer:IsAttachPost() then
    return
  end
  if self.cmdServer:HasMemberValue("ForceCountAfter") and 0 == tonumber(self.cmdServer:GetMemberValue("ForceCountAfter")) then
    return
  end
  local caster = self.battleEngine:GetObj(self.effectConfig.castRoleUid)
  caster.data.boutSkillTimes = (caster.data.boutSkillTimes or 0) + 1
  self.battleEngine.recordMgr:OnSkillTimesChange(self.effectConfig.castRoleUid, caster.data.boutSkillTimes)
end

function BEBeforeUseUlti:__CostEnergy()
  if self.cmdServer:IsAttachPost() then
    return
  end
  local caster = self.battleEngine:GetObj(self.effectConfig.castRoleUid)
  local extraData = {
    castRoleUid = self.effectConfig.castRoleUid
  }
  local proName = bc.BattleProperty.ulti_energy
  local ultiEnergy = caster:GetProperty(proName)
  local maxUltiEnergy = caster.property:GetMaxUltiEnergy()
  local consumeMode = ForceConsumeMode.FullPay
  if self.cmdServer:HasMemberValue("ForceConsumeMode") then
    consumeMode = tonumber(self.cmdServer:GetMemberValue("ForceConsumeMode")) or ForceConsumeMode.FullPay
  end
  local forceSuper = 0
  if self.cmdServer:HasMemberValue("ForceSuperUltiSkill") then
    forceSuper = tonumber(self.cmdServer:GetMemberValue("ForceSuperUltiSkill")) or 0
  end
  local forceBaseCost = caster:GetUltiCost()
  forceBaseCost = self.cmdServer:HasMemberValue("ForceUltiBaseCost") and tonumber(self.cmdServer:GetMemberValue("ForceUltiBaseCost")) or forceBaseCost
  if caster:CanUseSuperUtlSkill() then
    self.cmdServer.cmdParser:SetMemberValue("SuperUtliSkill", 1)
  end
  local cost
  local costBack = 0
  local calcBranch = "normal"
  if consumeMode == ForceConsumeMode.IgnoreCost then
    calcBranch = "force_free"
    cost = 0
    self.cmdServer.cmdParser:SetMemberValue("SuperUtliSkill", forceSuper)
  elseif consumeMode == ForceConsumeMode.PartialPay then
    calcBranch = "force_partial"
    cost = ultiEnergy
    self.cmdServer.cmdParser:SetMemberValue("SuperUtliSkill", forceSuper)
  elseif 1 == forceSuper then
    calcBranch = "force_full_super"
    cost = ultiEnergy
    self.cmdServer.cmdParser:SetMemberValue("SuperUtliSkill", 1)
  elseif 1 == self.cmdServer.cmdParser:IsSuperUtlSkill() then
    if caster:GetProperty(bc.BattleProperty.ulti_skill_level_up) > 0 and caster.data.doubleUltiEnergy and ultiEnergy >= maxUltiEnergy then
      calcBranch = "super_level_up_partial"
      costBack = self.cmdServer.cmdParser:GetAwakerNormalUltiCost(caster.tid)
      cost = ultiEnergy
    else
      calcBranch = "normal_super"
      cost = ultiEnergy
    end
  else
    calcBranch = "normal_base"
    cost = caster:GetUltiCost()
    if caster.data.doubleUltiEnergy then
      cost = cost + math.max(0, (ultiEnergy - cost) // 2)
    end
    self.cmdServer.cmdParser:SetMemberValue("SuperUtliSkill", 0)
  end
  if cost > 0 then
    local realUltiCost = (ultiEnergy or 0) - caster:LoseUltiEnergy(cost, extraData)
    if realUltiCost > 0 then
      self.battleEngine:CreateEventEffect(BattleLogicEvent.ConsumeUltiEnergy, {
        castRoleUid = caster.uid,
        camp = caster:GetCamp(),
        realCost = realUltiCost,
        calcBranch = calcBranch
      })
    end
  end
  if costBack > 0 then
    caster:GainUltiEnergy(costBack, extraData)
  end
  local ultiEnergyAfter = caster:GetProperty(proName) or 0
  self.battleEngine:DebugS("[BEBeforeUseUlti] cost_result {roleUid} {consumeMode} {branch} {forceSuper} {baseCost} {realCost} {energyBefore} {energyAfter}", caster.uid, consumeMode, calcBranch, forceSuper, forceBaseCost, cost, ultiEnergy, ultiEnergyAfter)
  self.cmdServer.cmdParser:SetMemberValue("UltiEnergyCost", cost)
  self.cmdServer:SetMemberValue("ForceConsumeMode", nil)
  self.cmdServer:SetMemberValue("ForceCountAfter", nil)
  self.cmdServer:SetMemberValue("ForceSuperUltiSkill", nil)
  self.cmdServer:SetMemberValue("ForceUltiBaseCost", nil)
end

return BEBeforeUseUlti
