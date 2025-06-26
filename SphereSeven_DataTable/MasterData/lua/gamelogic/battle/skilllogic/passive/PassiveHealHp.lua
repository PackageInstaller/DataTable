


local PassiveBase = require "GameLogic.Battle.SkillLogic.Passive.PassiveBase"
local PassiveHealHp = BaseClass("PassiveHealHp", PassiveBase)

local function __init(self)
    self.AttributeType = 0
    self.Value = 0
end

local function Run(self)
    local targetUnit = unit
    unit:HealHp(math.modf(self.__scc:GetHealHpBase()*0.1))
end

return PassiveHealHp