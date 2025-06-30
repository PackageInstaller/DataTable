---
--- 对持有异常状态的目标，效果命中提升${Params[1]}%
---

local Equip_14080204 = BaseClass("Equip_14080204", Skill)
local base = Skill

local function __init(self)
end

local function BeforeSkillEffect(self, targetUnit)
    base.BeforeSkillEffect(self, targetUnit)

    if targetUnit:GetComponent("BuffComponent"):HasDeBuff() then
        self.__subc:IncTempNumeric(NumericType.EAccAdd, self.Params[1])
    end
end

Equip_14080204.__init = __init
Equip_14080204.BeforeSkillEffect = BeforeSkillEffect

return Equip_14080204