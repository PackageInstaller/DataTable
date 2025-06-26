


local EffectBase = require "GameLogic.Battle.SkillLogic.Effect.EffectBase"
local EffectDispel = BaseClass("EffectDispel", EffectBase)

local function Run(self, skill, targetUnit, activeSkillResult)
    Logger.BattleLog(skill.SkillId .. "造成驱散效果")
    activeSkillResult.FeixiaoDispel = 
    {
        Type = self.Params[1],
        Count = self.Params[2],
    }
end

EffectDispel.Run = Run

return EffectDispel