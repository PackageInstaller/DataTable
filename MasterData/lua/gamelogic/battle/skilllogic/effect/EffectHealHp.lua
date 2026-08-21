


local EffectBase = require "GameLogic.Battle.SkillLogic.Effect.EffectBase"
local EffectDispel = BaseClass("EffectDispel", EffectBase)

local function Run(self, skill, targetUnit, activeSkillResult)
    local value = skill.Params[self.SkillParamIndices[1]]
    local hp = value / 100 * skill.__snc:Get(self.Config.Params[1])
    Logger.BattleLog("治疗效果: " .. hp)
    activeSkillResult.HealHp = hp
end

EffectDispel.Run = Run

return EffectDispel