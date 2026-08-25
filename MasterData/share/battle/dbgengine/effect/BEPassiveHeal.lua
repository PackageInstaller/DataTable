local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BEPassiveHeal, Super = System.NewClass("BEPassiveHeal", BattleEffectServer)

function BEPassiveHeal:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEPassiveHeal:DoEffect()
  Super.DoEffect(self)
  self.totalEffectTimes = self.params[2] or 1
  self.leftEffectTimes = self.totalEffectTimes
  do return self.DoMultiEffect end
  return self.DoMultiEffect, self
end

function BEPassiveHeal:__DoMultiEffect()
  local targets = self.targets
  local baseHeal = self.params[1]
  baseHeal = self:CalFinalVal(baseHeal)
  local castRoleUid = self.effectConfig.castRoleUid
  for _, target in ipairs(targets) do
    if target:IsDead() or target:HpIs0() then
    else
      local reason = bc.PropertyChangeReason.Heal
      local extraData = self:GetPropertyChangeSource(reason, baseHeal)
      local finalHeal, overFlowHeal = target:Heal(baseHeal, extraData)
      local healData = {
        castRoleUid = castRoleUid,
        targetRoleUid = target.uid,
        heal = baseHeal,
        realHeal = finalHeal,
        overFlowHeal = overFlowHeal,
        cmdServerUid = self.cmdServerUid
      }
      self.battleEngine:CreateEventEffect(BattleLogicEvent.DoHeal, healData)
      self.battleEngine:CreateEventEffect(BattleLogicEvent.BeHeal, healData)
    end
  end
  self.leftEffectTimes = self.leftEffectTimes - 1
  return true
end

return BEPassiveHeal
