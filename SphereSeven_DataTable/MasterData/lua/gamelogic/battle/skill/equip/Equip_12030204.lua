---
--- 暴击后，追加对方已损失生命${Params[1]}%的额外伤害

---
local Equip_12030204 = BaseClass("Equip_12030204", Skill)
local base = Skill

local function __init(self)
    self.triggering = false
end

local function AfterOneTargetAllHit(self, targetUnit, activeSkillResult)
    base.AfterOneTargetAllHit(self, targetUnit, activeSkillResult)

    if BattleUtil.IsFriend(self.SrcUnit, targetUnit) then
        return
    end

    if not activeSkillResult.IsCri then
        return
    end

    local targetUnitNumericComponent = targetUnit:GetComponent("NumericComponent")
    local damage = (targetUnitNumericComponent:Get(NumericType.MaxHp) - targetUnitNumericComponent:Get(NumericType.Hp)) * self.Params[1] / 100
    local damageData = DamageData.New(damage, BattleDamageType.Universal)
    targetUnit:GetComponent("SsUnitBattleComponent"):DealDamage(self.SrcUnit, damageData)
end

-- local function AfterDealDamage(self, damageData, reduceHp, hurtUnit)
--     if self.triggering then
--         return
--     end

--     if not damageData.IsCri then
--         return
--     end

--     self.triggering = true

--     local hurtUnitNumericComponent = hurtUnit:GetComponent("NumericComponent")
--     local damage = (hurtUnitNumericComponent:Get(NumericType.MaxHp) - hurtUnitNumericComponent:Get(NumericType.Hp)) * self.Params[1] / 100
--     local damageData = DamageData.New(damage, BattleDamageType.Universal)
--     hurtUnit:GetComponent("SsUnitBattleComponent"):DealDamage(self.SrcUnit, damageData)

--     self.triggering = false
-- end

Equip_12030204.__init = __init
Equip_12030204.AfterOneTargetAllHit = AfterOneTargetAllHit

return Equip_12030204