---
--- 攻击时，目标身上每有一个异常状态，最终伤害提升${Params[1]}%。
---

local Equip_12050104 = BaseClass("Equip_12050104", Skill)
local base = Skill

local function __init(self)
end

local function BeforeHit(self, activeSkillResult, targetUnit)
    base.BeforeHit(self, activeSkillResult, targetUnit)

    local debuffCount = targetUnit:GetComponent("BuffComponent"):BuffTypeCount(true)
    activeSkillResult.ExtraFinalDamagePct = activeSkillResult.ExtraFinalDamagePct + debuffCount * self.Params[1]
end

Equip_12050104.__init = __init
Equip_12050104.BeforeHit = BeforeHit

return Equip_12050104