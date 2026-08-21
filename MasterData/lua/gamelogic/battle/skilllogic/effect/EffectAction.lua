


local EffectBase = require "GameLogic.Battle.SkillLogic.Effect.EffectBase"
local EffectAction = BaseClass("EffectAction", EffectBase)

local function Run(self, skill, targetUnit, activeSkillResult)
    self.BattleComponent.HighReadyQueue:enqueue(targetUnit)
end

EffectAction.Run = Run

return EffectAction