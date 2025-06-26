


local EffectBase = require "GameLogic.Battle.SkillLogic.Effect.EffectBase"
local EffectDamageAttrDiff = BaseClass("EffectDamageAttrDiff", EffectBase)

local function Run(self, skill, targetUnit, result)
    local damageType = self.Params[1]
    local atk = skill.__snc:Get(NumericType.Atk)

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

    local attrType = self.Params[2]
    local attr1 = skill.__snc:Get(attrType)
    local attr2 = targetUnit:GetComponent("NumericComponent"):Get(attrType)
    local diffRate = (attr1 - attr2)/attr2
    local maxDiffRate = self.Params[3] / 100
    diffRate = Mathf.Clamp(diffRate, 0, maxDiffRate)
    local extraDamageRate = skill.Params[self.SkillParamIndices[2]] * diffRate/maxDiffRate
    local damageRate = (skill.Params[self.SkillParamIndices[1]] + extraDamageRate) / 100
    local damageNum = atk * damageRate / skill.MultistageNum
    local str = string.format("属性差 属性:%s 攻方值:%s 受方值:%s 上限差值比:%s 有效差值比:%s 额外伤害系数:%s",
        attrType, attr1, attr2, maxDiffRate, diffRate, extraDamageRate)
    Logger.BattleLog(str)
    Logger.BattleLog("攻击力:" .. atk .. " 伤害系数:" .. damageRate)

    Logger.BattleLog("分段:" .. skill.MultistageNum)
    Logger.BattleLog("输出值: " .. damageNum * skill.MultistageNum)
    result.FeixiaoDamage = {
        Type = damageType,
        Value = damageNum
    }
end

EffectDamageAttrDiff.Run = Run

return EffectDamageAttrDiff