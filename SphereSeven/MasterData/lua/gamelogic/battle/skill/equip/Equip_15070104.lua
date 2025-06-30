---
--- 受击时，如果来源速攻值大于自己${Params[1]}%以上，减少最终伤害${Params[2]}%，并提升自身速攻值${Params[3]}%
---

local Equip_15070104 = BaseClass("Equip_15070104", Skill)
local base = Skill

local function __init(self)
end

local function BeforeBeHit(self, activeSkillResult, atkUnit)
    base.BeforeBeHit(self, activeSkillResult, atkUnit)

    local diff = (1 - BATTLE_ACT_VALUE_MAX / self.SrcUnit:GetComponent("BattleUnitComponent").ActValue) * 100
    if diff > self.Params[1] then
        activeSkillResult.ExtraFinalDamagePct = activeSkillResult.ExtraFinalDamagePct - self.Params[2]
        activeSkillResult.ActChange = activeSkillResult.ActChange + self.Params[3]
    end
end

Equip_15070104.__init = __init
Equip_15070104.BeforeBeHit = BeforeBeHit

return Equip_15070104