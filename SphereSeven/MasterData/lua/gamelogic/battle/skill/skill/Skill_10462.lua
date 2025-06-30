---
--- 对一条直线的敌人造成${Params[1]}%物理攻击力的伤害,有${Params[2]}%的概赋予目标${Params[3]}回合的【麻痹】。当自身处于强化状态时,概率翻倍
---

local Skill_10462 = BaseClass("Skill_10462",Skill)
local base = Skill

local function __init(self)

end

local function onParamsInited(self)
    base.onParamsInited(self)

    self.Data.DamageScale = self.Params[1] / 100
    self.Data.Probably = self.Params[2]
    self.Data.DebuffTurn = self.Params[3]
end

local function OnUseActiveSkill(self, targetUnit)
    local result = ActiveSkillResult.New()
    local atk = self.__snc:Get(NumericType.Atk)
    local damageNum = atk * self.Data.DamageScale / self.MultistageNum
    result.FeixiaoDamage = {
        Type = BattleDamageType.Physical,
        Value = damageNum
    }

    local probably = self.Data.Probably
    if self.__sbc:HasBuff() then
        probably = probably * 2
    end

    if BattleUtil.IsPctProbHit(probably) then
        table.insert(result.Buffs, ActiveSkillBuff.New(BattleBuffType.Paralysis, self.Data.DebuffTurn))
    end

    return result
end

Skill_10462.__init = __init
Skill_10462.onParamsInited = onParamsInited
Skill_10462.OnUseActiveSkill = OnUseActiveSkill

return Skill_10462