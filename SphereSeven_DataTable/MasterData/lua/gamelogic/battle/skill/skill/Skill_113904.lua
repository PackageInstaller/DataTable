---
--- 守墓者
--  此单位存活时，被此单位击杀的单位不能复活。每有一个单位死亡，恢复自身最大生命值${Params[1]}%。

local Skill_113904 = BaseClass("Skill_113904", Skill)
local base = Skill

local function __init(self)
end

local function OnDeadEvent(self, unit)
    base.OnDeadEvent(self, unit)
    
    self.__subc:HealHp(math.ceil(self.__snc:Get(NumericType.MaxHp) * self.Params[1] / 100), false)
end

Skill_113904.__init = __init
Skill_113904.OnDeadEvent = OnDeadEvent

return Skill_113904