---
--- 攻击时，若目标当前生命值高于${Params[1]}%，则最终伤害提高Params[2]%
---

local Equip_11040004 = BaseClass("Equip_11040004", Skill)
local base = Skill

local function __init(self)
end

local function BeforeHit(self, activeSkillResult, targetUnit)
    base.BeforeHit(self, activeSkillResult, targetUnit)

    if BattleUtil.GetHpPct(targetUnit) < self.Params[1] then
        activeSkillResult.ExtraFinalDamagePct = activeSkillResult.ExtraFinalDamagePct + self.Params[2]
    end
end


Equip_11040004.__init = __init
Equip_11040004.BeforeHit = BeforeHit

return Equip_11040004