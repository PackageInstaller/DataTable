local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BP = bc.BattleProperty
local BEAfterUseUlti, Super = System.NewClass("BEAfterUseUlti", BattleEffectServer)

function BEAfterUseUlti:DoEffect()
  Super.DoEffect(self)
  local caster = self.battleEngine:GetObj(self.effectConfig.castRoleUid)
  local extraData = {
    castRoleUid = self.effectConfig.castRoleUid
  }
  local energyReturn = math.ceil(caster:GetProperty(BP.ulti_energy_plus_2))
  caster:GainUltiEnergy(energyReturn, extraData)
  self:__FireAfterUseUltiSkill()
  return true
end

function BEAfterUseUlti:__FireAfterUseUltiSkill()
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
    cmdServer = self.effectConfig.cmdServer
  }
  local beforeEffectConfig = {
    effectType = bc.BattleEffectType.BESendEvent,
    eventId = BattleLogicEvent.AfterUseUltiSkill,
    eventData = eventData
  }
  self.battleEngine.effectMgr:CreateEffect(beforeEffectConfig)
end

return BEAfterUseUlti
