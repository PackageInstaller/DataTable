


local EffectBase = require "GameLogic.Battle.SkillLogic.Effect.EffectBase"
local EffectCriDamage = BaseClass("EffectCriDamage", EffectBase)

local function Run(self, skill, targetUnit, activeSkillResult)
    activeSkillResult.ExtraCriDamage = activeSkillResult.ExtraCriDamage + skill.Params[self.SkillParamIndices[1]]
end

EffectCriDamage.Run = Run

return EffectCriDamage