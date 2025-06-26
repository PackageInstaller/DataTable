---
--- 对任意我方单位进行治疗时，最终治疗量提升${Params[1]}%
---

local Equip_16090004 = BaseClass("Equip_16090004", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.HealEffect, self.Params[1])
end

Equip_16090004.__init = __init
Equip_16090004.OnBattleStart = OnBattleStart

return Equip_16090004