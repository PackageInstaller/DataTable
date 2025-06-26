---
--- 受到群体攻击后,恢复${Params[1]}%伤害的生命值。自身下次攻击的最终伤害量提升${Params[2]}%。
---

local FightSoul_30045 = BaseClass("FightSoul_30045",Skill)
local base = Skill

local function __init(self)
    self.DamageAdd = 0
end

local function BeforeSkillEffect(self, targetUnit)
    self.__subc:IncTempNumeric(NumericType.FinalDamageAdd, self.DamageAdd)
end

local function OnAtkEnd(self)
    base.OnAtkEnd(self)
    self.DamageAdd = 0
end

local function AfterBeHitAll(self, atkUnit, activeSkillResult)
    base.AfterBeHitAll(self, atkUnit, activeSkillResult)

    if BattleUtil.IsSingleActiveSkill(self.__bc.CurActSkill) then
        return
    end

    if BattleUtil.IsFriend(atkUnit, self.SrcUnit) then
        return
    end

    local heal = activeSkillResult.TotalRealHpDamage * self.Params[1] / 100
    self.__subc:HealHp(heal)

    if self.DamageAdd <= 0 then
        self.DamageAdd = self.DamageAdd + self.Params[2]
    end
end

FightSoul_30045.__init = __init
FightSoul_30045.BeforeSkillEffect = BeforeSkillEffect
FightSoul_30045.OnAtkEnd = OnAtkEnd
FightSoul_30045.AfterBeHitAll = AfterBeHitAll

return FightSoul_30045