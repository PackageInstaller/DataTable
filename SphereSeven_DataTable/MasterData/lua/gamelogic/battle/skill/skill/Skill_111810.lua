---
--- 焚烧
--- 对全体敌人造成&{Params[1]}%法术伤害，&{Params[2]}%概率造成&{Params[3]}回合的【灼烧】。当攻击前自身的异常状态数量不多于&{Params[4]}个时，获得&{Params[5]}%额外倍率，造成【灼烧】的概率变成&{Params[6]}%。
---

local Skill_111810 = BaseClass("Skill_111810", Skill)
local base = Skill

local function __init(self)
end

local function OnUseActiveSkill(self, targetUnit)
    base.OnUseActiveSkill(self, targetUnit)

    local result = ActiveSkillResult.New()
    local damageScale = self.Params[1] / 100

    
    local prob = self.Params[2]
    if self.__sbc:BuffTypeCount(true) <= self.Params[4] then
        prob = self.Params[6]
        damageScale = damageScale + self.Params[5] / 100
    end
    
    local atk = self.__snc:Get(NumericType.Atk)
    local damageNum = atk * damageScale / self.MultistageNum
    result.FeixiaoDamage = {
        Type = BattleDamageType.Magic,
        Value = damageNum
    }

    if BattleUtil.IsPctProbHit(prob) then
        table.insert(result.Buffs, ActiveSkillBuff.New(BattleBuffType.Fire, self.Params[3]))
    end

    return result
end

Skill_111810.__init = __init
Skill_111810.OnUseActiveSkill = OnUseActiveSkill

return Skill_111810