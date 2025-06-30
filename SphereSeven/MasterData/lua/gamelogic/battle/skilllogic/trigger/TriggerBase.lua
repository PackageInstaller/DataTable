local TriggerBase = BaseClass("TriggerBase")

local function __init(self, triggerId, skill)
    self.Config = Z_BattleTrigger[triggerId]
    self.ConditionList = {}
    for _, conditionId in ipairs(self.Config.ConditionIds) do
        local condition = BattleConditionManager.GenerateCondition(conditionId, skill)
        table.insert(self.ConditionList, condition)
    end
    self.EffectList = {}
    for _, effectId in ipairs(self.Config.EffectIds) do
        local effect = BattleEffectManager:GetInstance():GenerateEffect(effectId, skill)
        table.insert(self.EffectList, effect)
    end
end

local function Run(self, skill, targetUnit)
    local battleComponent = Game.Scene:GetComponent("BattleComponent")
    if self.Config.IsAlways == 1 or skill ~= battleComponent.CurActSkill then
        return
    end

    for _, condition in ipairs(self.ConditionList) do
        if not condition:Check(skill, targetUnit, skill.UnitResults[targetUnit.UID]) then
            return
        end
    end
    for _, effect in ipairs(self.EffectList) do
        effect:RunBase(skill, targetUnit, skill.UnitResults[targetUnit.UID])
    end
end

TriggerBase.Run = Run
TriggerBase.__init = __init

return TriggerBase