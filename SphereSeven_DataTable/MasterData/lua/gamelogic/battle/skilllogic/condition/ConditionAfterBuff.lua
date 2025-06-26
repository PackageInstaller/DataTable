
local ConditionBase = require "GameLogic.Battle.SkillLogic.Condition.ConditionBase"
local ConditionAfterBuff = BaseClass("ConditionAfterBuff", ConditionBase)

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
        local buffId = self.Config.Params[k]
        if not buffComponent:HasBuffId(buffId) and not table.any(result.Buffs, function(v)
            return buffId == v.BuffId
            end) then
            return false
        end
    end

    return true
end

ConditionAfterBuff.Check = Check

return ConditionAfterBuff