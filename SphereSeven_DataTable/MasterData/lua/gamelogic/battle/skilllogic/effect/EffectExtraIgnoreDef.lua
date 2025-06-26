


local EffectBase = require "GameLogic.Battle.SkillLogic.Effect.EffectBase"
local EffectExtraIgnoreDef = BaseClass("EffectExtraIgnoreDef", EffectBase)

local function Run(self, skill, targetUnit, activeSkillResult)
    local type = self.Params[1]
    local ignoreDef = 0 
    if type == BattleEffectIgnoreDefType.IgnoreValue then
        ignoreDef = skill.Params[self.SkillParamIndices[1]]
    elseif type == BattleEffectIgnoreDefType.HpLose then
        ignoreDef = (1 - BattleUtil.GetHpPct(targetUnit)) * skill.Params[self.SkillParamIndices[1]]
    end

    local defType = self.Params[2]
    if defType == BattleFeffectDefType.Def then
        activeSkillResult.ExtraIgnoreDef = activeSkillResult.ExtraIgnoreDef + ignoreDef
    elseif defType == BattleFeffectDefType.MagicDef then
        activeSkillResult.ExtraIgnoreMagicDef = activeSkillResult.ExtraIgnoreMagicDef + ignoreDef
    elseif defType == BattleFeffectDefType.Both then
        activeSkillResult.ExtraIgnoreDef = activeSkillResult.ExtraIgnoreDef + ignoreDef
        activeSkillResult.ExtraIgnoreMagicDef = activeSkillResult.ExtraIgnoreMagicDef + ignoreDef
    end
end

EffectExtraIgnoreDef.Run = Run

return EffectExtraIgnoreDef