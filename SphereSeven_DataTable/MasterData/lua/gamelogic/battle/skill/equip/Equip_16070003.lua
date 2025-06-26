---
--- 暴击伤害提升${Params[1]}%
---

local Equip_16070003 = BaseClass("Equip_16070003", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.CriDamageAdd, self.Params[1])
end

Equip_16070003.__init = __init
Equip_16070003.OnBattleStart = OnBattleStart

return Equip_16070003