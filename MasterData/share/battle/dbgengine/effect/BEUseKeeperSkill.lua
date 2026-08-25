local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BP = bc.BattleProperty
local ForceConsumeMode = bc.ForceConsumeMode
local BEUseKeeperSkill, Super = System.NewClass("BEUseKeeperSkill", BattleEffectServer)

function BEUseKeeperSkill:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEUseKeeperSkill:Dispose()
  Super.Dispose(self)
end

function BEUseKeeperSkill:DoEffect()
  Super.DoEffect(self)
  local role = self.battleEngine:GetObj(self.effectConfig.castRoleUid)
  local forceCountAfter = 1
  if self.cmdServer:HasMemberValue("ForceCountAfter") then
    forceCountAfter = tonumber(self.cmdServer:GetMemberValue("ForceCountAfter")) or 0
  end
  self:__AddUseTimes(role, forceCountAfter)
  local skillId = self.effectConfig.skillId
  local cost = role:GetKeeperSkillCost()
  local consumeMode = ForceConsumeMode.FullPay
  if self.cmdServer:HasMemberValue("ForceConsumeMode") then
    consumeMode = tonumber(self.cmdServer:GetMemberValue("ForceConsumeMode")) or ForceConsumeMode.FullPay
  end
  local curEnergy = role:GetProperty(BP.keeper_energy) or 0
  local rawCost = cost
  if consumeMode == ForceConsumeMode.IgnoreCost then
    cost = 0
  elseif consumeMode == ForceConsumeMode.PartialPay then
    cost = math.min(curEnergy, cost)
  end
  local extraData = {
    castRoleUid = self.effectConfig.castRoleUid
  }
  if cost > 0 then
    role:SubProperty(BP.keeper_energy, cost, extraData)
  end
  local keeperEnergyAfter = role:GetProperty(BP.keeper_energy) or 0
  local realKeeperCost = curEnergy - keeperEnergyAfter
  if realKeeperCost > 0 then
    self.battleEngine:CreateEventEffect(BattleLogicEvent.ConsumeKeeperEnergy, {
      castRoleUid = self.effectConfig.castRoleUid,
      roleUid = role.uid,
      camp = role:GetCamp(),
      realCost = realKeeperCost,
      energyBefore = curEnergy,
      energyAfter = keeperEnergyAfter,
      skillId = skillId
    })
  end
  self.battleEngine:DebugS("[BEUseKeeperSkill] cost_result {roleUid} {consumeMode} {rawCost} {realCost} {energyBefore} {energyAfter} {countAfter}", role.uid, consumeMode, rawCost, cost, curEnergy, keeperEnergyAfter, forceCountAfter)
  self.cmdServer:SetMemberValue("keeper_energy_cost", cost)
  self.cmdServer:SetMemberValue("ForceConsumeMode", nil)
  self.cmdServer:SetMemberValue("ForceCountAfter", nil)
  self.battleEngine.recordMgr:OnUseKeeperSkill(role.uid, skillId)
  role:OnUseKeeperSkill(skillId)
  return true
end

function BEUseKeeperSkill:__AddUseTimes(role, forceCountAfter)
  if 0 ~= forceCountAfter then
    if self.effectConfig.skillId == role:GetChaosType2Skill() then
      role.data.chaosType2SkillTimes = (role.data.chaosType2SkillTimes or 0) + 1
      self.battleEngine.recordMgr:OnChaosType2SkillTimesChange(role.uid, role.data.chaosType2SkillTimes)
    elseif self.effectConfig.skillId == role:GetChaosType2Skill2() then
      role.data.chaosType2Skill2Times = (role.data.chaosType2Skill2Times or 0) + 1
      self.battleEngine.recordMgr:OnChaosType2Skill2TimesChange(role.uid, role.data.chaosType2Skill2Times)
    else
      role.data.boutSkillTimes = (role.data.boutSkillTimes or 0) + 1
      self.battleEngine.recordMgr:OnSkillTimesChange(role.uid, role.data.boutSkillTimes)
    end
  end
end

return BEUseKeeperSkill
