


local EffectBase = require "GameLogic.Battle.SkillLogic.Effect.EffectBase"
local EffectAddBuff = BaseClass("EffectActValue", EffectBase)

local function Run(self, skill, targetUnit, result)
    local buffId = self.Config.Params[1]
    local turnCount = skill.Params[self.SkillParamIndices[1]]
    Logger.BattleLog("添加buff: " .. buffId .. " 回合 " .. turnCount)
    table.insert(result.Buffs, ActiveSkillBuff.New(buffId, turnCount))
end

EffectAddBuff.Run = Run

return EffectAddBuff