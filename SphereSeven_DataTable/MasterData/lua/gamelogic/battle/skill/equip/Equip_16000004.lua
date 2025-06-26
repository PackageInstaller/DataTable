---
--- 生命提升${Params[1]}%，攻击提升${Params[2]}%
---

local Equip_16000004 = BaseClass("Equip_16000004", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.MaxHpPct, self.Params[1])
    self.__snc:Inc(NumericType.AtkPct, self.Params[2])
end

Equip_16000004.__init = __init
Equip_16000004.OnBattleStart = OnBattleStart

return Equip_16000004