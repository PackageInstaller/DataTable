
local ConditionBase = require "GameLogic.Battle.SkillLogic.Condition.ConditionBase"
local ConditionBuffTypeCount = BaseClass("ConditionBuffTypeCount", ConditionBase)

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
        local buffComponent = unit:GetComponent("BuffComponent")
        local isDeBuff = self.Params[1] == 2
        if buffComponent:BuffTypeCount(isDeBuff) < self.Params[2] then
            return false
        end
    end

    return true
end

ConditionBuffTypeCount.Check = Check

return ConditionBuffTypeCount