---
--- 攻击时，忽视目标${Params[1]}%的魔防
---

local Equip_12050004 = BaseClass("Equip_12050004", Skill)
local base = Skill

local function __init(self)
end

local function BeforeHit(self, activeSkillResult, targetUnit)
    base.BeforeHit(self, activeSkillResult, targetUnit)

    activeSkillResult.ExtraIgnoreMagicDef = activeSkillResult.ExtraIgnoreMagicDef + self.Params[1]
end

Equip_12050004.__init = __init
Equip_12050004.BeforeHit = BeforeHit

return Equip_12050004