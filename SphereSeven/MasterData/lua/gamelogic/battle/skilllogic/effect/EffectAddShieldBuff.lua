


local EffectBase = require "GameLogic.Battle.SkillLogic.Effect.EffectBase"
local EffectAddBuff = BaseClass("EffectActValue", EffectBase)

local function Run(self, skill, targetUnit, result)
    local buffId = self.Config.Params[1]
    local turnCount = skill.Params[self.SkillParamIndices[1]]
    local value = 0
    for i = 2, #self.Params do
        local scale = skill.Params[self.SkillParamIndices[i]] / 100
        local attr = skill.__snc:Get(self.Params[i])
        value = value + attr * scale
        Logger.BattleLog("护盾属性类型:" .. self.Params[i] .. "系数: " .. scale)
    end
    Logger.BattleLog("添加护盾buff: " .. buffId .. " 回合 " .. turnCount .. " 值: " .. value)
    local data = {ShieldValue = value}
    table.insert(result.Buffs, ActiveSkillBuff.New(buffId, turnCount, nil, nil, nil, nil, data))
end

EffectAddBuff.Run = Run

return EffectAddBuff