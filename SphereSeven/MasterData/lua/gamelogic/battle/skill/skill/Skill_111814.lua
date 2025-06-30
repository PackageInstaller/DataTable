---
--- 焚烧
--- 对全体敌人造成&{Params[1]}%法术伤害，&{Params[2]}%概率造成&{Params[3]}回合的【灼烧】。当攻击前自身的异常状态数量不多于&{Params[4]}个时，获得&{Params[5]}%%额外倍率，造成【灼烧】的概率变成&{Params[6]}%，,使自身所有技能冷却时间-&{Params[7]}%。
---

local Skill_111814 = BaseClass("Skill_111814", Skill)
local base = Skill

local function __init(self)
    self.ReduceCoolDown = 0
end

local function OnUseActiveSkill(self, targetUnit)
    base.OnUseActiveSkill(self, targetUnit)

    local result = ActiveSkillResult.New()
    local damageScale = self.Params[1] / 100
    
    local prob = self.Params[2]
    if self.__sbc:BuffTypeCount(true) <= self.Params[4] then
        prob = self.Params[6]
        damageScale = damageScale + self.Params[5] / 100
        self.ReduceCoolDown = self.Params[7]
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

local function OnActEnd(self)
    base.OnActEnd(self)

    if not self.__bc.CurActSkill == self then
        return
    end

    for id, skill in pairs(self.SrcUnit:GetComponent("SkillComponent").ActiveSkills) do
        skill:ReduceCoolDownTurn(self.ReduceCoolDown)
    end

    self.ReduceCoolDown = 0
end

Skill_111814.__init = __init
Skill_111814.OnUseActiveSkill = OnUseActiveSkill
Skill_111814.OnActEnd = OnActEnd

return Skill_111814