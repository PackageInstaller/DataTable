
local ConditionBase = require "GameLogic.Battle.SkillLogic.Condition.ConditionBase"
local ConditionBuff = BaseClass("ConditionBuff", ConditionBase)

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
        if not buffComponent:HasBuffId(self.Config.Params[k]) then
            return false
        end
    end

    return true
end

ConditionBuff.Check = Check

return ConditionBuff