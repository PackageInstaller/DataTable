---
--- 攻击目标大于${Params[1]}名时，提升${Params[2]}%的攻击力
---

local Equip_14090304 = BaseClass("Equip_14090304", Skill)
local base = Skill

local function __init(self)
end

local function BeforeSkillEffect(self, targetUnit)
    base.BeforeSkillEffect(self, targetUnit)

    if table.count(self.__bc.CurActSkill.TargetUnits) > self.Params[1] then
        self.__subc:IncTempNumeric(NumericType.AtkPct, self.Params[2])
    end
end

Equip_14090304.__init = __init
Equip_14090304.BeforeSkillEffect = BeforeSkillEffect

return Equip_14090304