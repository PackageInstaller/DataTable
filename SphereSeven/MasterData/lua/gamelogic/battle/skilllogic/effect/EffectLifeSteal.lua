


local EffectBase = require "GameLogic.Battle.SkillLogic.Effect.EffectBase"
local EffectLifeSteal = BaseClass("EffectLifeSteal", EffectBase)

local function Run(self, skill, targetUnit, result)
    result.FeixiaoLifeSteal.Value = result.FeixiaoLifeSteal.Value + skill.Params[self.SkillParamIndices[1]] / 100
    Logger.BattleLog("吸血配置 系数: " .. result.FeixiaoLifeSteal.Value)
end

EffectLifeSteal.Run = Run

return EffectLifeSteal