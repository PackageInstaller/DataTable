
local ConditionBase = require "GameLogic.Battle.SkillLogic.Condition.ConditionBase"
local ConditionStatus = BaseClass("ConditionStatus", ConditionBase)

local function Check(self, skill, targetUnit, result)
    for k, target in ipairs(self.Config.Targets) do
        local unit
        if target == TargetType.SkillTargetEnemy then
            unit = targetUnit
        elseif target == TargetType.SkillTargetFriend then
            unit = targetUnit
        elseif target == TargetType.Self then
            unit = skill.SrcUnit
        end

        local statusType = self.Config.Params[1]
        if statusType == BattleConditionStatusType.UnitStatus then
            local statusComponent = unit:GetComponent("CharacterComponent")
        elseif statusType == BattleConditionStatusType.ActStatus then
            if self.Config.Params[2] == BattleConditionActStatusType.IsCac then
                if not unit:GetComponent("SsUnitBattleComponent").IsCac then
                    return false
                end
            end
        end
    end

    return true
end

ConditionStatus.Check = Check

return ConditionStatus