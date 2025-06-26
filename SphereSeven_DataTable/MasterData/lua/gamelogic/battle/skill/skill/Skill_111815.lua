---
--- 黑龙爆炎
--- 对全体敌人造成&{Params[1]}%法术伤害，&{Params[2]}%的概率解除所有强化效果。当攻击前自身的异常状态数量不多于&{Params[3]}个时，获得&{Params[4]}%额外倍率，技能冷却时间减少&{Params[5]}回合，&{Params[6]}%的概率造成&{Params[7]}回合的【回复禁止】。
---

local Skill_111815 = BaseClass("Skill_111815", Skill)
local base = Skill

local function __init(self)
    self.ReduceCoolDown = 0
end

local function OnUseActiveSkill(self, targetUnit)
    base.OnUseActiveSkill(self, targetUnit)

    local result = ActiveSkillResult.New()
    local damageScale = self.Params[1] / 100

    if self.__sbc:BuffTypeCount(true) <= self.Params[3] then
        damageScale = damageScale + self.Params[4] / 100
        self.ReduceCoolDown = self.Params[5]
        if BattleUtil.IsPctProbHit(self.Params[6]) then
            table.insert(result.Buffs, ActiveSkillBuff.New(BattleBuffType.HealDisable, self.Params[7]))
        end
    end

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

    return result
end

local function OnActEnd(self)
    base.OnActEnd(self)

    if not self.__bc.CurActSkill == self then
        return
    end

    self:ReduceCoolDownTurn(self.ReduceCoolDown)
    self.ReduceCoolDown = 0
end

Skill_111815.__init = __init
Skill_111815.OnUseActiveSkill = OnUseActiveSkill
Skill_111815.OnActEnd = OnActEnd

return Skill_111815