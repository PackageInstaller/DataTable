---
--- 焚烧
--- 对全体敌人造成&{Params[1]}%法术伤害，&{Params[2]}%概率造成&{Params[3]}回合的【灼烧】。
---

local Skill_111802 = BaseClass("Skill_111802", Skill)
local base = Skill

local function __init(self)
end

local function OnUseActiveSkill(self, targetUnit)
    base.OnUseActiveSkill(self, targetUnit)

    local result = ActiveSkillResult.New()
    local damageScale = self.Params[1] / 100

    local atk = self.__snc:Get(NumericType.Atk)
    local damageNum = atk * damageScale / self.MultistageNum
    result.FeixiaoDamage = {
        Type = BattleDamageType.Magic,
        Value = damageNum
    }

    if BattleUtil.IsPctProbHit(self.Params[2]) then
        table.insert(result.Buffs, ActiveSkillBuff.New(BattleBuffType.Fire, self.Params[3]))
    end

    return result
end

Skill_111802.__init = __init
Skill_111802.OnUseActiveSkill = OnUseActiveSkill

return Skill_111802