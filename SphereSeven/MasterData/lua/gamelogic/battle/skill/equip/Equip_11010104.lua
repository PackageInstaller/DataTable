---
--- 攻击后，恢复实际伤害量${Params[1]}%的生命值
---
local Equip_11010104 = BaseClass("Equip_11010104", Skill)
local base = Skill

local function __init(self)
end

local function OnAtkEnd(self)
    base.OnAtkEnd(self)

    local totalHpDamage = 0
    for _, activeSkillResult in pairs(self.__bc.CurActSkill.UnitResults) do
        if activeSkillResult.TotalRealHpDamage > 0 then
            totalHpDamage = totalHpDamage + activeSkillResult.TotalRealHpDamage
        end
    end

    self.__subc:HealHp(totalHpDamage * self.Params[1] / 100)

end

Equip_11010104.__init = __init
Equip_11010104.OnAtkEnd = OnAtkEnd

return Equip_11010104