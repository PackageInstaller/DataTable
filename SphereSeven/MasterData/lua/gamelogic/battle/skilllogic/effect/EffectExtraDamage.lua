


local EffectBase = require "GameLogic.Battle.SkillLogic.Effect.EffectBase"
local EffectExtraDamage = BaseClass("EffectExtraDamage", EffectBase)

local function Run(self, skill, targetUnit, result)
    local atk = skill.__snc:Get(NumericType.Atk)
    local type = self.Params[1]
    local damageScale = 0
    -- 根据配置值
    if type == 1 then
        damageScale = skill.Params[self.SkillParamIndices[1]] / 100
    -- 损失生命值
    elseif type == 2 then
        damageScale = (1 - BattleUtil.GetHpPct(skill.SrcUnit)) * skill.Params[self.SkillParamIndices[1]] / 100
    -- 目标行动条位置
    elseif type == 3 then
        local actValue = targetUnit:GetComponent("BattleUnitComponent").ActValue
        damageScale = (1 - actValue / BATTLE_ACT_VALUE_MAX) * skill.Params[self.SkillParamIndices[1]] / 100
    end
    local damageNum = atk * damageScale / skill.MultistageNum
    Logger.BattleLog("额外输出:" .. damageNum * skill.MultistageNum)
    result.FeixiaoDamage.Value = result.FeixiaoDamage.Value + damageNum
end

EffectExtraDamage.Run = Run

return EffectExtraDamage