


local EffectBase = require "GameLogic.Battle.SkillLogic.Effect.EffectBase"
local EffectRevive = BaseClass("EffectRevive", EffectBase)

local function Run(self, skill, targetUnit, activeSkillResult)
    activeSkillResult.IsRevive = true
    local value = skill.Params[self.SkillParamIndices[1]]
    local hp = value / 100 * skill.__snc:Get(self.Config.Params[1])
    activeSkillResult.HealHp = hp
    Logger.BattleLog("复活效果: " .. hp)
end

EffectRevive.Run = Run

return EffectRevive