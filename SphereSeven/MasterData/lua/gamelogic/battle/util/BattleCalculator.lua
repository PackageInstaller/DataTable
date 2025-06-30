
local BattleCalculator = {}

local function GetBaseScale(activeSkillResult, sourceUnit, targetUnit)
    -- local sourceNumericComponet = sourceUnit:GetComponent("NumericComponent")
    local targetNumericComponet = targetUnit:GetComponent("NumericComponent")

    if activeSkillResult.FeixiaoDamage.Type == nil then 
        return
    end
    local def = 0
    local ignoreDef = 0
    if activeSkillResult.FeixiaoDamage.Type == BattleDamageType.Physical then
        Logger.BattleLog("无视的防御系数: " .. activeSkillResult.ExtraIgnoreDef)
        def = targetNumericComponet:Get(NumericType.Def) * (1 + activeSkillResult.ExtraDefPct / 100) * math.max(1 - activeSkillResult.ExtraIgnoreDef / 100, 0)
        Logger.BattleLog("最终物防: " .. def)
    elseif activeSkillResult.FeixiaoDamage.Type == BattleDamageType.Magic then
        Logger.BattleLog("无视的防御系数: " .. activeSkillResult.ExtraIgnoreMagicDef)
        def = targetNumericComponet:Get(NumericType.MagicDef) * (1 + activeSkillResult.ExtraMagicDefPct / 100) * math.max(1 - activeSkillResult.ExtraIgnoreMagicDef / 100, 0)
        Logger.BattleLog("最终魔防: " .. def)
    end

    if activeSkillResult.FeixiaoDamage.Type ~= BattleDamageType.Real then
        activeSkillResult.BaseScale = 300 / ( 300 + def)
        Logger.BattleLog("防御系数: " .. activeSkillResult.BaseScale)
    else
        Logger.BattleLog("真实伤害无视防御")
        activeSkillResult.BaseScale = 1
    end
end

local function GetElementalCounter(activeSkillResult, sourceUnit, targetUnit)
    local sourceUnitElement = sourceUnit:GetComponent("BattleUnitComponent").Element
    local targetUnitElement = targetUnit:GetComponent("BattleUnitComponent").Element

    local elementalScale = 0
    local Z_BattleElementalCounter = Z_BattleElementalCounter[sourceUnitElement]
    if Z_BattleElementalCounter == nil then return end
    for i = 1, #Z_BattleElementalCounter.CounterType do
        if Z_BattleElementalCounter.CounterType[i] == targetUnitElement then
            elementalScale = Z_BattleElementalCounter.CounterValue[i]
            break
        end
    end
    activeSkillResult.ElementalScale = 1 + elementalScale / 100
    Logger.BattleLog("属性克制系数: " .. elementalScale)
end

local function ExtraDamage(activeSkillResult, sourceUnit, targetUnit)

end

local function GetFinalDamageScale(activeSkillResult, sourceUnit, targetUnit)
    local sourceNumericComponet = sourceUnit:GetComponent("NumericComponent")
    local sourceBattleComponent = sourceUnit:GetComponent("SsUnitBattleComponent")

    local targetNumericComponet = targetUnit:GetComponent("NumericComponent")

    local finalDamageScale = sourceNumericComponet:Get(NumericType.FinalDamage)/100 - 1
    local finalHurtScale = targetNumericComponet:Get(NumericType.FinalHurt)/100 - 1
    if sourceBattleComponent:CurActSkillIsGeneralAtk() then
        local d = sourceNumericComponet:Get(NumericType.GAtkFinalDamage)/100 - 1 
        local h = targetNumericComponet:Get(NumericType.GAtkFinalHurt)/100 - 1
        finalDamageScale = finalDamageScale + d
        finalHurtScale = finalHurtScale + h
    else
        local d = sourceNumericComponet:Get(NumericType.SkillFinalDamage)/100 - 1
        local h = targetNumericComponet:Get(NumericType.SkillFinalHurt)/100 - 1
        finalDamageScale = finalDamageScale + d
        finalHurtScale = finalHurtScale + h
    end
    if sourceBattleComponent.IsCac then
        local d = sourceNumericComponet:Get(NumericType.CacFinalDamage)/100 - 1
        local h = targetNumericComponet:Get(NumericType.CacFinalHurt)/100 - 1
        finalDamageScale = finalDamageScale + d
        finalHurtScale = finalHurtScale + h
    end
    if activeSkillResult.IsCri then
        local d = sourceNumericComponet:Get(NumericType.CriFinalDamage)/100 - 1 
        local h = targetNumericComponet:Get(NumericType.CriFinalHurt)/100 - 1
        finalDamageScale = finalDamageScale + d
        finalHurtScale = finalHurtScale + h
    end

    activeSkillResult.FinalDamageScale = math.max(0, 1 + finalDamageScale - finalHurtScale + activeSkillResult.ExtraFinalDamagePct / 100)
    Logger.BattleLog("最终伤害系数: " .. activeSkillResult.FinalDamageScale)
end

local function CalcDamage(activeSkillResult, sourceUnit, targetUnit)
    local atkOutput = activeSkillResult.FeixiaoDamage.Value + activeSkillResult.ExtraDamage / activeSkillResult.MultistageNum
    local baseScale = activeSkillResult.BaseScale
    local HitScale = activeSkillResult.HitScale
    local elementalScale = activeSkillResult.ElementalScale
    local criScale = activeSkillResult.CriScale
    local finalScale = activeSkillResult.FinalDamageScale
    local fluctuationScale = BattleUtil.GetRandomFloat(95, 105) / 100
    local ultimateScale = activeSkillResult.UltimateScale

    -- 伤害输出*(300/(300+被攻击方对应防御))*[最终伤害系数]*[命中参数]*[暴击参数]*[属性克制参数]*[伤害波动参数]
    activeSkillResult.FinalDamage = atkOutput * baseScale * finalScale * HitScale * criScale * elementalScale * fluctuationScale * ultimateScale
    activeSkillResult.TotalDamage = activeSkillResult.FinalDamage * activeSkillResult.MultistageNum

    local calcStr = string.format("最终伤害计算: 伤害输出系数[%f] * 防御倍率[%f] * [%f] * 命中参数[%f] * 暴击参数[%f] * 属性克制参数[%f] * 伤害波动参数[%f]", 
                                    atkOutput * activeSkillResult.MultistageNum, baseScale,finalScale, HitScale, criScale, elementalScale, fluctuationScale, ultimateScale)
    Logger.BattleLog(calcStr)
    Logger.BattleLog("最终伤害: " .. activeSkillResult.TotalDamage)

    activeSkillResult.FinalDamage = math.max(0, math.modf(activeSkillResult.FinalDamage))
end

local function CalcHealHp(activeSkillResult, sourceUnit, targetUnit)
    local sourceNumericComponet = sourceUnit:GetComponent("NumericComponent")
    local targetNumericComponet = targetUnit:GetComponent("NumericComponent")

    local healScale = sourceNumericComponet:Get(NumericType.HealEffect) / 100
    local healRecScale = targetNumericComponet:Get(NumericType.HealRecEffect) / 100
    local finalHealHp = math.modf(activeSkillResult.HealHp * healScale * healRecScale)
    if finalHealHp < 0 then finalHealHp = 0 end
    activeSkillResult.HealHp = finalHealHp
end

BattleCalculator.GetBaseScale = GetBaseScale
BattleCalculator.GetElementalCounter = GetElementalCounter
BattleCalculator.ExtraDamage = ExtraDamage
BattleCalculator.GetFinalDamageScale = GetFinalDamageScale
BattleCalculator.CalcDamage = CalcDamage

BattleCalculator.CalcHealHp = CalcHealHp

return BattleCalculator