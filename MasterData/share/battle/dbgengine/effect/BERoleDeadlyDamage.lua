local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BERoleDeadlyDamage, Super = System.NewClass("BERoleDeadlyDamage", BattleEffectServer)

function BERoleDeadlyDamage:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BERoleDeadlyDamage:Dispose()
  Super.Dispose(self)
end

function BERoleDeadlyDamage:AddRunningSubEffect(subEffect)
  local ret = subEffect:TryDoEffect()
  assert(ret ~= bc.YIELD_FLAG, "死亡类触发器无法处理 yield 效果" .. subEffect.effectType)
  if ret then
    do return subEffect.XpcallDoEffect end
    return subEffect.XpcallDoEffect, subEffect, "死亡类触发器无法处理 yield 效果" .. subEffect.effectType, subEffect.effectType
  else
    do return subEffect.EffectEnd end
    return subEffect.EffectEnd, subEffect, "死亡类触发器无法处理 yield 效果" .. subEffect.effectType, subEffect.effectType
  end
end

function BERoleDeadlyDamage:SubEffectEnd()
end

function BERoleDeadlyDamage:DoEffect()
  Super.DoEffect(self)
  self.battleEngine:Debug("--------------------", table.tostring(table.deepclone(self.effectConfig)))
  local role = self.battleEngine:GetObj(self.effectConfig.roleUid)
  local castRoleUid = self.effectConfig.castRoleUid
  if not role then
    return false
  end
  local eventData = {
    castRoleUid = castRoleUid,
    targetRoleUid = role.uid,
    castDamage = self.effectConfig.castDamage,
    overflowDamage = self.effectConfig.overflowDamage,
    cmdServerUid = self.effectConfig.fromCmdServerUid,
    hpChangeReason = self.effectConfig.hpChangeReason
  }
  self.battleEngine:CreateEventEffect(BattleLogicEvent.RoleBeforeDeathResist, eventData)
  if role:GetProperty(bc.RoleProperty.hp) > 0 then
    self.battleEngine.recordMgr:OnFloatingText(role.uid, "Float_Tip_Revive", "Heal")
    return false
  end
  local isDeathResist = role:IsDeathResist()
  if isDeathResist then
    role:DeathResist()
    self.battleEngine:CreateEventEffect(BattleLogicEvent.RoleAfterDeathResist, eventData)
    return false
  end
  self.battleEngine:CreateEventEffect(BattleLogicEvent.RoleBeforeDeath, eventData)
  if role:GetProperty(bc.RoleProperty.hp) > 0 then
    if role:GetProperty(bc.RoleProperty.rivive_popup) <= 0 then
      self.battleEngine.recordMgr:OnFloatingText(role.uid, "Float_Tip_Revive", "Heal")
    end
    return false
  end
  self.battleEngine:CreateEventEffect(BattleLogicEvent.RoleAfterDeath, eventData)
  return false
end

return BERoleDeadlyDamage
