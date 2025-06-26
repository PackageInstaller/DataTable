---
--- 行动后，恢复自身最大生命值${Params[1]}%的生命值
---
local Equip_11010004 = BaseClass("Equip_11010004", Skill)
local base = Skill

local function __init(self)
end

local function OnActEnd(self)
    base.OnActEnd(self)

    self.__subc:HealHp(math.modf(self.__snc:Get(NumericType.MaxHp) * self.Params[1] / 100))
end

Equip_11010004.__init = __init
Equip_11010004.OnActEnd = OnActEnd

return Equip_11010004