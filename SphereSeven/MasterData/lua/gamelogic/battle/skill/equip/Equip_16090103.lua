---
--- 暴击伤害提升${Params[1]}%
---

local Equip_16090103 = BaseClass("Equip_16090103", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.CriDamageAdd, self.Params[1])
end

Equip_16090103.__init = __init
Equip_16090103.OnBattleStart = OnBattleStart

return Equip_16090103