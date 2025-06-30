---
--- 攻击目标大于1名时，使该次攻击的最终伤害提高${Params[1]}%
---

local Equip_11050104 = BaseClass("Equip_11050104", Skill)
local base = Skill

local function __init(self)
end

local function BeforeHit(self, activeSkillResult, targetUnit)
    base.BeforeHit(self, activeSkillResult, targetUnit)

    if table.count(self.__bc.CurActSkill.TargetUnits) > 1 then
        activeSkillResult.ExtraFinalDamagePct = activeSkillResult.ExtraFinalDamagePct + self.Params[1]
    end
end

Equip_11050104.__init = __init
Equip_11050104.BeforeHit = BeforeHit

return Equip_11050104