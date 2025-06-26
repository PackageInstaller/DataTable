---
--- 每个回合开始时，受到自身当前生命值${Params[1]}%的伤害。攻击后，造成自身最大生命值${Params[2]}%的额外伤害。
---

local Equip_14070204 = BaseClass("Equip_14070204", Skill)
local base = Skill

local function __init(self)
end

local function OnUnitSelfTurnStart(self)
    base.OnUnitSelfTurnStart(self)

    local damage = self.__snc:Get(NumericType.MaxHp) * self.Params[1] / 100
    local damageData = DamageData.New(damage, BattleDamageType.Universal)
    self.__subc:DealDamage(self.SrcUnit, damageData)
end

local function AfterOneTargetAllHit(self, targetUnit, activeSkillResult)
    base.AfterOneTargetAllHit(self, targetUnit, activeSkillResult)

    if BattleUtil.IsFriend(targetUnit, self.SrcUnit) then
        return
    end

    local damage = self.__snc:Get(NumericType.MaxHp) * self.Params[2] / 100
    local damageData = DamageData.New(damage, BattleDamageType.Universal)
    targetUnit:GetComponent("SsUnitBattleComponent"):DealDamage(self.SrcUnit, damageData)
end

Equip_14070204.__init = __init
Equip_14070204.OnUnitSelfTurnStart = OnUnitSelfTurnStart
Equip_14070204.AfterOneTargetAllHit = AfterOneTargetAllHit

return Equip_14070204