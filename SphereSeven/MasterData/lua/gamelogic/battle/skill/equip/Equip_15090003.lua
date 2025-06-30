---
--- 速度提升${Params[1]}%
---

local Equip_15090003 = BaseClass("Equip_15090003", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.SpeedPct, self.Params[1])
end

Equip_15090003.__init = __init
Equip_15090003.OnBattleStart = OnBattleStart

return Equip_15090003