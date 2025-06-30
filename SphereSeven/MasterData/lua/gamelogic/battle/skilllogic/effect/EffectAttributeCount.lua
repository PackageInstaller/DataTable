


local EffectBase = require "GameLogic.Battle.SkillLogic.Effect.EffectBase"
local EffectAttributeCount = BaseClass("EffectAttributeCount", EffectBase)

local function __init(self)
    self.MaxCount = 10
    self.Count = 0
end

local function Run(self, skill, targetUnit, activeSkillResult)
    if Count >= self.MaxCount then
        return
    end

    local numericComponent = targetUnit:GetComponent("NumericComponent")
    local type = self.Params[1]
    local value = self.Params[2]
    numericComponent:Inc(type, value)
    
    self.Count = self.Count + 1
end

EffectAttributeCount.Run = Run

return EffectAttributeCount