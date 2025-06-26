
local ConditionManager = BaseClass("ConditionManager", Singleton)

local function Check(conditionId, skill)
    local z_Condition = Z_BattleCondition[conditionId]
    
    local z_Trigger = Z_BattleTrigger[triggerId]
    if z_Trigger == nil then
        Logger.LogError("TriggerManager:GenerateTrigger: z_Trigger is nil, triggerId = "..triggerId)
        return nil
    end
    local triggerCls = require("GameLogic.Battle.SkillLogic.Trigger." .. TriggerTypeScript[z_Trigger.Type])
    if triggerCls == nil then
        Logger.LogError("TriggerManager:GenerateTrigger: triggerCls is nil, trigger type = "..z_Trigger.Type)
        return nil
    end
    local trigger = triggerCls.New(triggerId, skill)
    return trigger
end

local function GenerateCondition(conditionId, skill)
    local z_Condition = Z_BattleCondition[conditionId]
    if z_Condition == nil then
        Logger.LogError("ConditionManager:GenerateCondition: z_Condition is nil, conditionId = "..conditionId)
        return nil
    end
    local conditionCls = require("GameLogic.Battle.SkillLogic.Condition." .. BattleConditionTypeScript[z_Condition.Type])
    if conditionCls == nil then
        Logger.LogError("ConditionManager:GenerateCondition: conditionCls is nil, condition type = "..z_Condition.Type)
        return nil
    end
    local condition = conditionCls.New(conditionId, skill)
    return condition
end

ConditionManager.Check = Check
ConditionManager.GenerateCondition = GenerateCondition

return ConditionManager
