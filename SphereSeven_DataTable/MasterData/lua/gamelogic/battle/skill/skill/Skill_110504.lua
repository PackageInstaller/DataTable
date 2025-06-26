---
--- 渴血
--- 造成伤害后获得10%(Params[1])伤害量的治疗

local Skill_110504 = BaseClass("Skill_110504",Skill)
local base = Skill

local function __init(self)

end

local function BeforeHit(self, activeSkillResult, targetUnit)
    base.BeforeHit(self, activeSkillResult)

    if self.IsDisabled then
        return
    end

    activeSkillResult.IsSuckHp = true
    activeSkillResult.SuckHpScale = self.Params[1] / 100
end

Skill_110504.__init = __init
Skill_110504.BeforeHit = BeforeHit

return Skill_110504