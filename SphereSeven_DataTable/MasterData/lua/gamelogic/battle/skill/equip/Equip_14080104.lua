---
--- 如果本场战斗中未受到过伤害，攻击时最终伤害提高${Params[1]}%。
---

local Equip_14080104 = BaseClass("Equip_14080104", Skill)
local base = Skill

local function __init(self)
    self.Enable = false
end

local function OnBattleStart(self)
    base.OnBattleStart(self)

    self.Enable = true
end

local function BeforeHit(self, activeSkillResult, targetUnit)
    base.BeforeHit(self, activeSkillResult, targetUnit)

    if self.Enable then
        activeSkillResult.ExtraFinalDamagePct = activeSkillResult.ExtraFinalDamagePct + self.Params[1]
    end
end

local function AfterAllHurt(self, atkUnit, activeSkillResult)
    base.AfterAllHurt(self, atkUnit, activeSkillResult)

    if activeSkillResult.TotalRealHpDamage > 0 then
        self.Enable = false
    end
end

Equip_14080104.__init = __init
Equip_14080104.OnBattleStart = OnBattleStart
Equip_14080104.BeforeHit = BeforeHit
Equip_14080104.AfterAllHurt = AfterAllHurt

return Equip_14080104