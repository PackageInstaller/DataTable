


local EffectBase = require "GameLogic.Battle.SkillLogic.Effect.EffectBase"
local EffectDamage = BaseClass("EffectDamage", EffectBase)

local function Run(self, skill, targetUnit, result)
    local damageType = self.Params[1]
    local damageScale = skill.Params[self.SkillParamIndices[1]] / 100
    local atk = skill.__snc:Get(NumericType.Atk)
    local damageNum = atk * damageScale / skill.MultistageNum

    local outputStr = nil
    if damageType == BattleDamageType.Physical then
        outputStr = "物理输出"
    elseif damageType == BattleDamageType.Magic then
        outputStr = "魔法输出"
    elseif damageType == BattleDamageType.Real then
        outputStr = "真实输出"
    else
        Logger.LogError("未知的伤害类型:" .. damageType)
        return
    end
    Logger.BattleLog(outputStr)
    Logger.BattleLog("攻击力:" .. atk .. " 伤害系数:" .. damageScale)

    if self.SkillParamIndices[2] ~= nil
        and self.SkillParamIndices[2] ~= 0
        and self.Params[2] ~= nil
        and self.Params[2] ~= 0 then
        local attr = skill.__snc:Get(self.Params[2])
        local scale = skill.Params[self.SkillParamIndices[2]] / 100
        damageNum = damageNum + attr * scale / skill.MultistageNum
        Logger.BattleLog("额外属性攻击:" .. attr .. "," .. self.Params[2] .. " 伤害系数:" .. scale)
    end
    Logger.BattleLog("分段:" .. skill.MultistageNum)
    Logger.BattleLog("输出值: " .. damageNum * skill.MultistageNum)
    result.FeixiaoDamage = {
        Type = damageType,
        Value = damageNum
    }
end

EffectDamage.Run = Run

return EffectDamage