---
--- 闪电吐息
--- 对全体敌人造成&{Params[1]}%法术伤害，攻击后赋予自身&{Params[2]}回合的【攻击力提升】，【物防提升】。当攻击前自身强化状态不小于&{Params[3]}个时，额外解除&{Params[4]}个异常状态。
---

local Skill_113703 = BaseClass("Skill_113703", Skill)
local base = Skill

Skill_113703.SkillLightningBreath = true

local function __init(self)
    self.Data.UseTimes = 0
end

local function OnAtkStart(self)
    base.OnAtkStart(self)

    if self.__bc.CurActSkill ~= self then
        return
    end
    
    if self.__sbc:BuffTypeCount(false) >= self.Params[3] then
        local buffs = self.__sbc:RandomGetBuff(true, self.Params[4])
        for _, buff in pairs(buffs) do
            self.__sbc:RemoveOneBuff(buff)
        end
    end
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

    return result
end

local function OnAtkEnd(self)
    base.OnAtkEnd(self)

    if self.__bc.CurActSkill ~= self then
        return
    end

    self.__sbc:CreateBuff(BattleBuffType.AtkIncrease, nil, self.SrcUnit, self.SrcUnit, self.Params[2])
    self.__sbc:CreateBuff(BattleBuffType.DefIncrease, nil, self.SrcUnit, self.SrcUnit, self.Params[2])
end

Skill_113703.__init = __init
Skill_113703.OnAtkStart = OnAtkStart
Skill_113703.OnUseActiveSkill = OnUseActiveSkill
Skill_113703.OnAtkEnd = OnAtkEnd

return Skill_113703