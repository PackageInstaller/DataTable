local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BP = bc.BattleProperty
local BEChangeKeeperEnergy, Super = System.NewClass("BEChangeKeeperEnergy", BattleEffectServer)

function BEChangeKeeperEnergy:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEChangeKeeperEnergy:DoEffect()
  Super.DoEffect(self)
  local baseKeeperEnergy = math.ceil(self.params[1])
  baseKeeperEnergy = self:CalFinalVal(baseKeeperEnergy)
  local times = math.ceil(self.params[2] or 1)
  local reason = bc.PropertyChangeReason.AttrModify
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local energyBefore = player:GetProperty(BP.keeper_energy) or 0
  for _ = 1, times do
    local extraData = self:GetPropertyChangeSource(reason, baseKeeperEnergy)
    player:ChangeProperty(BP.keeper_energy, baseKeeperEnergy, extraData)
  end
  self:TryDispatchConsumeKeeperEnergy(player, energyBefore)
  return true
end

function BEChangeKeeperEnergy:TryDispatchConsumeKeeperEnergy(player, energyBefore)
  if not player then
    return
  end
  local skillId = self.cmdServer and self.cmdServer.skillConfigId
  local awakeSkillId = self.battleEngine.battleDT.GetConstant("SilverKeyAwakeSkill")
  if not (skillId and awakeSkillId) or skillId ~= awakeSkillId then
    return
  end
  local energyAfter = player:GetProperty(BP.keeper_energy) or 0
  local realKeeperCost = energyBefore - energyAfter
  if realKeeperCost <= 0 then
    self.battleEngine:DebugS("[BEChangeKeeperEnergy] skip_consume_stats {skillId} {realCost} {energyBefore} {energyAfter}", skillId, realKeeperCost, energyBefore, energyAfter)
    return
  end
  local castRoleUid = self.effectConfig and self.effectConfig.castRoleUid or self.cmdServer and self.cmdServer.castRoleUid or player.uid
  self.battleEngine:CreateEventEffect(BattleLogicEvent.ConsumeKeeperEnergy, {
    castRoleUid = castRoleUid,
    roleUid = player.uid,
    camp = player:GetCamp(),
    realCost = realKeeperCost,
    energyBefore = energyBefore,
    energyAfter = energyAfter,
    skillId = skillId
  })
  self.battleEngine:DebugS("[BEChangeKeeperEnergy] consume_stats {skillId} {realCost} {energyBefore} {energyAfter}", skillId, realKeeperCost, energyBefore, energyAfter)
end

return BEChangeKeeperEnergy
