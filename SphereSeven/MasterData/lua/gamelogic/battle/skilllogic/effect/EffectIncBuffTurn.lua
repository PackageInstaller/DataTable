


local EffectBase = require "GameLogic.Battle.SkillLogic.Effect.EffectBase"
local EffectIncBuffTurn = BaseClass("EffectIncBuffTurn", EffectBase)

local function Run(self, skill, targetUnit, result)
    local turnCount = skill.Params[self.SkillParamIndices[1]]
    local isDebuff = false
    if self.Params[1] == 1 then
        isDebuff = false
    elseif self.Params[1] == 2 then
        isDebuff = true
    end
    targetUnit:GetComponent("BuffComponent"):IncAllBuffTurn(isDebuff, turnCount)
end

EffectIncBuffTurn.Run = Run

return EffectIncBuffTurn