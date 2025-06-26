---
--- 嗜血
--- 造成伤害后获得20%(Params[1])伤害量的治疗

local Skill_110604 = BaseClass("Skill_110604",Skill)
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

Skill_110604.__init = __init
Skill_110604.BeforeHit = BeforeHit

return Skill_110604