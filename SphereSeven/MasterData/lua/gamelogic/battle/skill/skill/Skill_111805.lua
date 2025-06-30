---
--- 炎爪
--- 对血量最高的前排敌人造成&{Params[1]}%物理伤害，解除自身一个异常状态。当并非在战斗中第一次使用，且攻击前自身不处于异常状态时，击退目标&{Params[2]}%的行动值。
---

local Skill_111805 = BaseClass("Skill_111805", Skill)
local base = Skill

local function __init(self)
    self.Data.UseTimes = 0
end

local function OnAtkStart(self)
    base.OnAtkStart(self)

    if self.__bc.CurActSkill ~= self then
        return
    end

    self.Data.UseTimes = self.Data.UseTimes + 1
    self.__sbc:RandomRemoveOneBuff(false)
end

local function OnUseActiveSkill(self, targetUnit)
    base.OnUseActiveSkill(self, targetUnit)


    local result = ActiveSkillResult.New()
    local damageScale = self.Params[1] / 100

    local atk = self.__snc:Get(NumericType.Atk)
    local damageNum = atk * damageScale / self.MultistageNum
    result.FeixiaoDamage = {
        Type = BattleDamageType.Physical,
        Value = damageNum
    }

    if self.Data.UseTimes ~= 1 and not self.__sbc:HasDeBuff() then
        result.ActChange = result.ActChange - self.Params[2]
    end

    return result
end

Skill_111805.__init = __init
Skill_111805.OnAtkStart = OnAtkStart
Skill_111805.OnUseActiveSkill = OnUseActiveSkill

return Skill_111805