


local PassiveBase = require "GameLogic.Battle.SkillLogic.Passive.PassiveBase"
local PassiveAttribute = BaseClass("PassiveAttribute", PassiveBase)

local function OnEabled(self, skill, unit)
    local numericComponent = unit:GetComponent("NumericComponent")
    local type = self.Params[1]
    local value = self.Params[2]
    numericComponent:Inc(type, value)
end

local function OnDisabled(self, skill, unit)
    local numericComponent = unit:GetComponent("NumericComponent")
    local type = self.Params[1]
    local value = self.Params[2]
    numericComponent:Dec(type, value)
end

return PassiveAttribute