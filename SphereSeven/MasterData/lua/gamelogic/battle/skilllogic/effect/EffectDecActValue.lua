


local EffectBase = require "GameLogic.Battle.SkillLogic.Effect.EffectBase"
local EffectDecActValue = BaseClass("EffectDecActValue", EffectBase)

local function Run(self, skill, targetUnit, activeSkillResult)
    local value = skill.Params[self.SkillParamIndices[1]]
    activeSkillResult.ActChange = -value
end

EffectDecActValue.Run = Run

return EffectDecActValue