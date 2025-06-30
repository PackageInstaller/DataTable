---
--- 攻击时，附带目标最大生命值${Params[1]}%的伤害。（可暴击）
---
local Equip_12040204 = BaseClass("Equip_12040204", Skill)
local base = Skill

local function __init(self)
end

local function BeforeHit(self, activeSkillResult, targetUnit)
    base.BeforeHit(self, activeSkillResult, targetUnit)

    activeSkillResult.ExtraDamage = activeSkillResult.ExtraDamage + targetUnit:GetComponent("NumericComponent"):Get(NumericType.MaxHp) * self.Params[1] / 100
end


Equip_12040204.__init = __init
Equip_12040204.BeforeHit = BeforeHit

return Equip_12040204