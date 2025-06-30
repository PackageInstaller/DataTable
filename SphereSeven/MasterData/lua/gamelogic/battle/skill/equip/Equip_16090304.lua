---
--- 单体攻击时，最终伤害提升${Params[1]}%
---

local Equip_16090304 = BaseClass("Equip_16090304", Skill)
local base = Skill

local function __init(self)
end

local function BeforeHit(self, activeSkillResult, targetUnit)
    base.BeforeHit(self, activeSkillResult, targetUnit)

    local zSkill = self.__bc.CurActSkill.ZSkill
    if zSkill == nil or zSkill.EnemyRange ~= EnemyRange.Single then
        return
    end

    activeSkillResult.ExtraFinalDamagePct = activeSkillResult.ExtraFinalDamagePct + self.Params[1]
end

Equip_16090304.__init = __init
Equip_16090304.BeforeHit = BeforeHit

return Equip_16090304