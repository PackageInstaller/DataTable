
local EffectManager = BaseClass("EffectManager", Singleton)

local function GenerateEffect(self, effectId, skill)
    local z_Effect = Z_BattleSkillEffect[effectId]
    if z_Effect == nil then
        Logger.LogError("EffectManager:GenerateEffect: z_Effect is nil, [Z_BattleSkillEffect] effectId = "..effectId)
        return nil
    end
    if z_Effect.Type == 0 then
        Logger.LogError("EffectManager:GenerateEffect: z_Effect.Type is 0, [Z_BattleSkillEffect] effectId = "..effectId)
        return nil
    end

    local effectCls = require("GameLogic.Battle.SkillLogic.Effect." .. BattleEffectTypeScript[z_Effect.Type])
    if effectCls == nil then
        Logger.LogError("EffectManager:GenerateEffect: effectCls is nil, [BattleEffectTypeScript] effect type = "..z_Effect.Type)
        return nil
    end

    local effect = effectCls.New(effectId, skill)
    return effect
end

EffectManager.GenerateEffect = GenerateEffect

return EffectManager
