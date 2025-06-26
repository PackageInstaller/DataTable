---
--- 攻击时，若目标生命值低于${Params[1]}%，则最终伤害提高${Params[2]}%。
---
local Equip_11030004 = BaseClass("Equip_11030004", Skill)
local base = Skill

local function __init(self)
end

local function BeforeHit(self, activeSkillResult, targetUnit)
    base.BeforeHit(self, activeSkillResult)

    local hpPercent = BattleUtil.GetHpPct(targetUnit)

    if hpPercent * 100 <= self.Params[1] then
        activeSkillResult.ExtraFinalDamagePct = activeSkillResult.ExtraFinalDamagePct + self.Params[2]
    end
end

Equip_11030004.__init = __init
Equip_11030004.BeforeHit = BeforeHit

return Equip_11030004