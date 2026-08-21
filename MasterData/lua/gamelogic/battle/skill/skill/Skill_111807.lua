---
--- 黑龙爆炎
--- 对全体敌人造成&{Params[1]}%法术伤害并有&{Params[2]}%的概率解除所有强化效果，当攻击前自身不处于异常状态时，&{Params[3]}%的概率造成&{Params[4]}回合的【回复禁止】。
---

local Skill_111807 = BaseClass("Skill_111807", Skill)
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
        result.FeixiaoDispel = {
            Tpye = BattleDispelType.Buff,
            Value = -1
        }
    end

    if not self.__sbc:HasDeBuff() and BattleUtil.IsPctProbHit(self.Params[3]) then
        table.insert(result.Buffs, ActiveSkillBuff.New(BattleBuffType.HealDisable, self.Params[4]))
    end

    return result
end

Skill_111807.__init = __init
Skill_111807.OnUseActiveSkill = OnUseActiveSkill

return Skill_111807