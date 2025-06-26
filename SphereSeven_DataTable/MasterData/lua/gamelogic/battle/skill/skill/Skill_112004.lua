---
--- 穿刺攻击
--- 自身造成伤害时，附加自身${Params[1]}%攻击力的额外伤害。

local Skill_112004 = BaseClass("Skill_112004", Skill)
local base = Skill

local function __init(self)

end

local function BeforeHit(self, activeSkillResult, targetUnit)
    base.BeforeHit(self, activeSkillResult, targetUnit)

    if self.IsDisabled then
        return
    end

    activeSkillResult.ExtraDamage = activeSkillResult.ExtraDamage + self.__snc:Get(NumericType.Atk) * self.Params[1] / 100
end

Skill_112004.__init = __init
Skill_112004.BeforeHit = BeforeHit

return Skill_112004