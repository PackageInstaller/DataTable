---
--- 单体攻击时，攻击力提高${Params[1]}%
---

local Equip_16080104 = BaseClass("Equip_16080104", Skill)
local base = Skill

local function __init(self)
end

local function BeforeSkillEffect(self, targetUnit)
    base.BeforeSkillEffect(self, targetUnit)

    local zSkill = self.__bc.CurActSkill.ZSkill
    if zSkill == nil or zSkill.EnemyRange ~= EnemyRange.Single then
        return
    end

    self.__subc:IncTempNumeric(NumericType.AtkPct, self.Params[1])
end

Equip_16080104.__init = __init
Equip_16080104.BeforeSkillEffect = BeforeSkillEffect

return Equip_16080104