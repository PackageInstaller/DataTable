---
--- 生命提升${Params[1]}%
---

local Equip_14070003 = BaseClass("Equip_14070003", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.MaxHpPct, self.Params[1])
end


Equip_14070003.__init = __init
Equip_14070003.OnBattleStart = OnBattleStart

return Equip_14070003