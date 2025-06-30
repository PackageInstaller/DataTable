local ConditionBase = BaseClass("ConditionBase")

local function __init(self, conditionId, skill)
    self.Config = Z_BattleCondition[conditionId]
    self.Skill = skill
    self.Params = self.Config.Params
end

ConditionBase.__init = __init

return ConditionBase