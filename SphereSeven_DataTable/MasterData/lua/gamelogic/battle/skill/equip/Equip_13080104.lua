---
--- 受击后，提升${Params[1]}%的速攻值
---

local Equip_13080104 = BaseClass("Equip_13080104", Skill)
local base = Skill

local function __init(self)
end

local function AfterHurt(self, activeSkillResult, atkUnit)
    base.AfterHurt(self, activeSkillResult, atkUnit)

    activeSkillResult.ActChange = activeSkillResult.ActChange + self.Params[1]
end


Equip_13080104.__init = __init
Equip_13080104.AfterHurt = AfterHurt

return Equip_13080104