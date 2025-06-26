


local EffectBase = require "GameLogic.Battle.SkillLogic.Effect.EffectBase"
local EffectCritical = BaseClass("EffectCritical", EffectBase)

local function Run(self, skill, targetUnit)

end

EffectCritical.Run = Run

return EffectCritical