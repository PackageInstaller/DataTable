---
--- 暴击伤害提升${Params[1]}%
---
local Equip_11030104 = BaseClass("Equip_11030104", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.CriDamageAdd, self.Params[1])
end

Equip_11030104.__init = __init
Equip_11030104.OnBattleStart = OnBattleStart

return Equip_11030104