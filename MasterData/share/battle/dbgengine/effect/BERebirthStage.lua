local bc = require("Battle.BattleConst")
local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BERebirthStage, Super = System.NewClass("BERebirthStage", BattleEffectServer)

function BERebirthStage:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BERebirthStage:Dispose()
  Super.Dispose(self)
  self.battleEngine:UnregisterAllEventsByTarget(self)
end

function BERebirthStage:DoEffect()
  Super.DoEffect(self)
  local targets = self.targets
  local baseHeal = self.params[1]
  for _, target in ipairs(targets) do
    if target:HpIs0() then
      self.battleEngine:LogBattleWithTab("%s 复活", target:GetBattleLogName())
      target:ChangeFsmState(bc.AwakerFsmState.Idle, {})
      if target:IsRoleType(bc.RoleType.Monster) then
        target:SubHpNum(1)
      end
      local rebirthData = {
        castRoleUid = self.effectConfig.castRoleUid,
        targetRoleUid = target.uid
      }
      self.battleEngine:CreateEventEffect(BattleLogicEvent.RoleAfterRebirth, rebirthData)
    end
    local heal = baseHeal
    local isCrit
    if self.effectConfig.calcParam then
      heal, isCrit = self.cmdServer:GetRealHeal(baseHeal, target)
    end
    local reason = bc.PropertyChangeReason.Heal
    if isCrit then
      reason = bc.PropertyChangeReason.HealCrit
    end
    local extraData = self:GetPropertyChangeSource(reason, heal)
    local finalHeal, overFlowHeal = target:Heal(heal, extraData)
    local healData = {
      castRoleUid = self.effectConfig.castRoleUid,
      targetRoleUid = target.uid,
      heal = heal,
      realHeal = finalHeal,
      overFlowHeal = overFlowHeal,
      cmdServerUid = self.cmdServerUid,
      isCrit = isCrit
    }
    self.battleEngine:CreateEventEffect(BattleLogicEvent.DoHeal, healData)
    self.battleEngine:CreateEventEffect(BattleLogicEvent.BeHeal, healData)
  end
  return true
end

return BERebirthStage
