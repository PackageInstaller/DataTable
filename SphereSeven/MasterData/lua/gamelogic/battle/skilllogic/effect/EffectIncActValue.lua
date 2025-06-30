


local EffectBase = require "GameLogic.Battle.SkillLogic.Effect.EffectBase"
local EffectIncActValue = BaseClass("EffectIncActValue", EffectBase)

local function Run(self, skill, targetUnit, activeSkillResult)
    local value = skill.Params[self.SkillParamIndices[1]]
    activeSkillResult.ActChange = value
end

EffectIncActValue.Run = Run

return EffectIncActValue