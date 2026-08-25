local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BP = bc.BattleProperty
local BEHeal, Super = System.NewClass("BEHeal", BattleEffectServer)

function BEHeal:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEHeal:DoEffect()
  Super.DoEffect(self)
  self.totalEffectTimes = self.params[2] or 1
  self.leftEffectTimes = self.totalEffectTimes
  do return self.DoMultiEffect end
  return self.DoMultiEffect, self
end

function BEHeal:__DoMultiEffect()
  local targets = self.targets
  for _, target in ipairs(targets) do
    local effectType = bc.BattleEffectType.BEFunctionEffect
    local effectConfig = {
      effectType = effectType,
      func = self.Heal2SingleTarget,
      funcTarget = self,
      funcArgs = {target},
      targets = targets
    }
    self.battleEngine.effectMgr:CreateEffect(effectConfig)
  end
  self.leftEffectTimes = self.leftEffectTimes - 1
  return true
end

function BEHeal:Heal2SingleTarget(target)
  if target:IsDead() or target:HpIs0() then
    return
  end
  self:GenParams()
  local baseHeal = self.params[1]
  local paraPlusName = self.params[3]
  local castRoleUid = self.effectConfig.castRoleUid
  local heal, isCrit = self.cmdServer:GetRealHeal(baseHeal, target, paraPlusName)
  local reason = bc.PropertyChangeReason.Heal
  if isCrit then
    reason = bc.PropertyChangeReason.HealCrit
  end
  local extraData = self:GetPropertyChangeSource(reason, heal)
  local finalHeal, overFlowHeal = target:Heal(heal, extraData)
  local healData = {
    castRoleUid = castRoleUid,
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

return BEHeal
