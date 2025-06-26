---
--- 使用攻击技能施加异常状态时，效果命中提高${Params[1]}%。
---

local Equip_12050104 = BaseClass("Equip_12050104", Skill)
local base = Skill

local function __init(self)
end

local function BeforeSkillEffect(self, targetUnit)
    base.BeforeSkillEffect(self, targetUnit)

    self.__subc:IncTempNumeric(NumericType.EAccAdd, self.Params[1])
end

Equip_12050104.__init = __init
Equip_12050104.BeforeSkillEffect = BeforeSkillEffect

return Equip_12050104