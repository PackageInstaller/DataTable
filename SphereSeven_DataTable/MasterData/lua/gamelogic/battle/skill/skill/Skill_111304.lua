---
--- 亡灵
--- 自身死亡时自动复活并恢复100%(Params[1])体力，每场战斗仅限一次

local Skill_111304 = BaseClass("Skill_111304", Skill)
local base = Skill

local function __init(self)


    self.Data.Times = 0
end

local function AfterHurt(self, activeSkillResult, atkUnit)
    base.AfterHurt(self, activeSkillResult, atkUnit)

    if self.IsDisabled then
        return
    end
    
    if self.__snc:Get(NumericType.Hp) ~= 0 then
        return
    end

    if self.Data.Times >= 1 then
        return
    end

    self.__subc:HealHp(math.ceil(self.__snc:Get(NumericType.MaxHp) * self.Params[1] / 100), true)
    self.Data.Times = self.Data.Times + 1
end

Skill_111304.__init = __init
Skill_111304.AfterHurt = AfterHurt

return Skill_111304