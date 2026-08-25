local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BP = bc.BattleProperty
local BattleUnitUtil = {}

function BattleUnitUtil.CheckPreventActiveDamage(target, attackConfig)
  if attackConfig.damageType ~= bc.DamageType.Active then
    return false
  end
  if target:ImmueDamage(attackConfig) then
    return false
  end
  local casterUid = attackConfig.castRoleUid
  local caster = casterUid and target.battleEngine:GetObj(casterUid)
  if not caster then
    return false
  end
  local casterBlockFlag = (caster:GetProperty(BP.PreventActiveDamage) or 0) > 0
  local targetBlockFlag = (target:GetProperty(BP.PreventBeActiveDamage) or 0) > 0
  return casterBlockFlag or targetBlockFlag
end

function BattleUnitUtil.CalcBlockedDamage(damageVal, damageSubType, blockBefore)
  if blockBefore <= 0 or damageVal <= 0 then
    return math.ceil(damageVal), 0, 0, false, false, blockBefore
  end
  local blockedDamageResult = 0
  local blockAfter = blockBefore
  if blockBefore <= damageVal then
    if damageSubType ~= bc.DamageSubType.Puncture then
      damageVal = damageVal - blockBefore
      blockedDamageResult = blockBefore
    end
    blockAfter = 0
  elseif damageSubType ~= bc.DamageSubType.Puncture then
    blockedDamageResult = damageVal - blockBefore
    blockAfter = blockBefore - damageVal
    damageVal = 0
  else
    blockAfter = blockBefore - damageVal
  end
  local isBlockedAllDamage = damageVal <= 0
  damageVal = math.ceil(damageVal)
  local shieldLossAmount = blockBefore - blockAfter
  return damageVal, blockedDamageResult, shieldLossAmount, true, isBlockedAllDamage, blockAfter
end

function BattleUnitUtil.ApplyIncomingDamageLimitsBeforeHpLoss(unit, damageAfterShield, hp, damageExtraReasonTable)
  local cappedDamageVal = damageAfterShield
  local beDamageLimit = unit:GetProperty(BP.be_damage_limit) or 0
  if beDamageLimit > 0 then
    local beDamageStatics = unit:GetProperty(BP.be_damage_statics) or 0
    local limitDamage = math.max(0, beDamageLimit - beDamageStatics)
    cappedDamageVal = math.min(cappedDamageVal, limitDamage)
  end
  local appliedPvpDeathResist = false
  if unit:GetProperty(BP.pvp_death_resist) > 0 and hp <= cappedDamageVal then
    cappedDamageVal = hp - 1
    appliedPvpDeathResist = true
    if damageExtraReasonTable then
      damageExtraReasonTable.pvp_death_resist = true
    end
  end
  return cappedDamageVal, appliedPvpDeathResist
end

function BattleUnitUtil.ApplyPreventBeActiveDamageRetainHp(unit, hpLossAfterShield, hpBefore)
  local retainHpThreshold = unit:GetProperty(BP.PreventBeActiveDamageRetainHP) or 0
  if retainHpThreshold <= 0 then
    return hpLossAfterShield, 0
  end
  local hpLossBeforeRetain = hpLossAfterShield
  local cappedHpLoss = math.min(hpLossAfterShield, math.max(0, hpBefore - retainHpThreshold))
  local convertDamageVal = hpLossBeforeRetain - cappedHpLoss
  return cappedHpLoss, convertDamageVal
end

return BattleUnitUtil
