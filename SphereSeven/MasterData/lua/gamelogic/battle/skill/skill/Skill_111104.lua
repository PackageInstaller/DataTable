---
--- 深渊奴仆
--- 攻击速度低于自身的目标时，最终伤害+5%(Params[1])

local Skill_111104 = BaseClass("Skill_111104",Skill)
local base = Skill

local function __init(self)

end

local function BeforeSkillEffect(self, targetUnit)
    base.BeforeSkillEffect(self, targetUnit)

    if self.IsDisabled then
        return
    end
    if self.__snc:Get(NumericType.Speed) < targetUnit:GetComponent("NumericComponent"):Get(NumericType.Speed) then
        self.__subc:IncTempNumeric(NumericType.FinalDamageAdd, self.Params[1])
    end
end

Skill_111104.__init = __init
Skill_111104.BeforeSkillEffect = BeforeSkillEffect

return Skill_111104