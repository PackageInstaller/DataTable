---
--- 受到魔法伤害后，根据伤害量的${Params[1]}%提高自身攻击力1回合。
---

local Equip_13090204 = BaseClass("Equip_13090204", Skill)
local base = Skill

local function __init(self)
    self.Data.AtkAdd = 0
end

local function BeforeSkillEffect(self, targetUnit)
    base.BeforeSkillEffect(self, targetUnit)

    self.__subc:IncTempNumeric(NumericType.AtkAdd, self.Data.AtkAdd)
end

local function AfterBeHitAll(self, atkUnit, activeSkillResult)
    base.AfterBeHitAll(self, atkUnit, activeSkillResult)

    if activeSkillResult.FeixiaoDamage == nil or activeSkillResult.FeixiaoDamage.Type ~= BattleDamageType.Magic then
        return
    end

    self.Data.AtkAdd = self.Data.AtkAdd + activeSkillResult.TotalRealHpDamage * self.Params[1] / 100
end

local function OnUnitSelfTurnEnd(self)
    base.OnUnitSelfTurnEnd(self)

    self.Data.AtkAdd = 0
end

Equip_13090204.__init = __init
Equip_13090204.BeforeSkillEffect = BeforeSkillEffect
Equip_13090204.AfterBeHitAll = AfterBeHitAll
Equip_13090204.OnUnitSelfTurnEnd = OnUnitSelfTurnEnd

return Equip_13090204