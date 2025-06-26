---
--- 暴击时，对所有敌军造成自身攻击力${Params[1]}%的额外伤害。
---
local Equip_11040104 = BaseClass("Equip_11040104", Skill)
local base = Skill

local function __init(self)
end

local function AfterOneTargetAllHit(self, targetUnit, activeSkillResult)
    base.AfterOneTargetAllHit(self, targetUnit, activeSkillResult)

    if BattleUtil.IsFriend(self.SrcUnit, targetUnit) then
        return
    end

    if activeSkillResult.IsCri then
        local attr = self.__snc:Get(NumericType.Atk)
        local damageData = DamageData.New(attr * self.Params[1] / 100, BattleDamageType.Universal)
        targetUnit:GetComponent("SsUnitBattleComponent"):DealDamage(self.SrcUnit, damageData)
    end
end

Equip_11040104.__init = __init
Equip_11040104.AfterOneTargetAllHit = AfterOneTargetAllHit

return Equip_11040104