---
--- 攻击时，如果目标持有异常状态，暴击率提升${Params[1]}%
---

local Equip_14080004 = BaseClass("Equip_14080004", Skill)
local base = Skill

local function __init(self)
end

local function BeforeSkillEffect(self, targetUnit)
    base.BeforeSkillEffect(self, targetUnit)

    if targetUnit:GetComponent("BuffComponent"):HasDeBuff() then
        self.__subc:IncTempNumeric(NumericType.CriAdd, self.Params[1])
    end
end

Equip_14080004.__init = __init
Equip_14080004.BeforeSkillEffect = BeforeSkillEffect

return Equip_14080004